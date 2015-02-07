//
//  FollowerTableViewCell.m
//  iGithub
//
//  Created by Jack Yin on 15/2/7.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import "FollowerTableViewCell.h"
#import "Macros.h"

@implementation FollowerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self settupViews];
    }
    
    return self;
}

- (void)settupViews {
    UILabel *followersNumbers = [[UILabel alloc] init];
    followersNumbers.translatesAutoresizingMaskIntoConstraints = NO;
    followersNumbers.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    followersNumbers.text = @"18";
    followersNumbers.textAlignment = NSTextAlignmentCenter;
    followersNumbers.textColor = UIColorFromHex(0x4183C4);
    [self.contentView addSubview:followersNumbers];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:followersNumbers
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.contentView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.f
                                                                   constant:30.f];
    [self.contentView addConstraint:constraint];
    
    UILabel *starredNumbers = [[UILabel alloc] init];
    starredNumbers.translatesAutoresizingMaskIntoConstraints = NO;
    starredNumbers.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    starredNumbers.text = @"289";
    starredNumbers.textAlignment = NSTextAlignmentCenter;
    starredNumbers.textColor = UIColorFromHex(0x4183C4);
    [self.contentView addSubview:starredNumbers];

    constraint = [NSLayoutConstraint constraintWithItem:starredNumbers
                                              attribute:NSLayoutAttributeCenterX
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.contentView
                                              attribute:NSLayoutAttributeCenterX
                                             multiplier:1.f
                                               constant:0.f];
    [self.contentView addConstraint:constraint];
    
    UILabel *followingNumbers = [[UILabel alloc] init];
    followingNumbers.translatesAutoresizingMaskIntoConstraints = NO;
    followingNumbers.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    followingNumbers.text = @"74";
    followingNumbers.textAlignment = NSTextAlignmentCenter;
    followingNumbers.textColor = UIColorFromHex(0x4183C4);
    [self.contentView addSubview:followingNumbers];

    constraint = [NSLayoutConstraint constraintWithItem:followingNumbers
                                              attribute:NSLayoutAttributeTop
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.contentView
                                              attribute:NSLayoutAttributeTop
                                             multiplier:1.f
                                               constant:30.f];
    [self.contentView addConstraint:constraint];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(followersNumbers, starredNumbers, followingNumbers);
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[followersNumbers]-58-[starredNumbers]-58-[followingNumbers]"
                                                                   options:NSLayoutFormatAlignAllBottom
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    [self.contentView addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[starredNumbers]-36-|" options:kNilOptions metrics:nil views:viewsDictionary];
    [self.contentView addConstraints:constraints];
    
//    UILabel *followersLabel = [[UILabel alloc] init];
//    followersLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    followersLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:8];
//    followersLabel.text = @"Followers";
//    followersLabel.textAlignment = NSTextAlignmentCenter;
//    followersLabel.textColor = UIColorFromHex(0x888888);
//    
//    UILabel *starredLabel = [[UILabel alloc] init];
//    starredLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    starredLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:8];
//    starredLabel.text = @"Starred";
//    starredLabel.textAlignment = NSTextAlignmentCenter;
//    starredLabel.textColor = UIColorFromHex(0x888888);
//    
//    constraint = [NSLayoutConstraint constraintWithItem:starredLabel
//                                              attribute:NSLayoutAttributeCenterY
//                                              relatedBy:NSLayoutRelationEqual
//                                                 toItem:self.contentView
//                                              attribute:NSLayoutAttributeCenterY
//                                             multiplier:1.f
//                                               constant:0.f];
//    [self.contentView addConstraint:constraint];
//    
//    UILabel *followingLabel = [[UILabel alloc] init];
//    followingLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    followingLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:8];
//    followingLabel.text = @"Following";
//    followingLabel.textAlignment = NSTextAlignmentCenter;
//    followingLabel.textColor = UIColorFromHex(0x888888);
//    
//    [self.contentView addSubview:followersLabel];
//    [self.contentView addSubview:starredLabel];
//    [self.contentView addSubview:followingLabel];
//    
//    viewsDictionary = NSDictionaryOfVariableBindings(followersLabel, starredLabel, followingLabel, followersNumbers);
//    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-51-[followersLabel]-60-[starredLabel]-60-[followingLabel]"
//                                                          options:NSLayoutFormatAlignAllTop
//                                                          metrics:nil
//                                                            views:viewsDictionary];
//    [self.contentView addConstraints:constraints];
//    
//    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[followersNumbers][followersLabel]" options:kNilOptions metrics:nil views:viewsDictionary];
//    [self.contentView addConstraints:constraints];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
