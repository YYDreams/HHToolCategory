//
//  MineViewController.m
//  HHExtend
//
//  Created by flowerflower on 2018/3/28.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "MineViewController.h"
#import "PopTestViewController.h"
#import "AppDelegate.h"
#import "BaseTestViewController.h"
#import "BaseTabBarViewController.h"
#import "MineTestViewController.h"
#import "NetworkTestController.h"
#import "Test1ViewController.h"
#import "UserInfoManager.h"


@interface MineViewController ()

@property(nonatomic,strong)UITextField *textField;
@end

static NSString *const mineCellID = @"mineCellID";
@implementation MineViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
 
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 20, Screen_Width- 2 * 20, 30)];
    textField.placeholder = @"请输入账号";
    [self.view addSubview:textField];
    _textField = textField;

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(textField.frame)+30, Screen_Width- 2 *20, 50)];
    [btn addTarget:self action:@selector(btnOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    
    [btn setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:btn];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UserModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:UserDataFilePath];
    
    
//    NSLog(@"UserModel: %@------%@--",model.token,model.nickname);
    
    
    NSLog(@"UserModel: %@------%@-- %@ ",YH.userInfo.token,YH.userInfo.nickname,YH.userInfo.mobile);
    
}
- (void)btnOnClick{
    
    [HTTPRequest POST:@"5b6685533200006a00ee11b1" parameter:nil success:^(id resposeObject) {
       
        if ([resposeObject[@"code"] isEqualToString:@"200"]) {
            UserModel *model = [UserModel objectWithDic:resposeObject[@"data"]];
            model.mobile = _textField.text;
            [UserInfoManager shareInstance].userInfo = model;
            [UserInfoManager saveUserInfo:model];
            NSLog(@"%@",UserDataFilePath);
            [self.navigationController pushViewController:[Test1ViewController new] animated:YES];
            
            
        }
        
    } failure:^(NSError *error) {
       
    }];
    
}
@end
