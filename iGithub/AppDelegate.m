//
//  AppDelegate.m
//  iGithub
//
//  Created by Wonder on 14/11/17.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import "AppDelegate.h"

#import "Macros.h"
#import "Constants.h"
#import "KeychainWrapper.h"
#import "LeftViewController.h"
#import "NetworkProfileViewController.h"
#import "NavigationController.h"

#import <OctoKit/OctoKit.h>
#import <JASidePanelController.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *token = [KeychainWrapper valueForIdentifier:kAccessTokenKey];
    if (token) {
        NavigationController *navController = [[NavigationController alloc] initWithRootViewController:[[NetworkProfileViewController alloc] init]];
        navController.navigationBar.barTintColor = UIColorFromHex(0x183B6D);
        JASidePanelController *jaSidePanelController = [[JASidePanelController alloc] init];
        jaSidePanelController.leftPanel = [[LeftViewController alloc] init];
        jaSidePanelController.centerPanel = navController;
        
        self.window.rootViewController = jaSidePanelController;
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
