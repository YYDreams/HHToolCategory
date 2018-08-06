//
//  TitleScrollView.m
//  HHExtend
//
//  Created by flowerflower on 2018/3/28.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "TitleScrollView.h"

@implementation TitleScrollView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray{
    
    if (self == [super initWithFrame:frame]) {
        
        [self setuptitleArray:titleArray];
    }
    return self;
    
}

- (void)setuptitleArray:(NSArray *)titleArray{

    
    for (NSDictionary *dic in titleArray) {
    
        NSInteger index = [titleArray indexOfObject:dic];
        UIButton *btn =  [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake(80 * index , 0, 80, 80);
        btn.tag = 100+index;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.contentMode = UIViewContentModeCenter;
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -60, -60, 0)];
        
        
        [btn setTitle:dic[@"title"] forState:UIControlStateNormal];
        [btn setTitle:dic[@"title"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:dic[@"uImage"]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:dic[@"sImage"]] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (index == 0) {
            
            btn.selected = btn;
            self.selectedBtn = btn;
        }
        
        [self addSubview:btn];
        
        self.backgroundColor = [UIColor hh_redomColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.contentSize = CGSizeMake(80 * titleArray.count, self.height);
        
    }
    
    
}
- (void)btnOnClick:(UIButton *)button{
    
    
    if (self.selectedBtn == button) {
        
        return;
    }else{
        self.selectedBtn.selected = NO;
        button.selected = YES;
        self.selectedBtn = button;
    }
    
    if (_handlerBtnCallBack) {
        _handlerBtnCallBack(self.selectedBtn.tag - 100);
    }
    
    
}

-(void)setIndexSelected:(NSInteger )selectedIndex{
    UIButton * btn = (UIButton *)[self viewWithTag:selectedIndex+100];
    if (self.selectedBtn==btn) {
        return;
    }else{
        self.selectedBtn.selected= NO;
        btn.selected = YES;
        self.selectedBtn = btn;
    }
}

@end
