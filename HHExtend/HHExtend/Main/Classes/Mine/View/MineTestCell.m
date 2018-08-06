//
//  MineTestCell.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/11.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "MineTestCell.h"

@implementation MineTestCell

#pragma mark - init Method
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubView];
    }
    
    return self;
    
    
    
    
    

}
//    cell重用 cell绑定模型
//UI绑定model 根据数据改变UI
- (void)setCount:(int)count{
    _count = count;
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.count];
    
    self.model.count = self.countLabel.text;
}
- (void)setModel:(MineTestModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    self.count  = [model.count intValue];
    
}
#pragma mark - setupSubView
- (void)setupSubView{
    
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.countLabel];
    [self addSubview:self.addBtn];
    [self addSubview:self.minBtn];
    
    
}
#pragma mark - layoutSubviews
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(margin);
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-margin);
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(30);
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.addBtn.mas_left);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(30);
    }];
    [self.minBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.countLabel.mas_left);
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(30);
    }];
    
}

#pragma mark - Setter && Getter Methods
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [UILabel labelText:@"" fontSize:13 textColor:k3Color textAlignment:0];
    }
    return _titleLabel;
    
}
- (UILabel *)countLabel{
    
    if (!_countLabel) {
        _countLabel = [UILabel labelText:@"" fontSize:13 textColor:k3Color textAlignment:1];
    }
    return _countLabel;
    
}
- (UIButton *)addBtn{
    
    if (!_addBtn) {
        _addBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.layer.borderWidth =1.0;
        _addBtn.layer.borderColor = [UIColor colorWithHexString:@"62C6B2"].CGColor;
        _addBtn.layer.cornerRadius = 30 * 0.5;
        [_addBtn setTitle:@"+" forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addOnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
    
}
- (UIButton *)minBtn{
    
    if (!_minBtn) {
        _minBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _minBtn.layer.borderWidth =1.0;
        _minBtn.layer.borderColor = [UIColor colorWithHexString:@"62C6B2"].CGColor;
        _minBtn.layer.cornerRadius = 30 * 0.5;
        [_minBtn setTitle:@"-" forState:UIControlStateNormal];
        [_minBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [_minBtn addTarget:self action:@selector(minOnClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _minBtn;
    
}
- (void)addOnClick{
    
    if ([self.countLabel.text intValue]>=100) return;
    
    self.count ++;
    
}
- (void)minOnClick{
    
    
    if ([self.countLabel.text intValue]<=0) return;
        
    
    self.count --;
    
}
@end
