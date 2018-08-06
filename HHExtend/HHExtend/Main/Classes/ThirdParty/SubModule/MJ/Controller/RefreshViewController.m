//
//  RefreshViewController.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/4.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "RefreshViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "JYMpointDetaModel.h"
#import "JYMPointDetaCell.h"
@interface RefreshViewController ()

@property(nonatomic,strong) NSMutableArray *dataArray;  // <#注释#>

@property(nonatomic,strong) JYMpointDetaModel *model;  // <#注释#>

@end

@implementation RefreshViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableView];
    
    [self setupRefresh];

}
#pragma mark - setupTableView

- (void)setupTableView{
    self.tableView.height = Screen_Height - kNavHeight;
    
    self.tableView.rowHeight = 60;
    
}
#pragma mark - setupRefresh

- (void)setupRefresh{
    
    [self setupRefreshTarget:self.tableView];
    
    [self loadListDataWithPage:1 andStatus:3];
    
}
#pragma mark - loadDataFromNetwork
- (void)loadListDataWithPage:(int)page andStatus:(int)status{
    
    WeakSelf;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    param[@"accountNo"] = @"38087174007192";
    param[@"pageNum"] = @(page);
    param[@"pageSize"] = @(20);
   
    //全部订单
//    param[@"orderStatus"] = @(0);
//    param[@"userId"] = @"88c96211-7e08-49a6-a935-3ec533b4eac8";
//    param[@"pageSize"] = @(20);
//      param[@"pageNum"] = @(page);
//
    
    if (!_model) {
        [HHLoadingView showLoadingInView:self.view];

    }

    //kBalanceListUrl 美点明细   kOrderclientGetUserOrdersUrl  我的订单->全部
    [HTTPRequest POST:kBalanceListUrl parameter:param success:^(id resposeObject) {
        
        if (![resposeObject[@"list"] isKindOfClass:[NSNull class]]) {
            

            for (NSDictionary *dic in resposeObject[@"list"]) {

          JYMpointDetaModel *model = [JYMpointDetaModel mj_objectWithKeyValues:dic];

               [self.dataArray addObject:model];

                weakSelf.model = model;

            }
//
  
//            NSArray *dataArr = [JYMpointDetaModel objectsInArray:resposeObject[@"list"]];
//
//            [self.dataArray addObjectsFromArray:dataArr];
            
            int totalPage = [resposeObject[@"pages"] intValue];
            dispatch_async(dispatch_get_main_queue(), ^{
                [HHLoadingView hideLoadingForView:weakSelf.view];
                
                [weakSelf successEndRefreshStatus:status totalPage:totalPage];
                if (self.dataArray.count >0 && self.dataArray.count<20) {
                    
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                [self.tableView reloadData];
                
            });

        }else{
            [weakSelf failEndRefreshStatus:status];
        }
        
        self.currentPageStatus = PageStatusSucceed;
        self.succeedEmptyImage = [UIImage imageNamed:@"pull_refresh_bottom_0001"];
    } failure:^(NSError *error) {
        [weakSelf failEndRefreshStatus:status];
        NSLog(@"%@",error);
        [MBProgressHUD LY_ShowError:kNoNetworkTips time:2.0];
        [HHLoadingView hideLoadingForView:weakSelf.view];
        
        self.currentPageStatus = PageStatusError;
        if (!weakSelf.model) {
            
            self.emptyViewTapBlock = ^{
                [weakSelf pullDownRefresh:1];
            };
        }
    
    }];

}
- (void)pullDownRefresh:(int)page{
    
    [self.dataArray  removeAllObjects];
    //0 结束头部
    [self loadListDataWithPage:page andStatus:0];
    
}
- (void)pullUpRefresh:(int)page lastPage:(BOOL)isLastPage{
    
    if (isLastPage) {
        return;
    }
    
    [self loadListDataWithPage:page andStatus:1];
}
#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (!_model) return 0;
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JYMPointDetaCell *cell = [JYMPointDetaCell cellWithTableView:tableView];

    if (_model) {
        cell.model = [self.dataArray safeObjectAtIndex:indexPath.row];
    }
    return cell;
}
#pragma mark - Setter && Getter Methods
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;

}
@end
