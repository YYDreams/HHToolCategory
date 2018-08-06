//
//  AlgorithmController.m
//  HHExtend
//
//  Created by flowerflower on 2018/3/29.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "AlgorithmController.h"

@interface AlgorithmController ()

@property(nonatomic,strong) NSArray *titleArr;  // <#注释#>

@property(nonatomic,strong) NSMutableArray *dataArr;  // <#注释#>

@property(nonatomic,strong) UILabel *showLabel;  // <#注释#>



@end

@implementation AlgorithmController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubView];
    
}
#pragma mark - loadDataFromNetwork

#pragma mark - setupSubView
- (void)setupSubView{
    
    
    
    NSInteger totalloc = 4; //一行的列数
    CGFloat btnW = 80;
    CGFloat btnH = 40;
    CGFloat margin = (Screen_Width - btnW * totalloc)/(totalloc +1);
    CGFloat btnY = 0;
    for (NSInteger  i = 0 ; i< self.titleArr.count; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        NSInteger row = i/totalloc; //行
        NSInteger loc = i % totalloc; //lie
        CGFloat btnX = margin + (margin + btnW) *loc; ////x值由列号决定
        btnY = margin + (margin + btnH) * row; //y值由行号决定
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.tag =  i;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 10;
        btn.backgroundColor = [UIColor orangeColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    }
    
    [self.view addSubview:self.showLabel];
    self.showLabel.frame = CGRectMake(10, btnY+ 80, Screen_Width - 2 *10, 200);
    self.showLabel.text = [NSString stringWithFormat:@"%@",self.dataArr];
    
    
}
#pragma mark - setupConstranints


- (void)btnOnClick:(UIButton *)sender{
    
    NSLog(@"-----------%zd",sender.tag );
    NSLog(@"%@",sender.titleLabel.text);
    self.showLabel.text = [NSString stringWithFormat:@"%@",self.dataArr];
    switch (sender.tag) {
        case 0:
            [self bubbleBtnOnClick];
            break;
        case 1:
            [self selectBtnOnClick];
            break;
        case 2:
            [self fastBtnOnClick];
            break;
        case 3:
            [self insertBtnOnClick];
            break;
        case 4:
            [self hillBtnOnClick];
            break;
        case 5:
            [self mergeBtnOnClick];
            break;
        case 6:
            [self heapsortOnClick];
            break;
        default:
            break;
    }
    
    
    
    
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>

#pragma mark - SEL Method

- (void)bubbleBtnOnClick{
    
    
    int x = 0,y = 0;
    for (int i = 0 ; i < self.dataArr.count - 1; i++) {     //循环控制比较次数
        //为什么issort = true,不能写在循环外面
        //因为交换位置isSort = false,isSort的值永远是false,我们要检测的是某一趟是否交换位置
        BOOL isSort = true; //假设排序ok
        
        for (int j = 0 ; j < self.dataArr.count - 1; j++) {         //两两比较
                       //交换位置
            if (self.dataArr[j] < self.dataArr[j+1]) {  //从小到大 >   从大到小 <
                    isSort = false; //没有排序好
                id  temp = self.dataArr[j];
                self.dataArr[j] = self.dataArr[j+1];
                self.dataArr[j+1] = temp;
            }
            x++; //记录内循环的次数
        }
        y++; //记录外循环的次数
        
        if (isSort) {//如果排序好了
            
            break;
        }
    }
    NSLog(@"记录内循环的次数%zd",x); //36   6
    NSLog(@"记录外循环的次数%zd",y); //6    1
    //http://www.cocoachina.com/ios/20180329/22838.html
    self.showLabel.text = @"最近准备给 VirtualView-iOS 的文本元素新增一个 lineHeight 属性，以便和 VirtualView-Android 配合时能更精确的保证双平台的一致性。面向 Google 以及 Stack Overflow 编程了一会后发现，能查到的资料大部分是介绍如何实现 lineSpacing 属性，而不是 lineHeight";
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
//    paragraphStyle.lineSpacing = 10;
    paragraphStyle.lineSpacing = 10 - (self.showLabel.font.lineHeight - self.showLabel.font.pointSize);
    self.showLabel.backgroundColor = [UIColor orangeColor];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    self.showLabel.attributedText = [[NSAttributedString alloc] initWithString:self.showLabel.text attributes:attributes];
//    [NSString stringWithFormat:@"%@",self.dataArr];

    
}
- (void)selectBtnOnClick{
    
    int x = 0,y = 0;

    for (int i = 0; i <self.dataArr.count; i++) {
        
        for (int j = 0; j< self.dataArr.count - 1 - i; j++) {
            
            if (self.dataArr[j] > self.dataArr[j + 1]) {  //从小到大>    从大到小改成<即可
                /*
                  exchangeObjectAtIndex:需要交换的元素位置.
                  withObjectAtIndex:交换到哪个元素的位置.
                 **/
                [self.dataArr exchangeObjectAtIndex:j+1 withObjectAtIndex:j];
            }
        }
          x++; //记录内循环的次数
    }
    y++;
    
    NSLog(@"记录内循环的次数%zd",x); //7
    NSLog(@"记录外循环的次数%zd",y); //1
    self.showLabel.text = [NSString stringWithFormat:@"%@",self.dataArr];

    
}
- (void)fastBtnOnClick{
    
}
- (void) insertBtnOnClick{
    
}
- (void)hillBtnOnClick{
    
}
- (void)mergeBtnOnClick{
    
}
- (void)heapsortOnClick{
    
    
}
#pragma mark - Custom Method


#pragma mark - Setter && Getter Methods
- (UILabel *)showLabel{
    if (!_showLabel) {
        _showLabel = [UILabel labelText:@"" fontSize:13 textColor:k3Color textAlignment:0];
        _showLabel.numberOfLines  = 0;
        
        
    }
    
    return _showLabel;
}

- (NSArray *)titleArr{
    
    if (!_titleArr){ //冒泡、选择、快速、插入、希尔、归并、基数、堆排序
        _titleArr = @[@"冒泡",@"选择",@"快速",@"插入",@"希尔",@"归并",@"堆排序"];
    }
    return _titleArr;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithObjects:@10,@80,@50,@20,@30,@60,@40, nil];
    }
    return _dataArr;
}
@end
