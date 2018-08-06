//
//  HHLoadingView.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/4.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "HHLoadingView.h"
static NSArray *s_refreshingImages = nil;

@implementation HHLoadingView

+ (instancetype)loadViewWithFrame:(CGRect)frame{
    
    HHLoadingView *loadView = [[self alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    return loadView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"loadingcai2new001"];
        _imageView.size = CGSizeMake(image.size.width, image.size.height);
        _imageView.left = (Screen_Width - _imageView.size.width) / 2.0;
        _imageView.top = (Screen_Height - _imageView.size.height) / 2.0 - _imageView.size.height/4;
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kSeparatedLineColor;
        [self addAnimalImages];
    }
    return self;
}

- (NSArray *)refreshingImages{
    if (!s_refreshingImages) {
        NSMutableArray *refreshingImages  = [NSMutableArray array];
        for (int i = 1; i < 25; ++i) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loadingcai2new00%d",i]];
            [refreshingImages addObject:image];
        }
        s_refreshingImages = [refreshingImages copy];
    }
    return s_refreshingImages;
}

- (void)addAnimalImages{
    self.imageView.animationDuration = 1.5;
    self.imageView.animationImages = [self refreshingImages];
}

#pragma mark - 便利方法
+ (void)showLoadingInView:(UIView *)view{
    [self showLoadingInView:view edgeInset:UIEdgeInsetsZero];
}

+ (void)showLoadingInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset{
    HHLoadingView *loadingView = [self loadViewWithFrame:view.frame];
    
    loadingView.edgeInset = edgeInset;
    
    [loadingView showInView:view];
}

+ (void)showLoadingInView:(UIView *)view topEdge:(CGFloat)topEdge{
    HHLoadingView *loadingView = [self loadViewWithFrame:view.frame];
    loadingView.edgeInset = UIEdgeInsetsMake(topEdge, 0, 0, 0);
    [loadingView showInView:view];
}

+ (void)hideLoadingForView:(UIView *)view{
    HHLoadingView *loadingView = [self loadingForView:view];
    if (loadingView) {
        [loadingView hide];
    }
}

+ (void)hideAllLoadingForView:(UIView *)view{
    NSEnumerator *reverseSubviews = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in reverseSubviews) {
        if ([subview isKindOfClass:self]) {
            [(HHLoadingView *)subview hideNoAnimation];
        }
    }
}

+ (HHLoadingView *)loadingForView:(UIView *)view{
    NSEnumerator *reverseSubviews = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in reverseSubviews) {
        if ([subview isKindOfClass:self]) {
            return (HHLoadingView *)subview;
        }
    }
    return nil;
}

#pragma mark - 实例方法
- (void)showInView:(UIView *)view{
    if (!view) {
        return ;
    }
    if (self.superview != view) {
        [self removeFromSuperview];
        [view addSubview:self];
        [view bringSubviewToFront:self];
    }
    [self.imageView startAnimating];
}

- (void)hide{
    self.alpha = 1.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self hideNoAnimation];
    }];
}

- (void)hideNoAnimation{
    [self.imageView stopAnimating];
    [self removeFromSuperview];
}


- (void)dealloc{
    NSLog(@"%@释放了",[self class]);
}

@end
