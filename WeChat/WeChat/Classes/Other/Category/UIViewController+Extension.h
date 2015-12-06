//
//  UIViewController+Extension.h
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/4.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)
/** 登陆  */
- (void)login;
/** 设置tabbar  */
- (void)setTabBarWithImage:(NSString *)image SelectImage:(NSString *)selectImage title:(NSString *)title;
@end