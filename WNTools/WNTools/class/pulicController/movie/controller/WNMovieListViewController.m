//
//  WNMovieListViewController.m
//  WNTools
//
//  Created by imread on 8/11/16.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import "WNMovieListViewController.h"
#import "WNMovieViewController.h"

@interface WNMovieListViewController ()
@property(nonatomic,strong)NSArray *datasource;

@end

@implementation WNMovieListViewController

-(NSArray *)datasource
{
    if (!_datasource)
    {
        self.datasource = [NSArray array];
    }
    return _datasource;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的视频";
    self.datasource = @[@"老男孩"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.textLabel.text = self.datasource[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WNMovieViewController *movieVC = [[WNMovieViewController alloc] init];
    [self.navigationController pushViewController:movieVC animated:YES];
    

}



@end
