//
//  NavigationController.m
//  iGithub
//
//  Created by Jack Yin on 15/2/5.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *navBarTitleTextAtrributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationBar.titleTextAttributes = navBarTitleTextAtrributes;
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
