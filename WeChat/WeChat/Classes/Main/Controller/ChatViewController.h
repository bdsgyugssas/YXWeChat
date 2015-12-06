//
//  ChatViewController.h
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/6.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMPPJID;

@interface ChatViewController : UIViewController

/** 当前联系人的jid */
@property (strong, nonatomic)  XMPPJID *jid;


@end
