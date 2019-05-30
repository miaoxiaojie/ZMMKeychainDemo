//
//  AppDelegate+ZMMFinishLanch.m
//  ZMMKeychain
//
//  Created by miao on 2019/5/22.
//  Copyright © 2019年 miao. All rights reserved.
//

#import "AppDelegate+ZMMFinishLanch.h"
#import "RunTimeUtil.h"
#import "ZMMPackageKeychain.h"
#import "ZMMKeychain.h"
#import "ZMMKeychainItemWrapper.h"
#import "ZMMKchainWayType.h"
#import "ZMMDetailedViewController.h"
@implementation AppDelegate (ZMMFinishLanch)

+ (void)load
{
    //启动程序时初始化
    runTimeUtil.transforInstanceMethod([self class],
                                       @selector(application:didFinishLaunchingWithOptions:),
                                       @selector(transfor_saveKeyChainDate:didFinishLaunchingWithOptions:));
}

-(BOOL)transfor_saveKeyChainDate:(UIApplication *)application
                didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self transfor_saveKeyChainDate:application didFinishLaunchingWithOptions:launchOptions];
    
    [self p_updateAppleUUIDKeyChain];
    [self p_updateUserNameAndPassword];
    [self p_saveSecurityKeychainKeyChain];
    return YES;
}

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
    if ([object length] == 0) {
        [ZMMKeychain savekeyChainWithValue:security
                                       key:key
                                   service:server
                                     group:nil
                                accessible:KKeychainAccessibleWhenUnlocked];
        
    }
  
}

#pragma mark - 苹果官方KeychainItemWrapper保存
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

@end
