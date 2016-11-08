//
//  WNUploadViewController.m
//  WNTools
//
//  Created by 王楠 on 2016/11/5.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import "WNUploadViewController.h"
#import "WNHttpServer.h"
#import "WNStartUploadViewController.h"

@interface WNUploadViewController ()



@end

@implementation WNUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"上传";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(WIDTH/2-30, 150, 60, 40);
    [button setTitle:@"上传" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor darkGrayColor];
    [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    //[[WNHttpServer shareHttpServer]start];
}

-(void)clickBtn:(UIButton *)sender
{
    WNStartUploadViewController *startUploadVC = [[WNStartUploadViewController alloc]init];
    [self.navigationController pushViewController:startUploadVC animated:YES];
    
    
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
