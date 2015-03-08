//
//  OctoKitClient.m
//  iGithub
//
//  Created by Jack Yin on 15/2/28.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import "OauthUtility.h"
#import "KeychainWrapper.h"
#import "Constants.h"

@implementation OauthUtility

+ (OCTClient *)authenticatedClient {
    OCTUser *user = [OCTUser userWithRawLogin:[KeychainWrapper valueForIdentifier:kRawLogin] server:OCTServer.dotComServer];
    OCTClient *client = [OCTClient authenticatedClientWithUser:user token:[KeychainWrapper valueForIdentifier:kAccessTokenKey]];
    
    return client;
}

@end
