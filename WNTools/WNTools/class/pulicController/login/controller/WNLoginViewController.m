//
//  WNLoginViewController.m
//  WNTools
//
//  Created by 丁乾坤 on 2016/11/5.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import "WNLoginViewController.h"
#import "WN_Style1_Button.h"
#import "WN_Style1_TextField.h"

@interface WNLoginViewController ()
@property(nonatomic,strong)WN_Style1_TextField *usernameTField;
@property(nonatomic,strong)WN_Style1_TextField *passwordTField;
@property(nonatomic,strong)WN_Style1_Button *loginBtn;
@property(nonatomic,strong)WN_Style1_Button *registerBen;

@end

@implementation WNLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.usernameTField = [[WN_Style1_TextField alloc]initWithFrame:CGRectMake(20, 100, WIDTH-40, 45) placeholder:@"用户名" fontsize:13 textColor:[UIColor redColor]];
    [self.view addSubview:self.usernameTField];
    
    self.passwordTField = [[WN_Style1_TextField alloc]initWithFrame:CGRectMake(20, _usernameTField.frame.origin.y+50, WIDTH-40, 45) placeholder:@"密码" fontsize:13 textColor:[UIColor redColor]];
    [self.view addSubview:self.passwordTField];
    
    self.loginBtn = [[WN_Style1_Button alloc]init];
    [_loginBtn setFrame:CGRectMake(20, _passwordTField.frame.origin.y+65, 60, 45) title:@"登录" fontsize:13 titleColor:[UIColor blackColor]];
    [self.loginBtn addTarget:self action:@selector(clickLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    
    self.registerBen = [[WN_Style1_Button alloc]init];
    [_registerBen setFrame:CGRectMake(WIDTH-80, _passwordTField.frame.origin.y+65, 60, 45) title:@"注册" fontsize:13 titleColor:[UIColor blackColor]];
    [self.view addSubview:self.registerBen];

    
    
    
}

-(void)clickLoginBtn:(UIButton *)sender
{
    [self.passwordTField resignFirstResponder];
    [self.usernameTField resignFirstResponder];
    NSString *url = [NSString stringWithFormat:@"%@%@",SERVER_HOST,SERVER_LOGIN];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSString *str = [NSString stringWithFormat:@"username=%@&password=%@",self.usernameTField.text,self.passwordTField.text];
    NSData *strdata = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    
    __weak WNLoginViewController *weakSelf = self;
    NSURLSessionDataTask *task = [session uploadTaskWithRequest:request fromData:strdata completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *s = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSData *strData = [s dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingAllowFragments error:nil];
        if (json)
        {
            if ([json[@"code"] integerValue]==200)
            {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else if ([json[@"code"] integerValue]==403)
            {
                NSLog(@"");
            }
        }
        
        
    }];
    [task resume];
    
    
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
