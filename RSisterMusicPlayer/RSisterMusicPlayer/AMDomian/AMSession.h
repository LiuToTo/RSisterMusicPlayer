//
//  AMSession.h
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/5/4.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMMusic.h"

extern NSString * const kMusicListChangedNotification;

@interface AMSession : NSObject

+ (instancetype)currentSession;

@property (nonatomic, strong) NSArray *musics;

- (void)addMusic:(AMMusic *)music;
- (void)deleteMusicByIndex:(NSUInteger)index;
- (void)deleteMusic:(AMMusic *)music;

@end
