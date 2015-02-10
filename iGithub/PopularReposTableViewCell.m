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
@property (nonatomic, strong) UILabel *repoTitle;
@property (nonatomic, strong) UILabel *repoDescription;
@property (nonatomic, strong) UILabel *repoStars;
@property (nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation PopularReposTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _octiconRepo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OctRepo"]];
        _octiconRepo.translatesAutoresizingMaskIntoConstraints = NO;
        
        _octiconStar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OctStar"]];
        _octiconStar.translatesAutoresizingMaskIntoConstraints = NO;
        
        _repoTitle = [[UILabel alloc] init];
        _repoTitle.translatesAutoresizingMaskIntoConstraints = NO;
        _repoTitle.numberOfLines = 0;
        _repoTitle.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:10];
        _repoTitle.text = @"Subtitle";
        _repoTitle.textColor = UIColorFromHex(0x333333);
        
        _repoDescription = [[UILabel alloc] init];
        _repoDescription.translatesAutoresizingMaskIntoConstraints = NO;
        _repoDescription.numberOfLines = 0;
        _repoDescription.font = [UIFont fontWithName:@"STHeitiSC-Light" size:9];
        _repoDescription.text = @"网易斯坦福大学公开课：iOS 7应用开发字幕文件";
        _repoDescription.textColor = UIColorFromHex(0x888888);
        
        _repoStars = [[UILabel alloc] init];
        _repoStars.translatesAutoresizingMaskIntoConstraints = NO;
        _repoStars.numberOfLines = 0;
        _repoStars.font = [UIFont fontWithName:@"STHeitiSC-Light" size:10];
        _repoStars.text = @"150";
        _repoStars.textColor = UIColorFromHex(0x888888);
        
        [self.contentView addSubview:_octiconRepo];
        [self.contentView addSubview:_repoTitle];
        [self.contentView addSubview:_repoDescription];
        [self.contentView addSubview:_repoStars];
        [self.contentView addSubview:_octiconStar];
        
        [self setNeedsUpdateConstraints];
    }
    
    return self;
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_octiconRepo, _repoTitle, _repoDescription, _repoStars, _octiconStar);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-9-[_octiconRepo]" options:kNilOptions metrics:nil views:viewsDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_octiconRepo]-7-[_repoTitle]" options:NSLayoutFormatAlignAllTop metrics:nil views:viewsDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_repoTitle]-3-[_repoDescription]" options:NSLayoutFormatAlignAllLeft metrics:nil views:viewsDictionary]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_octiconStar]" options:kNilOptions metrics:nil views:viewsDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_repoStars]-4-[_octiconStar]-14-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary]];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

@end
