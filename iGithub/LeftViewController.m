//
//  LeftViewController.m
//  iGithub
//
//  Created by Jack Yin on 15/2/5.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import "LeftViewController.h"
#import <JASidePanelController.h>
#import "NavigationController.h"
#import "NetworkProfileViewController.h"
#import "MenuTableViewCell.h"
#import "Macros.h"
#import "OauthUtility.h"

@interface LeftViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) OCTEntity *entity;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromHex(0x054D8A);
    [self.tableView setSeparatorColor:UIColorFromHex(0xBDBDBD)];
    
    [self fetchOCTEntity];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NavigationController *nav = [[NavigationController alloc] initWithRootViewController:[[NetworkProfileViewController alloc] init]];
        JASidePanelController *ja = (JASidePanelController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [ja setCenterPanel:nav];
    }
}

#pragma mark - UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
        if (!cell) {
            cell = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftCell"];
        }
        
        if (indexPath.row == 0) {
            NSData *avatarData = [[NSData alloc] initWithContentsOfURL:self.entity.avatarURL];
            UIImage *avatarImage = [UIImage imageWithData:avatarData];
            cell.avatarImageView.image = avatarImage;
            cell.loginNameLabel.text = self.entity.login;
        }
        
        return cell;
    }
    
    return nil;
}

- (void)fetchOCTEntity {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    RACSignal *userInfo = [[OauthUtility authenticatedClient] fetchUserInfo];
    [[userInfo deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(OCTEntity *entity) {
        self.entity = entity;
    } error:^(NSError *error) {
        NSLog(@"Error");
    } completed:^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.tableView reloadData];
    }];
}

//- (void)fetchEntityDataForDefaultCell:(MenuTableViewCell *)cell {
//    RACSignal *userInfo = [[OauthUtility authenticatedClient] fetchUserInfo];
//    
//    [[userInfo deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(OCTEntity *entity) {

//    } error:^(NSError *error) {
//        
//    } completed:^{
//            [self.tableView reloadData];
//    }];
//}

@end
