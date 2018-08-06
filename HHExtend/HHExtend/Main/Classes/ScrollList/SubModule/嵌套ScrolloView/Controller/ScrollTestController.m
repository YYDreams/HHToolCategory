//
//  ScrollTestController.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/2.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "ScrollTestController.h"
#import "BaseTableView.h"
#import "ScrollTestCell.h"
#import "FSSegmentTitleView.h"
#import "FSScrollContentView.h"

#import "ContentController.h"
#import <MJRefresh/MJRefresh.h>
//#import <SVPullToRefresh.h>
@interface ScrollTestController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,FSSegmentTitleViewDelegate,FSPageContentViewDelegate>


//@property(nonatomic,strong) BaseTableView *tableView;  // <#注释#>

@property(nonatomic,strong) NSMutableArray *bannerArr;  // <#注释#>

@property (nonatomic, strong) FSSegmentTitleView *titleView;

@property(nonatomic,strong) ScrollTestCell *cell;  // <#注释#>

@property (nonatomic, assign) BOOL canScroll;

@end

static NSString *const ScrollCellID = @"ScrollCellID";
static NSString *const BannerCellID = @"BannerCellID";
static NSString *const AdvertisementCellID = @"AdvertisementCellID";


@implementation ScrollTestController


#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];

    [self setupSubView];
}
- (void)setupSubView{
   self.canScroll = YES;
    
    [self.tableView registerClass:[ScrollTestCell class] forCellReuseIdentifier:ScrollCellID];
    [self.tableView registerClass:[BannerCell class] forCellReuseIdentifier:BannerCellID];
    [self.tableView registerClass:[AdvertisementCell class] forCellReuseIdentifier:AdvertisementCellID];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    WeakSelf;
//
//    [self.tableView addPullToRefreshWithActionHandler:^{
//        [weakSelf loadNewData];
//    }];
    
    self.tableView.height =  Screen_Height - kNavHeight;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    

    
}
- (void)loadNewData{
    
    NSArray *sortTitles = @[@"全部",@"服饰穿搭",@"生活百货",@"美食吃货",@"美容护理",@"母婴儿童",@"数码家电"];
    self.cell.currentStr = sortTitles[self.titleView.selectIndex];

    self.cell.isRefresh = YES;
    [self.tableView.mj_header endRefreshing];
//    [self.tableView.pullToRefreshView stopAnimating];
}
#pragma mark notify
- (void)changeScrollStatus//改变主视图的状态
{
    self.canScroll = YES;
    self.cell.cellCanScroll = NO;
}

#pragma mark - loadDataFromNetwork

#pragma mark - setupSubView

#pragma mark - setupConstranints


#pragma mark - <UITableViewDataSource,UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        return 1;
    }
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%zd-==============",indexPath.section);
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 200;
        }
        return 50;
    }
    return CGRectGetHeight(self.view.bounds);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 50) titles:@[@"111全部",@"服饰穿搭",@"生活百货",@"美食吃货",@"美容护理",@"母婴儿童",@"数码家电"] delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    self.titleView.backgroundColor = [UIColor lightGrayColor];
    return self.titleView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
    if (indexPath.section == 1) {
        
         _cell= [tableView dequeueReusableCellWithIdentifier:ScrollCellID];
        NSArray *titles = @[@"全部",@"服饰穿搭",@"生活百货",@"美食吃货",@"美容护理",@"母婴儿童",@"数码家电"];

        NSMutableArray *contentVCs = [NSMutableArray array];
        for (NSString *title in titles) {
            ContentController *vc = [[ContentController alloc]init];
            vc.title = title;
//            vc.str = title;
            [contentVCs addObject:vc];
        }
        _cell.viewControllers = contentVCs;
        _cell.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 64) childVCs:contentVCs parentVC:self delegate:self];
        [_cell.contentView addSubview:_cell.pageContentView];
        return _cell;
    
    }else{
        if (indexPath.row == 0) {
            
            BannerCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:BannerCellID];
            bannerCell.headerView.delegate = self;
            bannerCell.bannerArr = self.bannerArr;
            
            return bannerCell;
        }else{
            AdvertisementCell *advCell = [tableView dequeueReusableCellWithIdentifier:AdvertisementCellID];
            advCell.advView  = [[AdvertisementView alloc]initWithFrame:advCell.bounds titles:@[@"daddadada",@"dadwe4r323232",@"dadadwe   qwert"]];
            [advCell addSubview:advCell.advView];

            return advCell;
            
        }
    }
    
    
    return nil;
    
    
}


#pragma mark - FSSegmentTitleViewDelegate
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.titleView.selectIndex = endIndex;
    self.tableView.scrollEnabled = YES;//此处其实是监测scrollview滚动，pageView滚动结束主tableview可以滑动，或者通过手势监听或者kvo，这里只是提供一种实现方式
}

- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.cell.pageContentView.contentViewCurrentIndex = endIndex;
}

- (void)FSContentViewDidScroll:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress
{
    self.tableView.scrollEnabled = NO;//pageView开始滚动主tableview禁止滑动
}

#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat bottomCellOffset = [self.tableView rectForSection:1].origin.y - kNavHeight;
    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            self.cell.cellCanScroll = YES;
        }
    }else{
        if (!self.canScroll) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
    self.tableView.showsVerticalScrollIndicator = _canScroll?YES:NO;
}
#pragma mark - SDCycleScrollViewDelegate


#pragma mark - Custom Method


#pragma mark - Setter && Getter Methods



//- (BaseTableView *)tableView{
//    if (!_tableView) {
//        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
//        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.01)];
//        [_tableView registerClass:[ScrollTestCell class] forCellReuseIdentifier:ScrollCellID];
//        [_tableView registerClass:[BannerCell class] forCellReuseIdentifier:BannerCellID];
//        [_tableView registerClass:[AdvertisementCell class] forCellReuseIdentifier:AdvertisementCellID];
//
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        [self.view addSubview:_tableView];
//    }
//    return _tableView;
//}

- (NSMutableArray *)bannerArr{
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray arrayWithArray:
                      @[@"http://img05.tooopen.com/images/20150202/sy_80219211654.jpg",
                        @"http://img06.tooopen.com/images/20161123/tooopen_sy_187628854311.jpg",
                        @"http://img07.tooopen.com/images/20170306/tooopen_sy_200775896618.jpg",
                        @"http://img06.tooopen.com/images/20170224/tooopen_sy_199503612842.jpg",
                        @"http://img02.tooopen.com/images/20160316/tooopen_sy_156105468631.jpg"]];
    }
    return _bannerArr;
    
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
