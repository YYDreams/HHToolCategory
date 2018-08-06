//
//  WXTabBarButton.h
//  WXMovie
//
//  Created by Zheng on 15/7/24.
//  Copyright (c) 2015年 Qingwu Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImageView.h"
//自定义的标签栏按钮
@interface WXTabBarButton : UIControl {
  FLAnimatedImageView *_imageView;
  UILabel *_titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
                withImageName:(NSString *)imageName
                    withTitle:(NSString *)title;

@end
