//
//  ThirdPartyController.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/4.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "ThirdPartyController.h"

@interface ThirdPartyController ()

@property(nonatomic,strong) NSMutableArray *viewControllers;  // <#注释#>

@property(nonatomic,strong) NSMutableArray  *titleArr;  // <#注释#>

@end

static NSString *const ThirdPartyCellID = @"ThirdPartyCellID";



@implementation ThirdPartyController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ThirdPartyCellID];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.viewControllers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ThirdPartyCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ThirdPartyCellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.viewControllers safeObjectAtIndex:indexPath.row]];
    cell.detailTextLabel.text = [self.titleArr safeObjectAtIndex:indexPath.row];
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
        _viewControllers = [NSMutableArray arrayWithObjects:@"RefreshViewController",@"Refresh1ViewController",@"MasonryViewController",@"LoginViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController", nil];
    }
    
    return _viewControllers;
    
}
- (NSMutableArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [NSMutableArray arrayWithObjects:@"刷新1",@"刷新2",@"Masonry", nil];
    }
    return _titleArr;
}

@end
