//
//  QrCodeViewController.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/9.
//  Copyright © 2018年 花花. All rights reserved.
//二维码的实质是 把字符串转为图片

#import "QrCodeViewController.h"
#import "QrCodeCell.h"
#import <HMScannerController.h>
@interface QrCodeViewController ()

@property(nonatomic,strong) UIImageView *imgView;  // <#注释#>

@property(nonatomic,strong) NSMutableArray *titleArr;  // <#注释#>

@property(nonatomic,strong) UILabel *contentLabel;  // <#注释#>

@end

@implementation QrCodeViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupInit];
}

#pragma mark - setupNav
- (void)setupNav{


    self.navigationItem.rightBarButtonItem =  [UIBarButtonItem itemWithtitle:@"扫一扫" target:self action:@selector(rightOnClick)];

}
- (void)setupInit{
    self.tableView.height = Screen_Height - kNavHeight;
    self.tableView.rowHeight = 150;
    self.tableView.tableFooterView = self.contentLabel;

}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QrCodeCell *cell = [QrCodeCell cellWithTableView:tableView];
    
    cell.titleLabel.text = [self.titleArr safeObjectAtIndex:indexPath.row];
    cell.imgView.image = indexPath.row?[UIImage  hh_ImageLogoFromQrInfo:@"我是flowerflower" qrCodeSize:400 logoName:@"m2015031214234046" radius:2 borderWidth:1.5 borderColor:[UIColor whiteColor]]:[UIImage hh_ImageFromQrInfo:@"我是flowerflower" qrCodeSize:400];
    
    return cell;
}
#pragma mark - SEL Method
- (void)rightOnClick{
    
    WeakSelf;
    HMScannerController *scanner = [HMScannerController scannerWithCardName:@"我是flowerflower" avatar:nil completion:^(NSString *stringValue) {
        
        NSLog(@"%@",stringValue);
        weakSelf.contentLabel.text = stringValue;
        
    }];
    
    [scanner setTitleColor:[UIColor whiteColor] tintColor:[UIColor greenColor]];
    
    [self showDetailViewController:scanner sender:nil];
    
}

#pragma mark - Setter && Getter Methods
- (NSMutableArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [NSMutableArray arrayWithObjects:@"普通二维码",@"带logo二维码", nil];
    }
    return _titleArr;
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel labelText:@"" fontSize:15 textColor:k3Color textAlignment:1];
        _contentLabel.numberOfLines = 0;
        _contentLabel.frame = CGRectMake(10, 10, Screen_Width - 2* 10, 20);
    }
    return _contentLabel;
}

@end



