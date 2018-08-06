//
//  AppDelegate+UI.m
//  HHExtend
//
//  Created by flowerflower on 2018/3/28.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "AppDelegate+UI.h"
#import "BaseTabBarViewController.h"

@implementation AppDelegate (UI)
- (void)initRootViewController{
    
    self.window.rootViewController = [[BaseTabBarViewController alloc]init];

    
}
@end
