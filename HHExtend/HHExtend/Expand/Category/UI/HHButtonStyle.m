//
//  HHButtonStyle.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/26.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "HHButtonStyle.h"
static CGFloat  kScale = 0.7;

@implementation HHButtonStyle

//- (instancetype)initWithFrame:(CGRect)frame{
//
//    if (self = [super initWithFrame:frame]) {
//
//
//
//        [self setupInit];
//
//
//    }
//    return self;
//}
//- (void)setupInit{
//
//    [self setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
//    [self setTitle:@"测试" forState:UIControlStateNormal];
//    [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [self sizeToFit];
//
//}
//
//- (void)layoutSubviews{
//
//    [super layoutSubviews];
//    /**
//     2018-04-26 14:34:30.638447+0800 HHExtend[7915:274626] -[HHButtonStyle layoutSubviews] [Line 38]{{18, 4}, {37, 21.666666666666668}} ---{{0, 6}, {18, 18}}
//     2018-04-26 14:34:30.638870+0800 HHExtend[7915:274626] -[HHButtonStyle layoutSubviews] [Line 43]按钮  {{0, 4}, {37, 21.666666666666668}} ---{{37, 6}, {18, 18}}
//     2018-04-26 14:34:30.639264+0800 HHExtend[7915:274626] -[HHButtonStyle layoutSubviews] [Line 38]{{18, 4}, {37, 21.666666666666668}} ---{{37, 6}, {18, 18}}
//     2018-04-26 14:34:30.639573+0800 HHExtend[7915:274626] -[HHButtonStyle layoutSubviews] [Line 43]按钮  {{-18, 4}, {37, 21.666666666666668}} ---{{74, 6}, {18, 18}}
//
//     2018-04-26 14:34:55.801569+0800 HHExtend[7915:274626] -[HHButtonStyle layoutSubviews] [Line 38]{{18, 4}, {37, 21.666666666666668}} ---{{0, 6}, {18, 18}}
//     2018-04-26 14:34:55.802056+0800 HHExtend[7915:274626] -[HHButtonStyle layoutSubviews] [Line 43]按钮  {{0, 4}, {37, 21.666666666666668}} ---{{37, 6}, {18, 18}}
//     2018-04-26 14:34:55.819268+0800 HHExtend[7915:274626] -[HHButtonStyle layoutSubviews] [Line 38]{{18, 4}, {37, 21.666666666666668}} ---{{0, 6}, {18, 18}}
//     2018-04-26 14:34:55.819644+0800 HHExtend[7915:274626] -[HHButtonStyle layoutSubviews] [Line 43]按钮  {{0, 4}, {37, 21.666666666666668}} ---{{37, 6}, {18, 18}}
//
//     **/
//    NSLog(@"%@ ---%@",NSStringFromCGRect(self.titleLabel.frame),NSStringFromCGRect(self.imageView.frame));
//
//
//    if (_positionStyle == ImagePositionStyleRight) {
//
//        self.titleLabel.frame = CGRectOffset(self.titleLabel.frame, - self.imageView.bounds.size.width, 0);
//
//        self.imageView.frame = CGRectOffset(self.imageView.frame, self.titleLabel.bounds.size.width, 0);
//
//
//    }else if (_positionStyle == ImagePositionStyleBottom){
//        CGFloat imageW = self.imageView.frame.size.width;
//        CGFloat imageH = self.imageView.frame.size.height;
//        CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
//        CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
//        self.imageEdgeInsets = UIEdgeInsetsMake(- titleIntrinsicContentSizeH - margin, 0, 0, - titleIntrinsicContentSizeW);
//        self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageW, - imageH - margin, 0);
//
//
//
//    }else if (_positionStyle == ImagePositionStyleTop){
//
//        CGFloat imageW = self.imageView.frame.size.width;
//        CGFloat imageH = self.imageView.frame.size.height;
//        CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
//        CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
//        self.imageEdgeInsets = UIEdgeInsetsMake(- titleIntrinsicContentSizeH - margin, 0, 0, - titleIntrinsicContentSizeW);
//        self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageW, - imageH - margin, 0);
//
//    }
//
//
//    NSLog(@"按钮  %@ ---%@",NSStringFromCGRect(self.titleLabel.frame),NSStringFromCGRect(self.imageView.frame));
//
//}
//
//

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.imageView.contentMode = UIViewContentModeCenter;
        
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
    
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat width = contentRect.size.width;
    CGFloat height = contentRect.size.height * kScale;
    
    return CGRectMake(X, Y, width, height);
    
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat X = 0;
    CGFloat Y = contentRect.size.height * kScale;
    CGFloat width = contentRect.size.width;
    CGFloat height = contentRect.size.height * (1 - kScale);
    
    return CGRectMake(X, Y, width, height);
    
}


@end
