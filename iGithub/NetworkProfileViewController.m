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


//- (void)fetchVcardAvatar {
//    
//    
//    [self.spinner startAnimating];
//    
//    OCTUser *user = [OCTUser userWithRawLogin:[KeychainWrapper valueForIdentifier:kLogin] server:OCTServer.dotComServer];
//    OCTClient *client = [OCTClient authenticatedClientWithUser:user token:[KeychainWrapper valueForIdentifier:kAccessTokenKey]];
//    RACSignal *userInfo = [client fetchUserInfo];
//    
//    [[userInfo deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(OCTEntity *entity) {
//        NSData *avatarData = [[NSData alloc] initWithContentsOfURL:entity.avatarURL];
//        UIImage *avatarImage = [UIImage imageWithData:avatarData];
//        self.avatar.image = avatarImage;
//    } error:^(NSError *error) {
//        [self.spinner stopAnimating];
//    } completed:^{
//        [self.spinner stopAnimating];
//    }];
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
//            [cell layoutIfNeeded];

            return cell;
        }
            break;
            
        case 1: {
            PopularReposTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"popularRepo"];
            if (!cell) {
                cell = [[PopularReposTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"popularRepo"];
            }
//            [cell layoutIfNeeded];
            
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

@end
