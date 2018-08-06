//
//  FunMenuModel.h
//  HHExtend
//
//  Created by flowerflower on 2018/4/11.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "BaseModel.h"

#import "YANScrollMenu.h"

@interface FunMenuModel : BaseModel<YANObjectProtocol>

@property(nonatomic,copy) NSString *icon;  // <#注释#>

@property(nonatomic,copy) NSString *name;  // <#注释#>

@property (nonatomic, strong) UIImage *itemPlaceholder;

@end

