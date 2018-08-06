//
//  TitleScrollView.h
//  HHExtend
//
//  Created by flowerflower on 2018/3/28.
//  Copyright © 2018年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleScrollView : UIScrollView

@property(nonatomic,strong) UIButton *selectedBtn;

@property(nonatomic,copy) void (^handlerBtnCallBack)(NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;

- (void)setIndexSelected:(NSInteger )selectedIndex;

@end
