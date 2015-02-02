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

#import <OctoKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    SideViewController *sideViewController = [[SideViewController alloc] init];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
    NSString *token = [KeychainWrapper valueForIdentifier:kAccessTokenKey];
    UIViewController *initialViewController = token ? sideViewController : loginViewController;
    
    self.window.rootViewController = initialViewController;

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
