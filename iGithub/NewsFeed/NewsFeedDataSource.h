//
//  NewsFeedStore.h
//  iGithub
//
//  Created by Jack Yin on 15/3/6.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UITableView.h>

@interface NewsFeedDataSource : NSObject <UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *events;
- (void)fetchNewsFeed;
@end
