//
//  ZMMDetailedViewController.m
//  ZMMKeychain
//
//  Created by miao on 2019/5/23.
//  Copyright © 2019年 miao. All rights reserved.
//

#import "ZMMDetailedViewController.h"
#import "ViewController.h"
#import "ZMMKeychain.h"
#import "ZMMKeychainItemWrapper.h"
#import "ZMMKchainWayType.h"
#import "ZMMPackageKeychain.h"

@interface ZMMDetailedViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listDatas;

@end

@implementation ZMMDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.listDatas = @[@"更新数据/保存数据",
                       @"展示数据",
                       @"清除数据",
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
    
    NSString *showData = @"";
    NSString *title = @"";
    if (indexPath.row == 0) {
        
        if (self.wayType == KAppKeychain) {
            title = @"保存KeychainItemWrapper的UUID";
            showData = keychainUtilType.getSavekeychainUUID(KAppKeychain);
        }else if (self.wayType == KSAMKeychain){
            title = @"保存SAMKeychain的密码";
            showData = keychainUtilType.getPassword();
        }else if (self.wayType == KSecurityTypeKeychain){
            showData = keychainUtilType.getSecurity();
        }
        
    }else if (indexPath.row == 1){
        if (self.wayType == KAppKeychain) {
            title = @"KeychainItemWrapper的UUID";
            showData = [ZMMKeychainItemWrapper loadObjectWithIdentifier:keychainUtilType.getkeychainWayKey(KAppKeychain)
                                                      aGroup:nil];
        }else if (self.wayType == KSAMKeychain){
            NSString *sever = keychainUtilType.getkeychainWayServer(KSAMKeychain);
            NSString *account = keychainUtilType.getSavekeychainUUID(KSAMKeychain);
            title = @"SAMKeychain的密码";
            showData = [ZMMPackageKeychain passwordForService:sever account:account];
        }else if (self.wayType == KSecurityTypeKeychain){
            NSString *key = keychainUtilType.getkeychainWayKey(KSecurityTypeKeychain);
            NSString *server = keychainUtilType.getkeychainWayServer(KSecurityTypeKeychain);
            title = @"Security秘钥";
            showData = [ZMMKeychain loadObjectForKey:key
                                             service:server
                                               group:nil];
        }
        
        
    }else if (indexPath.row == 2){
        showData = @"";
        if (self.wayType == KAppKeychain) {
            title = @"删除KeychainItemWrapper的UUID";
    
        }else if (self.wayType == KSAMKeychain){
            title = @"删除SAMKeychain的密码";
        }else if (self.wayType == KSecurityTypeKeychain){
            title = @"删除Security秘钥";
        }
        
    }

    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:showData preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull   action) {
        if (self.wayType == KAppKeychain && indexPath.row == 2) {
            NSString *identifier = keychainUtilType.getkeychainWayKey(KAppKeychain);
            [ZMMKeychainItemWrapper deleteObjectForIdentifier:identifier aGroup:nil];
        }else if (self.wayType == KAppKeychain && indexPath.row == 0){
            [self p_updateAppleUUIDKeyChain];
        }else if (self.wayType == KSAMKeychain && indexPath.row == 2) {
            NSString *sever = keychainUtilType.getkeychainWayServer(KSAMKeychain);
            NSString *account = keychainUtilType.getSavekeychainUUID(KSAMKeychain);
            [ZMMPackageKeychain deletePasswordForService:sever account:account];
        }else if(self.wayType == KSAMKeychain && indexPath.row == 0){
            [self p_updateUserNameAndPassword];
        }else if (self.wayType == KSecurityTypeKeychain && indexPath.row == 0){
            [self p_saveSecurityKeychainKeyChain];
        }else if (self.wayType == KSecurityTypeKeychain && indexPath.row == 2){
            NSString *key = keychainUtilType.getkeychainWayKey(KSecurityTypeKeychain);
            NSString *server = keychainUtilType.getkeychainWayServer(KSecurityTypeKeychain);
            [ZMMKeychain deleteItemForKey:key
                                  service:server
                                    group:@"group"];
        }
       
    }];
    [sureBtn setValue:[UIColor redColor] forKey:@"titleTextColor"];
    [alertVc addAction :sureBtn];
    //展示
    [self presentViewController:alertVc animated:YES completion:nil];
    
}

-(void)p_updateAppleUUIDKeyChain
{
    NSString *identifier = keychainUtilType.getkeychainWayKey(KAppKeychain);
    id objet = keychainUtilType.getSavekeychainUUID(KAppKeychain);
    NSString *cacheUUID =  [ZMMKeychainItemWrapper loadObjectWithIdentifier:identifier aGroup:nil];
    if ([cacheUUID length] == 0) {
        [ZMMKeychainItemWrapper saveItemWrapperWithIdentifier:identifier
                                                       object:objet
                                                       aGroup:nil];
    }
    
}

#pragma mark - SAMKeychain使用
#pragma mark - SAMKeychain使用
-(void)p_updateUserNameAndPassword
{
    NSString *server = keychainUtilType.getkeychainWayServer(KSAMKeychain);
    NSString *acount = keychainUtilType.getSavekeychainUUID(KSAMKeychain);
    NSString *password = keychainUtilType.getPassword();
    NSString *cacheName = [ZMMPackageKeychain passwordForService:server account:acount];
    if ([cacheName length] == 0) {
        [ZMMPackageKeychain setPassword:password forService:server account:acount];
        
    }
    
}

#pragma mark - SecurityKeychain使用方法
-(void)p_saveSecurityKeychainKeyChain
{
    NSString *key = keychainUtilType.getkeychainWayKey(KSecurityTypeKeychain);
    NSString *server = keychainUtilType.getkeychainWayServer(KSecurityTypeKeychain);
    NSString *security = keychainUtilType.getSecurity();
    id object = [ZMMKeychain loadObjectForKey:key
                                      service:server
                                        group:nil];
    if ([object isKindOfClass:[NSString class]] && [object length] == 0) {
        [ZMMKeychain savekeyChainWithValue:security
                                       key:key
                                   service:server
                                     group:nil
                                accessible:KKeychainAccessibleWhenUnlocked];
        
    }
    
}

@end
