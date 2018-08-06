//
//  LYTools.h
//  leyingyinggame
//
//  Created by 花花 on 2017/2/27.
//  Copyright © 2017年 花花. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYTools : NSObject
//MD5加密
+ (NSString *)MD5String:(NSString *)param;

/*
**
*  MD5加密, 32位 小写
*
*  @param str 传入要加密的字符串
*
*  @return 返回加密后的字符串
*/
+(NSString *)MD5ForLower32Bate:(NSString *)str;

/**
 *  MD5加密, 32位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForUpper32Bate:(NSString *)str;

/**
 *  MD5加密, 16位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForLower16Bate:(NSString *)str;

/**
 *  MD5加密, 16位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForUpper16Bate:(NSString *)str;


@end
