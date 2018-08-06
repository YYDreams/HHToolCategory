//
//  MasonryViewController.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/9.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "MasonryViewController.h"

@interface MasonryViewController ()

@property(nonatomic,strong) NSMutableArray *masonryArr;  // <#注释#>
@property(nonatomic,strong) NSMutableArray *masonryArr1;  // <#注释#>

@property(nonatomic,strong) UIView *redView;  // <#注释#>

@end

@implementation MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSubView];

}


- (void)setupSubView{
    
    [self.view addSubview:self.redView];
    
//    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        // 设置宽度小于等于200
//        make.width.lessThanOrEqualTo(@200);
//        // 设置高度大于等于10
//        make.height.greaterThanOrEqualTo(@(10));
//    }];
    
    /**
     *  distribute with fixed spacing
     * *  @param axisType     横排还是竖排
     *  @param fixedSpacing 两个控件间隔
     *  @param leadSpacing  第一个控件与边缘的间隔
     *  @param tailSpacing  最后一个控件与边缘的间隔
     */
    //    1、水平方向排列、固定控件间隔、控件长度不定
    [self masonry];
    
    /**
     *  distribute with fixed item size
     
     *  @param axisType        横排还是竖排
     *  @param fixedItemLength 控件的宽或高
     *  @param leadSpacing     第一个控件与边缘的间隔
     *  @param tailSpacing     最后一个控件与边缘的间隔
     */
    //2、水平方向排列、固定控件长度、控件间隔不定
    [self masonry1];
    
}
- (void)masonry{
    
    //水平方向 控制顶部、高
    //垂直方式  控制左、宽
    [self.masonryArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:10 tailSpacing:10];
    
    [self.masonryArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(50);
    }];
}
- (void)masonry1{
    
    
        [self.masonryArr1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:80 leadSpacing:10 tailSpacing:10];
    
    [self.masonryArr1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(65);
        make.height.mas_equalTo(50);
    }];
}

- (UIView *)redView{
    if (!_redView) {
        _redView = [[UIView alloc]init];
    }
    return _redView;
}

- (NSMutableArray *)masonryArr{
    
    if (!_masonryArr) {
        _masonryArr = [NSMutableArray array];
        for (int i = 0; i<4; i++) {
            
            
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor hh_redomColor];
            [self.view addSubview:view];
            [_masonryArr addObject:view];
        }
    }
    return _masonryArr;
}


- (NSMutableArray *)masonryArr1{
    
    if (!_masonryArr1) {
        _masonryArr1 = [NSMutableArray array];
        for (int i = 0; i<4; i++) {
            
            
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor hh_redomColor];
            [self.view addSubview:view];
            [_masonryArr1 addObject:view];
        }
    }
    return _masonryArr1;
}

@end
