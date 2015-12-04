//
//  MainLoginController.m
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/3.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MainLoginController.h"
#import "PhoneLoginController.h"
#import "XmppManager.h"
#import "MBProgressHUD.h"
#import "UserInfo.h"


@interface MainLoginController ()
- (IBAction)moreClick;
/** 用户账号  */
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
/** 用户头像  */
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
/** 用户密码  */
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
/** 按钮登陆  */
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;

@end

@implementation MainLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置界面
    [self setupView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - 私有方法
/**
 *  设置界面
 */
- (void)setupView
{
    self.userLabel.text=[UserInfo shareUserInfo].user;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerSuccess) name:@"registerSuccess" object:nil];
}

#pragma mark -监听方法

- (void)registerSuccess
{
    self.userLabel.text=[UserInfo shareUserInfo].user;
}
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
        [self performSegueWithIdentifier:@"注册" sender:nil];
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
        [self clickAvtionQQ];
    }];
    
    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:actionPhone];
    [alertController addAction:actionMail];
    [alertController addAction:actionCancle];
    
    [self presentViewController:alertController animated:YES completion:nil];


}
/**
 *  点击了手机号登陆选项
 */
- (void)clickAvtionPhone
{
    [self performSegueWithIdentifier:@"1" sender:nil];
}
/**
 *  点击了QQ登陆选项
 */
- (void)clickAvtionQQ
{
    [self performSegueWithIdentifier:@"2" sender:nil];
}
/**
 *  点击了登陆按钮
 */
- (IBAction)clickLoginButton
{
    [UserInfo shareUserInfo].pwd=self.pwdTextField.text;
    //登陆
    [self login];
}

@end
