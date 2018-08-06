//
//  UserModel.h
//  HHExtend
//
//  Created by flowerflower on 2018/8/5.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "BaseModel.h"
@interface UserModel : BaseModel

@property (nonatomic , copy) NSString              * token;
//@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * account;
@property (nonatomic , copy) NSString              * headImg;
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * userType;

@property (nonatomic , copy) NSString              * mobile;

+ (instancetype)shareInstance;

//保存用户信息
+ (void)saveUserInfo:(UserModel *)userInfo;
//获取用户信息
+ (UserModel *)userInfo;

//清除用户信息
+ (void)clearUserInfo;
@end
