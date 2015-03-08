//
//  NewsFeedStore.m
//  iGithub
//
//  Created by Jack Yin on 15/3/6.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import "NewsFeedDataSource.h"
#import <OctoKit/OctoKit.h>
#import "OauthUtility.h"
#import "KeychainWrapper.h"
#import "Constants.h"
#import "NewsFeedTableViewCell.h"

@implementation NewsFeedDataSource

- (void)fetchNewsFeed {
    RACSignal *userInfo = [[OauthUtility authenticatedClient] fetchUserInfo];
    RACSignal *events = [[userInfo flattenMap:^RACStream *(OCTUser *user) {
        OCTClient *client = [OCTClient authenticatedClientWithUser:user token:[KeychainWrapper valueForIdentifier:kAccessTokenKey]];
        return [client fetchUserEventsNotMatchingEtag:nil];
    }] map:^id(OCTResponse *response) {
        return response.parsedResult;
    }];
    
    [[events collect] subscribeNext:^(id x) {
        self.events = x;
        NSLog(@"Data Done");
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsFeedCell"];
    
    if (!cell) {
        NSArray *parts = [[NSBundle mainBundle] loadNibNamed:@"NewsFeedTableViewCell" owner:nil options:nil];
        cell = [parts objectAtIndex:0];
    }
    
    [[[self signalForAvatarAtIndexPath:indexPath] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(UIImage *image) {
        cell.avatar.image = image;
    }];
    
    [[[self signalForEventAtIndexPath:indexPath] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(OCTEvent *event) {
        cell.login.text = event.actorLogin;
    }];
    
    return cell;
}

- (RACSignal *)signalForEventAtIndexPath:(NSIndexPath *)indexPath {
    @weakify(self)
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        OCTEvent *event = [self.events objectAtIndex:indexPath.row];
        
        [subscriber sendNext:event];
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    return signal;
}

- (RACSignal *)signalForAvatarAtIndexPath:(NSIndexPath *)indexPath {
    RACScheduler *scheduler = [RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground];

    @weakify(self)
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        OCTEvent *event = [self.events objectAtIndex:indexPath.row];
        UIImage *avatar = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:event.actorAvatarURL]];
        [subscriber sendNext:avatar];
        [subscriber sendCompleted];

        return nil;
    }] subscribeOn:scheduler];
    
    return signal;
}


@end
