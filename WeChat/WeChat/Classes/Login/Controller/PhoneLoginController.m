//
//  PhoneLoginController.m
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/3.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "PhoneLoginController.h"

@interface PhoneLoginController ()

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

@end
