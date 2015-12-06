//
//  MeTableViewController.m
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/4.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MeTableViewController.h"
#import "XmppManager.h"

#import "XMPPvCardTemp.h"
#import "XMPPvCardTempModule.h"
#import "UserInfo.h"

@interface MeTableViewController ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
/** 昵称  */
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
/** 账号  */
@property (weak, nonatomic) IBOutlet UILabel *userLael;

@end

@implementation MeTableViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupCell];
 
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setupCell];
}


#pragma mark -私有方法
/**
 *  设置Cell
 */
- (void)setupCell
{
    XMPPvCardTemp *vCard = [XmppManager shareXmppManager].myvCardTemp;
    
    self.userLael.text = [NSString stringWithFormat:@"微信号:%@",[UserInfo shareUserInfo].user];

    if (vCard.photo) {
        self.photoImageView.image=[UIImage imageWithData:vCard.photo];
    }

}
#pragma mark -监听方法
/**
 *  点击退出按钮
 */
- (void)backToLogin
{
    //显示Alert
    UIAlertController *con=[UIAlertController alertControllerWithTitle:@"" message:@"退出后不会删除历史数据,下次登陆依然可以使用本账号" preferredStyle:0];
   
    UIAlertAction *acitonLogout=[UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[XmppManager shareXmppManager] logout:^{
            UIStoryboard *login=[UIStoryboard storyboardWithName:@"Login" bundle:nil];
            self.view.window.rootViewController=login.instantiateInitialViewController;
        }];
    }];
    [con addAction:acitonLogout];
    
    UIAlertAction *acitonCancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [con addAction:acitonCancle];
    
    [self presentViewController:con animated:YES completion:nil];
   
}

#pragma mark -datasouce
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            [self backToLogin];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;

}

@end
