//
//  AMPlayerManager.m
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/15.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AMPlayerManager.h"
#import "AMMoviePlayerManager.h"


@interface AMPlayerManager () 

@property (nonatomic, copy) NSString *currentMusic;
@property (nonatomic, assign) NSTimeInterval currentTime;

@end

@implementation AMPlayerManager

static AMPlayerManager *manager;
+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AMPlayerManager alloc] init];
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];

    });
    return manager;
}

- (void)loadMusiceWithFile:(NSString *)file
{
    NSAssert(file.length >0, @"file can't be nil");
    
    BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:file];
    NSAssert(isExists, @"file must be exists");
    
    if (_player && [self.currentMusic isEqualToString:file]) {
        return;
    }
    
    [_player stop];
    _player = nil;
    
    //1.音频文件的url路径
    NSData *data = [NSData dataWithContentsOfFile:file];
    
    //2.创建播放器（注意：一个AVAudioPlayer只能播放一个url）
    _player=[[AVAudioPlayer alloc]initWithData:data error:nil];
    _player.delegate = self;
    
    //3.缓冲
    [_player prepareToPlay];
    
    self.currentTime = 0;
    self.currentMusic = file;
}

- (void)play
{
    // 关闭在线播放
    [[AMMoviePlayerManager manager] stop];
    
    _player.currentTime = self.currentTime;
    [_player play];
}
- (void)pause
{
    self.currentTime = _player.currentTime;
    [_player pause];
    
}
- (void)stop
{
    [_player stop];
    self.currentTime = 0;
    self.currentMusic = nil;
}

- (NSString *)getCurrentTime
{
    long time = _player.currentTime;
    long minit = time / 60;
    long second = time % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld",minit,second];
}
- (CGFloat)progress
{
    return _player.currentTime / _player.duration;
}

- (void)setCurrentProgress:(CGFloat)progress
{
    _player.currentTime = _player.duration *progress;
}

#pragma mark - delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (_playFinishedHandler) {
        _playFinishedHandler();
    }
}


@end
