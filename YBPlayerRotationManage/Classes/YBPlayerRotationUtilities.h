//
//  YBPlayerRotationUtilities.h
//  YBPlayerRotationManage
//
//  Created by htbing on 2019/4/2.
//

#ifndef YBPlayerRotationUtilities_h
#define YBPlayerRotationUtilities_h

/// 全屏的模式
typedef NS_ENUM(NSUInteger, YBRotationMode) {
    YBRotationModePortrait, // 竖屏全屏
    YBRotationModeLandscape // 横屏全屏
};

typedef NS_ENUM(NSInteger,YBTransitionType) {
    YBTransitionTypePresent = 0,
    YBTransitionTypeDismiss  = 1
};


#endif /* YBPlayerRotationUtilities_h */
