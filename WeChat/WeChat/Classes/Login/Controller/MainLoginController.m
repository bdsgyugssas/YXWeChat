//
//  MainLoginController.m
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/3.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MainLoginController.h"
#import "PhoneLoginController.h"



@interface MainLoginController ()
- (IBAction)moreClick;

@end

@implementation MainLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
}



#pragma mark -监听方法
/**
 *  点击更多,弹出选择菜单
 */
- (IBAction)moreClick
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionChange = [UIAlertAction actionWithTitle:@"切换账号..." style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self clickAvtionChange];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"注册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"前往微信安全中心" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:actionChange];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [alertController addAction:action4];

    [self presentViewController:alertController animated:YES completion:nil];
    
}
/**
 *  点击了切换账号
 */
- (void)clickAvtionChange
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionPhone = [UIAlertAction actionWithTitle:@"手机号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self clickAvtionPhone];
    }];
    
    UIAlertAction *actionMail = [UIAlertAction actionWithTitle:@"微信号/邮箱地址/QQ号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self clickAvtionMail];
    }];
    
    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:actionPhone];
    [alertController addAction:actionMail];
    [alertController addAction:actionCancle];
    
    [self presentViewController:alertController animated:YES completion:nil];


}
/**
 *  点击了手机号登陆
 */
- (void)clickAvtionPhone
{
    [self performSegueWithIdentifier:@"1" sender:nil];
}

- (void)clickAvtionMail
{

}
@end
