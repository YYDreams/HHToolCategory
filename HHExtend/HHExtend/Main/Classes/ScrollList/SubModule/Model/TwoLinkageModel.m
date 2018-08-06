//
//  TwoLinkageModel.m
//  HHExtend
//
//  Created by flowerflower on 2018/3/28.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "TwoLinkageModel.h"

@implementation TwoLinkageModel

- (CGFloat)cellHight{
    if (!_cellHight) {
        
        
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = kFont(14);
        CGSize size = [self.desc boundingRectWithSize:CGSizeMake(Screen_Width - 2*margin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
        
//        CGFloat  y = 5 + 14  ;
//        CGRect rect = CGRectMake(10, y , Screen_Width - 20, size.height);
//        
//        self.cellHight = CGRectGetMaxY(rect) + 5;

        
        _cellHight = 5 + 14 + size.height + 5;
        
    }
    return _cellHight;
    
}
@end
