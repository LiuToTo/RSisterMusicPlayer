//
//  AFHTTPSessionManager+AmerMusic.h
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/3.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFHTTPSessionManager (AmerMusic)

+ (instancetype)musicManager;

+ (instancetype)jsonManager;

@end
