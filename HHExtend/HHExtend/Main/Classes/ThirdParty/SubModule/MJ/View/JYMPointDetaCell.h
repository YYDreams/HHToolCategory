//
//  JYMPointDetaCell.h
//  JYFarm
//
//  Created by 花花 on 2017/10/11.
//  Copyright © 2017年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYMpointDetaModel.h"
@interface JYMPointDetaCell : UITableViewCell
//支付宝充值
@property(nonatomic)UILabel *titleLabel;
//2017-10-06 17:59
@property(nonatomic)UILabel *timeLabel;
//＋500
@property(nonatomic)UILabel *moneyCountLabel;

@property(nonatomic)JYMpointDetaModel *model;

@property(nonatomic)JYMpointDetaModel *orderModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
