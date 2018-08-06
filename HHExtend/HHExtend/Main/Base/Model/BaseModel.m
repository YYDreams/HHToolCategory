//
//  BaseModel.m
//  HHExtend
//
//  Created by flowerflower on 2018/3/28.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (instancetype)objectWithDic:(NSDictionary *)dic
{
    //容错处理
    if (![dic isKindOfClass:[NSDictionary class]]||!dic)
    {
        return nil;
    }
    
    //获取子类名
    NSString * className =  [NSString stringWithUTF8String:object_getClassName(self)];
    
    return [NSClassFromString(className) mj_objectWithKeyValues:dic];
}

+ (NSArray*)objectsInArray:(NSArray<NSDictionary*>*)arr
{
    //获取子类名
    NSString * className =  [NSString stringWithUTF8String:object_getClassName(self)];
    
    return [NSClassFromString(className) mj_objectArrayWithKeyValuesArray:arr];
}
@end
