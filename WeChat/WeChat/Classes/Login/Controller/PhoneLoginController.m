//
//  PhoneLoginController.m
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/3.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "PhoneLoginController.h"
#import "UserInfo.h"

@interface PhoneLoginController ()
/** 用户名  */
@property (weak, nonatomic) IBOutlet UITextField *userField;
/** 用户密码  */
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
/** 登陆按钮  */
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;

@end

@implementation PhoneLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 监听按钮
/**
 *  点击取消按钮
 */
- (IBAction)back:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  监听输入栏状态改变
 */
- (IBAction)textChange {
    self.LoginButton.enabled = (self.userField.text.length && self.pwdField.text.length);
}

- (IBAction)loginClick:(id)sender {
    //存储账号密码
    [UserInfo shareUserInfo].user=self.userField.text;
    [UserInfo shareUserInfo].pwd=self.pwdField.text;
    //登陆
    [self login];
}

@end
