//
//  WN_Style1_TextField.m
//  WNTools
//
//  Created by 丁乾坤 on 2016/11/5.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import "WN_Style1_TextField.h"

@implementation WN_Style1_TextField


-(instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder fontsize:(NSInteger)fontsize textColor:(UIColor *)color
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.placeholder = placeholder;
        self.textColor = color;
        self.font = [UIFont systemFontOfSize:fontsize];
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
