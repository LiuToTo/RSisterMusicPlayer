//
//  AMAuditionListModel.h
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/22.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AMModel.h"

@interface AMAuditionListModel : AMModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger bitRate;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, copy) NSString *suffix;
@property (nonatomic, copy) NSString *typeDescription;
@property (nonatomic, copy) NSString *url;

@end
