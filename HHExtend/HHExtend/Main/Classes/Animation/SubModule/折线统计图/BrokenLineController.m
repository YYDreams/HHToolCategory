//
//  BrokenLineController.m
//  HHExtend
//
//  Created by flowerflower on 2018/5/2.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "BrokenLineController.h"

#import "FBYLineGraphView.h"

@interface BrokenLineController ()

@end

@implementation BrokenLineController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    FBYLineGraphView *LineGraphView = [[FBYLineGraphView alloc] initWithFrame:CGRectMake(10, 100, Screen_Width - 20, 220)];
    
    // 设置折线图属性
    
    LineGraphView.title = @"折线统计图"; // 折线图名称
    LineGraphView.maxValue = 100;   // 最大值
    LineGraphView.yMarkTitles = @[@"0",@"20",@"40",@"60",@"80",@"100"]; // Y轴刻度标签
    
    [LineGraphView setXMarkTitlesAndValues:@[@{@"item":@"1月1日",@"count":@10},@{@"item":@"1月2日",@"count":@80},@{@"item":@"1月3日",@"count":@68},@{@"item":@"1月4日",@"count":@100},@{@"item":@"1月5日",@"count":@60},@{@"item":@"1月6日",@"count":@56},@{@"item":@"1月7日",@"count":@11}] titleKey:@"item" valueKey:@"count"]; // X轴刻度标签及相应的值
    
    //     LineGraphView.xScaleMarkLEN = 60;
    
    //设置完数据等属性后绘图折线图
    [LineGraphView mapping];
    
    [self.view addSubview:LineGraphView];
}
#pragma mark - loadDataFromNetwork

#pragma mark - setupSubView

#pragma mark - setupConstranints


#pragma mark - <UITableViewDataSource,UITableViewDelegate>


#pragma mark - Custom Method


#pragma mark - Setter && Getter Methods

@end
