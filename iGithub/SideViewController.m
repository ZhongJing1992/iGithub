//
//  SideViewController.m
//  iGithub
//
//  Created by Jack Yin on 15/2/2.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#import "SideViewController.h"
#import "Macros.h"

@interface SideViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, assign) CGRect centerPanelRestingFrame;
@property (nonatomic, assign) CGPoint positionBeforePan;
@end

@implementation SideViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        //TODO: init
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.centerPanelContainer = [[UIView alloc] initWithFrame:self.view.bounds];
    self.centerPanelRestingFrame = self.centerPanelContainer.frame;
    [self.centerPanelContainer addSubview:self.centerPanel.view];
    
    [self.view addSubview:self.centerPanelContainer];
    [self.view bringSubviewToFront:self.centerPanelContainer];
}

- (void)setCenterPanel:(UIViewController *)centerPanel {
    _centerPanel = centerPanel;
    [_centerPanel addObserver:self forKeyPath:@"View" options:NSKeyValueObservingOptionInitial context:nil];
    [self addChildViewController:_centerPanel];
    [_centerPanel didMoveToParentViewController:self];
}

- (void)addPanGestureToView:(UIView *)view {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.delegate = self;
    panGesture.maximumNumberOfTouches = 1;
    panGesture.minimumNumberOfTouches = 1;
    [view addGestureRecognizer:panGesture];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.centerPanelContainer];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.positionBeforePan = self.centerPanelContainer.frame.origin;
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGRect frame = self.centerPanelRestingFrame;
        frame.origin.x += round(translation.x);
        self.centerPanelContainer.frame = frame;
    }
//    NSLog(@"%@", NSStringFromCGPoint(translation));
//    NSLog(@"%@", NSStringFromCGRect(recognizer.view.frame));
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([self validateThreshold:translation]) {
            CGRect frame = self.view.bounds;
            frame.origin.x = 256;
            self.centerPanelRestingFrame = frame;
            
            [UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                CGRect newFrame = self.view.bounds;
                newFrame.origin.x = 256;
                self.centerPanelContainer.frame = newFrame;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    
}

- (BOOL)validateThreshold:(CGPoint)translation {
    if (translation.x > 100) {
        return YES;
    }
    
    return NO;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"View"]) {
        [self addPanGestureToView:self.centerPanel.view];
    }
}

#pragma mark - Gesture Recognizer Delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint translation = [pan translationInView:self.centerPanelContainer];
        
        return YES;
    }
    
    return NO;
}

@end
