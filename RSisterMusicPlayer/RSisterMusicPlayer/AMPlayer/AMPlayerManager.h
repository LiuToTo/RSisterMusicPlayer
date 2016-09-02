//
//  AMPlayerManager.h
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/15.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AMPlayerManager : NSObject <AVAudioPlayerDelegate>

+ (instancetype)shareManager;

@property (nonatomic, strong ,readonly) AVAudioPlayer *player;

- (void)loadMusiceWithFile:(NSString *)file;

- (void)play;
- (void)pause;
- (void)stop;

- (NSString *)getCurrentTime;
@property (nonatomic, copy) void (^playFinishedHandler)();
@property (nonatomic, assign ,readonly) CGFloat progress;
- (void)setCurrentProgress:(CGFloat)progress;

@end
