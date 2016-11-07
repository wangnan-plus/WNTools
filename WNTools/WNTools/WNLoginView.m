//
//  WNLoginView.m
//  WNTools
//
//  Created by 丁乾坤 on 2016/11/5.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import "WNLoginView.h"
#import "WN_Style1_Button.h"
#import "WN_Style1_TextField.h"


@interface WNLoginView()

@property(nonatomic,strong)WN_Style1_TextField *usernameTField;
@property(nonatomic,strong)WN_Style1_TextField *passwordTField;
@property(nonatomic,strong)WN_Style1_Button *loginBtn;
@property(nonatomic,strong)WN_Style1_Button *registerBen;

@end

@implementation WNLoginView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
    
}

-(void)configUI
{
        
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
