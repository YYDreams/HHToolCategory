//
//  FunMenuView.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/11.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "FunMenuView.h"
@interface FunMenuView()<UICollectionViewDelegate,UICollectionViewDataSource>
@end

@implementation FunMenuView
- (instancetype)initWithFrame:(CGRect)frame{
    
    
    if (self = [super initWithFrame:frame]) {
        
        
        [self setupSubView];
    }
    return self;
    
}

-(void)setDataArr:(NSMutableArray *)dataArr{
    
    _dataArr = dataArr;

    [self.collectionView reloadData];
    
}
- (void)setupSubView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width,180) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[FunMenuCell class]  forCellWithReuseIdentifier:@"FunMenuCell"];

    
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_collectionView];
    
    
    
    
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake(Screen_Width/4, 78);
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

//设置每个item的水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FunMenuCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"FunMenuCell" forIndexPath:indexPath];
    cell.backgroundColor =[UIColor whiteColor];
    cell.model = [self.dataArr safeObjectAtIndex:indexPath.row];
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    for (JYCategorysModel *model in self.dataArr) {
//
//        model.selectedFlag = NO;
//    }
//    if (self.dataArr.count <= 0) return;
//    JYCategorysModel *catgoryModel = self.dataArr[indexPath.row];
//    catgoryModel.selectedFlag = YES;
//
//
//
//    JYCategorysModel *model = [self.dataArr safeObjectAtIndex:indexPath.row];
//
//    if (_FunDidSelectItemAtIndexPath) {
//        _FunDidSelectItemAtIndexPath(model.childrenListArr);
//    }
    
//    [collectionView reloadData];
    
    NSLog(@"%zd",indexPath.row);
    
}


@end




@implementation FunMenuCell


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        //        self.backgroundColor = [UIColor orangeColor];
        [self setupSubView];
        
    }
    return self;
    
}


//单元格是选中状态
- (void)selectedCell{
    
    self.tileLabel.textColor = kThemeColor;
}

//单元格不是选中状态
- (void)unselectedCell{
    
    
    self.tileLabel.textColor = k3Color;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    WeakSelf;
//    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.mas_centerX);
//        make.centerY.equalTo(self.mas_centerY).offset(-10);
//    }];
//    // 布局标题
//    [self.tileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.imgView.mas_bottom).offset(5);
//        make.centerX.equalTo(self.mas_centerX);
//    }];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.width.height.mas_equalTo(40);


    }];


    [_tileLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(weakSelf.imgView.mas_bottom).offset(5);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-5);


    }];

    
}

- (void)setupSubView{
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.tileLabel];
    
}

- (UIImageView *)imgView{
    
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
    }
    return _imgView;
}

- (UILabel *)tileLabel{
    
    
    if (!_tileLabel) {
        _tileLabel = [UILabel labelText:@"" fontSize:13 textColor:k6Color textAlignment:NSTextAlignmentCenter];
        
    }
    return _tileLabel;
}
- (void)setModel:(FunMenuModel *)model{
    
    
    _model = model;
    
    self.tileLabel.text = model.name;
//    _imgView.image = [UIImage imageNamed:model.imgage];
      [_imgView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:defaultFarmImage];

    
   
    
}
@end

//
//@implementation FunMenuView
//
//@end

