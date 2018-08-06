//
//  BaseNavViewController.m
//  JYShop
//
//  Created by 花花 on 2017/9/28.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()<UIGestureRecognizerDelegate,UINavigationBarDelegate,UINavigationControllerDelegate>

@end

@implementation BaseNavViewController


+(void)initialize{
//    UINavigationBar *bar = [UINavigationBar appearance];
//
//    //设置title
//    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}] ;
//    // 设置item
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    // UIControlStateNormal
//    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
//    itemAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
//    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
//    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
//    // UIControlStateDisabled
//    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
//    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor yellowColor];
//    [item setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
//    //去除系统的透明效果
//    [bar setTranslucent:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    __weak typeof(self) weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.navigationController.viewControllers.count == 1) {
        return NO;
    }else{
        return YES;
    }
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    if (navigationController.viewControllers.count == 1) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
        navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

#pragma mark - 可在此方法中拦截所有push 进来的控制器
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count>0) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateHighlighted];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        btn.size = CGSizeMake(40, 30);
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentMode = UIRectCornerTopLeft;
        [btn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    

        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
    
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.visibleViewController;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)backClick:(UIBarButtonItem *)sender{
    
    
    UIViewController *currentVC = self.topViewController;
    if (currentVC.handlerPopCallBack) {
        currentVC.handlerPopCallBack(sender);
        
    }else{
    [self popViewControllerAnimated:YES];
    }
    
}

@end
