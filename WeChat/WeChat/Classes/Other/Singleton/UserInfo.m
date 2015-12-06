//
//  UserInfoManager.m
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/4.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "UserInfo.h"

#define userKey @"user"
#define pwdKey @"pwd"
#define LoginKey @"isLogin"
#define UserPhoto @"userPhoto"
@implementation UserInfo

static id userInfo;
#pragma mark -单例初始化
+ (instancetype)shareUserInfo
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[self alloc]init];
    });
    
    return userInfo;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [super allocWithZone:zone];
    });
    
    return userInfo;
}
#pragma mark -
- (NSString *)jid
{
    return [NSString stringWithFormat:@"%@@%@",self.user,Domain];
    
}

- (void)saveUserInfo
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.user forKey:userKey];
    [defaults setObject:self.pwd forKey:pwdKey];
    [defaults setBool:self.isLogin forKey:LoginKey];
    
     NSData *data = UIImagePNGRepresentation(self.photo);
    [defaults setObject:data forKey:UserPhoto];
    
    [defaults synchronize];

}

- (void)readUserInfo
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    self.user = [defaults objectForKey:userKey];
    self.pwd = [defaults objectForKey:pwdKey];
    self.isLogin = [defaults boolForKey:LoginKey];
    NSData *data = [defaults objectForKey:UserPhoto];
    self.photo = [UIImage imageWithData:data];
}
@end
