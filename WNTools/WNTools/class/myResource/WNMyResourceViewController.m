//
//  WNMyResourceViewController.m
//  WNTools
//
//  Created by 王楠 on 2016/11/5.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import "WNMyResourceViewController.h"
#import "WNSongListViewController.h"
#import "WNMovieListViewController.h"
#import "WNNovelListViewController.h"

@interface WNMyResourceViewController ()

@property(nonatomic,strong)UIButton *songBtn;
@property(nonatomic,strong)UIButton *movieBtn;
@property(nonatomic,strong)UIButton *novelBtn;


@end


@implementation WNMyResourceViewController

-(UIButton *)songBtn
{
    if (!_songBtn)
    {
        self.songBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _songBtn.frame = CGRectMake(WIDTH/2-40, 120, 80, 40);
        [_songBtn setTitle:@"歌曲" forState:UIControlStateNormal];
        [_songBtn addTarget:self action:@selector(clickSongBtn:) forControlEvents:UIControlEventTouchUpInside];
        _songBtn.backgroundColor = [UIColor darkGrayColor];
    }
    return _songBtn;
}

-(UIButton *)movieBtn
{
    if (!_movieBtn)
    {
        self.movieBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _movieBtn.frame = CGRectMake(WIDTH/2-40, 180, 80, 40);
        [_movieBtn setTitle:@"视频" forState:UIControlStateNormal];
        [_movieBtn addTarget:self action:@selector(clickMovieBtn:) forControlEvents:UIControlEventTouchUpInside];
        _movieBtn.backgroundColor = [UIColor darkGrayColor];
    }
    return _movieBtn;
}

-(UIButton *)novelBtn
{
    if (!_novelBtn)
    {
        self.novelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _novelBtn.frame = CGRectMake(WIDTH/2-40, 240, 80, 40);
        [_novelBtn addTarget:self action:@selector(clickNovelBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_novelBtn setTitle:@"阅读" forState:UIControlStateNormal];
        _novelBtn.backgroundColor = [UIColor darkGrayColor];
    }
    return _novelBtn;
}

-(void)clickMovieBtn:(UIButton *)sender
{
    WNMovieListViewController *movieListVC = [[WNMovieListViewController alloc]init];
    [self.navigationController pushViewController:movieListVC animated:YES];
}

-(void)clickNovelBtn:(UIButton *)sender
{
    WNNovelListViewController *novelListVC = [[WNNovelListViewController alloc]init];
    [self.navigationController pushViewController:novelListVC animated:YES];
    
}

-(void)clickSongBtn:(UIButton *)sender
{
    WNSongListViewController *songListVC = [[WNSongListViewController alloc]init];
    [self.navigationController pushViewController:songListVC animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的资源";
    
    [self.view addSubview:self.songBtn];
    [self.view addSubview:self.movieBtn];
    [self.view addSubview:self.novelBtn];
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
