//
//  AFHTTPSessionManager+AmerMusic.m
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/3.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AFHTTPSessionManager+AmerMusic.h"

@implementation AFHTTPSessionManager (AmerMusic)

static AFHTTPSessionManager *jsonManager;
static AFHTTPSessionManager *musicManager;
+ (instancetype)musicManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        musicManager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];

        // 配置请求序列化对象
        musicManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        musicManager.requestSerializer.timeoutInterval = 30;
        
        // 响应序列化对象
        musicManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableSet *contentTypes = [[NSMutableSet alloc]
                     initWithSet:musicManager.responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"text/html"];
        [contentTypes addObject:@"audio/mpeg"];
        [contentTypes addObject:@"video/mp4"];
        musicManager.responseSerializer.acceptableContentTypes = contentTypes;
    });
    return musicManager;
}

+ (instancetype)jsonManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jsonManager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
        
        // 配置请求序列化对象
        jsonManager.requestSerializer = [AFJSONRequestSerializer serializer];
        jsonManager.requestSerializer.timeoutInterval = 30;
        
        // 响应序列化对象
        jsonManager.responseSerializer = [AFJSONResponseSerializer serializer];
        NSMutableSet *contentTypes = [[NSMutableSet alloc]
                                      initWithSet:jsonManager.responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"text/html"];
        [contentTypes addObject:@"text/plain"];
        jsonManager.responseSerializer.acceptableContentTypes = contentTypes;
    });
    return jsonManager;
}

@end
