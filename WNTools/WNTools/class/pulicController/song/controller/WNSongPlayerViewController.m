//
//  WNSongPlayerViewController.m
//  WNTools
//
//  Created by imread on 8/11/16.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import "WNSongPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WNLrcParser.h"

@interface WNSongPlayerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)AVAudioPlayer *audioPlayer;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)WNLrcParser *lrcParser;
@property(nonatomic,assign) NSUInteger currentRow;

@end

@implementation WNSongPlayerViewController

-(UITableView *)tableView
{
    if (!_tableView)
    {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"mp3"];
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
    [self.audioPlayer prepareToPlay];
    
    NSString *lrcPath = [[NSBundle mainBundle]pathForResource:@"123" ofType:@"lrc"];
    self.lrcParser = [[WNLrcParser alloc]init];
    [self.lrcParser parserLrcWithFileURL:lrcPath];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeTime:) userInfo:nil repeats:YES];
    [self.audioPlayer play];
}

- (void)changeTime:(NSTimer *)timer
{
//    self.progressSlider.value = self.audioPlayer.currentTime;
    
    [self.lrcParser.timeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *timeStr = self.lrcParser.timeArr[idx];
        NSArray *timeArr = [timeStr componentsSeparatedByString:@":"];
        CGFloat seconds = [timeArr[0] floatValue] * 60 + [timeArr[1] floatValue];
        if (seconds >= self.audioPlayer.currentTime) {
            if (idx == 0)
            {
                self.currentRow = idx;
            }
            else
            {
                self.currentRow = idx - 1;
            }
            *stop = YES;
        }
    }];
    [self.tableView reloadData];
    if (self.currentRow < self.lrcParser.lrcArr.count) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentRow inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lrcParser.lrcArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    if (indexPath.row < self.lrcParser.lrcArr.count)
    {
        cell.textLabel.text = self.lrcParser.lrcArr[indexPath.row];
    }
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.numberOfLines = 0;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.textLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:15];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.backgroundColor = [UIColor clearColor];
    if (self.currentRow == indexPath.row)
    {
        cell.textLabel.textColor = [UIColor redColor];
    }
    else
    {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    return cell;
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
