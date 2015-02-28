//
//  AccessKeyChain.h
//  iGithub
//
//  Created by Wonder on 14/11/18.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

/**
 *  Keychain 服务的 Objective-C 封装，
 *  用来保存 Oauth 2 的 AccessToken。
 */
@interface KeychainWrapper : NSObject

// 调用 searchKeychainCopyMatchingIdentifier: 并转换成一个字符串值。
+ (NSString *)valueForIdentifier:(NSString *)identifier;

// Default initializer to store a value in the keychain.
// Associated properties are handled for you (setting Data Protection Access, Company Identifer (to uniquely identify string, etc).
+ (BOOL)setValue:(NSString *)value forIdentifier:(NSString *)identifier;

// Delete a value in the keychain
+ (void)removeValueForIdentifier:(NSString *)identifier;

// Updates a value in the keychain.  If you try to set the value with createKeychainValue: and it already exists
// this method is called instead to update the value in place.
+ (BOOL)updateValue:(NSString *)value forIdentifier:(NSString *)identifier;

@end
