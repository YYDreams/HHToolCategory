//
//  LoginViewController.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/4.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "TestViewController.h"
#import "LYTools.h"
#import "HHLoadingView.h"
#import "RefreshViewController.h"
@interface LoginViewController ()


@property(nonatomic,strong) UIImageView *imgView;  // <#注释#>

@property(nonatomic,strong) UITextField *userName;  // <#注释#>

@property(nonatomic,strong) UITextField *password;  // <#注释#>

@property(nonatomic,strong) LoginView *loginView;  // <#注释#>


@end

@implementation LoginViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubView];
    [self setupConstranints];
}
#pragma mark - loadDataFromNetwork

#pragma mark - setupSubView
- (void)setupSubView{
    
    

    [self.view addSubview:self.imgView];
    

    [self.view addSubview:self.userName];
    
    [self.view addSubview:self.password];
    
    
    
    
    

//
////    LYButton *login = [[LYButton alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
////    login.center = CGPointMake(self.view.center.x, password.center.y+100);
////    [self.view addSubview:login];
////
//    __block LoginView *button = self.loginView;
//    WeakSelf;
//    self.loginView.translateBlock   = ^{
//        NSLog(@"跳转了哦");
//        button.bounds = CGRectMake(0, 0, 44, 44);
//        button.layer.cornerRadius = 22;
//
//        TestViewController *nextVC = [[TestViewController alloc]init];
//        [weakSelf presentViewController:nextVC animated:YES completion:nil];
//    };
    
    

    
    
}

- (void)setupConstranints{
    WeakSelf;
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(weakSelf.view);
    }];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(margin);
        make.right.mas_equalTo(-margin);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(200);
    }];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(margin);
        make.right.mas_equalTo(-margin);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(weakSelf.userName.mas_bottom).mas_offset(10);
    }];
    

    
    LoginView *login = [[LoginView alloc]initWithFrame:CGRectMake(margin,(Screen_Height-44)/2, Screen_Width- 2* margin, 44)];
    [self.view addSubview:login];
    
    __block LoginView *button = login;
    
    login.translateBlock = ^{
        
        
        [weakSelf loginOnClick];
        
        NSLog(@"跳转了哦");
//        button.bounds = CGRectMake(0, 0, 44, 44);
//        button.layer.cornerRadius = 22;

    };
    
}

- (void)loginOnClick{
    
    
    
    [HHLoadingView showLoadingInView:self.view];
    
    WeakSelf;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userName"] =  self.userName.text;
    param[@"terminalType"]= @(2);
    param[@"deviceId"] = [NSString getUUID];
    param[@"password"]= [LYTools MD5ForLower32Bate:self.password.text];
 
    [HTTPRequest POST:kLoginUrl parameter:param success:^(id resposeObject) {
        
        if (SUCCESS) {
            
            [HHLoadingView hideLoadingForView:weakSelf.view];
            LH.token = resposeObject[@"data"][@"token"];
            LH.userId = resposeObject[@"data"][@"userId"];
            NSLog(@"%@",resposeObject);
         
            
            
            RefreshViewController *nextVC = [[RefreshViewController alloc]init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
       
        
    } failure:^(NSError *error) {
        [MBProgressHUD LY_ShowError:(kNoNetworkTips) time:2.0];
    }];
    
    
}
- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.image = [UIImage imageNamed:@"login.png"];
        
    }
    return _imgView;
}
- (UITextField *)userName{
    
    if (!_userName) {
        _userName = [UITextField textFplaceholder:@"请输入用户名" bgColor:@"" keyboardType:UIKeyboardTypeNumberPad];
        
    }
    return _userName;
}

- (UITextField *)password{
    
    if (!_password) {
        _password = [UITextField textFplaceholder:@"请输入密码" bgColor:@"" keyboardType:UIKeyboardTypeNumberPad];
        
    }
    return _password;
}



#pragma mark - setupConstranints


#pragma mark - <UITableViewDataSource,UITableViewDelegate>


#pragma mark - Custom Method


#pragma mark - Setter && Getter Methods



@end
