//
//  FunMenuView.h
//  HHExtend
//
//  Created by flowerflower on 2018/4/11.
//  Copyright © 2018年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FunMenuModel.h"
@interface FunMenuView : UIView

@property(nonatomic,strong) UICollectionView *collectionView;  // <#注释#>

@property(nonatomic,strong) NSMutableArray *dataArr;  // <#注释#>

@end


@interface FunMenuCell: UICollectionViewCell


@property(nonatomic,strong) FunMenuModel *model;  // <#注释#>

@property(nonatomic,strong) UIImageView *imgView;

@property(nonatomic,strong) UILabel *tileLabel;


// *  文本的字体大小，默认是14号系统字体

//@property(nonatomic,strong) UIFont *textFont;  // <#注释#>


@end


@interface ScrollMenu : UIView

//当前指示器的颜色
@property(nonatomic,strong) UIColor *currentIndicatorColor;  // <#注释#>
//分页控制器分页的颜色，
@property(nonatomic,strong) UIColor *indicatorTintColor;  // <#注释#>


@end
