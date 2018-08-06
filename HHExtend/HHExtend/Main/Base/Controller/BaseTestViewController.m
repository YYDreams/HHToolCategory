//
//  BaseTestViewController.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/4.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "BaseTestViewController.h"
#import "BaseNavViewController.h"
#import "WXTabBarButton.h"
@interface BaseTestViewController (){
    UIImageView *_selectedView; // TabBar上面的选中视图

}

@end

@implementation BaseTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedIndex = 1;

        LH.isCleaner = YES;
    
    //移除按钮
    [self _removeTabBarButton];
    
    
    //自定义标签栏
    [self _customTabBar];
    
    

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //视图将要出现的时候，移除tabbar上的按钮
    
    //使用storyboard搭建三级控制器，在viewDidLoad方法走完之后，故事板没有全部加载完成
    //等故事板加载完成，就会再次添加tabbarbutton
    [self _removeTabBarButton];
}
#pragma mark - 标签栏的设置
- (void)_customTabBar {
    
    
    // 1.背景
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tab_bg_all"];
    // 3.选中的视图
    _selectedView = [[UIImageView alloc]
                     initWithImage:[UIImage imageNamed:@"selectTabbar_bg_all1"]];
    _selectedView.frame = CGRectMake(0, 0, 55, 47);
    [self.tabBar addSubview:_selectedView];
    
    // 2.tabbar按钮
    NSArray *titles = @[ @"首页", @"新闻", @"Top", @"影院", @"更多" ];
    
    NSArray *imageNames = @[
                            @"home_nav_home",
                            @"home_nav_home",
                            @"home_nav_home",
                            @"home_nav_home",
                            @"123.gif"
                            ];
    
        NSArray *ControllerViews = @[@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"MineViewController"];

    float buttonWidth = Screen_Width / titles.count;
    
    for (int i = 0; i < titles.count; i++) {
        NSString *title = titles[i];         //标题
        NSString *imageName = imageNames[i]; //图片
        
                //1.获取类名字符串
                NSString *className= ControllerViews[i];
                //2。获取类名
                Class class = NSClassFromString(className);
                //3.创建对象
                BaseUIViewController * viewController  = [[class alloc] init];

              viewController.navigationItem.title = titles[i];
        
         BaseNavViewController *Nav = [[BaseNavViewController alloc]initWithRootViewController:viewController];

                Nav.navigationBar.translucent = NO;
                [self addChildViewController:Nav];



        //每个按钮的frame
        CGRect frame = CGRectMake(buttonWidth * i, 0, buttonWidth, kTabBarHeight);
        
        //使用自定义的控件创建
        WXTabBarButton *button = [[WXTabBarButton alloc] initWithFrame:frame
                                                         withImageName:imageName
                                                             withTitle:title];
        button.tag = 1000 + i;
        [button addTarget:self
                   action:@selector(buttonAction:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabBar addSubview:button];
        
        if (i == 1) {
            //选中的视图和第一个按钮对齐
            _selectedView.center = button.center;
        }
        
   
    }
}


//移除系统标签栏上的按钮
- (void)_removeTabBarButton {
    
    //取到所有的子视图
    for (UIView *view in self.tabBar.subviews) {
        //从字符串生成一个类名
        Class class = NSClassFromString(@"UITabBarButton");
        
        //找出UITabBarButton，移除掉
        if ([view isKindOfClass:[WXTabBarButton class]] == NO) {
            [view removeFromSuperview];
        }
    }
    
    // NSLog(@"%@", self.tabBar.subviews);
}

#pragma mark - Button Action
- (void)buttonAction:(UIButton *)sender {
    // 1.切换界面
    self.selectedIndex = sender.tag - 1000;
    
    // 2.移动选中的视图
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.35];
    
    _selectedView.center = sender.center;
    
    [UIView commitAnimations];
}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//
//
//    [self setupControllers];
//}
//- (void)setupControllers{
//    
//
//
//
//    //控制器的名字JYHomeViewController  JYHomeController
//
//    NSArray *ControllerViews = @[@"TestViewController",@"TestViewController",@"TestViewController",@"TestViewController",@"MineViewController"];
//    //TabBar图片
//    NSArray *normalImageNames = @[@"home_nav_home", @"home_nav_home",@"home_nav_home", @"home_nav_home", @"home_nav_home"];
//    //TabBar选中的图片
//    NSArray *selectImageNames = @[@"home_nav_home_click", @"home_nav_home_click", @"home_nav_home_click", @"home_nav_home_click",@"home_nav_home_click"];
//
//    //TabBarItem标题
//    NSArray *titles = @[@"test1",@"test2",@"test3",@"test4",@"test5"];
//
//
//    for (int i = 0; i< ControllerViews.count; i++)
//    {
//        //1.获取类名字符串
//        NSString *className= ControllerViews[i];
//        //2。获取类名
//        Class class = NSClassFromString(className);
//        //3.创建对象
//        BaseUIViewController * viewController  = [[class alloc] init];
//        viewController.title = titles[i];
//        self.tabBar.tintColor = kThemeColor;
//        self.tabBar.translucent = NO;
//        //        self.delegate = self;
//        viewController.tabBarItem.image = [[UIImage imageNamed:normalImageNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        viewController.tabBarItem.selectedImage =  [[UIImage imageNamed:selectImageNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        BaseNavViewController *Nav = [[BaseNavViewController alloc]initWithRootViewController:viewController];
//
//        //        Nav.navigationBar.translucent = NO;
//        [self addChildViewController:Nav];
//
//        //        if (i==0) viewController.hiddenNavBar = YES;
//
//    }
//    //默认选中第一个
//    self.selectedIndex = 2;
//
//
//
//
//
//}


@end
