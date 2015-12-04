//
//  XmppManager.h
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/4.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

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

typedef void (^resultBlock)(resultType type);

typedef void (^logoutHandle)();

@interface XmppManager : NSObject

+ (instancetype)shareXmppManager;

/** 连接到服务器  */
- (void)connectToHostWithType:(connectType)type hander:(resultBlock)resultBlock;
/** 注销  */
- (void)logout:(logoutHandle)logoutHandle;

@end
