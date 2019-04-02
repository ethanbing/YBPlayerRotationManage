//
//  YBPlayerRotationController.h
//  HuaTuInterview
//
//  Created by htbing on 2019/3/12.
//  Copyright © 2019 fenggaowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBPlayerRotationUtilities.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBPlayerRotationController : UIViewController

@property (nonatomic, strong) UIImage *screenshotImage;
/// 设备横屏的方向  UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationLandscapeRight
@property (nonatomic, assign) UIInterfaceOrientation orientation;
@property (nonatomic, assign) YBRotationMode fullScreenMode;
@property (nonatomic, strong) id userinfo;

/**
 隐藏和显示状态栏操作

 @param hide 是否隐藏
 */
- (void)needStatusBarHide:(BOOL)hide;

@end

NS_ASSUME_NONNULL_END
