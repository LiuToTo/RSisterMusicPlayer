//
//  AMNetEngine.h
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/3.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AFHTTPSessionManager+AmerMusic.h"


extern NSString * const kErrorDomian;

typedef void(^AMNetworkFinished)(BOOL successed,id resultObj,NSError *error);

@interface AMNetEngine : NSObject

+ (void)searchKeyWordWithQueryKey:(NSString *)queryKey
                       finished:(AMNetworkFinished)finished;

+ (void)searchMusicListWithKeyWord:(NSString *)keyWord
                              page:(NSInteger)page
                          finished:(AMNetworkFinished)finished;

+ (void)searchMusicLrcWithSign:(NSString *)sign
                        songID:(NSString *)songID
                         lrcid:(NSString *)lrcID
                          type:(NSString *)type
                        artist:(NSString *)artist
                         title:(NSString *)title
                      finished:(AMNetworkFinished)finished;

+ (void)searchSingerPicWithSingerId:(NSString *)singerId
                              artist:(NSString *)artist
                               title:(NSString *)title
                                   x:(NSString *)x
                                   y:(NSString *)y
                            finished:(AMNetworkFinished)finished;

+ (void)downloadMusicWithURLStr:(NSString *)URLstr
                        process:(void (^)(NSProgress * process))downloadProgress
                       finished:(AMNetworkFinished)finished;

@end

//http://3p.pic.ttdtweb.com/3p.ttpod.com/singer/30124/1438215.jpg?app=ttpod&v=v9.0.0.2016040622&user_id=211291468&mid=iPhone7%2C2&f=f320&s=s310&imsi=&hid=&splus=9.2.1&active=1&net=2&openudid=df7ddc4e9777f1224aadb1b8d27c06cc3bd7c880&idfa=7E6F9DF6-E679-42EF-A41B-13474CE4A28C&utdid=VZ9gY%2FVXUG8DAN2xxy93iM3b&alf=(null)&bundle_id=com.ttpod.music&latitude=39.90975781029488&longtitude=116.5122736551878&access_token=08fb2b40c761198487a86a0af1489d3dc980d4c&vc=9000000

//测试下载地址
//@"http://m5.file.xiami.com/0/0/322965405/1773927296_16266259_l.mp3?auth_key=c9e0738e75371a4039c5afae86387311-1460505600-0-null"