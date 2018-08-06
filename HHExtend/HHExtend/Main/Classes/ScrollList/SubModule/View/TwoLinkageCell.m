//
//  TwoLinkageCell.m
//  HHExtend
//
//  Created by flowerflower on 2018/3/28.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "TwoLinkageCell.h"

@interface TwoLinkageCell()

@property(nonatomic,strong) UILabel *titleLabel;  // <#注释#>
@property(nonatomic,strong) UILabel *subLabel;  // <#注释#>


@end
@implementation TwoLinkageCell

#pragma mark - init Method
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubView];
    }
    
    return self;
    
    
    
}
- (void)setDic:(NSDictionary *)dic{
    
    self.titleLabel.text = dic[@"title"];
    self.subLabel.text = dic[@"desc"];
    
}

- (void)setModel:(TwoLinkageModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    self.subLabel.text = model.desc;
}
#pragma mark - setupSubView
- (void)setupSubView{
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.subLabel];
    
}
#pragma mark - layoutSubviews
- (void)layoutSubviews{
    
    [super layoutSubviews];
    WeakSelf;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(margin);
        make.right.mas_equalTo(-margin);
        make.bottom.mas_equalTo(weakSelf.subLabel.mas_top);
    }];
    
    
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(margin);
        make.right.mas_equalTo(-margin);
        make.bottom.mas_equalTo(weakSelf);
        make.width.mas_equalTo(Screen_Width - 2 *margin);
    }];
    
    
}
#pragma mark - Setter && Getter Methods

- (UILabel *)titleLabel{
    
    
    if (!_titleLabel) {
        _titleLabel = [UILabel labelText:@"" fontSize:13 textColor:k3Color textAlignment:0];
    }
    return _titleLabel;
}
- (UILabel *)subLabel{
    
    
    if (!_subLabel) {
        _subLabel = [UILabel labelText:@"" fontSize:13 textColor:k9Color textAlignment:0];
        _subLabel.numberOfLines = 0;
        
    }
    return _subLabel;
}
@end
