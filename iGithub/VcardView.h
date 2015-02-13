//
//  VcardView.h
//  iGithub
//
//  Created by Jack Yin on 15/2/10.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VcardView : UIView
@property (nonatomic, strong) UIImage *avatarImage;
@property (nonatomic, copy) NSString *login;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *blog;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@end
