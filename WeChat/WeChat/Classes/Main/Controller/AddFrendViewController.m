//
//  AddFrendViewController.m
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/5.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "AddFrendViewController.h"
#import "XmppManager.h"

#import "XMPPRoster.h"
#import "XMPPRosterCoreDataStorage.h"

#import "MBProgressHUD.h"


@interface AddFrendViewController() <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) UIButton *button;
@end
@implementation AddFrendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpView];
}



- (void)setUpView
{
    UIImageView *imageView = [[UIImageView alloc]init];
    
    imageView.frame = CGRectMake(0, 0, 40, 40);
    imageView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    imageView.contentMode = UIViewContentModeCenter;
   
    self.textField.leftView = imageView;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *button =[[UIButton alloc]init];
    [button setTitle:@"添加" forState:UIControlStateNormal];
    [button setTitleColor:ButtonGreenColor forState:UIControlStateNormal];
    [button setTitleColor:RGBA(17, 160, 9, 0.3) forState:UIControlStateDisabled];
    [button addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = (CGRect){{0,0},{50,30}};
    _button = button;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.button.enabled = NO;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textField becomeFirstResponder];
  
}


#pragma mark -私有方法
/**
 *  用户应经添加
 */
- (void)showUserIsExists
{
    MBProgressHUD *hud=[[MBProgressHUD alloc]init];
    [self.view addSubview:hud];
    hud.mode=MBProgressHUDModeCustomView;
    hud.customView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"error"]];
    hud.labelText=@"用户已经是你的朋友";
    [hud show:YES];
    [hud hide:YES afterDelay:1.0];

}
/**
 *  用户添加成功
 */
- (void)showAddUseruccess
{
    [self.textField resignFirstResponder];
    
    MBProgressHUD *hud=[[MBProgressHUD alloc]init];
    [self.view addSubview:hud];
    
    hud.mode=MBProgressHUDModeCustomView;
    hud.customView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"success"]];
    hud.labelText=@"添加成功";
    [hud show:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide:YES];
        [self.navigationController popViewControllerAnimated:YES];
    });

}

- (void)addFriends
{
    NSString *string = self.textField.text;
    
    [[XmppManager shareXmppManager] subscrubeFriend:string withStatus:^(subscrubeStatusType type) {
        switch (type) {
            case subscrubeStatusExists:
                [self showUserIsExists];
                break;
            case subscrubeStatusAdd:
                [self showAddUseruccess];
                break;
                
            default:
                break;
        }
        
    }];
}
#pragma mark -监听方法
- (void)addButtonClick
{
    [self addFriends];
    
}



#pragma mark -UITextFieldDelegate
- (IBAction)textChange:(id)sender {
    self.button.enabled = self.textField.text.length;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self addFriends];
   
    return YES;
}
@end
