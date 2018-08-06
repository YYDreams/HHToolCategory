//
//  MineTestViewController.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/11.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "MineTestViewController.h"
#import "MineTestCell.h"
#import "MineTestModel.h"
@interface MineTestViewController ()

@property(nonatomic,strong) NSMutableArray *dataArr;  // <#注释#>

@end

@implementation MineTestViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [self loadDataFromNetwork];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
    
}

- (void)loadDataFromNetwork{
    
    
    NSArray *array =@[
                       @{@"title":@"哈哈哈",@"count":@"8"},
                       @{@"title":@"哈哈eq哈",@"count":@"12"},
                       @{@"title":@"哈哈订哈",@"count":@"18"},
                       @{@"title":@"哈C哈哈",@"count":@"24"},
                       @{@"title":@"哈哈哈",@"count":@"9"},
                       @{@"title":@"哈呜呜呜",@"count":@"11"},
                       @{@"title":@"哈而且",@"count":@"54"},
                       @{@"title":@"哈22",@"count":@"33"},
                       @{@"title":@"嗯嗯哈哈",@"count":@"21"},
                       @{@"title":@"哈哦",@"count":@"33"},
                       ];
    
    
    
    
    for (NSDictionary *dic in array) {
        MineTestModel *model = [MineTestModel objectWithDic:dic];
        
        [self.dataArr addObject:model];
    }
    
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineTestCell *cell = [MineTestCell cellWithTableView:tableView];
   
    cell.model = [self.dataArr safeObjectAtIndex:indexPath.row];
    
    return cell;
    
}



- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


@end
