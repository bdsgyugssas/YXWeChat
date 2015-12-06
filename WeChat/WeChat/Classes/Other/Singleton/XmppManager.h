//
//  XmppManager.h
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/4.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMPPvCardTempModule,XMPPvCardTemp,XMPPRoster,XMPPRosterCoreDataStorage,XMPPJID;

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


/** 上传信息  */
- (void)updataMyCard:(XMPPvCardTemp *)myCard;
/** 添加朋友  */
- (void)subscrubeFriend:(NSString *)user withStatus:(subscrube)block;

- (void)removeFriend:(XMPPJID *)jid;

@end
