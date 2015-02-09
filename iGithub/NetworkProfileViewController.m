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
#import "VcardStatsTableViewCell.h"

#import <OctoKit/OctoKit.h>

@interface NetworkProfileViewController () <UITableViewDelegate, UITableViewDataSource>
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
    [self setupAvatarConstraint];
    
    [self setupProfileLabels];
}

- (void)viewDidAppear:(BOOL)animated {
    [self updateAvatar];
}

- (void)setupAvatarConstraint {
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_avatar);
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.avatar
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.avatar
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1.0f
                                                                   constant:0.0f];
    [self.tableView.tableHeaderView addConstraint:constraint];
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_avatar(71)]"
                                                                   options:NSLayoutFormatAlignAllLeft
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    [self.tableView.tableHeaderView addConstraints:constraints];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.avatar
                                              attribute:NSLayoutAttributeCenterY
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.avatar.superview
                                              attribute:NSLayoutAttributeCenterY
                                             multiplier:1.f
                                               constant:0.f];
    [self.tableView.tableHeaderView addConstraint:constraint];
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
        [spinner stopAnimating];
    } completed:^{
        NSLog(@"Complete");
        [spinner stopAnimating];
    }];
}

- (void)setupProfileLabels {
    UILabel *login = [[UILabel alloc] init];
    login.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    login.text = @"Your Login Name";
    login.textColor = [UIColor whiteColor];
    login.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableView.tableHeaderView addSubview:login];
    
    UILabel *location = [[UILabel alloc] init];
    location.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    location.text = @"Your Location";
    location.textColor = UIColorFromHex(0x7888A6);
    location.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableView.tableHeaderView addSubview:location];
    
    UILabel *blog = [[UILabel alloc] init];
    blog.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    blog.text = @"Your Blog Site";
    blog.textColor = UIColorFromHex(0x91A6C7);
    blog.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableView.tableHeaderView addSubview:blog];
    
    NSDictionary *viewsDic = NSDictionaryOfVariableBindings(login, location, blog, _avatar);
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-17-[login(17)]-8-[location(12)]-5-[blog(15)]" options:NSLayoutFormatAlignAllLeft metrics:nil views:viewsDic];
    [self.tableView.tableHeaderView addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_avatar]-8-[login]" options:kNilOptions metrics:nil views:viewsDic];
    [self.tableView.tableHeaderView addConstraints:constraints];
    
    OCTUser *user = [OCTUser userWithRawLogin:[KeychainWrapper valueForIdentifier:kLogin] server:OCTServer.dotComServer];
    OCTClient *client = [OCTClient authenticatedClientWithUser:user token:[KeychainWrapper valueForIdentifier:kAccessTokenKey]];
    RACSignal *userInfo = [client fetchUserInfo];
    
    [[userInfo deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(OCTEntity *entity) {
        login.text = entity.login;
        location.text = entity.location;
        blog.text = entity.blog;
    } error:^(NSError *error) {
        NSLog(@"Error");
    } completed:^{
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    
    if (section == 1) {
        return @"Popular repositories";
    }
    
    return @"Others";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            VcardStatsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"repo"];
            if (!cell) {
                cell = [[VcardStatsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"repo"];
                
            }

            return cell;
        }
            break;
            
        default: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            }
            
            cell.textLabel.text = [NSString stringWithFormat:@"octo %ld", (long)indexPath.row];
            cell.imageView.backgroundColor = [UIColor blackColor];
            
            return cell;

        }
            break;
    }
    
}

@end
