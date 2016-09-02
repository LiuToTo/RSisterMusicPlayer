//
//  AMSongModel.h
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/19.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AMModel.h"

@interface AMSongModel : AMModel

@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *singer_name;
@property (nonatomic, copy) NSString *weight;

@end
