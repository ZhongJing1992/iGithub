//
//  NewsFeedTableViewCell.m
//  iGithub
//
//  Created by Jack Yin on 15/3/4.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import "NewsFeedTableViewCell.h"

@interface NewsFeedTableViewCell ()

@end

@implementation NewsFeedTableViewCell

- (void)awakeFromNib {
    
    
    _avatar.layer.masksToBounds = YES;
    _avatar.layer.cornerRadius = 3;
    
}

- (void)layoutSubviews {
    [self.login sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
