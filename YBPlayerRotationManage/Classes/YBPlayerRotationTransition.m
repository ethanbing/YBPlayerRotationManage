//
//  YBPlayerRotationTransition.m
//  HuaTuInterview
//
//  Created by htbing on 2019/3/12.
//  Copyright © 2019 fenggaowei. All rights reserved.
//

#import "YBPlayerRotationTransition.h"

@interface YBPlayerRotationTransition () <UIViewControllerAnimatedTransitioning>

@property (nonatomic, weak) UIView *playerView;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, assign) YBTransitionType transitionType;
@property (nonatomic, assign) YBRotationMode fullScreenMode;
@property (nonatomic, assign) CGRect snapshootRect;
@property (nonatomic, assign) CGRect rotateViewRect;

@end

@implementation YBPlayerRotationTransition

- (void)dealloc {
    NSLog(@"%@释放了",self.class);
}

+ (instancetype)transitionWithTransitionType:(YBTransitionType)transitionType transitionItem:(nonnull YBPlayerTransitionItem *)transitionItem {
    YBPlayerRotationTransition *transition = [[self alloc] init];
    if (transition) {
        transition.transitionType = transitionType;
        transition.playerView = transitionItem.rotateView;
        transition.containerView = transitionItem.containerView;
        transition.fullScreenMode = transitionItem.rotationMode;
        transition.snapshootRect = transitionItem.snapshootRect;
        transition.rotateViewRect = transitionItem.rotateViewRect;
    }
    return transition;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    switch (self.transitionType) {
        case YBTransitionTypeDismiss: {
            [self animateDismissTransition:transitionContext];
        }
            break;
        case YBTransitionTypePresent: {
            [self animatePresentTransition:transitionContext];
        }
            break;
        default:
            break;
    }
}

- (void)animatePresentTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if (!toView || !toController) { return; }
    CGRect rect = [[transitionContext containerView] convertRect:self.containerView.frame fromView:toView];
    [[transitionContext containerView] addSubview:toView];
    [toController.view addSubview:self.playerView];
    if (self.fullScreenMode == YBRotationModeLandscape) {
        // 需要先旋转，否则位置不对
        toView.transform = [self getTransformRotationAngle];
        toView.frame = rect;
        self.playerView.frame = toView.bounds;
        toView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            toView.transform = CGAffineTransformIdentity;
            toView.frame = [transitionContext containerView].bounds;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        toView.frame = self.containerView.frame;
        self.playerView.frame = toView.bounds;
        toView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            toView.frame = [transitionContext containerView].bounds;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

- (void)animateDismissTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    if (!fromView || !toView) { return; }
    // 将 toView 插入fromView的下面，否则动画过程中不会显示toView
    [[transitionContext containerView] insertSubview:toView belowSubview:fromView];
    if (self.fullScreenMode == YBRotationModeLandscape) {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            // 让 fromView 返回playView的初始值
            fromView.transform = CGAffineTransformIdentity;
            fromView.frame = self.snapshootRect;
        } completion:^(BOOL finished) {
            [fromView removeFromSuperview];
            [self.containerView addSubview:self.playerView];
            self.playerView.frame = self.rotateViewRect;
            [transitionContext completeTransition:YES];
        }];
    } else {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            fromView.frame = self.containerView.frame;
        } completion:^(BOOL finished) {
            [fromView removeFromSuperview];
            [self.containerView addSubview:self.playerView];
            self.playerView.frame = self.containerView.bounds;
            [transitionContext completeTransition:YES];
        }];
    }
}

- (CGAffineTransform)getTransformRotationAngle {
    // 状态条的方向已经设置过,所以这个就是你想要旋转的方向
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    // 根据要进行旋转的方向来计算旋转的角度
    if (orientation == UIInterfaceOrientationPortrait) {
        return CGAffineTransformIdentity;
    } else if (orientation == UIInterfaceOrientationLandscapeLeft){
        return CGAffineTransformMakeRotation(M_PI_2);
    } else if (orientation == UIInterfaceOrientationLandscapeRight){
        return CGAffineTransformMakeRotation(-M_PI_2);
    }
    return CGAffineTransformIdentity;
}

@end

@implementation YBPlayerTransitionItem



@end
