//
//  AppDelegate.m
//  iGithub
//
//  Created by Wonder on 14/11/17.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import "AppDelegate.h"
#import "KeychainWrapper.h"
#import "Constants.h"
#import "SideViewController.h"
#import "CenterViewController.h"
#import <OctoKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *token = [KeychainWrapper valueForIdentifier:kAccessTokenKey];
    if (token) {
        SideViewController *sideViewController = [[SideViewController alloc] init];
        sideViewController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[CenterViewController alloc] init]];
        
        self.window.rootViewController = sideViewController;
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
        
        self.window.rootViewController = loginViewController;
    }
    
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
