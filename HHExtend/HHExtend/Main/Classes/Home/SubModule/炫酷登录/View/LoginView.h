//
//  LoginView.h
//  HHExtend
//
//  Created by flowerflower on 2018/4/4.
//  Copyright © 2018年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^finishBlock)();

@interface LoginView : UIView

@property (nonatomic,copy) finishBlock translateBlock;

@end
