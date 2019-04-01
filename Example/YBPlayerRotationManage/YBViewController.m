//
//  YBViewController.m
//  YBPlayerRotationManage
//
//  Created by 380711712@qq.com on 04/01/2019.
//  Copyright (c) 2019 380711712@qq.com. All rights reserved.
//

#import "YBViewController.h"
#import "YBPlayerView.h"
#import "Masonry.h"

@interface YBViewController ()

@property (nonatomic, strong) YBPlayerView *playerView;

@end

@implementation YBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    [self.view addSubview:self.playerView];
    
    [self.playerView configPlayerData:nil];
}

- (YBPlayerView *)playerView
{
    if (!_playerView) {
        CGFloat w = CGRectGetWidth(self.view.bounds);
        _playerView = [[YBPlayerView alloc] initWithFrame:CGRectMake(0, 80, w, w*9.0/16)];
    }
    return _playerView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
