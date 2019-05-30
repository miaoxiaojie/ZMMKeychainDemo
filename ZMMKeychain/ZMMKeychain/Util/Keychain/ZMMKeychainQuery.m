//
//  ZMMKeychainQuery.m
//  ZMMKeychain
//
//  Created by miao on 2019/5/23.
//  Copyright © 2019年 miao. All rights reserved.
//

#import "ZMMKeychainQuery.h"

@implementation ZMMKeychainQuery


+ (NSMutableDictionary *)getKeychainBaseQueryDictionaryForKey:(nonnull NSString *)akey
                                                      service:(nonnull NSString *)aService
                                                        group:(nullable NSString *)aGroup
{
    // 创建字典，它将是所有针对密钥链的查询的基础。
    NSMutableDictionary *baseQueryDictionary = [[NSMutableDictionary alloc]
                                                initWithCapacity: 4];
    
    [baseQueryDictionary setObject: (__bridge id)kSecClassGenericPassword
                            forKey: (__bridge id)kSecClass];
    
    [baseQueryDictionary setObject: akey
                            forKey: (__bridge id)kSecAttrAccount];
    
    [baseQueryDictionary setObject: aService
                            forKey: (__bridge id)kSecAttrService];
    
#if TARGET_IPHONE_SIMULATOR
    // Note: 如果在模拟器中运行，则无法设置访问组。模拟器中运行的应用程序没有签名，因此没有访问组供它们检查。在模拟器中运行的所有应用程序都可以看到所有的密钥链项。如果需要测试共享访问组的应用程序，则需要在设备上安装这些应用程序。
#else
    if ([accessGroup length] > 0)
    {
        [baseQueryDictionary setObject: aGroup
                                forKey: (__bridge id)kSecAttrAccessGroup];
    }
#endif
    
    return baseQueryDictionary;
}


@end
