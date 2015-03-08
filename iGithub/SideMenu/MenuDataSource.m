//
//  MenuDataSource.m
//  iGithub
//
//  Created by Jack Yin on 15/3/4.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import "MenuDataSource.h"
#import "OauthUtility.h"
#import <OctoKit/OctoKit.h>

@interface MenuDataSource () <UITableViewDataSource>
@property (nonatomic, strong) OCTEntity *entity;
@end

@implementation MenuDataSource

- (void)fetchOCTEntity {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    RACSignal *userInfo = [[OauthUtility authenticatedClient] fetchUserInfo];
    [userInfo subscribeNext:^(OCTEntity *entity) {
        self.entity = entity;
    } error:^(NSError *error) {

    } completed:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
    }];
}

@end
