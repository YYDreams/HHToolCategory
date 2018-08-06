//
//  TestViewController.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/4.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "TestViewController.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//
//
    
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"]]];
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.animatedImage = image;
    imageView.frame = CGRectMake(0.0, 0.0, 300.0, 300.0);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
}



@end
