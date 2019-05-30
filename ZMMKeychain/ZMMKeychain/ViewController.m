//
//  ViewController.m
//  ZMMKeychain
//
//  Created by miao on 2019/5/22.
//  Copyright © 2019年 miao. All rights reserved.
//

#import "ViewController.h"
#import "ZMMPackageKeychain.h"
#import "ZMMDetailedViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listDatas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Keychaindemo";
    self.listDatas = @[@"苹果官方KeychainItemWrapper使用",
                       @"SAMKeychain使用",
                       @"SecurityKeychain使用方法",
                       ];
    [self p_drawTableView];
    
}

#pragma mark - Private Methods

- (void)p_drawTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame
                                                  style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.0f];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.alwaysBounceVertical = YES;
    [self.view addSubview:self.tableView];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier01 = @"cellIdentifier01";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier01];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier01];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:13.f];
        
        //改变选中状态下背景样式
        UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
        selectedBackgroundView.backgroundColor = [UIColor colorWithRed:162/255.0 green:210/255.0 blue:234/255.0 alpha:1.0];
        cell.selectedBackgroundView = selectedBackgroundView;
    }
    cell.textLabel.text = [self.listDatas objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZMMDetailedViewController *VC = [[ZMMDetailedViewController alloc]init];
    if (indexPath.row == 0) {
        VC.wayType = KAppKeychain;
    }else if (indexPath.row == 1){
        VC.wayType = KSAMKeychain;
    }else if (indexPath.row == 2){
        VC.wayType = KSecurityTypeKeychain;
    }
    [self.navigationController pushViewController:VC animated:YES];
}

@end
