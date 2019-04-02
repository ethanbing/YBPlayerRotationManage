//
//  YBPlayerRotationTransition.h
//  HuaTuInterview
//
//  Created by htbing on 2019/3/12.
//  Copyright © 2019 fenggaowei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YBPlayerRotationUtilities.h"


NS_ASSUME_NONNULL_BEGIN

@class YBPlayerTransitionItem;
@interface YBPlayerRotationTransition : NSObject<UIViewControllerAnimatedTransitioning>

//+ (instancetype)transitionWithTransitionType:(YBTransitionType)transitionType
//                              fullScreenMode:(YBRotationMode)fullScreenMode
//                                  playerView:(UIView *)playerView
//                               containerView:(UIView *)containerView
//                              containerFrame:(CGRect)containerFrame;
+ (instancetype)transitionWithTransitionType:(YBTransitionType)transitionType
                              transitionItem:(YBPlayerTransitionItem *)transitionItem;

@end

@interface YBPlayerTransitionItem : NSObject

@property (nonatomic, assign) YBRotationMode rotationMode;
@property (nonatomic, strong) UIView *rotateView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, assign) CGRect snapshootRect;
@property (nonatomic, assign) CGRect rotateViewRect;

@end

NS_ASSUME_NONNULL_END
