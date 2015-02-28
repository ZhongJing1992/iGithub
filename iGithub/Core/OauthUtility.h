//
//  OctoKitClient.h
//  iGithub
//
//  Created by Jack Yin on 15/2/28.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OctoKit/OctoKit.h>

@interface OauthUtility : NSObject
+ (OCTClient *)authenticatedClient;
@end
