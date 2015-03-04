//
//  MenuCellTableViewCell.m
//  iGithub
//
//  Created by Jack Yin on 15/3/3.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "Macros.h"

@interface MenuTableViewCell ()
@property (nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation MenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 3;
        [_avatarImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_avatarImageView setBackgroundColor:[UIColor whiteColor]];
        
        _loginNameLabel = [[UILabel alloc] init];
        _loginNameLabel.textColor = [UIColor whiteColor];
        [_loginNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self.contentView addSubview:_avatarImageView];
        [self.contentView addSubview:_loginNameLabel];
        
        [self setNeedsUpdateConstraints];
    }
    
    return self;
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_avatarImageView, _loginNameLabel);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_avatarImageView(30)]-[_loginNameLabel]"
                                                                                options:NSLayoutFormatAlignAllCenterY
                                                                                metrics:nil
                                                                                  views:viewsDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_avatarImageView(30)]-|"
                                                                                 options:kNilOptions
                                                                                 metrics:nil
                                                                                   views:viewsDictionary]];
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor colorWithRed:216.0/255.0 green:217.0/255.0 blue:219.0/255.0 alpha:0.5];
        self.backgroundView = backgroundView;
    } else {
        self.backgroundView = nil;
    }
}

@end
