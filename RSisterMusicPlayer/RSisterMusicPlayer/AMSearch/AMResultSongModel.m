//
//  AMResultSongModel.m
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/22.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AMResultSongModel.h"

@implementation AMResultSongModel

- (void)setAuditionList:(NSArray *)auditionList
{
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:auditionList.count];
    
    for (NSDictionary *dict in auditionList) {
        AMAuditionListModel *model =[AMAuditionListModel modelWithDict:dict];
        [arrM addObject:model];
    }
    
    _auditionList = arrM.copy;
}

- (void)setSingers:(NSArray *)singers
{
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:singers.count];
    
    for (NSDictionary *dict in singers) {
        AMResultSingerModel *model =[AMResultSingerModel modelWithDict:dict];
        [arrM addObject:model];
    }
    
    _singers = arrM.copy;
}

@end
