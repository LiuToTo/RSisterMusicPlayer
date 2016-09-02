//
//  AMModel.m
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/19.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AMModel.h"

@implementation AMModel

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setInfoWithDict:dict];
    }
    return self;
}

- (void)setInfoWithDict:(NSDictionary *)dict{
    // 模型属性个数
    unsigned int count = 0;
    // 获取模型属性数组
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    NSDictionary * serializerDict = @{};
    if ([self respondsToSelector:@selector(modelConfigDict)]) {
        serializerDict = [self modelConfigDict];
    }
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char  * cPName = property_getName(property);
        NSString    * pName = [NSString stringWithUTF8String:cPName];
        NSString    * kName = [serializerDict objectForKey:pName];
        
        if (!kName) {
            kName = pName;
        }
        // kvc字典转模型
        if (dict[kName]&&![dict[kName] isKindOfClass:[NSNull class]]) {
            [self setValue:dict[kName] forKey:pName];
        }
    }
    free(propertyList);
}

@end
