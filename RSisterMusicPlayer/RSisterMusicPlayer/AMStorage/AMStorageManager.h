//
//  AMStorageManager.h
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/5/2.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMStorageManager : NSObject

+ (void)saveFileToDocumentWithName:(NSString *)name data:(id)data;
+ (id)dataFromDocumentWithName:(NSString *)name;

@end
