//
//  AppDelegate.m
//  iGithub
//
//  Created by Wonder on 14/11/17.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import "AppDelegate.h"
#import <OctoKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.host isEqual:@"oauth"]) {
        [OCTClient completeSignInWithCallbackURL:url];
        
        return YES;
    } else {
        
        return NO;
    }
}

@end
