
//
//  HomeViewController.m
//  HHExtend
//
//  Created by flowerflower on 2018/3/28.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "HomeViewController.h"
#import "TwoLinkageController.h"
#import "MovieViewController.h"
#import "TestViewController.h"
#import "LoginViewController.h"
#import "PickerViewController.h"
@interface HomeViewController ()

@property(nonatomic,strong) NSMutableArray *viewControllers;  // <#注释#>

@property(nonatomic,strong) NSMutableArray *titleArray;  // <#注释#>

@end

static NSString *const homeCellID = @"homeCellID";
@implementation HomeViewController

/**
 控件封装:
 NSString的使用
 1.自定义弹出视图
 2.二维码生成、扫一扫
 3.照片上传
 4.照片上传有进度
 5.指纹解锁
 6.pickerView省市区 年月日 自定义数组
 NSString 排序
 
 
 类似美团的下拉菜单  http://code.cocoachina.com/view/126047   http://code.cocoachina.com/view/130711
 
  仿QQ弹出菜单  http://code.cocoachina.com/view/130089
 
 精确到毫秒的倒计时 http://code.cocoachina.com/view/135146
 
 表格:
 垂直流水布局
 拖拽列表
 collectionView布局
 列表的展开和收起
 table联动
流水布局  http://code.cocoachina.com/view/129389
 动态瀑布流-展示网络图片 增强 http://code.cocoachina.com/view/129035
 
 popView弹出视图 http://code.cocoachina.com/view/132219
 模仿QQ点击下拉菜单 http://code.cocoachina.com/view/130034
 
 
 imgArr
 titleArr
 总个数
 
 指示器的颜色
 指示器当前颜色
 水平滚动
 还是直接垂直滚动
 
 
 
 动画相关
 折线图
 饼状图
 
 
 
 第三方:
 刷新
 Masonry
 
 
 
 **/
- (void)viewDidLoad {
    
    [super viewDidLoad];

    
    self.tableView.backgroundColor  = [UIColor clearColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.viewControllers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:homeCellID];
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

- (NSMutableArray *)viewControllers{
    if (!_viewControllers) {
        _viewControllers = [NSMutableArray arrayWithObjects:@"PickerViewController",@"QrCodeViewController",@"LoginViewController",@"ButtnonController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController", nil];
    }
    
    return _viewControllers;
    
    
}

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"PickerVIew选择省市区:年月日:自定义数组",@"二维码生成与扫一扫",@"登录",@"按钮的各种样式", nil];
    }
    return _titleArray;
}


@end
