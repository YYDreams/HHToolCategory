//
//  ScrollListController.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/2.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "ScrollListController.h"

#import "ScrollTestController.h"
#import "FunMenuViewController.h"
@interface ScrollListController ()

@end

static NSString *const ScrollListCellID = @"ScrollListCellID";
@implementation ScrollListController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ScrollListCellID];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return section?5:6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ScrollListCellID];
    if (0 == indexPath.section) {
        cell.textLabel.text = @[@"1", @"2", @"3", @"4", @"5", @"6"][indexPath.row];
    } else {
        cell.textLabel.text = @[@"11", @"12", @"13", @"14", @"15"][indexPath.row];
    }
    return cell;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ScrollListCellID];
//
//    cell.textLabel.text = [NSString stringWithFormat:@"Home:%zd",indexPath.row];
//
//    return cell;
//
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"%zd-----", indexPath.row);

//    [self.navigationController pushViewController:[ScrollTestController new] animated:YES];
        [self.navigationController pushViewController:[FunMenuViewController new] animated:YES];


}


@end
