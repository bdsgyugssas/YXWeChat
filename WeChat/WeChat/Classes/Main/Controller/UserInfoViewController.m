//
//  userInfoViewController.m
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/5.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "UserInfoViewController.h"
#import "EditViewController.h"
#import "MBProgressHUD.h"
#import "XmppManager.h"
#import "UserInfo.h"
#import "XMPPvCardTemp.h"

@interface UserInfoViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate,EditViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;

@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *userLabel;
/** 个人名片  */
@property (strong, nonatomic) XMPPvCardTemp *myvCardTemp;

@end

@implementation UserInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadVcard];
    
}


#pragma mark -私有方法
/**
 *  加载数据
 */
- (void)loadVcard
{
    self.myvCardTemp = [XmppManager shareXmppManager].myvCardTemp;
    
    if (self.myvCardTemp.photo) {
        self.userPhoto.image = [UIImage imageWithData:self.myvCardTemp.photo];
    }
    
    self.userLabel.text = [UserInfo shareUserInfo].user;
    
    self.nickNameLabel.text = self.myvCardTemp.nickname;
 
    
}
/**
 *  选择头像
 */
- (void)choosePhoto
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请选择获取方式" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    //拍照
    UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamere];
    }];
    [alertC addAction:actionCamera];
    
    //相册
    UIAlertAction *actionLab = [UIAlertAction actionWithTitle:@"手机相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotoLab];
    }];
    [alertC addAction:actionLab];
    
    //取消
    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertC addAction:actionCancle];

    [self presentViewController:alertC animated:YES completion:nil];
    
}
/**
 *  打开相机
 */
- (void)openCamere
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        MBProgressHUD *hud = [[MBProgressHUD alloc]init];
        [self.view addSubview:hud];
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"error"]];
        hud.labelText = @"相机不可用";
        [hud show:YES];
        [hud hide:YES afterDelay:1.0];
    }
    
    
}
/**
 *  打开手机相册
 */
- (void)openPhotoLab
{
    UIImagePickerController *contro = [[UIImagePickerController alloc]init];
   
    contro.delegate = self;
    contro.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    contro.allowsEditing = YES;
    
    [self presentViewController:contro animated:YES completion:nil];
    
    
    
}
/**
 *  push控制器准备
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id dVC = segue.destinationViewController;
    
    if ([dVC isKindOfClass:[EditViewController class]]) {
        UITableViewCell *cell = sender;
        EditViewController *controller = dVC;
        controller.delegate = self;
        controller.cell = cell;
    }

}
#pragma merk -EditViewControllerDelegate
- (void)editDidSave
{
    self.myvCardTemp.photo = UIImagePNGRepresentation(self.userPhoto.image);
    
    self.myvCardTemp.nickname = self.nickNameLabel.text;
    
    [UserInfo shareUserInfo].photo = self.userPhoto.image;
    
    [[XmppManager shareXmppManager] updataMyCard:self.myvCardTemp];

}

#pragma mark -UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.userPhoto.image = image;
    
    [self editDidSave];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSUInteger tag = cell.tag;
   
    if (tag == 1) {//点击了头像
        [self choosePhoto];
    }else if (tag == 2){//点击了用户昵称
        [self performSegueWithIdentifier:@"Edit" sender:cell];
    }else if (tag == 3){//点击了微信号
        return;
    }else{
        
    }
   
}
@end
