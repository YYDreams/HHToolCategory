//
//  HHPieChartView.h
//  HHExtend
//
//  Created by flowerflower on 2018/4/12.
//  Copyright © 2018年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHPieChartView : UIView


//@property(nonatomic,copy) void(^handlerDidSelectIndexPath)(HHPieChartView *pieChart,NSInteger index);
@property(nonatomic,strong) NSArray *dataArr;  // 数据数组

@property(nonatomic,copy) NSString *title;  // 标题

//绘制方法
- (void)draw;

@end


@interface HHPieCenterView : UIView

@property(nonatomic,strong) UILabel *nameLabel;  // 中心名称


@end
