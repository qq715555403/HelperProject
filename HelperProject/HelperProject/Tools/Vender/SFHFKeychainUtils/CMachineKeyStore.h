//
//  CMachineKeyStore.h
//  Leleda
//
//  Created by Bona on 14-7-2.
//  Copyright (c) 2014年 Leleda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMachineKeyStore : NSObject

+ (CMachineKeyStore *)sharedInstance;
+ (id)allocWithZone:(NSZone *)zone;
- (id)copyWithZone:(NSZone *)zone;

- (BOOL)isMachineKeyExsit;
- (NSString*)getMachineKey;
- (BOOL)setMachineKey:(NSString*)strKey;
- (NSString*) createAndStoreMachinKey;
- (BOOL) deleteMachineKey;

@end
