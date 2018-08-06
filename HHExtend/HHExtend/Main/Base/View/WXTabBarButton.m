//
//  WXTabBarButton.m
//  WXMovie
//
//  Created by Zheng on 15/7/24.
//  Copyright (c) 2015年 Qingwu Zheng. All rights reserved.
//

#import "WXTabBarButton.h"
@implementation WXTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
                withImageName:(NSString *)imageName
                    withTitle:(NSString *)title {
  self = [super initWithFrame:frame];

  if (self != nil) {

    // 1.ImageView
    _imageView = [[FLAnimatedImageView alloc]
        initWithFrame:CGRectMake((frame.size.width - 20) / 2, 7, 20, 20)];
    _imageView.image = [UIImage imageNamed:imageName];

    [self addSubview:_imageView];

    // 2.Label
    _titleLabel = [[UILabel alloc]
        initWithFrame:CGRectMake(0, 7 + 20 + 5, frame.size.width, 17)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _titleLabel.textColor = [UIColor whiteColor];

    _titleLabel.text = title;

    [self addSubview:_titleLabel];
  }

  return self;
}

@end
