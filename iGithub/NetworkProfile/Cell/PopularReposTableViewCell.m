//
//  PopularReposTableViewCell.m
//  iGithub
//
//  Created by Jack Yin on 15/2/10.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import "PopularReposTableViewCell.h"
#import "Macros.h"

@interface PopularReposTableViewCell ()
@property (nonatomic, strong) UIImageView *octiconRepo;
@property (nonatomic, strong) UIImageView *octiconStar;
@property (nonatomic, strong) UILabel *repoTitleLabel;
@property (nonatomic, strong) UILabel *repoDescriptionLabel;
@property (nonatomic, strong) UILabel *repoStarsLabel;
@property (nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation PopularReposTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        _octiconRepo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OctRepo"]];
        _octiconRepo.translatesAutoresizingMaskIntoConstraints = NO;
        
        _octiconStar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OctStar"]];
        _octiconStar.translatesAutoresizingMaskIntoConstraints = NO;
        
        _repoTitleLabel = [[UILabel alloc] init];
        _repoTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _repoTitleLabel.numberOfLines = 1;
        _repoTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
        _repoTitleLabel.text = @" ";
        _repoTitleLabel.textColor = UIColorFromHex(0x333333);
        
        _repoDescriptionLabel = [[UILabel alloc] init];
        _repoDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _repoDescriptionLabel.numberOfLines = 0;
        _repoDescriptionLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:10];
        _repoDescriptionLabel.text = @" ";
        _repoDescriptionLabel.textColor = UIColorFromHex(0x888888);
        
        _repoStarsLabel = [[UILabel alloc] init];
        _repoStarsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _repoStarsLabel.numberOfLines = 1;
        _repoStarsLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:10];
        _repoStarsLabel.text = @"-";
        _repoStarsLabel.textAlignment = NSTextAlignmentCenter;
        _repoStarsLabel.textColor = UIColorFromHex(0x888888);
        
        [self.contentView addSubview:_octiconRepo];
        [self.contentView addSubview:_repoTitleLabel];
        [self.contentView addSubview:_repoDescriptionLabel];
        [self.contentView addSubview:_repoStarsLabel];
        [self.contentView addSubview:_octiconStar];
        
        [self setNeedsUpdateConstraints];
    }
    
    return self;
}

- (void)setRepoTitle:(NSString *)repoTitle {
    _repoTitleLabel.text = repoTitle;
}

- (void)setRepoDescription:(NSString *)repoDescription {
    if (repoDescription.length != 0) {
        _repoDescriptionLabel.text = repoDescription;
    } else {
        _repoDescriptionLabel.text = @" ";
    }
}

- (void)setRepoStars:(NSUInteger)repoStars {
    _repoStarsLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)repoStars];
}


- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_octiconRepo, _repoTitleLabel, _repoDescriptionLabel, _repoStarsLabel, _octiconStar);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-9-[_octiconRepo]" options:kNilOptions metrics:nil views:viewsDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_octiconRepo]-7-[_repoTitleLabel]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_repoTitleLabel]-3-[_repoDescriptionLabel]-7-|" options:NSLayoutFormatAlignAllLeft metrics:nil views:viewsDictionary]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.octiconStar attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.f constant:1.f]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_repoStarsLabel]-4-[_octiconStar]-14-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary]];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

@end
