//
//  UIViewController+PopBlock.h
//  HHExtend
//
//  Created by flowerflower on 2018/3/28.
//  Copyright © 2018年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PopBlock)

@property(nonatomic,copy) void (^handlerPopCallBack)(UIBarButtonItem *backItem);

@end

