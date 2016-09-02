//
//  AMStorgeDB.m
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/6.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AMStorageDataBase.h"

@implementation AMStorageDataBase

static AMStorageDataBase *storageDataBase;
+ (instancetype)defaultStorageDB
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        storageDataBase = [[AMStorageDataBase alloc] init];
        [storageDataBase createOrOpenDataBase];
    });
    return storageDataBase;
}

- (void)createOrOpenDataBase
{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbPath = [document stringByAppendingPathComponent:@"MusicData.db"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    NSAssert([database open] != NO, @"database build or open fail.");
    _currentDataBase = database;
    
}

- (BOOL)createMusicListTable
{
    BOOL sucess = [self.currentDataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS AMMusicTable (ID INTEGER PRIMARY KEY AUTOINCREMENT, MusicName TEXT, MusicPath TEXT,Singer TEXT,PicUrl TEXT,LrcPAth TEXT)"];
    return sucess;
}

- (NSArray<AMMusic *> *)queryMusicListTable
{
    FMResultSet * resultSet = [self.currentDataBase executeQuery:@"SELECT * FROM AMMusicTable"];
    NSMutableArray *musices = [NSMutableArray array];
    
    while ([resultSet next]) {
        AMMusic *music = [[AMMusic alloc] init];
        music.ID = [resultSet intForColumn:@"ID"];
        music.musicName = [resultSet stringForColumn:@"MusicName"];
        music.musicPath = [resultSet stringForColumn:@"MusicPath"];
        music.singer = [resultSet stringForColumn:@"Singer"];
        music.picURl = [resultSet stringForColumn:@"PicUrl"];
        music.lrcPath = [resultSet stringForColumn:@"LrcPAth"];
        
        [musices addObject:music];
    }
    
    return musices;
}

- (BOOL)insertMusicListTableWithMusic:(AMMusic *)music
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO AMMusicTable (MusicName, MusicPath, Singer, PicUrl, LrcPAth) VALUES ('%@','%@','%@','%@','%@')",music.musicName,music.musicPath,music.singer,music.picURl,music.lrcPath];
    
    BOOL sucess =[self.currentDataBase executeUpdate:sql];
    return sucess;
}

- (BOOL)deleteMusicListTableWithMusic:(AMMusic *)music
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM AMMusicTable WHERE ID = '%ld' ",(long)music.ID];
    
    BOOL sucess =[self.currentDataBase executeUpdate:sql];
    return sucess;
}

@end
