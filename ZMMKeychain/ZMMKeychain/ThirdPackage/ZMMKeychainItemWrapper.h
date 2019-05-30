//
//  ZMMKeychainItemWrapper.h
//  ZMMKeychain
//
//  Created by miao on 2019/5/28.
//  Copyright © 2019年 miao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMMKeychainItemWrapper : NSObject

/**
 保存数据

 @param identifier 标识符
 @param object 数据
 @param aGroup 应用之间共享信息
 @return Yes
 */
+(BOOL)saveItemWrapperWithIdentifier:(nonnull NSString *)identifier
                              object:(id)object
                              aGroup:(nullable NSString *)aGroup;

/**
 加载数据

 @param identifier 标识符
 @param aGroup 应用之间共享信息
 @return 数据
 */
+(id)loadObjectWithIdentifier:(nonnull NSString *)identifier
                       aGroup:(nullable NSString *)aGroup;


/**
 删除数据

 @param identifier 标识符
 @param aGroup 应用之间共享信息
 @return Yes;
 */
+(BOOL)deleteObjectForIdentifier:(nonnull NSString *)identifier
                          aGroup:(nullable NSString *)aGroup;

@end

NS_ASSUME_NONNULL_END
