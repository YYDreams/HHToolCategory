//
//  UILabel+HHAddition.m
//  LYYGame
//
//  Created by 花花 on 2017/5/12.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "UILabel+HHAddition.h"

@implementation UILabel (HHAddition)
+ (instancetype)labelText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor textAlignment:(NSInteger)textAlignment{

    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.font = kFont(fontSize);
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    return label;
}
@end
