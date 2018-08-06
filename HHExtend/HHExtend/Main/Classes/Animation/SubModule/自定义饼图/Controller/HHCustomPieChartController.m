
//
//  HHCustomPieChartController.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/12.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "HHCustomPieChartController.h"
#import "HHPieChartView.h"
#import "HHPieModel.h"
@interface HHCustomPieChartController ()

@end

@implementation HHCustomPieChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    HHPieChartView *pieChartView = [[HHPieChartView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 250)];
    

    [self.view addSubview:pieChartView];

    HHPieModel *model1 = [[HHPieModel alloc]init];
    model1.name = @"交通出行";
    model1.rate = 0.20;
    
    HHPieModel *model2 = [[HHPieModel alloc]init];
    model2.name = @"生活日用";
    model2.rate = 0.30;
    
    HHPieModel *model3 = [[HHPieModel alloc]init];
    model3.name = @"饮食";
    model3.rate = 0.20;
    
    HHPieModel *model4 = [[HHPieModel alloc]init];
    model4.name = @"其他";
    model4.rate = 0.10;
    
    HHPieModel *model5 = [[HHPieModel alloc]init];
    model5.name = @"借呗";
    model5.rate = 0.20;
    
    NSArray *dataArray = @[model1, model2, model3, model4, model5];
    pieChartView.dataArr = dataArray;
    

    pieChartView.title = @"金额";
    [pieChartView draw];

    
    
    
    
    HHPieChartView *chart1 = [[HHPieChartView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(pieChartView.frame)+10, Screen_Width, 300)];
    
    [self.view addSubview:chart1];
    
    
    HHPieModel *model7 = [[HHPieModel alloc] init];
    
    model7.rate = 0.01;
    model7.name = @"哈哈1";
    
    
    HHPieModel *model8 = [[HHPieModel alloc] init];
    
    model8.rate = 0.01;
    model8.name = @"哈哈2";
    
    
    HHPieModel *model9 = [[HHPieModel alloc] init];
    
    model9.rate = 0.01;
    model9.name = @"哈哈";
    
    
    
    HHPieModel *model10 = [[HHPieModel alloc] init];
    
    model10.rate = 0.01;
    model10.name = @"哈哈哈哈哈哈";
    
    
    HHPieModel *model11 = [[HHPieModel alloc] init];
    model11.rate = 0.21;
    model11.name = @"哈哈哈哈哈哈";
    
    
    HHPieModel *model12 = [[HHPieModel alloc] init];
    
    model12.rate = 0.75;
    model12.name = @"哈哈哈哈哈哈哈哈哈哈哈哈";
    
    
    NSArray *dataArray1 = @[model7, model8, model9, model10, model11, model12];
    
    chart1.dataArr = dataArray1;
    
    chart1.title = @"🌹🌹";
    
    [chart1 draw];
}


@end
