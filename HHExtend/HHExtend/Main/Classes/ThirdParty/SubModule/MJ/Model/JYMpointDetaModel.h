//
//  JYMpointDetaModel.h
//  JYFarm
//
//  Created by 花花 on 2017/11/15.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "BaseModel.h"

@interface JYMpointDetaModel : BaseModel
/**
 "data": [
 {
 "id": 1,
 "businessNo": "111",
 "accountNo": "11205256373473",
 "createTime": 1510716913000,
 "payType": null,
 "accountAmount": 0,
 "balanceAmount": 100,
 "balanceStatus": 0,
 "balanceType": 0,
 "outOrderNo": "1111",
 "payRemark": "23232"
 }
 ]
 
 data =     (
 {
 accountAmount = 0;
 accountNo = 11205256373473;
 balanceAmount = 100;
 balanceStatus = 0;
 balanceType = 0;
 businessNo = 111;
 createTime = 1510716913000;
 id = 1;
 outOrderNo = 1111;
 payRemark = 23232;
 payType = "<null>";
 }
 );
 */

@property(nonatomic,copy)NSString *accountNo; //账户号

@property(nonatomic,copy)NSString *createTime; //创建时间

@property(nonatomic,copy)NSString *payType; //支付方式

@property(nonatomic,copy)NSString *accountAmount; //账户余额

@property(nonatomic,copy)NSString *balanceAmount; //收支金额

@property(nonatomic,assign)NSInteger balanceStatus; //收支状态(0：收入，1：支出，2：提现)

@property(nonatomic,copy)NSString *balanceTotal; //收支金额（元）

@property(nonatomic,copy)NSString *outOrderNo; //商户订单号

@property(nonatomic,copy)NSString *payRemark; //描述

@property(nonatomic,copy)NSString *orderNo;

@property(nonatomic,copy)NSString * productCount;  // <#注释#>


@end
