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
@property (nonatomic, assign) CGRect centerPanelOriginalFrame;
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
    self.centerPanelOriginalFrame = self.centerPanelContainer.frame;
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
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.positionBeforePan = self.centerPanelContainer.frame.origin;
    }
    
    CGPoint translation = [recognizer translationInView:self.centerPanelContainer];
    CGRect frame = self.centerPanelOriginalFrame;
    frame.origin.x += round(translation.x);
    self.centerPanelContainer.frame = frame;
//    NSLog(@"%@", NSStringFromCGPoint(translation));
//    NSLog(@"%@", NSStringFromCGRect(recognizer.view.frame));
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
//        CGPoint velocity = [recognizer velocityInView:self.centerPanelContainer];
        CGFloat offset = frame.origin.x - self.positionBeforePan.x;
    
        NSLog(@"%f", offset);
        
        CGRect newFrame = self.view.bounds;
        newFrame.origin.x = 256;
        self.centerPanelContainer.frame = newFrame;
    }
    
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
        
        if (translation.x > 0 ) {
            return YES;
        }
    }
    
    return NO;
}

@end
