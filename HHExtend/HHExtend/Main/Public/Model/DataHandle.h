//
//  DataHandle.h
//  HHExtend
//
//  Created by flowerflower on 2018/4/4.
//  Copyright © 2018年 花花. All rights reserved.
//


#define LH [DataHandle shareInstance]

#import <Foundation/Foundation.h>

@interface DataHandle : NSObject


//角色切换
@property (nonatomic, assign) BOOL isCleaner;

@property (nonatomic, copy)NSString *userId;

@property (nonatomic, copy)NSString *token;


+ (instancetype)shareInstance;
@end
