//
//  DataHandle.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/4.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "DataHandle.h"

@implementation DataHandle
static DataHandle * instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc]init];
    });
    
    return instance;
}

- (void)setToken:(NSString *)token{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    [userdefault  setValue:token forKey:kToken];
    [userdefault synchronize];
    
}
- (NSString *)token{
    
    return [[NSUserDefaults standardUserDefaults]valueForKey:kToken];
}

- (BOOL)isCleaner
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kLoginStatus];
}

- (void)setIsCleaner:(BOOL)isCleaner
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    [userdefault setBool:isCleaner forKey:kLoginStatus];
    [userdefault synchronize];
}


- (void)setUserId:(NSString *)userId{
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    [userdefault  setValue:userId forKey:kUserId];
    [userdefault synchronize];
}
- (NSString *)userId{
    
    return [[NSUserDefaults standardUserDefaults]valueForKey:kUserId];
}

@end
