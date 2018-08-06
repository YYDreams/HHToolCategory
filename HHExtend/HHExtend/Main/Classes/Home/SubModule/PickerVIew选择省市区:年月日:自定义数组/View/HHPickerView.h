//
//  HHPickerView.h
//  HHExtend
//
//  Created by flowerflower on 2018/4/9.
//  Copyright © 2018年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHPickerView : UIButton

typedef void(^handlerSelectAreaCallBack)(NSString *province, NSString *city, NSString *area);

@property (nonatomic, copy) handlerSelectAreaCallBack selectAreaCallBack;


+ (instancetype)selectArea:(handlerSelectAreaCallBack)selectArea;


- (void)show;

- (void)dismiss;


@end



@interface HHPickerToolBar : UIView



@property(nonatomic,copy) NSString   *title;

@property(nonatomic,strong) UIFont   *font;

@property(nonatomic,strong) UIColor  *titleColor;

@property(nonatomic,strong) UIColor  *borderButtonColor;

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
            cofirmButtonTitle:(NSString *)cofirmButtonTitle
                     addTrget:(id)target
                 cancelAction:(SEL)cancelAction
                 cofirmAction:(SEL)cofirmAction;

@end

