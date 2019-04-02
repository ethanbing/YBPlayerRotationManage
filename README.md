# YBPlayerRotationManage

[![CI Status](https://img.shields.io/travis/380711712@qq.com/YBPlayerRotationManage.svg?style=flat)](https://travis-ci.org/380711712@qq.com/YBPlayerRotationManage)
[![Version](https://img.shields.io/cocoapods/v/YBPlayerRotationManage.svg?style=flat)](https://cocoapods.org/pods/YBPlayerRotationManage)
[![License](https://img.shields.io/cocoapods/l/YBPlayerRotationManage.svg?style=flat)](https://cocoapods.org/pods/YBPlayerRotationManage)
[![Platform](https://img.shields.io/cocoapods/p/YBPlayerRotationManage.svg?style=flat)](https://cocoapods.org/pods/YBPlayerRotationManage)

## 说明：

播放器自动全屏控制，简单到极致，两行代码搞定

## Installation

YBPlayerRotationManage is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'YBPlayerRotationManage'
```

## Usage

#### 1、在播放器内部添加成员变量，并初始化，传入播放器旋转的view和播放器所承载的view

```objective-c
- (void)setupRotationManage
{
    self.rotationManage = [[YBPlayerRotationManage alloc] initWithRotateViewView:self containerView:self.superview];
    //    self.rotationManage.rotationMode = YBRotationModeLandscape;//默认就是横屏模式
    self.rotationManage.orientationWillChange = ^(YBPlayerRotationManage * _Nonnull observer, BOOL isFullScreen) {
        //方向将要改变
    };
    self.rotationManage.orientationDidChanged = ^(YBPlayerRotationManage * _Nonnull observer, BOOL isFullScreen) {
        //方向已经改变
    };
}
```

#### 2、添加全屏和小屏的切换，例如：

```objective-c
- (void)fullBtnClick:(UIButton *)btn
{
    if (btn.selected) {
        [self.rotationManage enterLandscapeFullScreen:UIInterfaceOrientationPortrait];
    }else{
        [self.rotationManage enterLandscapeFullScreen:UIInterfaceOrientationLandscapeRight];
    }
}
```

#### 然后就完成了，欧耶！！！自带旋转监听，全自动旋转播放器完成

## Author

380711712@qq.com, 380711712@qq.com

## License

YBPlayerRotationManage is available under the MIT license. See the LICENSE file for more info.
