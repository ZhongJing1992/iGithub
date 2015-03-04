//
//  ViewController.m
//  iGithub
//
//  Created by Wonder on 14/11/17.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import "LoginViewController.h"
#import "KeychainWrapper.h"
#import "Constants.h"

#import <JASidePanelController.h>
#import <OctoKit/OctoKit.h>


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
        [KeychainWrapper setValue:authenticatedClient.user.login forIdentifier:kLogin];
        NSAssert(authenticatedClient.token, @"NO Token!");
        NSLog(@"login:%@ token:%@", [KeychainWrapper valueForIdentifier:kLogin], [KeychainWrapper valueForIdentifier:kAccessTokenKey]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            JASidePanelController *jaSidePanelController = [[JASidePanelController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = jaSidePanelController;
        });
    } error:^(NSError *error) {
        // Authentication failed.
        NSLog(@"failed!");
    }];
}


@end
