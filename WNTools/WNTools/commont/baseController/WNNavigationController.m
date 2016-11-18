//
//  WNNavigationController.m
//  WNTools
//
//  Created by 丁乾坤 on 2016/11/11.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import "WNNavigationController.h"

@interface WNNavigationController ()

@end

@implementation WNNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];

}

//重新psuh 方法  隐藏显示 tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count == 1)
    {
        viewController.hidesBottomBarWhenPushed = NO;
    }
}

@end
