//
//  AMPlayerBar.h
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/3.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 播放模式
typedef enum : NSUInteger {
     /// 顺序播放
    AMPlayerModelSequency = 1,
     /// 随机播放
    AMPlayerModelRandom = 2,
    /// 列表循环
    AMPlayerModelSequencyCircle = 3,
    /// 单曲循环
    AMPlayerModelSingleCircle = 4,
} AMPlayerModel;

/// 换曲
typedef enum : NSUInteger {
    AMPlayerChangeTypeForward,  // 上一曲
    AMPlayerChangeTypeNext,  // 下一曲
} AMPlayerChangeType;
typedef void(^AMPlayerBarPlayHandle)(BOOL isPlaying);
typedef void(^AMPlayerBarPreferHandle)(BOOL isPrefer);
typedef void(^AMPlayerBarChangeHandle)(AMPlayerChangeType changeType,AMPlayerModel playModel);
typedef void(^AMPlayerBarChooseModelHandle)(AMPlayerModel playModel);

@interface AMPlayerBar : UIView

+ (instancetype)playerBar;
+ (instancetype)playerBarWithFrame:(CGRect)frame;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (assign, nonatomic) AMPlayerModel playerModel;
@property (strong, nonatomic) AMPlayerBarPlayHandle playHandle;
@property (strong, nonatomic) AMPlayerBarPreferHandle preferHandle;
@property (strong, nonatomic) AMPlayerBarChangeHandle changeHandle;
@property (strong, nonatomic) AMPlayerBarChooseModelHandle ChooseModelHandle;

- (void)play;
- (void)next;

@end
