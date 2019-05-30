//
//  ZMMKeychain.m
//  ZMMKeychain
//
//  Created by miao on 2019/5/22.
//  Copyright © 2019年 miao. All rights reserved.
//

#import "ZMMKeychain.h"
#import <Security/Security.h>
#import "ZMMKeychainQuery.h"

@implementation ZMMKeychain

+(BOOL)savekeyChainWithValue:(id)object
                         key:(nonnull NSString *)aKey
                     service:(nonnull NSString *)aService
                       group:(nullable NSString *)aGroup
                  accessible:(kKeychainAccessible)aAccessible
{
    //如果键或服务参数为空，则引发异常
    if ([aKey length] == 0)
    {
        [NSException raise: NSInvalidArgumentException
                    format: @"%s 键参数不能为空",
         __PRETTY_FUNCTION__];
    }
    else if ([aService length] == 0)
    {
        [NSException raise: NSInvalidArgumentException
                    format: @"%s 服务参数不能为空",
         __PRETTY_FUNCTION__];
    }
    
    BOOL saveSuccessful = YES;
    
    // 如果该项为nil，则尝试从密钥链中删除它。
    if (object == nil)
    {
        saveSuccessful = [self deleteItemForKey:aKey
                                        service:aService
                                          group:aGroup];
    }
    else
    {
        // 从密钥链中加载密钥、服务和访问组的项，以检查它是否已经存在。
        NSError *itemFromKeychainError = nil;
        NSDictionary *itemFromKeychain = [self p_itemAttributesAndDataForKey:aKey
                                                                  forService:aService
                                                                      aGroup:aGroup];
        
        // 如果在检查项目是否存在时出现除“项目未找到”以外的任何错误，则立即退出。
        if (itemFromKeychain == nil
            && [itemFromKeychainError code] != errSecItemNotFound)
        {
            // 返回NO，因为检查项是否存在失败。
            saveSuccessful = NO;
            
        }
        // 否则，如果在检查项是否存在时密钥链没有出错，则继续将该项保存到密钥链。
        else
        {
            // 将项目存档，以便将其保存到密钥链。
            NSData *valueData = [NSKeyedArchiver archivedDataWithRootObject:object
                                                      requiringSecureCoding:YES
                                                                      error:nil];
            itemFromKeychain = nil;
            // 如果该项不存在，则将其添加到密钥链。
            if (itemFromKeychain == nil)
            {
                NSMutableDictionary *attributes = [ZMMKeychainQuery getKeychainBaseQueryDictionaryForKey:aKey
                                                                                                 service:aService
                                                                                                   group:aGroup];
                
                [attributes setObject: valueData
                               forKey: (__bridge id)kSecValueData];
                
                if (aAccessible == KKeychainAccessibleAfterFirstUnlock)
                {
                    [attributes setObject: (__bridge id)kSecAttrAccessibleAfterFirstUnlock
                                   forKey: (__bridge id)kSecAttrAccessible];
                }
                else if (aAccessible == KKeychainAccessibleWhenUnlocked)
                {
                    [attributes setObject: (__bridge id)kSecAttrAccessibleWhenUnlocked
                                   forKey: (__bridge id)kSecAttrAccessible];
                }
                else
                {
                    [attributes setObject: (__bridge id)kSecAttrAccessibleAlwaysThisDeviceOnly
                                   forKey: (__bridge id)kSecAttrAccessible];
                }
                
                OSStatus resultCode = SecItemAdd((__bridge CFDictionaryRef)attributes, NULL);
                
                // 检查保存是否成功。
                if (resultCode != errSecSuccess)
                {
                    // 返回NO，因为保存项失败。
                    saveSuccessful = NO;
                    
                }
            }
            // 如果项确实存在，则更新密钥链中的项。
            else
            {
                NSDictionary *queryDictionary = [ZMMKeychainQuery getKeychainBaseQueryDictionaryForKey:aKey
                                                                                               service:aService
                                                                                                 group:aGroup];
                
                NSDictionary *attributesToUpdate = [NSDictionary dictionaryWithObjectsAndKeys:
                                                    valueData,
                                                    (__bridge id)kSecValueData,
                                                    nil];
                
                OSStatus resultCode = SecItemUpdate((__bridge CFDictionaryRef)queryDictionary, (__bridge CFDictionaryRef)attributesToUpdate);
                
                // 检查更新是否成功.
                if (resultCode != errSecSuccess)
                {
                    // 返回NO，因为更新项失败。
                    saveSuccessful = NO;
                    NSAssert( resultCode != errSecSuccess, @"检查更新失败" );
                }
            }
        }
    }
    
    return saveSuccessful;
}

+(id)loadObjectForKey:(nonnull NSString *)aKey
              service:(nonnull NSString *)aService
                group:(nullable NSString *)aGroup

{
    //从密钥链加载项。
    NSDictionary *itemAttributesAndData = [self p_itemAttributesAndDataForKey:aKey
                                                                   forService:aService
                                                                       aGroup:aGroup];
    //提取项的值数据。
    NSData *rawData = nil;
    
    if (itemAttributesAndData != nil)
    {
        rawData = [itemAttributesAndData objectForKey: (__bridge id)kSecValueData];
    }
    //解压缩从密钥链接收的数据。
    id object = nil;
    
    if (rawData != nil)
    {
        object = [NSKeyedUnarchiver unarchivedObjectOfClass:self
                                                   fromData:rawData
                                                      error:nil];
    }
    return object;
}

+ (BOOL)deleteItemForKey:(nonnull NSString *)aKey
                 service:(nonnull NSString *)aService
                   group:(nullable NSString *)aGroup
{
    //如果键或服务参数为空，则引发异常
    if ([aKey length] == 0)
    {
        [NSException raise: NSInvalidArgumentException
                    format: @"%s键参数不能为空",
         __PRETTY_FUNCTION__];
    }
    else if ([aService length] == 0)
    {
        [NSException raise: NSInvalidArgumentException
                    format: @"%s服务参数不能为空",
         __PRETTY_FUNCTION__];
    }
    
    // 假设删除将成功。
    BOOL deleteSuccessful = YES;
    
    //从密钥链中删除项。
    NSDictionary *queryDictionary = [ZMMKeychainQuery getKeychainBaseQueryDictionaryForKey:aKey
                                                                                   service:aService
                                                                                     group:aGroup];
    
    OSStatus resultCode = SecItemDelete((__bridge CFDictionaryRef)queryDictionary);
    
    // 检查删除是否成功。
    if (resultCode != errSecSuccess)
    {
        // 返回NO，因为删除项失败。
        deleteSuccessful = NO;
    }
    
    return deleteSuccessful;
}

#pragma mark - Privated Method
+ (NSDictionary *)p_itemAttributesAndDataForKey:(NSString *)aKey
                                    forService:(NSString *)aService
                                        aGroup:(NSString *)aGroup

{
    //如果键或服务参数为空，则引发异常
    if ([aKey length] == 0)
    {
        [NSException raise: NSInvalidArgumentException
                    format: @"%s 键参数不能为空",
         __PRETTY_FUNCTION__];
    }
    else if ([aService length] == 0)
    {
        [NSException raise: NSInvalidArgumentException
                    format: @"%s 服务参数不能为空",
         __PRETTY_FUNCTION__];
    }
    
    //从匹配密钥、服务和访问组的密钥链加载项。
    NSMutableDictionary *queryDictionary = [ZMMKeychainQuery getKeychainBaseQueryDictionaryForKey:aKey
                                                                                          service:aService
                                                                                            group:aGroup];
    
    [queryDictionary setObject: (__bridge id)kSecMatchLimitOne
                        forKey: (__bridge id)kSecMatchLimit];
    [queryDictionary setObject: (id)kCFBooleanTrue
                        forKey: (__bridge id)kSecReturnAttributes];
    [queryDictionary setObject: (id)kCFBooleanTrue
                        forKey: (__bridge id)kSecReturnData];
    
    CFTypeRef itemAttributesAndDataTypeRef = nil;
    OSStatus resultCode = SecItemCopyMatching((__bridge CFDictionaryRef)queryDictionary, &itemAttributesAndDataTypeRef);
    
    NSDictionary *itemAttributesAndData = nil;
    NSError *error;
    if (resultCode != errSecSuccess)
    {
        if (error != NULL)
        {
            NSAssert( resultCode != errSecSuccess, @"copy失败" );
        }
    }
    else
    {
        itemAttributesAndData = [[NSDictionary alloc] initWithDictionary:(__bridge NSDictionary *)itemAttributesAndDataTypeRef];
    }
    if (itemAttributesAndDataTypeRef != NULL) {
        
        CFRelease(itemAttributesAndDataTypeRef);
        itemAttributesAndDataTypeRef = NULL;
    }
    
    return itemAttributesAndData;
}

@end
