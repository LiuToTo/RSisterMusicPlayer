//
//  NSString+FilePath.m
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/15.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "NSString+FilePath.h"

@implementation NSString (FilePath)

- (NSString *)documentFilePath
{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [document stringByAppendingPathComponent:self];
}

@end
