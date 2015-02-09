//
//  FollowerTableViewCell.m
//  iGithub
//
//  Created by Jack Yin on 15/2/7.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import "VcardStatsTableViewCell.h"
#import "VCardStats.h"
#import "Macros.h"

@interface VcardStatsTableViewCell ()
@property (nonatomic, strong) VcardStats *followers;
@property (nonatomic, strong) VcardStats *stars;
@property (nonatomic, strong) VcardStats *following;
@property (nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation VcardStatsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self settupViews];
        [self setNeedsUpdateConstraints];
    }
    
    return self;
}

- (void)setupFollowers {
    _followers = [[VcardStats alloc] initWithFrame:CGRectZero];
    _followers.translatesAutoresizingMaskIntoConstraints = NO;
    _followers.vcardStatCount = @"18";
    _followers.textMuted = @"Followers";
    [self.contentView addSubview:_followers];

}

- (void)setupStars {
    _stars = [[VcardStats alloc] initWithFrame:CGRectZero];
    _stars.translatesAutoresizingMaskIntoConstraints = NO;
    _stars.vcardStatCount = @"289";
    _stars.textMuted = @"Starred";
    [self.contentView addSubview:_stars];

}

- (void)setupFollowing {
    _following = [[VcardStats alloc] initWithFrame:CGRectZero];
    _following.translatesAutoresizingMaskIntoConstraints = NO;
    _following.vcardStatCount = @"74";
    _following.textMuted = @"Following";
    [self.contentView addSubview:_following];

}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.stars
                                                                     attribute:NSLayoutAttributeCenterX
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeCenterX
                                                                    multiplier:1.f
                                                                      constant:0.f]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.stars
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1.f
                                                                      constant:0.f]];
        
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_followers, _stars, _following);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-31-[_stars]-31-|"
                                                                                 options:kNilOptions
                                                                                 metrics:nil
                                                                                   views:viewsDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_followers]-(>=60)-[_stars]-(>=60)-[_following]"
                                                                                 options:NSLayoutFormatAlignAllCenterY
                                                                                 metrics:nil
                                                                                   views:viewsDictionary]];
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

- (void)settupViews {
    [self setupFollowers];
    [self setupStars];
    [self setupFollowing];
}

@end
