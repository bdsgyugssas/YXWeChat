//
//  UserInfoManager.h
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/4.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
/** 用户名  */
@property (copy,nonatomic) NSString *user;
/** 用户密码  */
@property (copy,nonatomic) NSString *pwd;
/** 是否处于登陆状态  */
@property (assign, nonatomic) BOOL isLogin;
/** 注册用户名  */
@property (copy,nonatomic) NSString *registerUser;
/** 注册用户密码  */
@property (copy,nonatomic) NSString *registerPwd;

/** 存储用户账号信息  */
- (void)saveUserInfo;
/** 读取用户账号信息  */
- (void)readUserInfo;

+ (instancetype)shareUserInfo;
@end
