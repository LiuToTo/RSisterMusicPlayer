//
//  AMStorgeDB.h
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/6.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
#import "AMMusic.h"

@interface AMStorageDataBase : NSObject

+ (instancetype)defaultStorageDB;

@property (nonatomic, readonly) FMDatabase *currentDataBase;

- (BOOL)createMusicListTable;

- (NSArray<AMMusic *> *)queryMusicListTable;

- (BOOL)insertMusicListTableWithMusic:(AMMusic *)music;
- (BOOL)deleteMusicListTableWithMusic:(AMMusic *)music;

@end
