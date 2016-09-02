//
//  AMModel.h
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/19.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@protocol AMModelConfigDelegate <NSObject>
@optional
/**
 *  适配网络数据与本地模型属性值
 *
 *  @return 字典 ——>｛模型属性：网络参数｝
 */
- (NSDictionary *)modelConfigDict;
@end


@interface AMModel : NSObject <AMModelConfigDelegate>

/**
 *  快速字典转模型
 *
 *  @param dict 数据字典
 *
 *  @return 模型对象
 */
+ (instancetype)modelWithDict:(NSDictionary *)dict;

/**
 *  初始化字典转模型
 *
 *  @param dict 数据字典
 *
 *  @return 模型数据
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

@property (nonatomic, strong) NSString *typeName;

@end
