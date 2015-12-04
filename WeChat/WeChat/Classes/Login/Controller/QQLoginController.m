//
//  QQLoginController.m
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/4.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "QQLoginController.h"
#import "XmppManager.h"
#import "MBProgressHUD.h"
#import "UserInfo.h"

@interface QQLoginController ()
/** 账号  */
@property (weak, nonatomic) IBOutlet UITextField *userTextfield;
/** 密码  */
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

/** 点击登陆按钮  */
- (IBAction)loginClick:(id)sender;

@end

@implementation QQLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -  监听方法
/**
 *  点击取消按钮
 */
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  点击登陆按钮
 */
- (IBAction)loginClick:(id)sender
{
    
    //存储账号密码
    [UserInfo shareUserInfo].user=self.userTextfield.text;
    [UserInfo shareUserInfo].pwd=self.pwdTextField.text;
    //登陆
    [self login];
    
}



@end
