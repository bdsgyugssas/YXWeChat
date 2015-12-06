//
//  InputView.h
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/6.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputView : UIView

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

+ (instancetype)inputView;

@end
