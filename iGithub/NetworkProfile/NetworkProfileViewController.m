//
//  CenterViewController.m
//  iGithub
//
//  Created by Jack Yin on 15/2/3.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import "NetworkProfileViewController.h"
#import "Macros.h"
#import "OauthUtility.h"
#import "VcardView.h"
#import "VcardStatsTableViewCell.h"
#import "PopularReposTableViewCell.h"
#import "PopularRepositories.h"

#import <OctoKit/Octokit.h>

@interface NetworkProfileViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, strong) NSArray *popularRepos;
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self fetchDataForPopularRepos];
}

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        
        self.didSetupConstraints = YES;
    }
    
    [super updateViewConstraints];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 17;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

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
    
    if (section == 1) {
        return self.popularRepos.count;
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
            
            OCTRepository *repo = (OCTRepository *)[self.popularRepos objectAtIndex:indexPath.row];
            if (repo) {
                cell.repoTitle = repo.name;
                cell.repoDescription = repo.repoDescription;
                cell.repoStars = repo.stargazersCount;
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

- (void)fetchDataForVcard:(VcardView *)vcard {
    [vcard.spinner startAnimating];

    RACSignal *userInfo = [[OauthUtility authenticatedClient] fetchUserInfo];
    
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

- (void)fetchDataForVcardStatsCell:(VcardStatsTableViewCell *)cell {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    RACSignal *userInfo = [[OauthUtility authenticatedClient] fetchUserInfo];

    [[userInfo deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(OCTEntity *entity) {
        cell.followers.vcardStatCount = [NSString stringWithFormat:@"%lu", (unsigned long)entity.followers];
        cell.following.vcardStatCount = [NSString stringWithFormat:@"%lu", (unsigned long)entity.following];
    } error:^(NSError *error) {
        NSLog(@"Error");
    } completed:^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

- (void)fetchDataForPopularRepos {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    RACSignal *repositories = [[OauthUtility authenticatedClient] fetchUserRepositories];
    
    NSArray * __block sortedArray;
    [[repositories collect] subscribeNext:^(OCTRepository *repository) {
        sortedArray = [(NSArray *)repository sortedArrayUsingComparator:^NSComparisonResult(OCTRepository *repo1, OCTRepository *repo2) {
            if (repo1.stargazersCount > repo2.stargazersCount) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            
            if (repo1.stargazersCount < repo2.stargazersCount) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            return (NSComparisonResult)NSOrderedSame;
        }];
    } error:^(NSError *error) {
        
    } completed:^{
        if (sortedArray.count < 4) {
            self.popularRepos = sortedArray;
        } else {
            self.popularRepos = [sortedArray objectsAtIndexes:[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 4)]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self.tableView reloadData];
        });
    }];
}



@end
