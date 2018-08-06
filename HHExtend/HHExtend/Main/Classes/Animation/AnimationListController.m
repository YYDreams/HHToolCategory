//
//  AnimationListController.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/10.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "AnimationListController.h"

@interface AnimationListController ()
@property(nonatomic,strong) NSMutableArray *viewControllers;  // <#注释#>

@property(nonatomic,strong) NSMutableArray *titleArray;  // <#注释#>
@end

static NSString *const AnimationListCellID = @"AnimationListCellID";
@implementation AnimationListController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight  =  kTableView_rowHeight;
    
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.viewControllers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AnimationListCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:AnimationListCellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.viewControllers safeObjectAtIndex:indexPath.row]];
    cell.detailTextLabel.text = [self.titleArray safeObjectAtIndex:indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //1.获取类名字符串
    NSString *className= [self.viewControllers safeObjectAtIndex:indexPath.row];
    //2。获取类名
    Class class = NSClassFromString(className);
    //3.创建对象
    BaseUIViewController * viewController  = [[class alloc] init];
    viewController.title = [self.viewControllers safeObjectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}
#pragma mark - Setter && Getter Methods


- (NSMutableArray *)viewControllers{
    if (!_viewControllers) {
        _viewControllers = [NSMutableArray arrayWithObjects:@"AnimationSimpleController",@"AlgorithmController",@"HHCustomPieChartController",@"BrokenLineController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController", nil];
    }
    
    return _viewControllers;
    
    
}

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"简单小动画",@"算法相关(暂放此处)",@"画饼吃",@"折线统计图", nil];
    }
    return _titleArray;
}

@end
