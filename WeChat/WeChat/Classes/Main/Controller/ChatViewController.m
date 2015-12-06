//
//  ChatViewController.m
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/6.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "ChatViewController.h"
#import "InputView.h"
#import "XmppManager.h"
#import "XMPPMessageArchivingCoreDataStorage.h"
#import "UserInfo.h"

@interface ChatViewController () <UITableViewDataSource,NSFetchedResultsControllerDelegate,UITextViewDelegate>
//竖直约束
@property (strong, nonatomic) NSArray *Vconstraint;
//文本输入框
@property (weak, nonatomic) InputView *inputView;
//tableView
@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSFetchedResultsController *resultsController;

@property (strong, nonatomic) NSArray *resultsArray;


@end

@implementation ChatViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupView];
 
    [self loadData];
}
#pragma mark -私有方法
/**
 *  加载聊天数据
 */
- (void)loadData
{
    NSManagedObjectContext *context = [XmppManager shareXmppManager].messageArchivingCoreDataStorage.mainThreadManagedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPMessageArchiving_Message_CoreDataObject"];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@ AND bareJidStr = %@",[UserInfo shareUserInfo].jid,self.jid.bare];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    
    
    request.predicate = pre;
    request.sortDescriptors = @[sort];
    
    NSFetchedResultsController *resultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
    resultsController.delegate = self;
    [resultsController performFetch:nil];
    self.resultsArray = resultsController.fetchedObjects;
    self.resultsController = resultsController;
    NSLog(@"%lu",(unsigned long)self.resultsArray.count);
    [self scrollBottom];
    

}
/**
 *  初始View
 */
- (void)setupView
{
    UITableView *tableView = [[UITableView alloc]init];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    InputView *inputView = [InputView inputView];
    inputView.translatesAutoresizingMaskIntoConstraints = NO;
    inputView.inputTextView.delegate = self;
    [self.view addSubview:inputView];
    self.inputView = inputView;
    
    //监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeConstraint:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //添加约束
    NSDictionary *dict = @{@"tableView":tableView,
                           @"inputView":inputView};
    
    NSArray *tableViewHconstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|" options:0 metrics:0 views:dict];
    [self.view addConstraints:tableViewHconstraint];
    
    NSArray *inputViewHconstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[inputView]-0-|" options:0 metrics:0 views:dict];
    [self.view addConstraints:inputViewHconstraint];
    
    NSArray *Vconstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tableView]-0-[inputView(50)]-0-|" options:0 metrics:0 views:dict];
    [self.view addConstraints:Vconstraint];
    
    self.Vconstraint = Vconstraint;

}

#pragma mark -监听方法
/**
 *  监听到键盘尺寸发生改变
 */
- (void)changeConstraint:(NSNotification *)notification
{
    [self.view removeConstraints:self.Vconstraint];
    
    CGFloat Y = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat H = [UIScreen mainScreen].bounds.size.height;
    
    NSDictionary *dict = @{@"tableView":self.tableView,
                           @"inputView":self.inputView};
    
    NSString *con = [NSString stringWithFormat:@"V:|-0-[tableView]-0-[inputView(50)]-%f-|",H-Y];
    self.Vconstraint = [NSLayoutConstraint constraintsWithVisualFormat:con options:0 metrics:0 views:dict];
    
    [self.view addConstraints:self.Vconstraint];
    [self scrollBottom];
}
/**
 *  tableView滚到底部
 */
- (void)scrollBottom
{
//    NSInteger row = self.resultsArray.count - 1;
//    if (row >= 0) {
//    
//        NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
//        [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    }


}
#pragma mark -UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text rangeOfString:@"\n"].length) {
        [[XmppManager shareXmppManager] sendMessage:textView.text toJid:self.jid];
        textView.text = nil;
    }

}
#pragma mark -NSFetchedResultsControllerDelegate
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self loadData];
    [self scrollBottom];
    [self.tableView reloadData];

}
#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ChatCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    XMPPMessageArchiving_Message_CoreDataObject *object = self.resultsArray[indexPath.row];
    if ([object.outgoing boolValue]) {
        cell.textLabel.text = [NSString stringWithFormat:@"WO:%@",object.body];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"YOU:%@",object.body];
    }

    return cell;
    
}


@end
