//
//  UIViewController+PopBlock.m
//  HHExtend
//
//  Created by flowerflower on 2018/3/28.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "UIViewController+PopBlock.h"
#import <objc/runtime.h>
@implementation UIViewController (PopBlock)

- (void)setHandlerPopCallBack:(void (^)(UIBarButtonItem *))handlerPopCallBack{

    objc_setAssociatedObject(self, @selector(handlerPopCallBack), handlerPopCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (void (^)(UIBarButtonItem *))handlerPopCallBack{
    
    return objc_getAssociatedObject(self, _cmd);
    
}

@end
