//
//  ViewController.m
//  iGithub
//
//  Created by Wonder on 14/11/17.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import "LoginViewController.h"
#import "SideViewController.h"
#import "KeychainWrapper.h"
#import "Constants.h"

#import <OctoKit.h>


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [OCTClient setClientID:kClientID clientSecret:kClientSecret];
}

- (IBAction)signIn:(UIButton *)sender {
    [[OCTClient signInToServerUsingWebBrowser:OCTServer.dotComServer scopes:OCTClientAuthorizationScopesUser] subscribeNext:^(OCTClient *authenticatedClient) {
        [KeychainWrapper setValue:authenticatedClient.token forIdentifier:kAccessTokenKey];
        NSAssert(authenticatedClient.token, @"NO Token!");
        NSLog(@"token:%@", [KeychainWrapper valueForIdentifier:kAccessTokenKey]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            SideViewController *sideViewController = [[SideViewController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = sideViewController;
        });
    } error:^(NSError *error) {
        // Authentication failed.
        NSLog(@"failed!");
    }];
}


@end
