//
//  Test1ViewController.m
//  HHExtend
//
//  Created by flowerflower on 2018/8/5.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "Test1ViewController.h"
#import "UserInfoManager.h"
@interface Test1ViewController ()

@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UserModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:UserDataFilePath];
//
//
UserModel *model =     [UserModel userInfo];
//    NSLog(@"%@------%@--",model.token,model.nickname);
    NSLog(@"UserModel: %@------%@-- %@ ",YH.userInfo.token,YH.userInfo.nickname,YH.userInfo.mobile);

    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, Screen_Width- 2 *20, 50)];
    [btn addTarget:self action:@selector(btnOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [btn setTitle:@"退出" forState:UIControlStateNormal];
    
    [btn setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:btn];
    
}

-(void)btnOnClick{
    

 
    [UserInfoManager clearUserInfo];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
