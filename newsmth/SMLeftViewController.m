//
//  SMLeftViewController.m
//  newsmth
//
//  Created by Maxwin on 13-6-12.
//  Copyright (c) 2013年 nju. All rights reserved.
//

#import "SMLeftViewController.h"
#import "SMMainViewController.h"
#import "SMMainpageViewController.h"
#import "SMFavorListViewController.h"
#import "SMAccountManager.h"

@interface SMLeftViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SMLeftViewController

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAccountNotification) name:NOTIFICATION_ACCOUT object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)onAccountNotification
{
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
    NSString *user = [SMAccountManager instance].name;
    cell.textLabel.text = indexPath.row == 0 ? (user == nil ? @"guest" : user) : @"收藏";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc;
    if (indexPath.row == 0) {
        vc = [SMMainpageViewController instance];
    } else {
        vc = [SMFavorListViewController instance];
    }
    
    [[SMMainViewController instance] setRootViewController:vc];
    [[SMMainViewController instance] setLeftVisiable:NO];
}

@end
