//
//  WN_Style1_Button.m
//  WNTools
//
//  Created by 丁乾坤 on 2016/11/5.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import "WN_Style1_Button.h"

@implementation WN_Style1_Button






-(void)setFrame:(CGRect)frame title:(NSString *)title fontsize:(NSInteger)fontsize titleColor:(UIColor *)titlecolor
{
    self.frame = frame;
    self.layer.cornerRadius = 4;
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:titlecolor forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:fontsize];
    self.backgroundColor = [UIColor yellowColor];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
