//
//  PopularRepositories.m
//  iGithub
//
//  Created by Jack Yin on 15/2/13.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import "PopularRepositories.h"
#import "Constants.h"
#import "KeychainWrapper.h"

#import <OctoKit/OctoKit.h>

@interface PopularRepositories ()

@end

@implementation PopularRepositories

- (OCTRepository *)repositoryForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.popularRepos objectAtIndex:indexPath.row];
}

//+ (NSArray *)popularRepositoriesWithSortedByStargazersCount {
//    NSArray *sortedRepo = [self sortedRepoByStargazersCount];
//    return [sortedRepo objectsAtIndexes:[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 4)]];
//}

- (void)sortedRepoByStargazersCount {
    OCTUser *user = [OCTUser userWithRawLogin:[KeychainWrapper valueForIdentifier:kLogin] server:OCTServer.dotComServer];
    OCTClient *client = [OCTClient authenticatedClientWithUser:user token:[KeychainWrapper valueForIdentifier:kAccessTokenKey]];
    RACSignal *repositories = [client fetchUserRepositories];
    
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
        self.popularRepos = [sortedArray objectsAtIndexes:[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 4)]];
        
    }];
}

@end
