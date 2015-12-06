//
//  InputView.m
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/6.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "InputView.h"

@implementation InputView


+ (instancetype)inputView
{

    return [[[NSBundle mainBundle] loadNibNamed:@"InputView" owner:nil options:nil] lastObject];
}

@end
