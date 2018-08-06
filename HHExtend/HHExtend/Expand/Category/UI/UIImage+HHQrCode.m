//
//  UIImage+HHQrCode.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/9.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "UIImage+HHQrCode.h"
#import "UIImage+HH.h"
@implementation UIImage (HHQrCode)

+ (UIImage *)hh_ImageFromQrInfo:(NSString *)qrInfo qrCodeSize:(CGFloat)codeSize{
    
    if (qrInfo == nil && [qrInfo isEqualToString:@""]) {
        
        return nil;
    }
    //1.限制大小
    codeSize = [self limitCodeSize:codeSize];
    //2.根据qrInfo 创建CIImage
   CIImage * outputImage =   [self setupQrInfo:qrInfo];
    //3.根据CIImage生成指定大小的UIImage
    UIImage *finalImage = [self createImageFormCIImage:outputImage size:codeSize];
    
    return finalImage;
}

//限制大小
+ (CGFloat)limitCodeSize:(CGFloat)codeSize{
    
    codeSize = MAX(160, codeSize);
    codeSize = MIN(CGRectGetWidth([UIScreen mainScreen].bounds) - 80, codeSize);
    
    return codeSize;
    
}
//根据qrInfo 创建CIImage
+ (CIImage *)setupQrInfo:(NSString *)qrInfo{
    
   //1.创建一个二维码滤镜实例
    CIFilter *filter  = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 恢复滤镜的默认属性
    [filter setDefaults];
    //2.设置数据
    NSString *str = qrInfo;
    //3.将字符串转换成 NSdata (虽然二维码本质上是 字符串,但是这里需要转换,不转换就崩溃)
    NSData *infoData = [str dataUsingEncoding:NSUTF8StringEncoding];
    // 通过KVC设置滤镜inputMessage数据
    NSLog(@"%@",filter.inputKeys);
    //    inputMessage, //二维码输入信息
    //    inputCorrectionLevel //二维码错误的等级,就是容错率
    //设置过滤器的 输入值  ,KVC赋值
    [filter setValue:infoData forKey:@"inputMessage"];
    
    // 3、获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    return outputImage;
    
    
}
//根据CIImage生成指定大小的UIImage
+ (UIImage *)createImageFormCIImage:(CIImage *)image size:(CGFloat)size{
    
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    size_t width = CGRectGetWidth(extent) *scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


//中间带图标的二维码
+ (UIImage *)hh_ImageLogoFromQrInfo:(NSString *)qrInfo qrCodeSize:(CGFloat)qrCodeSize logoName:(NSString *)logoName  radius: (CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    
    
    UIImage *orginImg = [self hh_ImageFromQrInfo:qrInfo qrCodeSize:qrCodeSize];
    
    
    if (!logoName || [logoName isEqualToString:@""]) {
        NSLog(@"未输入logo图片名字");
        return  orginImg;
    }
    
    UIImage *finalImage ;
    
    //根据二维码图片设置生成水印图片rect
    CGRect waterImageRect = [self getWaterImageRectFromOutputQRImage:orginImg];
    

    UIImage *logoImage = [UIImage imageWithImage:[UIImage imageNamed:logoName] scaledToSize:waterImageRect.size];
    
    //生成水印图片 rect 从00 开始LX_scaleToSize:waterImageRect.size

    UIImage *waterImage =[UIImage ClipImageRadiousWithImage:logoImage circleRect:CGRectMake(0, 0, waterImageRect.size.width, waterImageRect.size.height) radious:radius borderWith:borderWidth borderColor:borderColor];
    
    
    //添加水印图片
    
    finalImage =[UIImage WaterImageWithImage:orginImg waterImage:waterImage waterImageRect:waterImageRect];
    
    
    
    return finalImage;
    
}

+(CGRect)getWaterImageRectFromOutputQRImage:(UIImage *)orginQRImage{
    
    CGSize linkSize = CGSizeMake(orginQRImage.size.width / 4, orginQRImage.size.height / 4);
    
    CGFloat linkX = (orginQRImage.size.width -linkSize.width)/2;
    CGFloat linkY = (orginQRImage.size.height -linkSize.height)/2;
    
    
    return CGRectMake(linkX, linkY, linkSize.width, linkSize.height);
}
@end
