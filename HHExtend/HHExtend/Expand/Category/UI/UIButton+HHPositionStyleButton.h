//
//  UIButton+HHPositionStyleButton.h
//  SingleSelOrMultiSel
//
//  Created by flowerflower on 2018/3/26.
//  Copyright © 2018年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    ImagePositionStyleDefault, //默认样式  图片在左 文字在右
    ImagePositionStyleRight,  //文字在左 图片在右
    ImagePositionStyleTop, // 图片在上 文字在下
    ImagePositionStyleBottom,  //图片在下 文字在上
} ImagePositionStyle;

@interface UIButton (HHPositionStyleButton)

- (void)hh_imagePositionStyle:(ImagePositionStyle)positionStyle margin:(CGFloat)margin;


@end
