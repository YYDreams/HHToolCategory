//
//  PickerViewController.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/9.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "PickerViewController.h"
#import "HHPickerView.h"
@interface PickerViewController ()

@property (nonatomic, strong) HHPickerView *pickerView;

@property(nonatomic,strong) UILabel *addressLabel;  // <#注释#>

@property(nonatomic)UIView *bgView;

@end

@implementation PickerViewController


#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubView];
    

}

#pragma mark - setupSubView
- (void)setupSubView{
   
        [self.view addSubview:self.addressLabel];

}

#pragma mark - SEL Method
- (void)selectAddress{
    
//    [self.view endEditing:YES];

    [self.pickerView show];

}
#pragma mark - Setter && Getter Methods
- (HHPickerView *)pickerView {
    if (!_pickerView) {
        WeakSelf;
        _pickerView = [HHPickerView selectArea:^(NSString *province, NSString *city, NSString *area) {
            weakSelf.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ ", province, city, area];

            NSLog(@"%@ %@ %@ ", province, city, area);
            
        }];
    }
    return _pickerView;
}
- (UILabel *)addressLabel{
    if (!_addressLabel) {
        
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100 ,Screen_Width- 2*20,40)];
        _addressLabel.backgroundColor = [UIColor redColor];
        _addressLabel.text = @"请选择地址";
        _addressLabel.font = kFont(16);
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.userInteractionEnabled = YES;
        _addressLabel.adjustsFontSizeToFitWidth = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAddress)];
        tap.numberOfTapsRequired = 1;
        [_addressLabel addGestureRecognizer:tap];
    }
    return _addressLabel;
}

@end
