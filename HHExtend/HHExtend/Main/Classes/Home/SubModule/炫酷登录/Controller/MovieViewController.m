//
//  MovieViewController.m
//  MoviePlayer
//
//  Created by LOVE on 2017/12/8.
//  Copyright © 2017年 LOVE. All rights reserved.
//

#import "MovieViewController.h"
#import <AVKit/AVKit.h>

@interface MovieViewController ()

@property(nonatomic)AVPlayerViewController *avPlayer;
@end

@implementation MovieViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupInit];
}
#pragma mark - setupInit Method
- (void)setupInit{
    
    self.avPlayer = [[AVPlayerViewController alloc]init];
    if (@available(iOS 9.0, *)) { //多分屏功能取消
        self.avPlayer.allowsPictureInPicturePlayback = NO;
    } else {
        // Fallback on earlier versions
    }
    
    self.avPlayer.showsPlaybackControls = false; //设置是否显示媒体播放组件
    
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL: _movieUrl];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    [layer setFrame:[UIScreen mainScreen].bounds];
    layer.videoGravity = AVLayerVideoGravityResizeAspect;     //设置填充模式

    self.avPlayer.player = player;
    [self.view.layer addSublayer:layer];
    
    [self.avPlayer.player play];
    //重复播放
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(play) name:AVPlayerItemDidPlayToEndTimeNotification object:item];
    //定时器。延迟3秒再出现进入按钮
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(createLogin) userInfo:nil repeats:YES];
    
}
#pragma mark - CreateBtn Method
- (void)createLogin{
    UIButton *loginBtn = [[UIButton alloc]init];
    loginBtn.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height - 160, [UIScreen mainScreen].bounds.size.width - 20, 50);
    loginBtn.layer.borderWidth = 1;
    loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    loginBtn.layer.cornerRadius = 20;
    loginBtn.alpha = 0;
    [loginBtn setTitle:@"立即进入" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(joinOnClick) forControlEvents:UIControlEventTouchUpInside];
    [UIView animateWithDuration:4 animations:^{
        loginBtn.alpha = 1;
    }];
    [self.view addSubview:loginBtn];
    
}
#pragma mark - SEL Method
- (void)play{
    //播放完成后。设置播放进度为0 。 重新播放
    [self.avPlayer.player seekToTime:CMTimeMake(0, 1)];
    [self.avPlayer.player play];
}
- (void)joinOnClick{
    
    if (self.joinBtnCallBack) {
        self.joinBtnCallBack();
    }
}
@end
