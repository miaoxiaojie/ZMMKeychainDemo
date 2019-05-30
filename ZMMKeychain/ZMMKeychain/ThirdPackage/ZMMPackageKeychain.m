//
//  ZMMPackageKeychain.m
//  ZMMKeychain
//
//  Created by miao on 2019/5/22.
//  Copyright © 2019年 miao. All rights reserved.
//

#import "ZMMPackageKeychain.h"
#import "SAMKeychain.h"

@implementation ZMMPackageKeychain

+ (NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account
{
  return [SAMKeychain passwordForService:serviceName account:account];
}

+ (NSData *)passwordDataForService:(NSString *)serviceName account:(NSString *)account
{
    return [SAMKeychain passwordDataForService:serviceName account:account];
}

+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account
{
   return [SAMKeychain setPassword:password forService:serviceName account:account];
}

+ (BOOL)setPasswordData:(NSData *)password forService:(NSString *)serviceName account:(NSString *)account
{
    return [SAMKeychain setPasswordData:password forService:serviceName account:account];
}

+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account
{
    return [SAMKeychain deletePasswordForService:serviceName account:account];
}

@end
