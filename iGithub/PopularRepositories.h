//
//  PopularRepositories.h
//  iGithub
//
//  Created by Jack Yin on 15/2/13.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OctoKit/OctoKit.h>

@interface PopularRepositories : NSObject <UITableViewDataSource>
@property (nonatomic, strong) NSArray *popularRepos;
- (OCTRepository *)repositoryForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
