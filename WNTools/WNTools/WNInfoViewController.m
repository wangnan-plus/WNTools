//
//  WNLoginViewController.m
//  WNTools
//
//  Created by 丁乾坤 on 2016/11/5.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import "WNInfoViewController.h"
#import "WNLoginViewController.h"

@interface WNInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *datasource;

@end

@implementation WNInfoViewController

-(UITableView *)tableView
{
    if (!_tableView)
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 0, WIDTH-40, HEIGHT-164) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    }
    
    return _tableView;
}


-(NSArray *)datasource
{
    if (!_datasource)
    {
        self.datasource = [NSArray array];
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我";
    [self.view addSubview:self.tableView];
    self.datasource = @[@"等待开发",@"我的收藏",@"设置"];
    
    
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    self.tableView.tableHeaderView = aView;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 60);
    btn.center = aView.center;
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [aView addSubview:btn];
    [self.view addSubview:self.tableView];
    
}

-(void)clickBtn:(UIButton *)button
{
    WNLoginViewController *loginVC =[[WNLoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text = self.datasource[indexPath.row];
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
