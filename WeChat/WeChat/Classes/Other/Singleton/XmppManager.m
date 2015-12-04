//
//  XmppManager.m
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/4.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "XmppManager.h"
#import "XMPPFramework.h"
#import "UserInfo.h"

@interface XmppManager()<XMPPStreamDelegate>

@property (assign, nonatomic) BOOL isRegister;

@property (strong, nonatomic) XMPPStream *stream;

@property (copy, nonatomic) resultBlock resultBlock;

@end


@implementation XmppManager

static id Xmppmanager;
#pragma mark -单例初始化
+ (instancetype)shareXmppManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Xmppmanager = [[self alloc]init];
    });
    
    return Xmppmanager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Xmppmanager = [super allocWithZone:zone];
    });
    
    return Xmppmanager;
}

#pragma mark -私有方法
/**
 *  注销
 */
- (void)logout:(logoutHandle)logoutHandle
{
    //发送离线消息
    XMPPPresence *pre=[XMPPPresence presenceWithType:@"unavailable"];
    [self.stream sendElement:pre];
    //断开连接
    [self.stream disconnect];
    //改变登录状态
    [UserInfo shareUserInfo].isLogin=NO;
    [[UserInfo shareUserInfo] saveUserInfo];
    
    //显示登陆界面
    logoutHandle();
    
}
/**
 *  连接到服务器
 */
- (void)connectToHostWithType:(connectType)type hander:(resultBlock)resultBlock
{
    self.resultBlock=resultBlock;
    
    if (self.stream == nil) {
        [self setupStream];
    }

    [self.stream disconnect];
    
   //判断是登陆状态还是注册状态
    NSString *user=nil;
    switch (type) {
        case connectTypeLogin:{
            user=[UserInfo shareUserInfo].user;
            self.isRegister=NO;
        }
            break;
        case connectTypeRegister:{
            user=[UserInfo shareUserInfo].registerUser;
            self.isRegister=YES;
        }
            break;
    }
    
    //用户名
    XMPPJID *myJID = [XMPPJID jidWithUser:user domain:@"zhengyuxindemacbook-pro.local" resource:@"iphone"];
    
    self.stream.myJID = myJID;
    //服务器地址
    self.stream.hostName = @"zhengyuxindemacbook-pro.local";
    //服务器端口
    self.stream.hostPort = 5222;

    NSError *error = nil;
    if (![self.stream connectWithTimeout:XMPPStreamTimeoutNone error:&error]) {
        WCLog(@"连接失败,原因是:%@",error);
    }


}
/**
 *  创建XmppStream
 */
- (void)setupStream
{
    self.stream = [[XMPPStream alloc]init];
    
    [self.stream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];

}
/**
 *  发送密码到服务器
 */
- (void)sendPwdToHost
{
    NSString *pwd = [UserInfo shareUserInfo].pwd;
    NSError *error = nil;
    
    if (![self.stream authenticateWithPassword:pwd error:&error]) {
        WCLog(@"授权失败:%@",error);
    }
}
#pragma mark -XMPPStreamDelegate
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
        [UserInfo shareUserInfo].isLogin = YES;
        //登陆成功，存储用户信息
        [[UserInfo shareUserInfo] saveUserInfo];
    
        XMPPPresence *presence = [XMPPPresence presence];
        [self.stream sendElement:presence];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.resultBlock) {
                self.resultBlock(resultTypeLoginSuccess);
            }
        });
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.resultBlock) {
            self.resultBlock(resultTypeLoginFail);
        }
    });
}

- (void)xmppStreamDidRegister:(XMPPStream *)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.resultBlock) {
            [UserInfo shareUserInfo].user=[UserInfo shareUserInfo].registerUser;
            self.resultBlock(resultTypeRegisterSuccess);
        }
    });

}

- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.resultBlock) {
            self.resultBlock(resultTypeRegisterFail);
        }
    });

}
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    
    
    if (self.isRegister) {//注册状态
        [self.stream registerWithPassword:[UserInfo shareUserInfo].registerPwd error:nil];
    }else{//登陆状态
        [self sendPwdToHost];
    }
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
//    WCLog(@"连接失败,原因是%@",error);
}


@end