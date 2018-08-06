//
//  TwoLinkageController.m
//  HHExtend
//
//  Created by flowerflower on 2018/3/28.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "TwoLinkageController.h"
#import "TwoLinkageCell.h"
#import "TitleScrollView.h"
#import "TwoLinkageModel.h"
@interface TwoLinkageController ()

@property(nonatomic,strong) NSMutableArray  *dataArr;  //

@property(nonatomic,strong) TitleScrollView *scrollView;  // <#注释#>

@property(nonatomic,strong) NSArray *titleArr;  // <#注释#>

@end

static NSString *const TwoLinkageCellID = @"TwoLinkageCellID";
@implementation TwoLinkageController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"两级联动";
    [self setupSubView];
    [self loadDataFromNetwork];
}

#pragma mark - loadDataFromNetwork
- (void)loadDataFromNetwork{
    
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithObjects:@{@"title":@"家庭医生",@"desc":@"拥有家庭医生，您可以随时就全家的健康问题进行在线咨询。",@"index":@"0"}
                ,@{@"title":@"专家问诊",@"desc":@"您可以免费或以折扣价格向爱心医疗专家进行在线问诊。您可以免费或以折扣价格向爱心医疗专家进行在线问诊。您可以免费或以折扣价格向爱心医疗专家进行在线问诊。您可以免费或以折扣价格向爱心医疗专家进行在线问诊。您可以免费或以折扣价格向爱心医疗专家进行在线问诊。您可以免费或以折扣价格向爱心医疗专家进行在线问诊。",@"index":@"1"}
                ,@{@"title":@"健康档案",@"desc":@"免费为全家人创建健康档案，爱心云健康帮您记录医疗信息。",@"index":@"2"}
                ,@{@"title":@"健康直播",@"desc":@"各路知名医疗大神手把手传授您健康诀窍。",@"index":@"3"}
                ,@{@"title":@"报告解读",@"desc":@"免费或以折扣价格为您解读检验报告单并提供专业医疗建议。免费或以折扣价格为您解读检验报告单并提供专业医疗建议。",@"index":@"4"}
                ,@{@"title":@"医院转诊",@"desc":@"您可以免费或以折扣价格向爱心医疗专家进行在线问诊。您可以免费或以折扣价格向爱心医疗专家进行在线问诊。您可以免费或以折扣价格向爱心医疗专家进行在线问诊。",@"index":@"5"}
                ,@{@"title":@"海外就医",@"desc":@"联合全球顶级优质医疗机构，为您提供最专业医学意见。",@"index":@"6"}
                ,@{@"title":@"住院手术",@"desc":@"当确定手术需求时，为您安排顶级医院的手术治疗方案。当确定手术需求时，为您安排顶级医院的手术治疗方案。当确定手术需求时，为您安排顶级医院的手术治疗方案。当确定手术需求时，为您安排顶级医院的手术治疗方案。当确定手术需求时，为您安排顶级医院的手术治疗方案。",@"index":@"7"}, nil];


    for (NSDictionary *dic in tempArr) {
        
        TwoLinkageModel *model = [TwoLinkageModel objectWithDic:dic];
        
        [self.dataArr addObject:model];
    }
    
}

#pragma mark - setupSubView
- (void)setupSubView{
    
    [self.view addSubview:self.scrollView];

    
    
    [self.tableView registerClass:[TwoLinkageCell class] forCellReuseIdentifier:TwoLinkageCellID];
    WeakSelf;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(weakSelf.scrollView.mas_bottom);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(Screen_Height - self.scrollView.height);

    }];

#warning bug 
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0,  Screen_Height-self.scrollView.height, 0);

    //{{0, 0}, {414, 736}}
    NSLog(@"--------%@",NSStringFromCGRect(self.tableView.frame));

    
}


#pragma mark - setupConstranints


#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TwoLinkageCell *cell = [tableView dequeueReusableCellWithIdentifier:TwoLinkageCellID];
    cell.model = [self.dataArr safeObjectAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TwoLinkageModel *model = [self.dataArr safeObjectAtIndex:indexPath.row];
    return model.cellHight;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isKindOfClass:[UITableView class]]) {

        CGPoint gjPoint  = CGPointMake(80, self.scrollView.frame.size.height+1);//+1很重要，+1确保关键的点在需要的位置
        CGPoint p_intable =   [self.view convertPoint:gjPoint toView:self.tableView];
        NSIndexPath *indexPath =  [self.tableView indexPathForRowAtPoint:p_intable];
        TwoLinkageModel *model = self.dataArr[indexPath.row];
        NSInteger bottomIndex = [model.index integerValue];
        if (bottomIndex!=self.scrollView.selectedBtn.tag-100) {
            [self.scrollView setContentOffset:CGPointMake(80*bottomIndex, 0) animated:YES];
            [self.scrollView setIndexSelected:bottomIndex];
     }
        
        
        NSLog(@"%@",NSStringFromCGRect(self.tableView.frame));
    }
    
}
#pragma mark - Custom Method


#pragma mark - Setter && Getter Methods
- (TitleScrollView *)scrollView{
    
    if (!_scrollView) {
        
        _scrollView = [[TitleScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 80) titleArray:self.titleArr];
        WeakSelf;
        _scrollView.handlerBtnCallBack = ^(NSInteger index) {
          
   [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
        };
    }
    return _scrollView;
        
}
- (NSArray *)titleArr{
    
    if (!_titleArr) {
        _titleArr = @[
                      @{@"title":@"家庭医生",@"sImage":@"index0_s",@"uImage":@"index0_u",@"indexId":@"0"},
                      @{@"title":@"专家问诊",@"sImage":@"index1_s",@"uImage":@"index1_u",@"indexId":@"1"},
                      @{@"title":@"健康档案",@"sImage":@"index2_s",@"uImage":@"index2_u",@"indexId":@"2"},
                      @{@"title":@"健康直播",@"sImage":@"index3_s",@"uImage":@"index3_u",@"indexId":@"3"},
                      @{@"title":@"报告解读",@"sImage":@"index4_s",@"uImage":@"index4_u",@"indexId":@"4"},
                      @{@"title":@"医院转诊",@"sImage":@"index5_s",@"uImage":@"index5_u",@"indexId":@"5"},
                      @{@"title":@"海外就医",@"sImage":@"index6_s",@"uImage":@"index6_u",@"indexId":@"6"},
                      @{@"title":@"住院手术",@"sImage":@"index7_s",@"uImage":@"index7_u",@"indexId":@"7"}];
    }
    return _titleArr;
}

- (NSMutableArray *)dataArr{

    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}



@end
