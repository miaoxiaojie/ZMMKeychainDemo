//
//  ZMMKeychain.h
//  ZMMKeychain
//
//  Created by miao on 2019/5/22.
//  Copyright © 2019年 miao. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, kKeychainAccessible)
{
    KKeychainAccessibleWhenUnlocked,//表示获取当前密钥只要屏幕处于解锁状态就可以了
    KKeychainAccessibleAfterFirstUnlock,//表示手机第一次解锁就可以获取当前密钥
    KKeychainAccessibleAlwaysThisDeviceOnly,//总是可以获取，当然也是设备唯一指定
    KKeychainAccessibleUnknow//
};

NS_ASSUME_NONNULL_BEGIN

@interface ZMMKeychain : NSObject

/**
 保存数据

 @param object 数据
 @param aKey key值
 @param aService 服务值
 @param aGroup 应用之间共享信息
 @param aAccessible 什么条件下获取内容
 @return 成功YES,否则NO
 */
+(BOOL)savekeyChainWithValue:(id)object
                         key:(nonnull NSString *)aKey
                     service:(nonnull NSString *)aService
                      group:(nullable NSString *)aGroup
                 accessible:(kKeychainAccessible)aAccessible;
/**
 下载数据

 @param aKey key值
 @param aService 服务值
 @param aGroup 应用之间共享信息
 @return 返回的数据
 */
+(id)loadObjectForKey:(nonnull NSString *)aKey
              service:(nonnull NSString *)aService
                group:(nullable NSString *)aGroup;
/**
 删除数据

 @param aKey key值
 @param aService 服务值
 @param aGroup 应用之间共享信息
 @return 删除成功YES,否则NO
 */
+ (BOOL)deleteItemForKey:(nonnull NSString *)aKey
                 service:(nonnull NSString *)aService
                   group:(nullable NSString *)aGroup;

@end

NS_ASSUME_NONNULL_END
