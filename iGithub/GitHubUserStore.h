//
//  GitHubUserStore.h
//  iGithub
//
//  Created by Jack Yin on 15/3/2.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MenuTableViewCell.h"

@interface GitHubUserStore : NSObject
+ (void)fetchEntityDataForDefaultCell:(MenuTableViewCell *)cell;
@end
