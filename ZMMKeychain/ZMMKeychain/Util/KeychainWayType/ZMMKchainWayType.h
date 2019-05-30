//
//  ZMMKchainWayType.h
//  ZMMKeychain
//
//  Created by miao on 2019/5/28.
//  Copyright © 2019年 miao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMMDetailedViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZMMKchainWayType : NSObject

extern const struct ZMMKeychainUtilType
{
    NSString *(*getkeychainWayKey)(keychainWayType);
    NSString *(*getkeychainWayServer)(keychainWayType);
    NSString *(*getSavekeychainUUID)(keychainWayType);
    NSString *(*getPassword)(void);
    NSString *(*getSecurity)(void);
}keychainUtilType;

@end

NS_ASSUME_NONNULL_END
