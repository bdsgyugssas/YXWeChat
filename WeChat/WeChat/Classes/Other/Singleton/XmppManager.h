//
//  XmppManager.h
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/4.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMPPvCardTempModule,XMPPvCardTemp,XMPPRoster,XMPPRosterCoreDataStorage,XMPPJID,XMPPMessageArchivingCoreDataStorage;

typedef enum{
    resultTypeLoginSuccess,
    resultTypeLoginFail,
    resultTypeRegisterSuccess,
    resultTypeRegisterFail,
}resultType;

typedef enum {
    connectTypeLogin,
    connectTypeRegister,
}connectType;

typedef enum {
    subscrubeStatusExists,//用户存在
    subscrubeStatusAdd,//用户已经添加
}subscrubeStatusType;

typedef void (^resultBlock)(resultType type);
/** 注销之后的回调  */
typedef void (^logoutHandle)();
/** 添加朋友  */
typedef void (^subscrube) (subscrubeStatusType type);

@interface XmppManager : NSObject

+ (instancetype)shareXmppManager;

/** 连接到服务器  */
- (void)connectToHostWithType:(connectType)type hander:(resultBlock)resultBlock;
/** 注销  */
- (void)logout:(logoutHandle)logoutHandle;

/** 电子名片  */
@property (strong, nonatomic) XMPPvCardTemp *myvCardTemp;
/** 花名册  */
@property (strong, nonatomic) XMPPRoster *roster;
/** 花名册存储  */
@property (strong, nonatomic) XMPPRosterCoreDataStorage *rosterCoreDataStorage;
/** 聊天数据存储  */
@property (strong, nonatomic) XMPPMessageArchivingCoreDataStorage *messageArchivingCoreDataStorage;


/** 上传个人信息  */
- (void)updataMyCard:(XMPPvCardTemp *)myCard;
/** 发送聊天数据  */
- (void)sendMessage:(NSString *)message toJid:(XMPPJID *)jid;

/** 添加朋友  */
- (void)subscrubeFriend:(NSString *)user withStatus:(subscrube)block;
/** 移除朋友  */
- (void)removeFriend:(XMPPJID *)jid;

@end
