//
//  UserModel.m
//  HHExtend
//
//  Created by flowerflower on 2018/8/5.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
- (void)encodeWithCoder:(NSCoder *)aCoder{
    /* 获取类中的ivar列表
     count:  count为ivar总数
     class_copyIvarList:  获取类的全部属性
     **/
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(self.class, &count);
    for (int i  = 0; i< count; i++) {
        //取出Ivar
        Ivar ivar = ivarList[i];
        //属性名称  ivar_getName:获取类实例成员变量，只能取到本类的，父类的访问不到
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //归档  通过KVC取的 就没有int类型了
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    //但凡在C语言里面 看到New Creat Copy 都需要释放
    free(ivarList); //释放
}
- (instancetype)initWithCoder:(NSCoder *)coder{
    
    if ( self = [super init]) {
        unsigned int count = 0;
        Ivar *ivarList = class_copyIvarList(self.class, &count);
        
        for (int i  = 0; i< count; i++) {
            //取出Ivar
            Ivar ivar = ivarList[i];
            //属性名称
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            //解档    设置到成员变量上
            [self setValue: [coder decodeObjectForKey:key] forKey:key];
        }
        free(ivarList); //释放
    }
    return self;
}

static UserModel * instance = nil;

+ (instancetype)shareInstance{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];

    });
    
    return instance;
}

+ (void)saveUserInfo:(UserModel *)userInfo{
    
    [NSKeyedArchiver archiveRootObject:userInfo toFile:UserDataFilePath];

}

+ (UserModel *)userInfo{
    
    UserModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:UserDataFilePath];
    return model;
    
}
+ (void)clearUserInfo{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    if ([fileManager removeItemAtPath:UserDataFilePath error:&error]) {
        
        NSLog(@"清除用户数据成功");
    }else{
        NSLog(@"清除本地序列化的文件失败....:%@",error);
    }
    
    
    
}


@end
