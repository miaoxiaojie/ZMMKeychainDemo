//
//  ZMMDetailedViewController.h
//  ZMMKeychain
//
//  Created by miao on 2019/5/23.
//  Copyright © 2019年 miao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, keychainWayType)
{
    KSecurityTypeKeychain,
    KSAMKeychain,
    KAppKeychain
};

NS_ASSUME_NONNULL_BEGIN

@interface ZMMDetailedViewController : UIViewController

@property (nonatomic, assign) keychainWayType wayType;

@end

NS_ASSUME_NONNULL_END
