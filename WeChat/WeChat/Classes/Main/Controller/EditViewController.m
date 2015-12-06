//
//  EditViewController.m
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/5.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController(){
    UIButton *_button;
}

@property (weak, nonatomic) IBOutlet UITextField *EditTextField;

@end
@implementation EditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupView];


}

- (void)viewDidAppear:(BOOL)animated
{
    [self.EditTextField becomeFirstResponder];

}
- (IBAction)textChange:(id)sender {
    
    _button.enabled = self.EditTextField.text.length;
}


- (void)saveButtonClick
{
    self.cell.detailTextLabel.text = self.EditTextField.text;
    [self.cell layoutSubviews];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if ([self.delegate respondsToSelector:@selector(editDidSave)]) {
        [self.delegate editDidSave];
    }

}
#pragma mark 

- (void)setupView
{
    self.navigationItem.title = self.cell.textLabel.text;
    self.EditTextField.text = self.cell.detailTextLabel.text;
    
    UIButton *button =[[UIButton alloc]init];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:ButtonGreenColor forState:UIControlStateNormal];
    [button setTitleColor:RGBA(17, 160, 9, 0.3) forState:UIControlStateDisabled];
    [button addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = (CGRect){{0,0},{50,30}};
    
    _button = button;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    

    
}

@end
