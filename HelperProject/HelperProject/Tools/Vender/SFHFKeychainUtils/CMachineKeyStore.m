//
//  CMachineKeyStore.m
//  Leleda
//
//  Created by Bona on 14-7-2.
//  Copyright (c) 2014年 Leleda. All rights reserved.
//

#import "CMachineKeyStore.h"
#import "SFHFKeychainUtils.h"
#import <CommonCrypto/CommonDigest.h> 

__strong static CMachineKeyStore *singleton = nil;

@implementation CMachineKeyStore

+ (CMachineKeyStore *)sharedInstance
{
    // dispatch_once不仅意味着代码仅会被运行一次，而且还是线程安全的
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        singleton = [[super allocWithZone:NULL] init];
    });
    return singleton;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
- (NSString *)md5HexDigest:(NSString*)input
{

    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

- (NSString*) createAndStoreMachinKey
{
    NSUUID*pUUID = [[NSUUID alloc]init];
    NSString *md5str = [self md5HexDigest:[pUUID UUIDString]];
    md5str = [md5str substringWithRange:NSMakeRange(0,22)];
    NSLog(@"the new UUID is |%@|\n",md5str);
    BOOL bOK = [self setMachineKey:md5str];
    if (bOK) {
        return md5str;
    }
    return @"";
}

-(BOOL)isMachineKeyExsit
{
    NSError*pError = [[NSError alloc] init];
    NSString*MachineKey = [SFHFKeychainUtils getPasswordForUsername:@"leleda" andServiceName:@"machinekey" error:&pError];
    
    if (MachineKey.length == 0) {
        return FALSE;
    }
    
    return TRUE;

}
- (NSString*)getMachineKey
{
    NSError*pError = [[NSError alloc] init];
    NSString*MachineKey = [SFHFKeychainUtils getPasswordForUsername:@"leleda" andServiceName:@"machinekey" error:&pError];
    
    return MachineKey;
}
- (BOOL) deleteMachineKey
{
  return [SFHFKeychainUtils deleteItemForUsername:@"leleda" andServiceName:@"machinekey" error:nil];
}


- (BOOL)setMachineKey:(NSString*)strKey
{
    NSError*pError = [[NSError alloc] init];
    return [SFHFKeychainUtils storeUsername:@"leleda"
                                andPassword:strKey
                             forServiceName:@"machinekey"
                             updateExisting:FALSE
                                      error:&pError];
    

}

@end

