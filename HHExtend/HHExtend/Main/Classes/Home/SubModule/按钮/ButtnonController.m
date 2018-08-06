//
//  ButtnonController.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/26.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "ButtnonController.h"
#import "HHButtonStyle.h"
#import "HHButton.h"
#import "UIButton+HHPositionStyleButton.h"
#import "FSCustomButton.h"
@interface ButtnonController ()

@end

@implementation ButtnonController
-(void)loadCXButton{
    
    for (NSInteger i = 0; i < 3; i ++) {
        
        HHButtonStyle * button = [HHButtonStyle buttonWithType:UIButtonTypeCustom];
        
        [button setImage:[UIImage imageNamed:@"home_func_11"] forState:UIControlStateNormal];
        
        [button setTitle:[NSString stringWithFormat:@"祝福%zd",i] forState:UIControlStateNormal];
        
        button.backgroundColor = [UIColor grayColor];
        
        [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        
        //下面是九宫格的设计
        NSInteger l = i % 3;
        NSInteger h = i / 3;
         button.tag = i;
         [button addTarget:self action:@selector(clickFunctionBtn:) forControlEvents:UIControlEventTouchUpInside];
        NSInteger kMagin = 20;
        
        CGFloat width = (self.view.frame.size.width - 4 * kMagin) / 3;
        CGFloat height = 80;
        //通过个数位置确定具体的frame
        button.frame = CGRectMake(kMagin + (kMagin + width) * l,20 + kMagin + (kMagin + height) * h, width, height);
        
        NSLog(@"%@",NSStringFromCGRect(button.frame));
        
        [self.view addSubview:button];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadCXButton];
    
    HHButtonStyle *btn = [[HHButtonStyle alloc]init];
    btn.positionStyle = ImagePositionStyleRight; //图片在右 文字在左
    btn.frame = CGRectMake(20, 20, 55, 30);
    [btn layoutIfNeeded];
    btn.backgroundColor = [UIColor darkGrayColor];
    
    
    [self.view addSubview:btn];
    
    
    
    FSCustomButton *button = [[FSCustomButton alloc] initWithFrame:CGRectMake(120, 20, 100, 80)];
    button.adjustsTitleTintColorAutomatically = YES;
//    [button setTintColor:UIColorMake(27, 31, 35)];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button setTitle:@"图片在上" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor hh_redomColor];
    [button setImage:[UIImage imageNamed:@"home_func_11"] forState:UIControlStateNormal];
    button.layer.cornerRadius = 4;
    button.buttonImagePosition = FSCustomButtonImagePositionTop;
    [button addTarget:self action:@selector(clickFunctionBtn:) forControlEvents:UIControlEventTouchUpInside];

    button.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
    [self.view addSubview:button];
    

    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 200, Screen_Width, 100)];
    contentView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:contentView];
    NSArray * titles =@[(@"积分任务"),(@"活动中心"),(@"游戏划账"),(@"兑换乐盈券")];
    CGFloat btnW = Screen_Width/4;
    CGFloat btnH = 80;
//    CGFloat margin = 5;
//  CGFloat margin =   (Screen_Width - btnW * titles.count)/(titles.count + 1);
    
    
    for (int i= 0; i<titles.count; i++){
        
        FSCustomButton *button1 = [[FSCustomButton alloc]init];
//                                   WithFrame:CGRectMake(20, 10, btnW, btnH)];
        button1.adjustsTitleTintColorAutomatically = YES;
//        button1.frame = CGRectMake(margin + (margin + btnW) * (i % titles.count), 10, btnW, btnH);
        button1.frame = CGRectMake((btnW) * (i % titles.count), 10, btnW, btnH);

        button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [button1 setTitle:titles[i] forState:UIControlStateNormal];
        button1.backgroundColor = [UIColor hh_redomColor];
//        [button1 setImage:[UIImage imageNamed:@"home_func_11"] forState:UIControlStateNormal];
          [button1 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_func_1%i",i+1]] forState:UIControlStateNormal];
        button1.buttonImagePosition = FSCustomButtonImagePositionTop;
        [button1 addTarget:self action:@selector(clickFunctionBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        button1.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
//
//        btn.tag = i + 1;
//        btn.titleLabel.font = kFont(10);
//        [btn setTitle:titles[i] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_func_1%i",i+1]] forState:UIControlStateNormal];
//
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        button.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
//
//        button.buttonImagePosition = FSCustomButtonImagePositionTop;
//
//        [btn addTarget:self action:@selector(clickFunctionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:button1];
    }
 
    
}

- (void)clickFunctionBtn:(UIButton *)btn{
    
    
    NSLog(@"------------%@",btn.titleLabel.text);
}

@end
