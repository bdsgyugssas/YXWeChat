//
//  AppDelegate.m
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/2.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "AppDelegate.h"
#import "UserInfo.h"
#import "XmppManager.h"
#import "DDLog.h"
#import "DDTTYLogger.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    //读取用户信息
    [[UserInfo shareUserInfo] readUserInfo];
    //根据用户信息判断显示界面
    if ([UserInfo shareUserInfo].isLogin) {
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.window.rootViewController=story.instantiateInitialViewController;
        //连接到服务器
        [[XmppManager shareXmppManager] connectToHostWithType:connectTypeLogin hander:nil];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
