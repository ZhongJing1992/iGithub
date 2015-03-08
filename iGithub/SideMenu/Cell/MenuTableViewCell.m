//
//  MenuCellTableViewCell.m
//  iGithub
//
//  Created by Jack Yin on 15/3/3.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "Macros.h"

@interface MenuTableViewCell ()
@property (nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation MenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        _menuImageView = [[UIImageView alloc] init];
        _menuImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _menuImageView.image = [UIImage imageNamed:@"MenuProfilePictureViewBlankProfileSquare"];
        _menuImageView.layer.masksToBounds = YES;
        _menuImageView.layer.cornerRadius = 3;
        
        _menuLabel = [[UILabel alloc] init];
        _menuLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _menuLabel.textColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_menuImageView];
        [self.contentView addSubview:_menuLabel];
        
        [self setNeedsUpdateConstraints];
    }
    
    return self;
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.menuImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.menuImageView attribute:NSLayoutAttributeHeight multiplier:1.f constant:0.f]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.menuImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f]];
        
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_menuImageView, _menuLabel);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_menuImageView(30)]-[_menuLabel]"
                                                                                options:NSLayoutFormatAlignAllCenterY
                                                                                metrics:nil
                                                                                  views:viewsDictionary]];
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    self.backgroundColor = [UIColor colorWithRed:239 green:239 blue:239 alpha:0.1];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    
    self.backgroundColor = [UIColor clearColor];
}

@end
