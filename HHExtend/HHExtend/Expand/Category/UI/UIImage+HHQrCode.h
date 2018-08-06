//
//  UIImage+HHQrCode.h
//  HHExtend
//
//  Created by flowerflower on 2018/4/9.
//  Copyright © 2018年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HHQrCode)

//普通的二维码
+ (UIImage *)hh_ImageFromQrInfo:(NSString *)qrInfo qrCodeSize:(CGFloat)codeSize;

//中间带图标的二维码
+ (UIImage *)hh_ImageLogoFromQrInfo:(NSString *)qrInfo qrCodeSize:(CGFloat)qrCodeSize logoName:(NSString *)logoName  radius: (CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end
