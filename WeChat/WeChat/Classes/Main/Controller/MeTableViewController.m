//
//  MeTableViewController.m
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/4.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MeTableViewController.h"
#import "XmppManager.h"

@interface MeTableViewController ()

@end

@implementation MeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"我";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -   监听方法
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

#pragma mark - datasouce
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
