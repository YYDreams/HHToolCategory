//
//  MovieViewController.h
//  MoviePlayer
//
//  Created by LOVE on 2017/12/8.
//  Copyright © 2017年 LOVE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieViewController : UIViewController
//播放的Url
@property(nonatomic,strong)NSURL *movieUrl;
//立即进入
@property(nonatomic,copy)void (^joinBtnCallBack)();

@end
