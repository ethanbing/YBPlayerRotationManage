//
//  YBPlayerRotationController.h
//  HuaTuInterview
//
//  Created by htbing on 2019/3/12.
//  Copyright © 2019 fenggaowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBPlayerRotationManage.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBPlayerRotationController : UIViewController

@property (nonatomic, strong) UIImage *screenshotImage;
/// 设备横屏的方向  UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationLandscapeRight
@property (nonatomic, assign) UIInterfaceOrientation orientation;
@property (nonatomic, assign) YBRotationMode fullScreenMode;

@end

NS_ASSUME_NONNULL_END
