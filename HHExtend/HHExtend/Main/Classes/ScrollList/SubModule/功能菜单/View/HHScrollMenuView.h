//
//  HHScrollMenuView.h
//  HHExtend
//
//  Created by flowerflower on 2018/4/12.
//  Copyright © 2018年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHScrollMenuView;

@protocol HHScrollMenuViewDataSource <NSObject>

- (NSInteger)scrollMenu:(HHScrollMenuView *)menu numberOfItemsInSection:(NSInteger)section;

- (NSInteger)numberOfSectionsInScrollMenu:(HHScrollMenuView *)menu;

- (id)scrollMenu:(HHScrollMenuView *)menu cellForItemAtIndexPath:(NSIndexPath *)indexPath;


@end

@interface HHScrollMenuView : UIView

//点击每个item的点击事件
@property(nonatomic,copy) void (^handlerSelectItemAtIndexPath)(HHScrollMenuView *menuView,NSIndexPath *indexPath);

//每个item的大小  默认40 70 
@property(nonatomic,copy) CGSize (^handlerItemSize)();  // <#注释#>

//当前指示器的颜色
@property(nonatomic,strong) UIColor *currentIndicatorColor;  // <#注释#>
//分页控制器分页的颜色，
@property(nonatomic,strong) UIColor *indicatorTintColor;  // <#注释#>

@property (nonatomic, weak) id<HHScrollMenuViewDataSource> dataSource;

- (void)reloadData;
@end




@interface HHMenuModel:NSObject

@property(nonatomic,copy) NSString *itemTitle;  // <#注释#>

@property(nonatomic,copy) NSString *itemImage;  // <#注释#>

@end

#pragma mark - HHMenuItemCell
@interface HHMenuItemCell: UICollectionViewCell


@property(nonatomic,strong) HHMenuModel *model;  // <#注释#>


@property (nonatomic, assign) CGSize iconSize ;

@property(nonatomic,assign) CGFloat  iconCornerRadius;  // <#注释#>

// *  图片与文本的距离，默认是 10
@property(nonatomic,assign) CGFloat  space;  // <#注释#>

//*  文本的字体颜色，默认是darkTextColor
@property (nonatomic, strong) UIColor *textColor;

// *  文本的字体大小，默认是14号系统字体
@property (nonatomic, strong) UIFont *textFont;

@end


#pragma mark - HHScrollMenuIndicatorView 
@interface HHScrollMenuIndicatorView : UIView



@end






