//
//  YBPlayerRotationObserver.h
//  HuaTuInterview
//
//  Created by htbing on 2019/3/12.
//  Copyright © 2019 fenggaowei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 全屏的模式
typedef NS_ENUM(NSUInteger, YBRotationMode) {
    YBRotationModePortrait, // 竖屏全屏
    YBRotationModeLandscape // 横屏全屏
};

NS_ASSUME_NONNULL_BEGIN

@interface YBPlayerRotationManage : NSObject

- (instancetype)initWithRotateViewView:(UIView *)rotateView containerView:(UIView *)containerView;
/// 小屏状态播放器的容器视图
@property (nonatomic, weak, readwrite) UIView *containerView;
/// 是否全屏
@property (nonatomic, assign, readonly, getter=isFullScreen) BOOL fullScreen;
/// 设备方向即将改变
@property (nonatomic, copy, readwrite, nullable) void(^orientationWillChange)(YBPlayerRotationManage *observer, BOOL isFullScreen);
/// 设备方向已经改变
@property (nonatomic, copy, readwrite, nullable) void(^orientationDidChanged)(YBPlayerRotationManage *observer, BOOL isFullScreen);
/// 全屏的模式，默认横屏进入全屏
@property (nonatomic, assign) YBRotationMode rotationMode;
/// 进入横屏全屏状态
- (void)enterLandscapeFullScreen:(UIInterfaceOrientation)orientation;
/// 进入竖屏全屏状态
- (void)enterPortraitFullScreen:(BOOL)fullScreen;

@end

NS_ASSUME_NONNULL_END
