//
//  YBPlayerRotationController.m
//  HuaTuInterview
//
//  Created by htbing on 2019/3/12.
//  Copyright © 2019 fenggaowei. All rights reserved.
//

#import "YBPlayerRotationController.h"

@interface YBPlayerRotationController ()

@property (nonatomic, assign) BOOL statusBarHide;

@end

@implementation YBPlayerRotationController

- (void)viewDidLoad {
    [super viewDidLoad];
    _statusBarHide = YES;
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)needStatusBarHide:(BOOL)hide
{
    _statusBarHide = hide;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)dealloc {
    NSLog(@"%@释放了",self.class);
}

// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    return YES;
}

// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.fullScreenMode == YBRotationModeLandscape) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIRectEdge)preferredScreenEdgesDeferringSystemGestures
{
    return UIRectEdgeAll;
}

- (BOOL)prefersHomeIndicatorAutoHidden
{
    return YES;
}

// 默认的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.orientation;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return _statusBarHide;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
