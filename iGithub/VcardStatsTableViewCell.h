//
//  FollowerTableViewCell.h
//  iGithub
//
//  Created by Jack Yin on 15/2/7.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCardStats.h"

@interface VcardStatsTableViewCell : UITableViewCell
@property (nonatomic, strong) VcardStats *followers;
@property (nonatomic, strong) VcardStats *stars;
@property (nonatomic, strong) VcardStats *following;
@end
