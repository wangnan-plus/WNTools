//
//  WNHttpServer.h
//  WNTools
//
//  Created by imread on 7/11/16.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WNHttpServer : NSObject



+(WNHttpServer *)shareHttpServer;
-(void)start;

@end
