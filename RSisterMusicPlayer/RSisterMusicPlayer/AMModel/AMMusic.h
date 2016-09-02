//
//  AMMusic.h
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/12.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMMusic : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString * musicName;
@property (nonatomic, copy) NSString * musicPath;
@property (nonatomic, copy) NSString * singer;
@property (nonatomic, copy) NSString * picURl;
@property (nonatomic, copy) NSString * lrcPath;

@end

@interface AMMusic (download)


@end