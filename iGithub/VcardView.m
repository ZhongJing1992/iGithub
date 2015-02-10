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
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *login;
@property (nonatomic, strong) UILabel *location;
@property (nonatomic, strong) UILabel *blog;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
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

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(320, 91);
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        [self.avatar addConstraint:[NSLayoutConstraint constraintWithItem:self.spinner
                                                                attribute:NSLayoutAttributeCenterX
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.avatar
                                                                attribute:NSLayoutAttributeCenterX
                                                               multiplier:1.f
                                                                 constant:0.f]];
        
        [self.avatar addConstraint:[NSLayoutConstraint constraintWithItem:self.spinner
                                                                attribute:NSLayoutAttributeCenterY
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.avatar
                                                                attribute:NSLayoutAttributeCenterY
                                                               multiplier:1.f
                                                                 constant:0.f]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatar
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.avatar
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1.f
                                                          constant:0.f]];
        
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_avatar, _login, _location, _blog);
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_avatar(71)]" options:kNilOptions metrics:nil views:viewsDictionary]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_avatar]-8-[_location]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_login]-6-[_location]-5-[_blog]" options:NSLayoutFormatAlignAllLeft metrics:nil views:viewsDictionary]];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

- (void)setupVcardAvatar {
    self.avatar = [[UIImageView alloc] init];
    self.avatar.translatesAutoresizingMaskIntoConstraints = NO;
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = 3.0f;
    self.avatar.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.avatar];
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.spinner.translatesAutoresizingMaskIntoConstraints = NO;
    self.spinner.color = [UIColor blackColor];
    self.spinner.hidesWhenStopped = YES;
    [self.avatar addSubview:self.spinner];

}

- (void)setupVcardDetails {
    self.login = [[UILabel alloc] init];
    self.login.translatesAutoresizingMaskIntoConstraints = NO;
    self.login.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    self.login.text = @"Your Login Name";
    self.login.textColor = [UIColor whiteColor];
    
    self.location = [[UILabel alloc] init];
    self.location.translatesAutoresizingMaskIntoConstraints = NO;
    self.location.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    self.location.text = @"Your Location";
    self.location.textColor = UIColorFromHex(0x7888A6);
    
    self.blog = [[UILabel alloc] init];
    self.blog.translatesAutoresizingMaskIntoConstraints = NO;
    self.blog.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    self.blog.text = @"Your Blog Site";
    self.blog.textColor = UIColorFromHex(0x91A6C7);
    
    [self addSubview:self.login];
    [self addSubview:self.location];
    [self addSubview:self.blog];
    
//    OCTUser *user = [OCTUser userWithRawLogin:[KeychainWrapper valueForIdentifier:kLogin] server:OCTServer.dotComServer];
//    OCTClient *client = [OCTClient authenticatedClientWithUser:user token:[KeychainWrapper valueForIdentifier:kAccessTokenKey]];
//    RACSignal *userInfo = [client fetchUserInfo];
//    
//    [[userInfo deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(OCTEntity *entity) {
//        self.login.text = entity.login;
//        self.location.text = entity.location;
//        self.blog.text = entity.blog;
//    } error:^(NSError *error) {
//        NSLog(@"Error");
//    } completed:^{
//        
//    }];
}

@end
