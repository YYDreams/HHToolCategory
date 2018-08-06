//
//  BaseModel.h
//  HHExtend
//
//  Created by flowerflower on 2018/3/28.
//  Copyright © 2018年 花花. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

+ (instancetype)objectWithDic:(NSDictionary*)dic;

+ (NSArray*)objectsInArray:(NSArray<NSDictionary*>*)arr;
@end
