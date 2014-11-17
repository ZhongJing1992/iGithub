//
//  ViewController.m
//  iGithub
//
//  Created by Wonder on 14/11/17.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import "ViewController.h"
#import <OctoKit.h>

static NSString * clientID = @"4a4616654a78c72f9ce1";
static NSString * clientSecret = @"f50bed3c41cfe0fe1fd878c9931e7e62bac896ef";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [OCTClient setClientID:clientID clientSecret:clientSecret];
}

- (IBAction)signIn:(UIButton *)sender {
    [[OCTClient signInToServerUsingWebBrowser:OCTServer.dotComServer scopes:OCTClientAuthorizationScopesUser] subscribeNext:^(OCTClient *authenticatedClient) {
        // Authentication was successful.
        NSLog(@"succeed!");
    } error:^(NSError *error) {
        // Authentication failed.
        NSLog(@"failed!");
    }];
}


@end
