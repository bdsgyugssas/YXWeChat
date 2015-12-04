//
//  RegisterController.m
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/4.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "RegisterController.h"
#import "UserInfo.h"

#import "MBProgressHUD.h"
#import "XmppManager.h"

@interface RegisterController ()
/** 账号  */
@property (weak, nonatomic) IBOutlet UITextField *registerUserField;
/** 密码  */
@property (weak, nonatomic) IBOutlet UITextField *registerPwdField;
/** 注册按钮  */
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation RegisterController


#pragma mark -监听方法
- (IBAction)textChange {
    
    self.registerButton.enabled=(self.registerPwdField.text.length && self.registerUserField.text.length);
}


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registerClick:(id)sender {
    
    [self.view endEditing:YES];
    
    if (![self.registerUserField isTelphoneNum]) {
       
        MBProgressHUD *hud=[[MBProgressHUD alloc]init];
        [self.view addSubview:hud];
        hud.mode=MBProgressHUDModeCustomView;
        hud.customView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"error"]];
        hud.labelText=@"请输入正确的手机号码";
        [hud show:YES];
        [hud hide:YES afterDelay:1.0];
        
        return;
    }
    
    UserInfo *info = [UserInfo shareUserInfo];
    info.registerUser = self.registerUserField.text;
    info.registerPwd = self.registerPwdField.text;
    
    [self goRegister];
}

- (void)goRegister
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在注册中...";
    
    __weak typeof(self) selfVC=self;
    
    [[XmppManager shareXmppManager] connectToHostWithType:connectTypeRegister hander:^(resultType type) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        switch (type) {
            case resultTypeRegisterSuccess:
                [selfVC registerSuccess];
                break;
            case resultTypeRegisterFail:
                [selfVC registerFail];
                break;
            default:break;
        }
    }];
    
}
/**
 *  注册成功
 */
- (void)registerSuccess
{
    MBProgressHUD *hud=[[MBProgressHUD alloc]init];
    [self.view addSubview:hud];
    
    hud.mode=MBProgressHUDModeCustomView;
    hud.customView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"success"]];
    hud.labelText=@"注册成功";
    [hud show:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"registerSuccess" object:nil];
        
    });
    
    
    
}
/**
 *  注册失败
 */
- (void)registerFail
{
    MBProgressHUD *hud=[[MBProgressHUD alloc]init];
    [self.view addSubview:hud];
    
    hud.mode=MBProgressHUDModeCustomView;
    hud.customView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"error"]];
    hud.labelText=@"注册失败";
    [hud show:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.registerPwdField.text=nil;
        self.registerUserField.text=nil;
        
    });
    
    
}


@end
