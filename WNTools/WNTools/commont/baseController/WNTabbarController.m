//
//  WNTabbarController.m
//  WNTools
//
//  Created by 丁乾坤 on 2016/11/11.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import "WNTabbarController.h"
#import "WNInfoViewController.h"
#import "WNUploadViewController.h"
#import "WNMyResourceViewController.h"
#import "WNNavigationController.h"
@interface WNTabbarController ()

@end

@implementation WNTabbarController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setUpController];
}


#pragma mark ----- 初始化视图控制器
- (void)_setUpController{
    
    WNInfoViewController *loginVC = [[WNInfoViewController alloc]init];
    WNNavigationController *loginNav = [[WNNavigationController alloc]initWithRootViewController:loginVC];
    loginVC.title = @"我的资源";
    
    WNUploadViewController *uploadVC = [[WNUploadViewController alloc]init];
    WNNavigationController *uploadNav = [[WNNavigationController alloc]initWithRootViewController:uploadVC];
    uploadVC.title = @"上传";
    
    WNMyResourceViewController *myResourceVC = [[WNMyResourceViewController alloc]init];
    WNNavigationController *myResourceNav = [[WNNavigationController alloc]initWithRootViewController:myResourceVC];
    myResourceVC.title = @"我";
    
    
    self.viewControllers = @[myResourceNav,uploadNav,loginNav];
}



@end
