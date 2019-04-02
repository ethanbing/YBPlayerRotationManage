//
//  YBPlayerView.m
//  YBPlayerRotationManage_Example
//
//  Created by htbing on 2019/4/1.
//  Copyright © 2019 380711712@qq.com. All rights reserved.
//

#import "YBPlayerView.h"
#import "Masonry.h"
#import "YBPlayerRotationManage.h"

@interface YBPlayerView()

@property (nonatomic, strong) UIButton *fullBtn;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) YBPlayerRotationManage *rotationManage;

@end


@implementation YBPlayerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupConent];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupConent];
    }
    return self;
}

- (void)setupConent
{
    self.backgroundColor = UIColor.greenColor;
    
    [self addSubview:self.backBtn];
    [self addSubview:self.fullBtn];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.width.height.mas_equalTo(40);
    }];
    [self.fullBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
        make.width.height.mas_equalTo(40);
    }];
}

- (void)configPlayerData:(id)data
{
    [self setupRotationManage];
}

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

- (void)fullBtnClick:(UIButton *)btn
{
    if (btn.selected) {
        [self.rotationManage enterLandscapeFullScreen:UIInterfaceOrientationPortrait];
    }else{
        [self.rotationManage enterLandscapeFullScreen:UIInterfaceOrientationLandscapeRight];
    }
}

- (void)backBtnClick:(UIButton *)btn
{
    if (self.fullScreen) {
        [self.rotationManage enterLandscapeFullScreen:UIInterfaceOrientationPortrait];
    }else{
        //返回页面
    }
}

- (void)setFullScreen:(BOOL)fullScreen
{
    _fullScreen = fullScreen;
    self.fullBtn.selected = fullScreen;
}

- (UIButton *)fullBtn
{
    if (!_fullBtn) {
        _fullBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullBtn setImage:[UIImage imageNamed:@"player_full_screen"] forState:UIControlStateNormal];
        [_fullBtn setImage:[UIImage imageNamed:@"player_small_screen"] forState:UIControlStateSelected];
        [_fullBtn addTarget:self action:@selector(fullBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _fullBtn.backgroundColor = [UIColor redColor];
    }
    return _fullBtn;
}

- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"player_back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
