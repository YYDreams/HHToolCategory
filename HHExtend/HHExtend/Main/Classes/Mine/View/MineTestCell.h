//
//  MineTestCell.h
//  HHExtend
//
//  Created by flowerflower on 2018/4/11.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "BaseCell.h"
#import "MineTestModel.h"
@interface MineTestCell : BaseCell

@property(nonatomic,strong) UILabel *titleLabel;  // <#注释#>


@property(nonatomic,strong) UIButton *minBtn;  // <#注释#>


@property(nonatomic,strong) UILabel *countLabel;  // <#注释#>


@property(nonatomic,strong) UIButton *addBtn;  // <#注释#>


@property(nonatomic,strong) MineTestModel *model;  // <#注释#>

@property(nonatomic,assign) int  count;  // <#注释#>

@end
