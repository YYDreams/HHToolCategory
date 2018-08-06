//
//  HHScrollMenuView.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/12.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "HHScrollMenuView.h"
#import "HHFloweLayout.h"
#define kScale(P)                ((P) * ([UIScreen mainScreen].bounds.size.width / 375.f))

@interface HHScrollMenuView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;  // <#注释#>

@property(nonatomic,strong) UIPageControl *pageControl;  // <#注释#>

@property(nonatomic,strong) HHFloweLayout *layout;  // <#注释#>

@property(nonatomic,assign) CGFloat  pageControlHeight;  // 分页控制器的高度

@property(nonatomic,assign) CGSize  itemSize;  // 单元格尺寸

@property(nonatomic,assign) NSInteger  totalPages;  // 分页控制的总页数

@property (nonatomic, strong) UIView *header;

/**
 *  页眉高度
 */
@property (nonatomic, assign) CGFloat headerHeight;

/**
 *  记录每个分区的位移量
 */
@property (nonatomic, strong) NSMutableArray<NSNumber *> *offsetArray;




@end
@implementation HHScrollMenuView
- (NSMutableArray<NSNumber *> *)offsetArray{
    if (_offsetArray == nil) {
        _offsetArray = [NSMutableArray array];
    }
    return _offsetArray;
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
    
        [self setupSubView];
    }
    return self;
    
}

- (void)setupSubView{
    
    
    self.layout = ({
       
        HHFloweLayout *layout = [[HHFloweLayout alloc]init];
        layout.itemSize = self.itemSize;
        layout;
    });
    
    
    self.collectionView = ({
       
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.pagingEnabled = YES;
        
        [collectionView registerClass:[HHMenuItemCell class] forCellWithReuseIdentifier:NSStringFromClass([HHMenuItemCell class])];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView;
    });
    
    self.pageControl = ({
        UIPageControl * pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        pageControl.currentPageIndicatorTintColor = [UIColor darkTextColor];
        pageControl.pageIndicatorTintColor =  [UIColor groupTableViewBackgroundColor];
        pageControl.numberOfPages = self.totalPages;
        pageControl.currentPage = 0;
        [pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
        pageControl;
    });
    
    self.header = ({
        UIView *header = [[UIView alloc] init];
        header.backgroundColor = [UIColor yellowColor];
        header.clipsToBounds = YES;
        header;
    });
    
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    [self addSubview:self.header];
    
    [self layoutHeaderInSection:0];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self updateHeaderConstraints];
    [self.pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.left.bottom.right.mas_equalTo(self);
        make.height.mas_equalTo(self.pageControlHeight);
    }];
    
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.pageControl.mas_top);
        make.top.mas_equalTo(self.header.mas_bottom);
    }];
    
}
- (void)updateHeaderConstraints{
 
    
    [self.header mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(0);
    }];
    
}
- (void)pageTurn:(UIPageControl*)sender{
    
    CGSize viewSize = self.collectionView.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [self.collectionView scrollRectToVisible:rect animated:YES];
    
    [self changeHeaderInMenuContentOffset:rect.origin.x];
    
}

- (void)layoutHeaderInSection:(NSUInteger)section{
    
    
}
- (NSInteger)numberOfItemsInSection:(NSInteger)section{
    
   
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(scrollMenu:numberOfItemsInSection:)]) {
        
        return [self.dataSource scrollMenu:self numberOfItemsInSection:section];
    }
    return 0;
}
- (NSInteger)numberOfSections{
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsInScrollMenu:)]) {
        
        return [self.dataSource numberOfSectionsInScrollMenu:self];
        
    }
    return 0;
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self numberOfItemsInSection:section];
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return [self numberOfSections];
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HHMenuItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HHMenuItemCell class]) forIndexPath:indexPath];
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(scrollMenu:cellForItemAtIndexPath:)]) {
        
     HHMenuModel *model =  [self.dataSource scrollMenu:self cellForItemAtIndexPath:indexPath];
       
        cell.model = model;
    }
    
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_handlerSelectItemAtIndexPath) {
        _handlerSelectItemAtIndexPath(self,indexPath);
    }
}
#pragma mark - Setter && Getter Methods
- (void)setCurrentIndicatorColor:(UIColor *)currentIndicatorColor{
    _currentIndicatorColor = currentIndicatorColor;
    if (self.pageControl) {
        self.pageControl.currentPageIndicatorTintColor = currentIndicatorColor;
    }
}
- (void)setIndicatorTintColor:(UIColor *)indicatorTintColor{
    
    _indicatorTintColor = indicatorTintColor;
    if (self.pageControl) {
        self.pageControl.pageIndicatorTintColor = indicatorTintColor;
    }
}
- (CGSize)itemSize{
    
    
    if (_handlerItemSize) {
     return  _handlerItemSize();
    }
    return CGSizeMake(kScale(40), kScale(70));
    
}

/** 获取分页器总页数 */
- (NSInteger)totalPages{
    
    //视图尺寸
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height - self.pageControlHeight - self.headerHeight;
    //行列最大的单元格数量
    NSInteger xCount = width/self.itemSize.width;
    NSInteger yCount = height/self.itemSize.height;
    
    //单页的数量
    NSInteger allCount = xCount * yCount;
    
    //清除上次位移数据
    [self.offsetArray removeAllObjects];
    
    //总页数
    NSUInteger page = 0;
    for (NSUInteger idx = 0; idx < [self numberOfSections]; idx ++) {
        NSUInteger count = [self numberOfItemsInSection:idx];
        NSUInteger pageRe = (count%allCount == 0) ?  (count/allCount) :  (count/allCount)+1;
        page += pageRe;
        
        //记录section的最大位移量
        [self.offsetArray addObject:@(page * width)];
    }
    
    return page;
}
#pragma mark - ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [self.pageControl setCurrentPage:offset.x / bounds.size.width];
    
    
    [self changeHeaderInMenuContentOffset:offset.x];
    
}
#pragma mark - Section
- (void)changeHeaderInMenuContentOffset:(CGFloat)offset{
    
    for (int idx = 0; idx < self.offsetArray.count; idx ++) {
        
        CGFloat currentOffset = offset + self.collectionView.frame.size.width;
        CGFloat theOffset = [self.offsetArray[idx] floatValue];
        
        
        if (currentOffset <= theOffset) {
            
            [self layoutHeaderInSection:idx];
            
            return;
        }
        
    }
}

- (void)reloadData{
    
    self.layout.itemSize = self.itemSize;
    
    self.pageControl.hidden = (self.totalPages == 1);
    
    self.pageControl.numberOfPages = self.totalPages;
    
    [self.collectionView reloadData];

    
    [self changeHeaderInMenuContentOffset:self.pageControl.currentPage * self.collectionView.frame.size.width];
}

/** 页眉高度 */
- (CGFloat)headerHeight{
    
  
    return kScale(0);
}
@end



@interface HHMenuItemCell()

@property(nonatomic,strong) UIImageView *imgView;  // <#注释#>

@property(nonatomic,strong) UILabel *titleLabel;  // <#注释#>


@end


@implementation HHMenuItemCell



- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupInit];
        [self setupSubView];
    }
    return self;
}
- (void)setModel:(HHMenuModel *)model{
    
    _model = model;
    
    self.titleLabel.text = model.itemTitle;
//     [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.itemImage] placeholderImage:defaultPlaceholderImage];
 
    
}
- (void)setupInit{
    
    self.iconSize = CGSizeMake(kScale(40), kScale(40));
    self.iconCornerRadius = kScale(20);
    self.space = kScale(10);
    self.textColor = [UIColor darkTextColor];
    self.textFont = [UIFont systemFontOfSize:kScale(14)];
    
}
- (void)setupSubView{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.imgView = ({
       
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = self.iconCornerRadius;
        imageView;
    });
    
    self.titleLabel = ({
       
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = self.textColor;
        titleLabel.font = self.textFont;
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = 1;
        titleLabel;
    });
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //图片的约束
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.size.mas_equalTo(self.iconSize);
        make.centerY.mas_equalTo(self.contentView).offset(- 2*self.space);
    }];
    
    //文本的约束
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.top.equalTo(self.imgView.mas_bottom).offset(self.space);
    }];
    
}
- (void)setIconSize:(CGSize)iconSize{
    if (iconSize.width >0 && iconSize.height>0) {
        _iconSize = iconSize;
        [self layoutIfNeeded];
    }
}
- (void)setSpace:(CGFloat)space{
    if (space >0) {
        _space = space;
        [self layoutIfNeeded];
    }
    
}
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.titleLabel.textColor = textColor;
    
}
- (void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
    self.titleLabel.font = textFont;
    
}


-(void)setIconCornerRadius:(CGFloat)iconCornerRadius{
    
    
    if (iconCornerRadius>0) {
        _iconCornerRadius = iconCornerRadius;
        self.imgView.layer.cornerRadius = iconCornerRadius;
    }
    
}
@end


@interface HHScrollMenuIndicatorView()


@end

@implementation HHScrollMenuIndicatorView

@end

@implementation HHMenuModel

@end

