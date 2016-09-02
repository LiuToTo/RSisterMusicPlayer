//
//  AMResultSingerModel.h
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/22.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AMModel.h"

@interface AMResultSingerModel : AMModel

@property (nonatomic, assign) NSInteger shopId;
@property (nonatomic, copy) NSString *singerId;
@property (nonatomic, copy) NSString *singerName;
@property (nonatomic, assign) NSInteger singerSFlag;

@end

