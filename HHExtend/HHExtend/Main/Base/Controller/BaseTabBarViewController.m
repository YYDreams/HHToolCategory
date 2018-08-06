//
//  BaseTabBarViewController.m
//  JYShop
//
//  Created by 花花 on 2017/9/28.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseUIViewController.h"
#import "BaseNavViewController.h"
#import "YYFPSLabel.h"


@interface BaseTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupControllers];
    
#if DEBUG
    //显示当前帧率
    [self setupFPSLabel];
#endif
    
    
}

#pragma mark -    FPS Label 显示当前帧率
- (void)setupFPSLabel{
    YYFPSLabel *label = [[YYFPSLabel alloc] init];
    label.frame = CGRectMake(10, Screen_Height - 49 - 30 - 10, 60, 30);
    [self.view addSubview:label];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self addTabBarSelectedImageAnimation];
}

- (void)addTabBarSelectedImageAnimation{
    
    for (UIControl *ctrl in self.tabBar.subviews) {
        if ([ctrl isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [ctrl addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    
}

-(void)tabBarButtonClick:(UIControl *)ctrl{
    UIView *imageView,*label;
    [self addView:imageView ctrl:ctrl classString:@"UITabBarSwappableImageView"];
    [self addView:label ctrl:ctrl classString:@"UITabBarButtonLabel"];
    
}

-(void)addView:(UIView *)view ctrl:(UIControl *)ctrl classString:(NSString *)classString{
    
    for (UIView *view in ctrl.subviews) {
        if ([view isKindOfClass:NSClassFromString(classString)]) {
            
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.y"];
            
            animation.values = @[@(0), @(M_PI_2), @(M_PI), @(M_PI * 2)];
            animation.duration = 0.4;
            animation.calculationMode = kCAAnimationCubic;
            
            [view.layer addAnimation:animation forKey:@"playTransitionAnimation"];
                 
        }
    }
    
}
- (void)setupControllers{
    
    LH.isCleaner  = NO;
    //控制器的名字JYHomeViewController  JYHomeController
    
    NSArray *ControllerViews = @[@"HomeViewController",@"ThirdPartyController",@"ScrollListController",@"AnimationListController",@"MineViewController"];
    //TabBar图片
    NSArray *normalImageNames = @[@"home_nav_home", @"home_nav_home",@"home_nav_home", @"home_nav_home", @"home_nav_home"];
    //TabBar选中的图片
    NSArray *selectImageNames = @[@"home_nav_home_click", @"home_nav_home_click", @"home_nav_home_click", @"home_nav_home_click",@"home_nav_home_click"];
    
    //TabBarItem标题
    NSArray *titles = @[@"控件",@"😀",@"表格",@"动画+算法",@"预留"];
    
    
    for (int i = 0; i< ControllerViews.count; i++)
    {
        //1.获取类名字符串
        NSString *className= ControllerViews[i];
        //2。获取类名
        Class class = NSClassFromString(className);
        //3.创建对象
        BaseUIViewController * viewController  = [[class alloc] init];
        viewController.title = titles[i];
        self.tabBar.tintColor = kThemeColor;
        self.tabBar.translucent = NO;
//        self.delegate = self;
        viewController.tabBarItem.image = [[UIImage imageNamed:normalImageNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.tabBarItem.selectedImage =  [[UIImage imageNamed:selectImageNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        BaseNavViewController *Nav = [[BaseNavViewController alloc]initWithRootViewController:viewController];
    
        Nav.navigationBar.translucent = NO;
        [self addChildViewController:Nav];
        
        //        if (i==0) viewController.hiddenNavBar = YES;
        
    }
    //默认选中第一个
    self.selectedIndex = 0;
    
    
    
}


//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//
//
//    if ([viewController isKindOfClass:[BaseNavViewController class]]) {
//
//        BaseNavViewController *viewCtrl = (BaseNavViewController *)viewController;
//
//        if ([viewCtrl.viewControllers.firstObject isKindOfClass:[JYHomeViewController class]]) {
//
//            [[NSNotificationCenter defaultCenter]postNotificationName:kTabBarDidSelectedNotification object:nil];
//        }
//
//    }
//
//
//
//}

@end
