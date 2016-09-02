//
//  AMConfig.m
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/15.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AMConfig.h"

@implementation AMConfig

+ (NSString *)searchKeyWordApi
{
    return @"http://so.ard.iyyin.com/sug/sugAll";
}

+ (NSString *)searchMusicListApi
{
    return @"http://search.dongting.com/song/search";
}

+ (NSString *)searchSingerPictureApi
{
    return @"http://so.ard.iyyin.com/s/pic?";
}

@end
