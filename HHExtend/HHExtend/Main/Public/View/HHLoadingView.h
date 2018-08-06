//
//  HHLoadingView.h
//  HHExtend
//
//  Created by flowerflower on 2018/4/4.
//  Copyright © 2018年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHLoadingView : UIView


@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) UIEdgeInsets edgeInset;

// 便利方法

+ (void)showLoadingInView:(UIView *)view;

+ (void)showLoadingInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset;

+ (void)hideLoadingForView:(UIView *)view;

+ (void)hideAllLoadingForView:(UIView *)view;

+ (HHLoadingView *)loadingForView:(UIView *)view;

+ (void)showLoadingInView:(UIView *)view topEdge:(CGFloat)topEdge;


- (void)showInView:(UIView *)view;

- (void)hide;

@end
