//
//  FunMenuViewController.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/11.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "FunMenuViewController.h"
#import "FunMenuView.h"
#import "FunMenuModel.h"
#import "HHFunMenuView.h"
#import "YANScrollMenu.h"
#define IMG(name)           [UIImage imageNamed:name]

#define kScale(P)                ((P) * ([UIScreen mainScreen].bounds.size.width / 375.f))

@interface FunMenuViewController ()

@property (nonatomic, strong) YANScrollMenu *menu;
/**
 *  dataSource
 */
@property (nonatomic, strong) NSMutableArray<FunMenuModel *> *dataSource;


@property(nonatomic,strong) FunMenuView *menuView;  // <#注释#>

@property(nonatomic,strong) NSMutableArray *dataArr;  // <#注释#>

@property(nonatomic,strong) HHFunMenuView *scrollMenView;  // <#注释#>

@property(nonatomic,assign)     BOOL showHeader;


@end

@implementation FunMenuViewController

-(NSMutableArray<FunMenuModel *> *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
// 读取本地JSON文件

- (HHFunMenuView *)scrollMenView{
    
    if (!_scrollMenView) {
        _scrollMenView = [[HHFunMenuView alloc]init];
        _scrollMenView.backgroundColor = kBgColor;
        // 总数(必须赋值)
        _scrollMenView.totallNumber=16;
        // 每页显示个数(必须赋值)
        _scrollMenView.pageNum =8;
        // 每行显示个数(必须赋值)
        _scrollMenView.rowNum =4;
        // 指示器圆点颜色
        
        
        _scrollMenView.pageTintColor = [UIColor greenColor];
        // 指示器当前页圆点颜色
        _scrollMenView.currentPageTintColor = [UIColor redColor];
        _scrollMenView.gfScrollMenViewClickIndex = ^(NSInteger index) {
            NSLog(@"点击的是第----%ld个",(long)index);
        };
        
    }
    return _scrollMenView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hh_redomColor];

    [self loadData];

    
 
self.scrollMenView.titlesArray =   @[@"推荐车位",@"车位出售",@"车位长租",@"车位求购",@"车位求租",@"91车位",@"共享车位",@"车位投建",@"推荐车位",@"车位出售",@"车位长租",@"车位求购",@"车位求租",@"91车位",@"共享车位",@"车位投建"].mutableCopy;
    
self.scrollMenView.imagesArray =    @[@"applause_0",@"applause_0",@"applause_0",@"applause_0",@"applause_1",@"applause_2",@"applause_3",@"applause_0",@"applause_0",@"applause_5",@"applause_3",@"applause_0",@"applause_1",@"applause_2",@"applause_0",@"applause_2"].mutableCopy;

    
    [self.view addSubview:self.scrollMenView];
 

    [self initConstraints];
    _showHeader = YES;
    


    
    [self prepareUI];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self createData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.menu reloadData];
            
        });
    });
    
        [self.view addSubview:self.menuView];
}


#pragma mark - Prepare UI
- (void)prepareUI{
        
     
    self.menu = [[YANScrollMenu alloc] initWithFrame:CGRectMake(0, 230, self.view.frame.size.width,kScale(240)) delegate:self];
    self.menu.currentPageIndicatorTintColor = [UIColor redColor];
    self.menu.pageIndicatorTintColor = [UIColor greenColor];
        [YANMenuItem appearance].textFont = [UIFont systemFontOfSize:12];
        [YANMenuItem appearance].space = 3;
        [YANMenuItem appearance].textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.0];
//    [[YANMenuItem appearance]setIconSize:CGSizeMake(70, 70)];
    
    
    [self.view addSubview:self.menu];
    }
//#pragma mark -  Data
- (void)createData{
    
        NSArray *images = @[
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            IMG(@"applause_0"),
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498711713465&di=d986d7003deaae41342dd9885c117e38&imgtype=0&src=http%3A%2F%2Fs9.rr.itc.cn%2Fr%2FwapChange%2F20168_3_0%2Fa86hlk59412347762310.GIF"];
        NSArray *titles = @[@"美食",
                            @"休闲娱乐",
                            @"电影/演出",
                            @"KTV",
                            @"酒店住宿",
                            @"火车票/机票",
                            @"旅游景点",
                            @"运动健身",
                            @"家装建材",
                            @"美容美发",
                            @"美容美发",
                            @"母婴",
                            @"学习培训",
                            @"旅游出行",
                            @"旅游景点",
                            @"运动健身",
                            @"火车票/机票",
                            @"旅游景点",
                            @"运动健身",
                            @"家装建材",
                            @"美容美发",
                            @"母婴",
                            @"学习培训",
                            @"旅游出行",
                            @"动态图\n从网络获取"];
    
    NSMutableArray <FunMenuModel *> *allDataSource = [NSMutableArray array];
        for (NSUInteger idx = 0; idx< images.count; idx ++) {
            
            FunMenuModel *object = [[FunMenuModel alloc] init];
            object.name = titles[idx];
            object.icon = images[idx];
//            object.itemPlaceholder = IMG(@"applause_0");
            [allDataSource addObject:object];
            
            
        }
    
    [self.dataSource addObjectsFromArray:allDataSource];

        
    }
#pragma mark - YANScrollMenuProtocol
 - (NSUInteger)numberOfSectionsInScrollMenu:(YANScrollMenu *)menu{
        
        return 1;
    }
    - (NSUInteger)scrollMenu:(YANScrollMenu *)menu numberOfItemsInSection:(NSInteger)section{
        
        return self.dataSource.count;
    }
- (id<YANObjectProtocol>)scrollMenu:(YANScrollMenu *)scrollMenu objectAtIndexPath:(NSIndexPath *)indexPath{
        
        return self.dataSource[indexPath.item];
    }
- (CGSize)itemSizeOfScrollMenu:(YANScrollMenu *)menu{
        
        return CGSizeMake(kScale(75), kScale(65));
}

/** 如果不要页眉，不用遵守此协议  */
- (UIView *)scrollMenu:(YANScrollMenu *)menu headerInSection:(NSUInteger)section{
    
    if (_showHeader) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kScale(40))];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont boldSystemFontOfSize:kScale(17)];
        label.text = [NSString stringWithFormat:@"--  SECTION %ld  --",section];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(view);
        }];
        
        switch (section%3) {
            case 0:
                label.textColor = [UIColor greenColor];
                break;
            case 1:
                label.textColor = [UIColor orangeColor];
                break;
            case 2:
                label.textColor = [UIColor blueColor];
                break;
            default:
                break;
        }
        
        return view;
    }
    
    return nil;
    
}
- (CGFloat)heightOfHeaderInScrollMenu:(YANScrollMenu *)menu{
    
    return   _showHeader ? kScale(40) : 0;
    
}
- (void)scrollMenu:(YANScrollMenu *)menu didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"IndexPath:%@",indexPath);
    
}

- (void)initConstraints{
    
    
    
    [self.scrollMenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@220);
    }];
}
- (void)loadData{

    
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
 
 
    [HTTPRequest POST:kCategorysUrl parameter:param success:^(id resposeObject) {
        if (SUCCESS) {
          

            NSArray *listArr = [FunMenuModel objectsInArray:resposeObject[@"data"]];


            [self.dataArr addObjectsFromArray:listArr];

            self.menuView.dataArr = self.dataArr;

        }else{
            
        }
        
        
    } failure:^(NSError *error) {
       
    }];
    
}


- (FunMenuView *)menuView{
        if (!_menuView) {
        _menuView = [[FunMenuView alloc]initWithFrame:CGRectMake(0,510, Screen_Width, 180)];
            _menuView.backgroundColor = kBgColor;
    }
    return _menuView;
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
    
}



@end
