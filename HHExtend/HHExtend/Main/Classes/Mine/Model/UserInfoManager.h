//
//  UserInfoManager.h
//  HHExtend
//
//  Created by flowerflower on 2018/8/5.
//  Copyright © 2018年 花花. All rights reserved.
//
#define YH [UserInfoManager shareInstance]

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface UserInfoManager : NSObject

@property(nonatomic,strong)UserModel *userInfo;

+ (instancetype)shareInstance;

//保存用户信息
+ (void)saveUserInfo:(UserModel *)userInfo;

//清除用户信息
+ (void)clearUserInfo;

@end
