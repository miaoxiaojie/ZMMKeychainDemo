//
//  ZMMKeychainItemWrapper.m
//  ZMMKeychain
//
//  Created by miao on 2019/5/28.
//  Copyright © 2019年 miao. All rights reserved.
//

#import "ZMMKeychainItemWrapper.h"
#import "KeychainItemWrapper.h"

@implementation ZMMKeychainItemWrapper

+(BOOL)saveItemWrapperWithIdentifier:(nonnull NSString *)identifier
                              object:(id)object
                              aGroup:(nullable NSString *)aGroup
{
    BOOL saveResult = YES;
    if ([identifier length] == 0) {
        saveResult = NO;
    }
    if (object == nil) {
        [self deleteObjectForIdentifier:identifier aGroup:aGroup];
    }else{
        KeychainItemWrapper *warp = [[KeychainItemWrapper alloc]initWithIdentifier:identifier accessGroup:aGroup];
        [warp objectForKey:(id)kSecValueData];
        [warp setObject:identifier forKey:(id)kSecAttrService];
        [warp setObject:identifier forKey:(id)kSecAttrAccount];
        [warp setObject:object forKey:(id)kSecValueData];
        //权限
        [warp setObject:(id)kSecAttrAccessibleAlwaysThisDeviceOnly forKey:(id)kSecAttrAccessible];
#if TARGET_IPHONE_SIMULATOR
        // Note: 如果在模拟器中运行，则无法设置访问组。模拟器中运行的应用程序没有签名，因此没有访问组供它们检查。在模拟器中运行的所有应用程序都可以看到所有的密钥链项。如果需要测试共享访问组的应用程序，则需要在设备上安装这些应用程序。
#else
        if ([accessGroup length] > 0)
        {
            [warp setObject: accessGroup forKey:(id)kSecAttrAccessGroup];
        }
#endif
    }
    return saveResult;
}

+(id)loadObjectWithIdentifier:(nonnull NSString *)identifier
                       aGroup:(nullable NSString *)aGroup
{
    if ([identifier length] == 0) {
        return nil;
    }
    KeychainItemWrapper *warp = [[KeychainItemWrapper alloc]initWithIdentifier:identifier accessGroup:aGroup];
    id object = [warp objectForKey:(id)kSecValueData];
#if TARGET_IPHONE_SIMULATOR
    // Note: 如果在模拟器中运行，则无法设置访问组。模拟器中运行的应用程序没有签名，因此没有访问组供它们检查。在模拟器中运行的所有应用程序都可以看到所有的密钥链项。如果需要测试共享访问组的应用程序，则需要在设备上安装这些应用程序。
#else
    if ([accessGroup length] > 0)
    {
        [warp objectForKey:(id)kSecAttrAccessGroup];
    }
#endif

    return object;
}

+(BOOL)deleteObjectForIdentifier:(nonnull NSString *)identifier
                          aGroup:(nullable NSString *)aGroup
{
    BOOL deleteResult = YES;
    if ([identifier length] == 0) {
        deleteResult = NO;
    }
     KeychainItemWrapper *warp = [[KeychainItemWrapper alloc]initWithIdentifier:identifier accessGroup:aGroup];
    [warp resetKeychainItem];
    return deleteResult;
}

@end
