//
//  QrCodeCell.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/10.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "QrCodeCell.h"
@interface QrCodeCell()



@end
@implementation QrCodeCell

#pragma mark - init Method
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubView];
    }
    
    return self;

}
//+ (instancetype)cellWithTableView:(UITableView *)tableView{
//    static NSString *ID = @"QrCodeCell";
//    QrCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    NSLog(@"-----------------------");
//
//    if (cell == nil) {
//        cell = [[QrCodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//        NSLog(@"++++++++++++++++++++++++");
//    }
//    return cell;
//}

#pragma mark - setupSubView
- (void)setupSubView{
    
    [self addSubview:self.imgView];
    [self addSubview:self.titleLabel];
    
}
#pragma mark - layoutSubviews
- (void)layoutSubviews{
    
    [super layoutSubviews];
    WeakSelf;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(margin);
        make.center.mas_equalTo(weakSelf);
    }];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.center.mas_equalTo(weakSelf);
    }];
    
    
}
#pragma mark - Setter && Getter Methods
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelText:@"" fontSize:15 textColor:k3Color textAlignment:0];
    }
    return _titleLabel;
}
- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
    }
    return _imgView;
}

@end
