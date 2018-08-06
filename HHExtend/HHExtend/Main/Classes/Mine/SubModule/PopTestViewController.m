//
//  PopTestViewController.m
//  HHExtend
//
//  Created by flowerflower on 2018/3/28.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "PopTestViewController.h"

@interface PopTestViewController ()

@end

@implementation PopTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  
    WeakSelf;
    self.handlerPopCallBack = ^(UIBarButtonItem *backItem) {
      
        [weakSelf showAlert];
    };
    
}
- (void)showAlert{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定返回？" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    
    
    
    [self presentViewController:alertVC animated:YES completion:^{
        
    }];
}

- (void)setupNav{
    
    
    
}

- (void)setupInit{
    
    
    
    
    
}

@end
