//
//  BaseTableViewController.m
//  LYGame
//
//  Created by 花花 on 2017/7/15.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "BaseTableViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "UITableView+LYRefresh.h"
#import "HHTableView.h"

@interface BaseTableViewController ()
@property (nonatomic, weak)UITableView * targetTableView;
@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[HHTableView alloc] initWithFrame:CGRectMake(0,0,Screen_Width,Screen_Height) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = kBgColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = kSeparatedLineColor;
        //empty
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        self.succeedEmptyStr =@"当前暂无内容~";
        self.succeedEmptyImage = [UIImage imageNamed:@"mine_background"];
        [self.view addSubview:_tableView];
        
    }
    
    return _tableView;
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}




#pragma mark -- fresh
- (void)setupRefreshTarget:(UITableView *)tableView
{
    //设置tableView默认 对象为lybaseviewcontroller的tableview
    if (tableView==nil) tableView = self.tableView;
    
    self.targetTableView = tableView;
    
    [tableView setupRefreshFunctionWith:HHRefreshTypeHeaderAndFooter];
    
    WeakSelf;
    [tableView pullUpRefresh:^(int page, BOOL isLastPage) {
        
        [weakSelf pullUpRefresh:page lastPage:isLastPage];
    }];
    
    [tableView pullDownRefresh:^(int page)
     {
         [weakSelf pullDownRefresh:page];
     }];
}

- (void)setupRefreshTarget:(UITableView *)tableView With:(HHRefreshType)type
{
    //设置tableView默认 对象为lybaseviewcontroller的tableview
    if (tableView==nil) tableView = self.tableView;
    
    self.targetTableView = tableView;
    
    [tableView setupRefreshFunctionWith:type];
    
    WeakSelf;
    if (type == HHRefreshTypeHeader)
    {
        [tableView pullDownRefresh:^(int page)
         {
             [weakSelf pullDownRefresh:page];
         }];
    }
    else if (type==HHRefreshTypeFooter)
    {
        [tableView pullUpRefresh:^(int page, BOOL isLastPage) {
            
            [weakSelf pullUpRefresh:page lastPage:isLastPage];
        }];
    }
    else
    {
        [self setupRefreshTarget:tableView];
    }
}

- (void)pullDownRefresh:(int)page
{
    
}

- (void)pullUpRefresh:(int)page lastPage:(BOOL)isLastPage
{
    
}
//请求成功结束刷新状态
- (void)successEndRefreshStatus:(int)status totalPage:(int)totalPage
{
    [self.targetTableView endRefreshStatus:status totalPage:totalPage];
}
//请求失败结束刷新状态
- (void)failEndRefreshStatus:(int)status
{
    [self.targetTableView endRefreshStatus:status];
}

- (void)endRefreshWithNoMoreData{
    [self.targetTableView endRefreshWithNoMoreData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
