//
//  HHPickerView.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/9.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "HHPickerView.h"
static CGFloat const PickerViewHeight = 240; //picker总高度
static CGFloat const PickerViewRowHeight = 32; //picker之间的行高

@interface  HHPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong) HHPickerToolBar *toolbar;  // <#注释#>

@property(nonatomic,strong) UIPickerView *pickerView;  // <#注释#>

@property(nonatomic,strong) UIView *lineView;  // <#注释#>

@property(nonatomic,strong) NSArray *rootArray;  // <#注释#>

@property(nonatomic,strong) NSMutableArray *provinceArr;  // 当前省数组

@property(nonatomic,strong) NSMutableArray *cityArr;  // 当前市数组

@property(nonatomic,strong) NSMutableArray *areaArr;  // 当前地区数组

@property(nonatomic,copy) NSString *province;  // 省份

@property(nonatomic,copy) NSString *city;  // 城市

@property(nonatomic,copy) NSString *area;  // 地区

@end

@implementation HHPickerView

- (instancetype)init{
    if (self = [super init]) {
        
        [self setupInit];
        [self setupSubView];
        [self loadData];
        
    }
    return self;
    
}
- (void)setupInit{
    
    self.bounds = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithHexString:@"333333" alpha:0.5];
    [self.layer setOpaque:0.0];
}

- (void)setupSubView{
    
    [self addSubview:self.pickerView];
    [self.pickerView addSubview:self.lineView];
    [self addSubview:self.toolbar];
    [self addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)loadData{
    //1. 获取省份
    [self.rootArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.provinceArr addObject:obj];//获取省名 obj[@"state"]
    }];
    
    //2. 随便获取一个省的城市
    NSMutableArray *citys = [NSMutableArray arrayWithArray:[self.provinceArr firstObject][@"cities"]];
    [citys enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.cityArr addObject:obj];//获取市名 obj[@"city"]
    }];
    
    //3. 随便获取一个城市的（县，区，等）
    NSMutableArray *countyAry = [NSMutableArray arrayWithArray:[self.cityArr firstObject][@"areas"]];
    [countyAry enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.areaArr addObject:obj];//获取区名字  obj[@"county"]
    }];

    [self reloadSelectAddress];
}
+ (instancetype)selectArea:(handlerSelectAreaCallBack)selectArea{
    
    HHPickerView *pickerView = [[HHPickerView alloc]init];
    pickerView.selectAreaCallBack = selectArea;
    return pickerView;
}
- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    CGRect frameTool = self.toolbar.frame;
    frameTool.origin.y -= PickerViewHeight;
    
    CGRect framePicker =  self.pickerView.frame;
    framePicker.origin.y -= PickerViewHeight;
    [UIView animateWithDuration:0.3 animations:^{
        [self.layer setOpacity:1];
        self.toolbar.frame = frameTool;
        self.pickerView.frame = framePicker;
    }];
    
}
- (void)dismiss{

    CGRect frameTool = self.toolbar.frame;
    frameTool.origin.y += PickerViewHeight;
    
    CGRect framePicker = self.pickerView.frame;
    framePicker.origin.y += PickerViewHeight;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.layer setOpacity:0];
        self.toolbar.frame = frameTool;
        self.pickerView.frame = framePicker;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
}
- (void)reloadSelectAddress{

    NSInteger row0 = [self.pickerView selectedRowInComponent:0];
    NSInteger row1 = [self.pickerView selectedRowInComponent:1];
    NSInteger row2 = [self.pickerView selectedRowInComponent:2];
    
    self.province = @""; self.city = @""; self.area = @"";

    if (self.provinceArr.count>0) {
        
        self.province = self.provinceArr[row0][@"state"];
    }
    if (self.cityArr.count >0) {
        
        self.city = self.cityArr[row1][@"city"];
    }
    if (self.areaArr.count >0) {
        
        self.area = self.areaArr[row2][@"county"];
    }
    NSString *title = [NSString stringWithFormat:@"%@ %@ %@", self.province, self.city, self.area];

    [self.toolbar setTitle:title];
}


#pragma mark - <UIPickerViewDataSource,UIPickerViewDelegate>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinceArr.count;
    }else if (component == 1){
        return self.cityArr.count;
    }
    return self.areaArr.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    switch (component) {
        case 0:
            if (row < _provinceArr.count) {
                [self updateComponentForCityWithProvinceNum:_provinceArr[row] row:row];
            }
            break;
        case 1:
            if (row < _cityArr.count) {
                [self updateComponentForCountyWithCityNum:_cityArr[row] row:row];
            }
            break;
        case 2:
            if (row < _areaArr.count) {
                [self updateComponentForStreetWithCountyNum:_areaArr[row] row:row];
            }
            break;
  
        default:
            break;
    }
    
    [self reloadSelectAddress];
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(8, 0, self.frame.size.width/4 - 16, 30)];
    label.adjustsFontSizeToFitWidth = NO;
    label.font = [UIFont systemFontOfSize: 14];
    label.textAlignment = NSTextAlignmentCenter;
    NSString *text = @"";
    switch (component) {
        case 0:
            if (row < _provinceArr.count) { text = _provinceArr[row][@"state"]; }
            break;
        case 1:
            if (row < _cityArr.count) { text = _cityArr[row][@"city"]; }
            break;
        case 2:
            if (row < _areaArr.count) { text = _areaArr[row][@"county"]; }
            break;
     
        default:
            break;
    }
    
    if (text.length != 0) { label.text = text; }
    return label;
}
- (void)updateComponentForCityWithProvinceNum:(NSDictionary *)dict row:(NSInteger)row {
    NSMutableArray *citys = [NSMutableArray arrayWithArray:dict[@"cities"]];
    [self.cityArr removeAllObjects];
    [citys enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.cityArr addObject:obj];
    }];
    [self.pickerView reloadComponent:1];
    [self.pickerView selectRow:0 inComponent:1 animated:YES];
    //    if (_arrayCity.count > 0) {
    //        [self updateComponentForCountyWithCityNum:self.arrayCity[0] row:0];
    //    }else {
    [self updateComponentForCountyWithCityNum:@{@"":@""} row:0];
    self.province = @"";
    //    }
}


- (void)updateComponentForCountyWithCityNum:(NSDictionary *)dict row:(NSInteger)row {
    [self.areaArr removeAllObjects];
    NSMutableArray *countyAry = [NSMutableArray arrayWithArray:dict[@"areas"]];
    [countyAry enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.areaArr addObject:obj];//获取区名字  obj[@"county"]
    }];
    [self.pickerView reloadComponent:2];
    [self.pickerView selectRow:0 inComponent:2 animated:YES];
    //    if (_arrayArea.count > 0 && row < _arrayArea.count) {
    //        [self updateComponentForStreetWithCountyNum:_arrayArea[row] row:0];
    //    }else {
    [self updateComponentForStreetWithCountyNum:@{@"":@""} row:0];
    //    }
}

- (void)updateComponentForStreetWithCountyNum:(NSDictionary *)dict row:(NSInteger)row {
//    [self.arrayStreets removeAllObjects];
//    [self.arrayStreets addObjectsFromArray:dict[@"streets"]];
    [self.pickerView reloadComponent:2];
    //    [self.pickerView selectRow:0 inComponent:2 animated:YES];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return PickerViewRowHeight;
}

#pragma mark - SEL Method

- (void)cofirmAction{

    if (self.selectAreaCallBack) {
        self.selectAreaCallBack(self.province, self.city, self.area);
    }
    [self dismiss];
}


#pragma mark - Setter && Getter Methods
- (UIPickerView *)pickerView{
    if (!_pickerView) {
        
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, Screen_Height +44, Screen_Width, PickerViewHeight-44)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        
    }
    
    return _pickerView;
}
- (HHPickerToolBar *)toolbar{
    if (!_toolbar) {
        
        _toolbar = [[HHPickerToolBar alloc]initWithTitle:@"选择城市地区" cancelButtonTitle:@"取消" cofirmButtonTitle:@"确定" addTrget:self cancelAction:@selector(dismiss) cofirmAction:@selector(cofirmAction)];
        _toolbar.x = 0;
        _toolbar.y = Screen_Height;
    }
    return _toolbar;
    
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,Screen_Width, 0.5)];
        [_lineView setBackgroundColor:kSeparatedLineColor];
    }
    return _lineView;
}

- (NSArray *)rootArray {
    if (!_rootArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
        _rootArray = [[NSArray array] initWithContentsOfFile:path];
    }
    return _rootArray;
}
- (NSMutableArray *)provinceArr{
    
    if (!_provinceArr) {
        _provinceArr  = [NSMutableArray array];
    }
    return _provinceArr;
    
}
- (NSMutableArray *)cityArr{
    
    if (!_cityArr) {
        _cityArr  = [NSMutableArray array];
    }
    return _cityArr;
    
}
- (NSMutableArray *)areaArr{
    
    if (!_areaArr) {
        _areaArr  = [NSMutableArray array];
    }
    return _areaArr;
    
}



@end

@interface HHPickerToolBar()




@property(nonatomic,strong) UIButton *leftButton;  // <#注释#>

@property(nonatomic,strong) UILabel *titleLabel;  // <#注释#>

@property(nonatomic,strong) UIButton *rightButton;  // <#注释#>

@end


@implementation HHPickerToolBar

#pragma mark - inits Method
- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
            cofirmButtonTitle:(NSString *)cofirmButtonTitle
                     addTrget:(id)target
                 cancelAction:(SEL)cancelAction
                 cofirmAction:(SEL)cofirmAction{
   
    if(self = [self init]){
        
    [self.titleLabel setText:@""];
    [self.leftButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    [self.leftButton setTitleColor:kThemeColor forState:UIControlStateNormal];
    [self.leftButton addTarget:target action:cancelAction forControlEvents:UIControlEventTouchUpInside];
    
    [self.rightButton setTitle:cofirmButtonTitle forState:UIControlStateNormal];
    [self.rightButton setTitleColor:kThemeColor forState:UIControlStateNormal];
    [self.rightButton addTarget:target action:cofirmAction forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (instancetype)init{
    if (self = [super init]) {
        [self setupInit];
        [self setupSubView];
    }
    return self;
}
#pragma mark - setupSubView
- (void)setupSubView{

    [self addSubview:self.leftButton];
    
    [self addSubview:self.rightButton];
    
    [self addSubview:self.titleLabel];
}
#pragma mark - setupInit

- (void)setupInit{
    
    _title = nil;
    
    _font = [UIFont systemFontOfSize:15];
    _titleColor = [UIColor blackColor];
    _borderButtonColor = kThemeColor;
    self.bounds = CGRectMake(0, 0, Screen_Width, 44);
    self.backgroundColor = [UIColor whiteColor];
    
}
#pragma mark - Setter && Getter Methods
- (void)setTitle:(NSString *)title{
    
    _title = title;
}
- (void)setTitleColor:(UIColor *)titleColor{
    
    _titleColor = titleColor;
    [self.titleLabel setTextColor:titleColor];
    [self.leftButton setTitleColor:titleColor forState:UIControlStateNormal];
    [self.rightButton setTitleColor:titleColor forState:UIControlStateNormal];
    
}
- (void)setFont:(UIFont *)font{
    
    _font = font;
    [self.titleLabel setFont:font];
    [self.leftButton.titleLabel setFont:font];
    [self.rightButton.titleLabel setFont:font];
}
- (void)setBorderButtonColor:(UIColor *)borderButtonColor{
    
    _borderButtonColor = borderButtonColor;
}
- (UIButton *)leftButton{
    
    if (!_leftButton) {
        _leftButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 2, 45, 35)];
        [_leftButton setTitleColor:self.titleColor forState:UIControlStateNormal];
        [_leftButton.titleLabel setFont:self.font];
        
    }
    return _leftButton;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        CGFloat titleX = CGRectGetMaxX(self.leftButton.frame) + 5;
        CGFloat titleW = Screen_Width - titleX * 2;
        CGFloat titleH = 44;
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleX, 0, titleW, titleH)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = self.titleColor;
        _titleLabel.font = self.font;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabel;
}

- (UIButton *)rightButton{
    
    if (!_rightButton) {
        _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(Screen_Width - 45 - 15, 5, 45, 35)];
        [_rightButton setTitleColor:self.titleColor forState:UIControlStateNormal];
        [_rightButton.titleLabel setFont:self.font];
    }

    return _rightButton;
}
@end
