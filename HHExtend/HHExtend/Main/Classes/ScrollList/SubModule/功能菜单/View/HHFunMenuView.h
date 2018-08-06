//
//  HHFunMenuView.h
//  HHExtend
//
//  Created by flowerflower on 2018/4/11.
//  Copyright © 2018年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HHFunMenuView : UIView
/**图片数组*/
@property (nonatomic,strong) NSMutableArray *imagesArray;
/**文字数组*/
@property (nonatomic,strong) NSMutableArray *titlesArray;
/**每页个数(必须实现)*/
@property (nonatomic,assign) NSInteger pageNum;
/**总数(必须实现)*/
@property (nonatomic,assign) float  totallNumber;
/**每行显示个数(必须实现)*/
@property (nonatomic,assign) NSInteger rowNum;
/**圆点颜色*/
@property (nonatomic,strong) UIColor *pageTintColor;
/**当前颜色*/
@property (nonatomic,strong) UIColor *currentPageTintColor;
/**选中序列*/
@property (nonatomic,copy) void(^gfScrollMenViewClickIndex)(NSInteger index);
@end

@interface GFScrollMenCell:UIView
/**icon*/
@property (nonatomic,strong) UIImageView *iconImageView;
/**标题*/
@property (nonatomic,strong) UILabel *titleLabel;
/**按钮*/
@property (nonatomic,strong) UIButton *clickButton;


@end
