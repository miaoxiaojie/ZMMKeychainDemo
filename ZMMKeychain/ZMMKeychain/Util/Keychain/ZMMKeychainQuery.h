//
//  ZMMKeychainQuery.h
//  ZMMKeychain
//
//  Created by miao on 2019/5/23.
//  Copyright © 2019年 miao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMMKeychainQuery : NSObject

/**
 获得NSMutableDictionary

 @param akey key值
 @param aService 服务名
 @param aGroup 应用之间共享信息
 @return 数据
 */
+ (NSMutableDictionary *)getKeychainBaseQueryDictionaryForKey:(nonnull NSString *)akey
                                                      service:(nonnull NSString *)aService
                                                        group:(nullable NSString *)aGroup;


@end

NS_ASSUME_NONNULL_END
