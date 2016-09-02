//
//  AMResultSongModel.h
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/22.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AMModel.h"
#import "AMResultSingerModel.h"
#import "AMAuditionListModel.h"

@interface AMResultSongModel : AMModel

@property (nonatomic, copy) NSString *albumId;
@property (nonatomic, copy) NSString *albumName;
@property (nonatomic, strong) NSArray *auditionList;
@property (nonatomic, strong) NSArray *mvList;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *riskRank;
@property (nonatomic, copy) NSString *singerId;
@property (nonatomic, copy) NSString *singerName;
@property (nonatomic, strong) NSArray *singers;
@property (nonatomic, copy) NSString *songId;


@end
