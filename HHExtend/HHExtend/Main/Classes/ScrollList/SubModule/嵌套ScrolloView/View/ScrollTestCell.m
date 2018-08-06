//
//  ScrollTestCell.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/2.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "ScrollTestCell.h"
#import "ContentController.h"
@implementation ScrollTestCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setViewControllers:(NSMutableArray *)viewControllers{
    
    _viewControllers = viewControllers;
}

- (void)setCellCanScroll:(BOOL)cellCanScroll{
    
    _cellCanScroll = cellCanScroll;
    
    for (ContentController *vc in _viewControllers) {
        
        vc.vcCanScroll = cellCanScroll;
        if (! cellCanScroll) { //如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
            vc.tableView.contentOffset = CGPointZero;
            
        }
    }
}
- (void)setIsRefresh:(BOOL)isRefresh{
    
    _isRefresh = isRefresh;
    
    for (ContentController *ctrl in self.viewControllers) {
        if ([ctrl.title isEqualToString:self.currentStr]) {
            ctrl.isRefresh = isRefresh;
        }
    }
}


@end


@implementation BannerCell

#pragma mark - init Method
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubView];
    }
    
    return self;
    
    
    
}
- (void)setBannerArr:(NSArray *)bannerArr{
    _bannerArr = bannerArr;
    
    self.headerView.imageURLStringsGroup = bannerArr;
}
#pragma mark - setupSubView
- (void)setupSubView{
    
    
    [self addSubview:self.headerView];
    
    
    
}
#pragma mark - layoutSubviews
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
    
    
}
#pragma mark - Setter && Getter Methods
- (SDCycleScrollView *)headerView{
    if (!_headerView) {
        _headerView = [[SDCycleScrollView alloc]init];
    }
    return _headerView;
    
}


@end

@implementation AdvertisementCell


@end

@interface AdvertisementView()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic,strong) NSMutableArray *titles;
@property(assign, nonatomic)int titleIndex;
@property(assign, nonatomic)int index;

@end


@implementation  AdvertisementView


- (instancetype)initWithFrame:(CGRect)frame  titles:(NSArray *)titles{
    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = [UIColor whiteColor];
        //小喇叭
        //        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(15, (self.height-15)/2, 15, 15)];
        //        image.userInteractionEnabled = NO;
        //        image.image = [UIImage imageNamed:@"home_speaker"];
        //        [self addSubview:image];
        
        UILabel *tagLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, (50-20)/2, 40, 20)];
        tagLabel.text = @"资讯";
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.textColor = [UIColor colorWithHexString:@"ff6c00"];
        tagLabel.font = [UIFont systemFontOfSize:12];
        tagLabel.layer.borderColor =  [UIColor colorWithRed:0.94f green:0.46f blue:0.27f alpha:1.00f].CGColor;
        tagLabel.layer.borderWidth = .5f;
        [self addSubview:tagLabel];
        
        
        NSMutableArray *MutableTitles = [NSMutableArray arrayWithArray:titles];
        NSString *str = @"";
        self.titles = MutableTitles;
        [self.titles addObject:str]; //加一个空的,防止数组为空奔溃
        self.index = 1;
        UIButton *btn = [[UIButton alloc]init];
        
        btn.frame = CGRectMake(CGRectGetMaxX(tagLabel.frame)+10, 0, Screen_Width - 2 *30, self.bounds.size.height);
        btn.tag = self.index;
        //靠左 不居中显示
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        btn.titleLabel.font = kFont(13);
        [btn setTitleColor:[UIColor colorWithHexString:@"161616"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:self.titles[0] forState:UIControlStateNormal];
        
        [self addSubview:btn];
        self.clipsToBounds = YES;
        [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextAd) userInfo:nil repeats:YES];
        
    }
    
    return self;
}




-(void)nextAd{
    UIButton *firstBtn = [self viewWithTag:self.index];
    UIButton *modelBtn = [[UIButton alloc]initWithFrame: CGRectMake(55, self.bounds.size.height, Screen_Width -2 *30, self.bounds.size.height)];
    modelBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    modelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    modelBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail; //文字多出部分 在右侧显示点点
    modelBtn.titleLabel.font = kFont(13);
    [modelBtn setTitleColor:[UIColor colorWithHexString:@"161616"] forState:UIControlStateNormal];
    [modelBtn setBackgroundColor:[UIColor clearColor]];
    modelBtn.tag = self.index + 1;
    if ([self.titles[self.titleIndex+1] isEqualToString:@""]) {
        self.titleIndex = -1;
        self.index = 0;
    }
    if (modelBtn.tag == self.titles.count) {
        
        modelBtn.tag = 1;
    }
    
    [modelBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [modelBtn setTitle:self.titles[self.titleIndex+1] forState:UIControlStateNormal];
    [self addSubview:modelBtn];
    
    [UIView animateWithDuration:0.25 animations:^{
        firstBtn.y = -self.bounds.size.height;
        modelBtn.y = 0;
        
    } completion:^(BOOL finished) {
        [firstBtn removeFromSuperview];
        
    } ];
    self.index++;
    self.titleIndex++;
    
    
    
}
//回调
-(void)clickBtn:(UIButton *)btn{

    
    NSLog(@"======%@",btn.titleLabel.text);
    
    if (_handerAdvBtnCallBack) {
        _handerAdvBtnCallBack(btn);
    }
    
}

@end





