//
//  ContactsViewController.m
//  WeChat
//
//  Created by 郑雨鑫 on 15/12/5.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "ContactsViewController.h"
#import "XmppManager.h"
#import "XMPPRosterCoreDataStorage.h"
#import "UserInfo.h"

@interface ContactsViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSArray *fetchObjects;

@property (strong, nonatomic) NSFetchedResultsController *requestController;


@end

@implementation ContactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self loadData];
}

#pragma mark -私有方法
/**
 *  加载联系人数据
 */
- (void)loadData
{
    //上下文
     NSManagedObjectContext *context = [XmppManager shareXmppManager].rosterCoreDataStorage.mainThreadManagedObjectContext;
    //设置请求,查哪张表
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];
    //设置筛选方式和排序
    NSString *jid = [NSString stringWithFormat:@"%@@%@",[UserInfo shareUserInfo].user,Domain];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@",jid];
    request.predicate = predicate;
    
    NSSortDescriptor *sortD = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];
    request.sortDescriptors = @[sortD];
    //执行请求
    
    NSFetchedResultsController *results = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
    results.delegate = self;

    [results performFetch:nil];
    
    self.requestController = results;
    self.fetchObjects = results.fetchedObjects;

}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fetchObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    XMPPUserCoreDataStorageObject *object = self.fetchObjects[indexPath.row];
    
    cell.textLabel.text = object.displayName;
    
    NSString *string = nil;
    switch (object.sectionNum.intValue) {
        case 0:
            string = @"在线";
            break;
        case 1:
            string = @"离开";
            break;
        case 2:
            string = @"离线";
            break;
        default:
            break;
    }
    
    cell.detailTextLabel.text = string;
    
    return cell;
    
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        XMPPUserCoreDataStorageObject *object = self.fetchObjects[indexPath.row];
        [[XmppManager shareXmppManager] removeFriend:object.jid];
    }

}
#pragma mark -NSFetchedResultsControllerDelegate
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self loadData];
    [self.tableView reloadData];

}

@end
