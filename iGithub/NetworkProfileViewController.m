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
#import "VcardView.h"
#import "VcardStatsTableViewCell.h"
#import "PopularReposTableViewCell.h"

#import <OctoKit/OctoKit.h>

@interface NetworkProfileViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation NetworkProfileViewController

- (id)init {
    if (self = [super init]) {
        self.
        self.title = @"Network Profile";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = self.view.bounds;
    frame.size.height = 90;
    VcardView *tableHeaderView = [[VcardView alloc] initWithFrame:frame];
    self.tableView.tableHeaderView = tableHeaderView;
    
    [self fetchDataForVcard:tableHeaderView];
}

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        
        
        self.didSetupConstraints = YES;
    }
    
    [super updateViewConstraints];
}

//- (void)viewDidAppear:(BOOL)animated {
//    [self updateAvatar];
//}


- (void)fetchDataForVcard:(VcardView *)vcard {
    [vcard.spinner startAnimating];
    
    OCTUser *user = [OCTUser userWithRawLogin:[KeychainWrapper valueForIdentifier:kLogin] server:OCTServer.dotComServer];
    OCTClient *client = [OCTClient authenticatedClientWithUser:user token:[KeychainWrapper valueForIdentifier:kAccessTokenKey]];
    RACSignal *userInfo = [client fetchUserInfo];
    
    [[userInfo deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(OCTEntity *entity) {
        NSData *avatarData = [[NSData alloc] initWithContentsOfURL:entity.avatarURL];
        UIImage *avatarImage = [UIImage imageWithData:avatarData];
        
        vcard.avatarImage = avatarImage;
        vcard.login = entity.login;
        vcard.location = entity.location;
        vcard.blog = entity.blog;
    } error:^(NSError *error) {
        [vcard.spinner stopAnimating];
    } completed:^{
        [vcard.spinner stopAnimating];
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 17;
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (section == 1) {
//        UILabel *header = [[UILabel alloc] init];
//        header.text = @"Popular repositories";
//        header.textColor = UIColorFromHex(0x333333);
//        header.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12];
//        
//        UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 17)];
//        sectionHeaderView.backgroundColor = UIColorFromHex(0xF5F5F5);
//        [sectionHeaderView addSubview:header];
//        
//        return sectionHeaderView;
//    }
//    
//    return nil;
//}

#pragma mark - UITableViewDataSource

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
            VcardStatsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"vcardStats"];
            if (!cell) {
                cell = [[VcardStatsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"vcardStats"];
                
            }
            
            [self fetchDataForVcardStatsCell:cell];
            
            return cell;
        }
            break;
            
        case 1: {
            PopularReposTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"popularRepo"];
            if (!cell) {
                cell = [[PopularReposTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"popularRepo"];
            }
            
            return cell;
        }
            break;
            
        default: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            }
            
            cell.textLabel.text = @"1";
             
            return cell;

        }
            break;
    }
    
}

- (void)fetchDataForVcardStatsCell:(VcardStatsTableViewCell *)cell {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    OCTUser *user = [OCTUser userWithRawLogin:[KeychainWrapper valueForIdentifier:kLogin] server:OCTServer.dotComServer];
    OCTClient *client = [OCTClient authenticatedClientWithUser:user token:[KeychainWrapper valueForIdentifier:kAccessTokenKey]];
    RACSignal *userInfo = [client fetchUserInfo];

    [[userInfo deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(OCTEntity *entity) {
        cell.followers.vcardStatCount = [NSString stringWithFormat:@"%lu", (unsigned long)entity.followers];
        cell.following.vcardStatCount = [NSString stringWithFormat:@"%lu", (unsigned long)entity.following];
    } error:^(NSError *error) {
        NSLog(@"Error");
    } completed:^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

@end
