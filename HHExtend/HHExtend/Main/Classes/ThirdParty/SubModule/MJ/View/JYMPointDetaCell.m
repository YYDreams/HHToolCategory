//
//  JYMPointDetaCell.m
//  JYFarm
//
//  Created by 花花 on 2017/10/11.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "JYMPointDetaCell.h"

@interface JYMPointDetaCell ()

@end
@implementation JYMPointDetaCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubView];
    }
    return self;

}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"JYMPointDetaCell";
    JYMPointDetaCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[JYMPointDetaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (void)setOrderModel:(JYMpointDetaModel *)orderModel{
    _orderModel = orderModel;
    self.titleLabel.text = orderModel.orderNo;
    self.timeLabel.text = orderModel.createTime;
    self.moneyCountLabel.text = orderModel.productCount;
}
- (void)setModel:(JYMpointDetaModel *)model{
    
    _model = model;
   
    self.titleLabel.text = model.payRemark;
    //收支状态(0：收入，1：支出，2：提现）
    if (model.balanceStatus == 0) {
        
        self.moneyCountLabel.textColor = kThemeColor;
    self.moneyCountLabel.text = [NSString stringWithFormat:@"+%@",model.balanceTotal];
        
    }else{
        self.moneyCountLabel.textColor = k6Color;
    self.moneyCountLabel.text = [NSString stringWithFormat:@"-%@",model.balanceTotal];
        
    }
    
    self.timeLabel.text = [NSString  timeShowWithFormatStyle:@"yyyy-MM-dd HH:mm:ss" timeInterval:[model.createTime doubleValue]];
    
    
}
- (void)setFrame:(CGRect)frame{
    
    CGRect tempRect = frame;

    tempRect.origin.y += 10;
    tempRect.size.height -= 10;
    [super setFrame:tempRect];
    
    
}

- (void)setupSubView{
   
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.moneyCountLabel];


}
- (void)layoutSubviews{

    [super layoutSubviews];
    CGFloat margin = 10;
    WeakSelf;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(margin);
        make.top.mas_equalTo(10);
        
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(margin);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(5);
        
    }];
    [self.moneyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
         make.right.mas_equalTo(-margin);
    }];

}
- (UILabel *)titleLabel{

    if (!_titleLabel) {
        _titleLabel = [UILabel labelText:@"" fontSize:13 textColor:k3Color textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;

}
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel labelText:@"" fontSize:10 textColor:k9Color textAlignment:NSTextAlignmentCenter];
    }
    return _timeLabel;

}
- (UILabel *)moneyCountLabel{

    if (!_moneyCountLabel) {
        _moneyCountLabel = [UILabel labelText:@"" fontSize:20 textColor:kThemeColor textAlignment:NSTextAlignmentCenter];
    }
    return _moneyCountLabel;

}
@end
