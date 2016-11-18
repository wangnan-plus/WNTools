//
//  WNMovieViewController.m
//  WNTools
//
//  Created by imread on 8/11/16.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import "WNMovieViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface WNMovieViewController ()

@property(nonatomic, strong)AVAudioSession *audioSession;

@property(nonatomic, strong)AVPlayer *player;

@property(nonatomic, strong)AVPlayerViewController *playerVC;

//@property (nonatomic, strong) AVPlayer *player; /**< 媒体播放器 */
@property (nonatomic, strong) AVPlayerViewController *playerViewController; /**< 媒体播放控制器 */

@end

@implementation WNMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //加载播放器
    [self _setupPlayeForFullScreen];
   // [self _player];
    
}

#pragma mark -----  全屏播放器
- (void)_setupPlayeForFullScreen{
    //资源路径
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
    NSURL *movieUrl = [NSURL fileURLWithPath:moviePath];
    //加载资源
    AVPlayer *player = [AVPlayer playerWithURL:movieUrl];
    //设置播放器位置和大小
    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];
    playerVC.player = player;
    //设置拉伸模式
    playerVC.videoGravity = AVLayerVideoGravityResizeAspect;
    playerVC.showsPlaybackControls = YES;
    [playerVC.player play];
    //设置播放器位置大小
    playerVC.view.frame = self.view.bounds;
    [self addChildViewController:playerVC];
    [self.view addSubview:playerVC.view];
    
    
}


//直接播放
- (void)_player{
    // 1、获取媒体资源地址
    NSString *path = [[NSBundle mainBundle] pathForAuxiliaryExecutable:@"test.mp4"];
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:path];
    
    // 2、创建AVPlayerItem
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:sourceMovieURL];
    // 3、根据AVPlayerItem创建媒体播放器
    _player = [AVPlayer playerWithPlayerItem:playerItem];
    // 4、创建AVPlayerLayer，用于呈现视频
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    // 5、设置显示大小和位置
    playerLayer.bounds = CGRectMake(0, 0, 350, 300);
    playerLayer.position = CGPointMake(CGRectGetMidX(self.view.bounds), 64 + CGRectGetMidY(playerLayer.bounds) + 30);
    // 6、设置拉伸模式
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    // 7、获取播放持续时间
    NSLog(@"%lld", playerItem.duration.value);
    [_player play];
    [self.view.layer addSublayer:playerLayer];
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
