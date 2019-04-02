//
//  YBPlayerRotationObserver.m
//  HuaTuInterview
//
//  Created by htbing on 2019/3/12.
//  Copyright © 2019 fenggaowei. All rights reserved.
//

#import "YBPlayerRotationManage.h"
#import "YBPlayerRotationController.h"
#import "YBPlayerRotationTransition.h"

@interface YBPlayerRotationManage ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, weak, readwrite) UIView *rotateView;
///
@property (nonatomic, assign, getter=isFullScreen) BOOL fullScreen;
/// 当前设备的方向
@property (nonatomic, readwrite) UIDeviceOrientation currentOrientation;
/// 全屏的控制器
@property (nonatomic, weak) YBPlayerRotationController *fullScrrenVC;
@property (nonatomic, assign) CGRect snapshootRect;
@property (nonatomic, assign) CGRect rotateViewRect;

@end

@implementation YBPlayerRotationManage

- (instancetype)initWithRotateViewView:(UIView *)rotateView containerView:(UIView *)containerView {
    self = [super init];
    if (self) {
        _rotateView = rotateView;
        _containerView = containerView;
        _rotateViewRect = rotateView.frame;
        self.rotationMode = YBRotationModeLandscape;
        UIWindow * win = UIApplication.sharedApplication.keyWindow;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.snapshootRect = [rotateView convertRect:rotateView.bounds toView:win];
        });
        [self observerDeviceOrientation];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)observerDeviceOrientation {
    if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceOrientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)handleDeviceOrientationChange {
    /// 如果是竖屏状态全屏，直接return
    if (self.rotationMode == YBRotationModePortrait) return;
    if (UIDeviceOrientationIsValidInterfaceOrientation([UIDevice currentDevice].orientation)) {
        self.currentOrientation = [UIDevice currentDevice].orientation;
    } else {
        self.currentOrientation = UIDeviceOrientationUnknown;
        return;
    }
    
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)self.currentOrientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait: {
            [self enterLandscapeFullScreen:UIInterfaceOrientationPortrait];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft: {
            [self enterLandscapeFullScreen:UIInterfaceOrientationLandscapeLeft];
        }
            break;
        case UIInterfaceOrientationLandscapeRight: {
            [self enterLandscapeFullScreen:UIInterfaceOrientationLandscapeRight];
        }
            break;
        default: break;
    }
}

- (void)enterLandscapeFullScreen:(UIInterfaceOrientation)orientation {
    if (self.rotationMode == YBRotationModePortrait) return;
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        if (self.fullScreen) return;
        if (self.orientationWillChange) {
            self.orientationWillChange(self, self.isFullScreen);
        }
        YBPlayerRotationController *fullScrrenVC = [[YBPlayerRotationController alloc] init];
        fullScrrenVC.orientation = orientation;
        fullScrrenVC.fullScreenMode = self.rotationMode;
        fullScrrenVC.transitioningDelegate = self;
        fullScrrenVC.modalPresentationStyle = UIModalPresentationFullScreen;
        UIWindow *win = [UIApplication sharedApplication].keyWindow;
        [win.rootViewController presentViewController:fullScrrenVC animated:YES completion:^{
            self.fullScreen = YES;
            if (self.orientationDidChanged) {
                self.orientationDidChanged(self, self.isFullScreen);
            }
        }];
        self.fullScrrenVC = fullScrrenVC;
    } else {
        if (!self.fullScreen) return;
        if (self.orientationWillChange) {
            self.orientationWillChange(self, self.isFullScreen);
        }
        [self.fullScrrenVC dismissViewControllerAnimated:YES completion:^{
            self.fullScreen = NO;
            if (self.orientationDidChanged) {
                self.orientationDidChanged(self, self.isFullScreen);
            }
        }];
    }
}

/// 进入竖屏全屏状态
- (void)enterPortraitFullScreen:(BOOL)fullScreen {
    if (self.rotationMode == YBRotationModeLandscape) return;
    if (fullScreen) {
        if (self.fullScreen) return;
        if (self.orientationWillChange) {
            self.orientationWillChange(self, self.isFullScreen);
        }
        YBPlayerRotationController *fullScrrenVC = [[YBPlayerRotationController alloc] init];
        fullScrrenVC.orientation = UIInterfaceOrientationPortrait;
        fullScrrenVC.fullScreenMode = self.rotationMode;
        fullScrrenVC.transitioningDelegate = self;
        UIWindow *win = [UIApplication sharedApplication].keyWindow;
        [win.rootViewController presentViewController:fullScrrenVC animated:YES completion:^{
            
        }];
        self.fullScreen = YES;
        self.fullScrrenVC = fullScrrenVC;
        if (self.orientationDidChanged) {
            self.orientationDidChanged(self, self.isFullScreen);
        }
    } else {
        if (!self.fullScreen) return;
        if (self.orientationWillChange) {
            self.orientationWillChange(self, self.isFullScreen);
        }
        [self.fullScrrenVC dismissViewControllerAnimated:YES completion:^{
            self.fullScreen = NO;
            if (self.orientationDidChanged) {
                self.orientationDidChanged(self, self.isFullScreen);
            }
        }];
    }
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    YBPlayerTransitionItem * item = YBPlayerTransitionItem.new;
    item.rotationMode = self.rotationMode;
    item.rotateView = self.rotateView;
    item.containerView = self.containerView;
    item.snapshootRect = self.snapshootRect;
    item.rotateViewRect = self.rotateViewRect;
    return [YBPlayerRotationTransition transitionWithTransitionType:YBTransitionTypePresent transitionItem:item];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    YBPlayerTransitionItem * item = YBPlayerTransitionItem.new;
    item.rotationMode = self.rotationMode;
    item.rotateView = self.rotateView;
    item.containerView = self.containerView;
    item.snapshootRect = self.snapshootRect;
    item.rotateViewRect = self.rotateViewRect;
    return [YBPlayerRotationTransition transitionWithTransitionType:YBTransitionTypeDismiss transitionItem:item];
}

@end
