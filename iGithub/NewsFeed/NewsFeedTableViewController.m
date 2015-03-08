//
//  NewsTableViewController.m
//  iGithub
//
//  Created by Wonder on 14/11/18.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import "NewsFeedTableViewController.h"
#import "OauthUtility.h"
#import "KeychainWrapper.h"
#import "Constants.h"
#import "NewsFeedDataSource.h"
#import "NewsFeedTableViewCell.h"

@interface NewsFeedTableViewController () <UITableViewDataSource>
@property (nonatomic, strong) NewsFeedDataSource *news;
@end

@implementation NewsFeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.news = [[NewsFeedDataSource alloc] init];
    [self.news fetchNewsFeed];
    [[[RACObserve(self.news, events) filter:^BOOL(NSArray *events) {
        NSLog(@"%lu", (unsigned long)events.count);
        return events.count > 0;
    }] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        [self.tableView reloadData];
        NSLog(@"reload");
    }];
    self.tableView.dataSource = self.news;
}

- (void)dealloc {
    self.tableView.dataSource = nil;
}



@end
