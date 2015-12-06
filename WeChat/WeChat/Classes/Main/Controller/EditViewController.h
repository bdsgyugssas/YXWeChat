//
//  EditViewController.h
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/5.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditViewControllerDelegate <NSObject>

- (void)editDidSave;

@end

@interface EditViewController : UITableViewController

@property (strong, nonatomic) UITableViewCell *cell;

@property (weak, nonatomic) id <EditViewControllerDelegate> delegate;
@end
