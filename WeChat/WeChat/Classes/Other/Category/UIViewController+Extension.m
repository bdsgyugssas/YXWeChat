//
//  UIViewController+Extension.m
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/4.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "MBProgressHUD.h"
#import "XmppManager.h"


@implementation UIViewController (Extension)

- (void)setTabBarWithImage:(NSString *)image SelectImage:(NSString *)selectImage title:(NSString *)title
{
    
    [self.tabBarItem setImage:[UIImage imageNamed:image]];
    [self.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabbar_meHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    self.tabBarItem.title = title;
    self.navigationItem.title = title;
    
    NSMutableDictionary *normalDict = [NSMutableDictionary dictionary];
    normalDict[NSForegroundColorAttributeName] = GrayColor;
    NSMutableDictionary *selectDict = [NSMutableDictionary dictionary];
    selectDict[NSForegroundColorAttributeName] = GreenColor;
    
    [self.tabBarItem setTitleTextAttributes:normalDict forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:selectDict forState:UIControlStateSelected]; 
}

/**
 *  登陆
 */
- (void)login
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在登录中...";
 
    __weak typeof(self) selfVC=self;
    
    [[XmppManager shareXmppManager] connectToHostWithType:connectTypeLogin hander:^(resultType type) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        switch (type) {
            case resultTypeLoginFail:
                [selfVC showAlert];
                break;
            case resultTypeLoginSuccess:
                [selfVC showMainView];
            default: break;
        }
    }];
}

/**
 *  密码正确
 */
- (void)showMainView
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.view.window.rootViewController=storyboard.instantiateInitialViewController;
    
}
/**
 *  密码错误
 */
- (void)showAlert
{
    UIAlertController *con=[UIAlertController alertControllerWithTitle:@"账号/密码错误" message:@"请重新输入账号/密码" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [con addAction:action];
    
    [self presentViewController:con animated:YES completion:nil];
    
}



@end
