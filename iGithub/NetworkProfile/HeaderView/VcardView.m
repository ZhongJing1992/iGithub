//
//  VcardView.m
//  iGithub
//
//  Created by Jack Yin on 15/2/10.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import "VcardView.h"
#import "Macros.h"
#import "Constants.h"
#import "KeychainWrapper.h"

#import <OctoKit/OctoKit.h>

@interface VcardView ()
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *loginLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *blogLabel;
@end

@implementation VcardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromHex(0x2C3C59);
        
        [self setupVcardAvatar];
        [self setupVcardDetails];
    }
    
    return self;
}

- (void)setAvatarImage:(UIImage *)avatarImage {
    _avatarImageView.image = avatarImage;
}

- (void)setLogin:(NSString *)login {
    _loginLabel.text = login;
}

- (void)setLocation:(NSString *)location {
    _locationLabel.text = location;
}

- (void)setBlog:(NSString *)blog {
    _blogLabel.text = blog;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(320, 91);
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        [self.avatarImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.spinner
                                                                attribute:NSLayoutAttributeCenterX
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.avatarImageView
                                                                attribute:NSLayoutAttributeCenterX
                                                               multiplier:1.f
                                                                 constant:0.f]];
        
        [self.avatarImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.spinner
                                                                attribute:NSLayoutAttributeCenterY
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.avatarImageView
                                                                attribute:NSLayoutAttributeCenterY
                                                               multiplier:1.f
                                                                 constant:0.f]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarImageView
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.avatarImageView
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1.f
                                                          constant:0.f]];
        
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_avatarImageView, _loginLabel, _locationLabel, _blogLabel);
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_avatarImageView]-10-|"
                                                                     options:kNilOptions
                                                                     metrics:nil
                                                                       views:viewsDictionary]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_avatarImageView]-8-[_locationLabel]"
                                                                     options:NSLayoutFormatAlignAllCenterY
                                                                     metrics:nil
                                                                       views:viewsDictionary]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_loginLabel]-6-[_locationLabel]-5-[_blogLabel]"
                                                                     options:NSLayoutFormatAlignAllLeft
                                                                     metrics:nil
                                                                       views:viewsDictionary]];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

- (void)setupVcardAvatar {
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.cornerRadius = 3.0f;
    self.avatarImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.avatarImageView];
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.spinner.translatesAutoresizingMaskIntoConstraints = NO;
    self.spinner.color = [UIColor blackColor];
    self.spinner.hidesWhenStopped = YES;
    [self.avatarImageView addSubview:self.spinner];

}

- (void)setupVcardDetails {
    self.loginLabel = [[UILabel alloc] init];
    self.loginLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.loginLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    self.loginLabel.text = @"Your Login Name";
    self.loginLabel.textColor = [UIColor whiteColor];
    
    self.locationLabel = [[UILabel alloc] init];
    self.locationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.locationLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    self.locationLabel.text = @"Your Location";
    self.locationLabel.textColor = UIColorFromHex(0x7888A6);
    
    self.blogLabel = [[UILabel alloc] init];
    self.blogLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.blogLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    self.blogLabel.text = @"Your Blog Site";
    self.blogLabel.textColor = UIColorFromHex(0x91A6C7);
    
    [self addSubview:self.loginLabel];
    [self addSubview:self.locationLabel];
    [self addSubview:self.blogLabel];
}

@end
