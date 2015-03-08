//
//  GitHubUserStore.m
//  iGithub
//
//  Created by Jack Yin on 15/3/2.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import "GitHubUserStore.h"
#import "OauthUtility.h"

#import <OctoKit/OctoKit.h>

@implementation GitHubUserStore

+ (void)fetchEntityDataForDefaultCell:(MenuTableViewCell *)cell {
    RACSignal *userInfo = [[OauthUtility authenticatedClient] fetchUserInfo];
    
    [[userInfo deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(OCTEntity *entity) {
        NSData *avatarData = [[NSData alloc] initWithContentsOfURL:entity.avatarURL];
        UIImage *avatarImage = [UIImage imageWithData:avatarData];
        cell.menuImageView.image = avatarImage;
        cell.menuImageView.layer.masksToBounds = YES;
        cell.menuImageView.layer.cornerRadius = 3;
        cell.menuLabel.text = entity.login;
        cell.menuLabel.textColor = [UIColor whiteColor];
    } error:^(NSError *error) {
        
    } completed:^{
        
    }];
}

@end
