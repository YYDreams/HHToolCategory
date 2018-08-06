//
//  ScrollTestCell.h
//  HHExtend
//
//  Created by flowerflower on 2018/4/2.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "BaseCell.h"
#import "FSScrollContentView.h"
#import "SDCycleScrollView.h"


@interface ScrollTestCell : BaseCell

@property(nonatomic,strong) FSPageContentView *pageContentView;  // <#注释#>

@property(nonatomic,strong) NSMutableArray *viewControllers;  // <#注释#>

@property(nonatomic,assign) BOOL  cellCanScroll;  // <#注释#>

@property(nonatomic,assign) BOOL  isRefresh;  // <#注释#>

@property(nonatomic,strong) NSString *currentStr;  // <#注释#>


@end


//轮播图
@interface BannerCell:BaseCell

@property(nonatomic,strong) SDCycleScrollView *headerView;  // <#注释#>

@property(nonatomic,strong) NSArray *bannerArr;  // <#注释#>



@end


//广告
@class AdvertisementView;

@interface AdvertisementCell:BaseCell

@property(nonatomic,strong) AdvertisementView *advView;  // <#注释#>


@property(nonatomic,strong) NSArray *advArr;  // <#注释#>

@end



@interface AdvertisementView: UIView




@property(nonatomic,copy) void (^handerAdvBtnCallBack)(UIButton *btn);

- (instancetype)initWithFrame:(CGRect)frame  titles:(NSArray *)titles;
@end

