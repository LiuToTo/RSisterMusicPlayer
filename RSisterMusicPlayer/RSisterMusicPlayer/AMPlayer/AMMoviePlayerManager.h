//
//  AMMoviePlayerManager.h
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/22.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMMoviePlayerManager : NSObject

@property (nonatomic, strong, readonly) UIView *playView;
@property (nonatomic, assign, readonly) BOOL playing;

+ (instancetype)manager;

- (void)loadMusiceWithURL:(NSString *)url;
- (void)stop;

@end
