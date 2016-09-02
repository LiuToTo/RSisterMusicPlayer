//
//  AMNetEngine.m
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/3.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AMNetEngine.h"
#import "AMConfig.h"

 NSString * const kErrorDomian = @"kErrorDomian";


@implementation AMNetEngine

+ (void)searchKeyWordWithQueryKey:(NSString *)queryKey
                         finished:(AMNetworkFinished)finished
{
    NSDictionary *parameters = [self parameterWithDict:@{@"q":queryKey,}];
    
    [[AFHTTPSessionManager jsonManager] GET:[AMConfig searchKeyWordApi] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             
             NSError *error = nil;
             id result = nil;
             NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
             
             if (code == 1) {
                 result = [responseObject objectForKey:@"data"];
             }else{
                 error = [NSError errorWithDomain:kErrorDomian code:code userInfo:responseObject];
             }
             finished(YES,result,error);
         }else{
             finished(YES,responseObject,nil);
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
         finished(NO,nil,error);
     }];
}

+ (void)searchMusicListWithKeyWord:(NSString *)keyWord
                              page:(NSInteger)page
                          finished:(AMNetworkFinished)finished
{
    NSDictionary *parameters = [self parameterWithDict:@{@"q":keyWord,@"page":@(page),@"size":@(50)}];
    
    [[AFHTTPSessionManager jsonManager] GET:[AMConfig searchMusicListApi] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray *data = [responseObject objectForKey:@"data"];
         if (finished) {
             finished(YES,data,nil);
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
        finished(NO,nil,error);
     }];
}

+ (void)searchMusicLrcWithSign:(NSString *)sign
                        songID:(NSString *)songID
                         lrcid:(NSString *)lrcID
                          type:(NSString *)type
                        artist:(NSString *)artist
                         title:(NSString *)title
                      finished:(AMNetworkFinished)finished
{

}

+ (void)searchSingerPicWithSingerId:(NSString *)singerId
                             artist:(NSString *)artist
                              title:(NSString *)title
                                  x:(NSString *)x
                                  y:(NSString *)y
                           finished:(AMNetworkFinished)finished
{
     NSDictionary *parameters = [self parameterWithDict:@{@"singerid":singerId,@"artist":artist,@"title":title,@"x":x,@"y":y}];
    
    [[AFHTTPSessionManager jsonManager] GET:[AMConfig searchSingerPictureApi] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
         NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
         NSLog(@"%@",error);
    }];
}

+ (void)downloadMusicWithURLStr:(NSString *)URLstr
                        process:(void (^)(NSProgress * process))downloadProgress
                       finished:(AMNetworkFinished)finished
{
    NSDictionary *parameters = [self parameterWithDict:nil];
    [[AFHTTPSessionManager musicManager] GET:URLstr parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         finished(YES,responseObject,nil);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         finished(NO,nil,error);
     }];
}

+ (NSDictionary *)parameterWithDict:(NSDictionary *)dict
{
    NSString *openudid = @"df7ddc4e9777f1224aadb1b8d27c06cc3bd7c880";
    NSString *idfa = @"7E6F9DF6-E679-42EF-A41B-13474CE4A28C";
    NSString *utdid = @"VZ9gY%2FVXUG8DAN2xxy93iM3b";
    NSString *access_token = @"adeae86831edc9d240f55175cc56eb1c";
    
    NSDictionary *baseParameters = @{@"app":@"ttpod",
                               @"v":@"v8.1.5.2016022418",
                               @"user_id":@"211291468",
                               @"mid":@" iPhone7%2C2",
                               @"f":@"f320",
                               @"s":@"s310",
                               @"imsi":@"",
                               @"hid":@"",
                               @"splus":@"9.2.1",
                               @"active":@"1",
                               @"net":@"2",
                               @"openudid":openudid,
                               @"idfa":idfa,
                               @"utdid":utdid,
                               @"alf":@"201200",
                               @"bundle_id":@"com.ttpod.music",
                               @"latitude":@"39.90840295261007",
                               @"longtitude":@"116.5062890453049",
                               @"access_token":access_token};
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:baseParameters];
    if (dict.count >0) {
        [parameters setValuesForKeysWithDictionary:dict];
    }
    
    
    return parameters.copy;
}

@end

//http://3p.pic.ttdtweb.com/3p.ttpod.com/singer/1767563/6901893.jpg?app=ttpod&v=v9.0.0.2016040622&user_id=211291468&mid=iPhone7%2C2&f=f320&s=s310&imsi=&hid=&splus=9.2.1&active=1&net=2&openudid=df7ddc4e9777f1224aadb1b8d27c06cc3bd7c880&idfa=7E6F9DF6-E679-42EF-A41B-13474CE4A28C&utdid=VZ9gY%2FVXUG8DAN2xxy93iM3b&alf=(null)&bundle_id=com.ttpod.music&latitude=39.90975781029488&longtitude=116.5122736551878&access_token=08fb2b40c761198487a86a0af1489d3dc980d4c&vc=9000000
//NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//NSString *path = [document stringByAppendingPathComponent:@"jar of love.mp3"];
//AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
//manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"audio/mpeg", nil];
//manager.requestSerializer.timeoutInterval = 30;
//[manager GET:@"http://m5.file.xiami.com/980/78980/414285/1770885848_3640967_l.mp3?auth_key=9eb2c6ded581d07f86dea47a25ff5e7a-1459641600-0-null&app=ttpod&v=v8.1.5.2016022418&user_id=0&mid=iPhone7%2C2&f=f320&s=s310&imsi=&hid=&splus=9.2.1&active=1&net=2&openudid=df7ddc4e9777f1224aadb1b8d27c06cc3bd7c880&idfa=7E6F9DF6-E679-42EF-A41B-13474CE4A28C&utdid=VZ9gY%2FVXUG8DAN2xxy93iM3b&alf=201200&bundle_id=com.ttpod.music&latitude=39.89161581219013&longtitude=116.6049967416721" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//    NSLog(@"%@",downloadProgress);
//} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//    NSLog(@"%@",responseObject);
//    NSData *data = responseObject;
//
//    NSMutableData *sounds = [[NSMutableData alloc] initWithData:data];
//    //        NSURL *url = [NSURL URLWithString:path];
//    [sounds writeToFile:path atomically:YES];
//    //        [data writeToURL:url atomically:YES];
//
//} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//    NSLog(@"%@",error);
//}];
////          self.leftTableView.backgroundColor = [UIColor blueColor];@"Beyond.mp3"
//






