//
//  YBPlayerView.h
//  YBPlayerRotationManage_Example
//
//  Created by htbing on 2019/4/1.
//  Copyright © 2019 380711712@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YBPlayerView : UIView

@property (nonatomic, assign) BOOL fullScreen;


- (void)configPlayerData:(id _Nullable)data;

@end

NS_ASSUME_NONNULL_END
