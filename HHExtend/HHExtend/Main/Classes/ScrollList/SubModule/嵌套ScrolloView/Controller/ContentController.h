//
//  ContentController.h
//  HHExtend
//
//  Created by flowerflower on 2018/4/2.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "BaseUIViewController.h"

@interface ContentController : BaseUIViewController

@property(nonatomic,strong) UITableView *tableView;  // <#注释#>


@property(nonatomic,assign) BOOL  isRefresh;  // <#注释#>

@property(nonatomic,assign) BOOL  vcCanScroll;  // <#注释#>

@end
