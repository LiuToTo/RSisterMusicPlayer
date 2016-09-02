//
//  AMSession.m
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/5/4.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AMSession.h"

NSString * const kMusicListChangedNotification = @"kMusicListChangedNotification";

@implementation AMSession
static AMSession *currentSession;
+ (instancetype)currentSession
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentSession = [[AMSession alloc] init];
    });
    return currentSession;
}

- (void)addMusic:(AMMusic *)music
{
    if (_musics.count >0) {
        NSMutableArray *temp = [NSMutableArray arrayWithArray:_musics];
        [temp addObject:music];
        _musics = temp.copy;
    }else{
        _musics = @[music];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMusicListChangedNotification object:nil];
}
- (void)deleteMusicByIndex:(NSUInteger)index
{
    if (_musics.count >0) {
        NSMutableArray *temp = [NSMutableArray arrayWithArray:_musics];
        [temp removeObjectAtIndex:index];
        _musics = temp.copy;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kMusicListChangedNotification object:nil];
    }
}

- (void)deleteMusic:(AMMusic *)music
{
    if (_musics.count >0) {
        NSMutableArray *temp = [NSMutableArray arrayWithArray:_musics];
        [temp removeObject:music];
        _musics = temp.copy;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kMusicListChangedNotification object:nil];
    }
}

@end
