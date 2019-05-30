//
//  ZMMPackageKeychain.h
//  ZMMKeychain
//
//  Created by miao on 2019/5/22.
//  Copyright © 2019年 miao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMMPackageKeychain : NSObject

/**
 *  返回指定服务和用户名的密码值,返回格式为NSString
 *
 *  @param serviceName 服务名
 *  @param account       用户名
 *
 *  @return 指定服务名和用户名的密码
 */
+ (NSString *)passwordForService:(nonnull NSString *)serviceName
                         account:(nonnull NSString *)account;

/**
 *  返回指定服务和用户名的密码值,返回格式为NSData
 *
 *  @param serviceName 服务名
 *  @param account     用户名
 *
 *  @return 指定服务名和用户名的密码
 */
+ (NSData *)passwordDataForService:(nonnull NSString *)serviceName
                           account:(nonnull NSString *)account;

/**
 *  keychain中设置密码
 *
 *  @param password    密码,格式为NSString
 *  @param serviceName 服务名
 *  @param account     用户名
 *
 *  @return 成功YES,否则NO
 */
+ (BOOL)setPassword:(nullable NSString *)password
         forService:(nonnull NSString *)serviceName
            account:(nonnull NSString *)account;

/**
 *  keychain中设置密码
 *
 *  @param password    密码,格式为NSData
 *  @param serviceName 服务名
 *  @param account     用户名
 *
 *  @return 成功YES,否则NO
 */
+ (BOOL)setPasswordData:(nullable NSData *)password
             forService:(nonnull NSString *)serviceName
                account:(nonnull NSString *)account;

/**
 *  删除keychain中的密码
 *
 *  @param serviceName 服务名
 *  @param account     用户名
 *
 *  @return 成功YES,否则NO
 */
+ (BOOL)deletePasswordForService:(nonnull NSString *)serviceName
                         account:(nonnull NSString *)account;



@end

NS_ASSUME_NONNULL_END
