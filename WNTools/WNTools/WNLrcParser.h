//
//  WNLrcParser.h
//  WNTools
//
//  Created by imread on 8/11/16.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WNLrcParser : NSObject

@property (nonatomic,strong) NSMutableArray *timeArr;
@property (nonatomic,strong) NSMutableArray *lrcArr;

- (void)parserLrcWithFileURL:(NSString *)lrcPath;

@end
