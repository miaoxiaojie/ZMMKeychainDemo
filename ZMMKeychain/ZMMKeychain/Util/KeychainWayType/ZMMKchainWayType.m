//
//  ZMMKchainWayType.m
//  ZMMKeychain
//
//  Created by miao on 2019/5/28.
//  Copyright © 2019年 miao. All rights reserved.
//

#import "ZMMKchainWayType.h"
#define ZMM_AppleKeyChain_UUIDKey @"ZMM_AppleKeyChain_UUIDKey"
#define ZMM_SecurityKeyChain_Key @"ZMM_SecurityKeyChain_Key"

#define ZMM_AppleKeyChain_UUID @"AppleKeyChain_319cbzcnc39x x"
#define ZMM_SAMKeyChain_Username @"SAM——13223987834"
#define ZMM_SecurityKeyChain_UUID @"SecurityKeyChain_fvfff4444"

#define ZMM_getPassword  @"zhuiqnxmxzm@121322"
#define ZMM_getSecurity  @"@$@#$@2348u9289304-324mqopcm"

#define ZMM_SAMKeyChain_server @"ZMM_SAMKeyChain_server"
#define ZMM_SecurityKeyChain_server @"ZMM_SecurityKeyChain_server"

@implementation ZMMKchainWayType


static NSString *getkeychainWayKey(keychainWayType wayType)
{
        if (wayType == KAppKeychain) {
            return ZMM_AppleKeyChain_UUIDKey;
        }else if (wayType == KSecurityTypeKeychain){
            return ZMM_SecurityKeyChain_Key;
        }
    return @"zmm";
}

static NSString *getkeychainWayServer(keychainWayType wayType)
{
    if (wayType == KSAMKeychain){
        return ZMM_SAMKeyChain_server;
    }else if (wayType == KSecurityTypeKeychain){
        return ZMM_SecurityKeyChain_server;
    }
    return @"zmm";
}
static NSString *getSavekeychainUUID(keychainWayType wayType)
{
    if (wayType == KAppKeychain) {
        return ZMM_AppleKeyChain_UUID;
    }else if (wayType == KSAMKeychain){
        return ZMM_SAMKeyChain_Username;
    }else if (wayType == KSecurityTypeKeychain){
        return ZMM_SecurityKeyChain_UUID;
    }
    return @"zmm";
}

static NSString *getPassword()
{
    return ZMM_getPassword;
}

static NSString *getSecurity()
{
    return ZMM_getSecurity;
}

const struct ZMMKeychainUtilType keychainUtilType = {
    .getkeychainWayKey = getkeychainWayKey,
    .getSavekeychainUUID = getSavekeychainUUID,
    .getPassword = getPassword,
    .getkeychainWayServer = getkeychainWayServer,
    .getSecurity = getSecurity,
};

@end
