//
//  AMMoviePlayerManager.m
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/22.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AMMoviePlayerManager.h"
#import "AMPlayerManager.h"
#import  <MediaPlayer/MediaPlayer.h>


@interface AMMoviePlayerManager ()
{
    BOOL _playing;
}

@property (nonatomic, strong) MPMoviePlayerController *player;

@end
@implementation AMMoviePlayerManager

static AMMoviePlayerManager *manager;
+ (instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AMMoviePlayerManager alloc] init];
    });
    return manager;
}

- (void)loadMusiceWithURL:(NSString *)url
{
    // 关闭本地播放
    [[AMPlayerManager shareManager] stop];
    
    _player = [[MPMoviePlayerController alloc] init];
    
    _player.movieSourceType=MPMovieSourceTypeStreaming;
    
    [_player setContentURL:[NSURL URLWithString:url]];
    
    [_player prepareToPlay];
    
    [_player play];
    
}

- (UIView *)playView
{
    return _player.view;
}

- (BOOL)playing
{
    return  _player.isAirPlayVideoActive;
}

- (void)stop
{
    [_player stop];
}

@end
