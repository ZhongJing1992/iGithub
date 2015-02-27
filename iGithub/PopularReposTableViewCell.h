//
//  PopularReposTableViewCell.h
//  iGithub
//
//  Created by Jack Yin on 15/2/10.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopularReposTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString *repoTitle;
@property (nonatomic, strong) NSString *repoDescription;
@property (nonatomic, assign) NSUInteger repoStars;
@end
