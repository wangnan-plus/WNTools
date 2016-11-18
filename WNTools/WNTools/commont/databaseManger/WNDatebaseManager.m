//
//  WNDatebaseManager.m
//  WNTools
//
//  Created by imread on 8/11/16.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import "WNDatebaseManager.h"

@implementation WNDatebaseManager

+(WNDatebaseManager *)dataBase
{
    static WNDatebaseManager *database;
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        database = [WNDatebaseManager dataBase];
        [database creatDatabase];
    });
    return database;
}

-(void)creatDatabase
{
  
}


@end
