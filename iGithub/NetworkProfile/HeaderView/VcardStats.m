//
//  VCardStats.m
//  iGithub
//
//  Created by Jack Yin on 15/2/8.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import "VcardStats.h"
#import "Macros.h"

@interface VcardStats ()
@property (nonatomic, strong) UILabel *vcardStatCountLabel;
@property (nonatomic, strong) UILabel *textMutedLabel;
@property (nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation VcardStats

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
        [self setupVcardStatCountLabel];
        [self setupTextMutedLabel];
    }
    
    return self;
}

- (void)setVcardStatCount:(NSString *)vcardStatCount {
    _vcardStatCountLabel.text = vcardStatCount;
}

- (void)setTextMuted:(NSString *)textMuted {
    _textMutedLabel.text = textMuted;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(40, 30);
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.vcardStatCountLabel
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.f
                                                          constant:0.f]];

        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_vcardStatCountLabel, _textMutedLabel);

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_vcardStatCountLabel][_textMutedLabel]|"
                                                                     options:NSLayoutFormatAlignAllCenterX
                                                                     metrics:nil
                                                                       views:viewsDictionary]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_vcardStatCountLabel]|"
                                                                     options:kNilOptions
                                                                     metrics:nil
                                                                       views:viewsDictionary]];
        self.didSetupConstraints = YES;
    }

    [super updateConstraints];
}

- (void)setupVcardStatCountLabel {
    _vcardStatCountLabel = [[UILabel alloc] init];
    _vcardStatCountLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _vcardStatCountLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    _vcardStatCountLabel.numberOfLines = 1;
    _vcardStatCountLabel.textAlignment = NSTextAlignmentCenter;
    _vcardStatCountLabel.textColor = UIColorFromHex(0x4183C4);
    [self addSubview:_vcardStatCountLabel];;
    
}

- (void)setupTextMutedLabel {
    _textMutedLabel = [[UILabel alloc] init];
    _textMutedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _textMutedLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:8];
    _textMutedLabel.numberOfLines = 1;
    _textMutedLabel.textAlignment = NSTextAlignmentCenter;
    _textMutedLabel.textColor = UIColorFromHex(0x888888);
    [self addSubview:_textMutedLabel];
}

@end
