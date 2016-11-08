//
//  WNSongPlayerViewController.m
//  WNTools
//
//  Created by imread on 8/11/16.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import "WNSongPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface WNSongPlayerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)AVAudioPlayer *audioPlayer;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation WNSongPlayerViewController

-(UITableView *)tableView
{
    if (!_tableView)
    {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"mp3"];
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
    [self.audioPlayer play];

    
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
