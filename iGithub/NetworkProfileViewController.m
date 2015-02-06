//
//  CenterViewController.m
//  iGithub
//
//  Created by Jack Yin on 15/2/3.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import "NetworkProfileViewController.h"
#import "Macros.h"
#import "Constants.h"
#import "KeychainWrapper.h"

#import <OctoKit/OctoKit.h>

@interface NetworkProfileViewController ()
@property (nonatomic, strong) UIImageView *avatar;
@end

@implementation NetworkProfileViewController

- (id)init {
    if (self = [super init]) {
        self.title = @"Network Profile";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 90)];
    tableHeaderView.backgroundColor = UIColorFromHex(0x2C3C59);
    self.tableView.tableHeaderView = tableHeaderView;
    
    self.avatar = [[UIImageView alloc] init];
    self.avatar.translatesAutoresizingMaskIntoConstraints = NO;
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = 3.0f;
    self.avatar.backgroundColor = [UIColor whiteColor];
    [tableHeaderView addSubview:self.avatar];
    [self setupAvatarConstraint:tableHeaderView];
    
    UILabel *login = [[UILabel alloc] init];
    UILabel *location = [[UILabel alloc] init];
    UILabel *blog = [[UILabel alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
    [self updateAvatar];
}

- (void)setupAvatarConstraint:(UIView *)tableHeaderView {
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_avatar);
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.avatar
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.avatar
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1.0f
                                                                   constant:0.0f];
    [tableHeaderView addConstraint:constraint];
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_avatar(71)]"
                                                                   options:NSLayoutFormatAlignAllLeft
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    [tableHeaderView addConstraints:constraints];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.avatar
                                              attribute:NSLayoutAttributeCenterY
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.avatar.superview
                                              attribute:NSLayoutAttributeCenterY
                                             multiplier:1.f
                                               constant:0.f];
    [tableHeaderView addConstraint:constraint];
}

- (void)updateAvatar {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.color = [UIColor blackColor];
    spinner.hidesWhenStopped = YES;
    spinner.translatesAutoresizingMaskIntoConstraints = NO;
    [self.avatar addSubview:spinner];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:spinner
                                                                  attribute:NSLayoutAttributeCenterX
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:spinner.superview
                                                                  attribute:NSLayoutAttributeCenterX
                                                                 multiplier:1.f
                                                                   constant:0.f];
    [spinner.superview addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:spinner
                                              attribute:NSLayoutAttributeCenterY
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:spinner.superview
                                              attribute:NSLayoutAttributeCenterY
                                             multiplier:1.f
                                               constant:0.f];
    [spinner.superview addConstraint:constraint];
    [spinner startAnimating];
    
    OCTUser *user = [OCTUser userWithRawLogin:[KeychainWrapper valueForIdentifier:kLogin] server:OCTServer.dotComServer];
    OCTClient *client = [OCTClient authenticatedClientWithUser:user token:[KeychainWrapper valueForIdentifier:kAccessTokenKey]];
    RACSignal *userInfo = [client fetchUserInfo];
    
    [[userInfo deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(OCTEntity *entity) {
        NSData *avatarData = [[NSData alloc] initWithContentsOfURL:entity.avatarURL];
        UIImage *avatarImage = [UIImage imageWithData:avatarData];
        self.avatar.image = avatarImage;
    } error:^(NSError *error) {
        NSLog(@"Error");
    } completed:^{
        NSLog(@"Complete");
        [spinner stopAnimating];
    }];
}

@end
