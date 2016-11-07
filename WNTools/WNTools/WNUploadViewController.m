//
//  WNUploadViewController.m
//  WNTools
//
//  Created by 丁乾坤 on 2016/11/5.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import "WNUploadViewController.h"
#import "WNHttpServer.h"
#import "AsyncSocket.h"

@interface WNUploadViewController ()<AsyncSocketDelegate>

@property(nonatomic,strong)AsyncSocket *socketServer;
@property(nonatomic,strong)AsyncSocket *socketNew;
@property(nonatomic,assign)long fileSize;
@property(nonatomic,strong)NSMutableData *fileData;
@property(nonatomic,copy)NSString *fileName;
@property(nonatomic,assign)NSInteger fileLength;

@end

@implementation WNUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"上传";
    
    self.socketServer = [[AsyncSocket alloc]initWithDelegate:self];
    [self.socketServer acceptOnPort:5201 error:nil];
    //[[WNHttpServer shareHttpServer]start];
}

-(void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket
{
    self.socketNew = newSocket;
}

-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
  [self.socketNew readDataWithTimeout:-1 tag:0];
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSData *headerData = [data subdataWithRange:NSMakeRange(0, 50)];
    
    NSString *headerString = [[NSString alloc] initWithData:headerData encoding:NSUTF8StringEncoding];
    if (headerString && [headerString componentsSeparatedByString:@"&&"].count == 3) {
        
        NSArray *fileArray = [headerString componentsSeparatedByString:@"&&"];
        
        NSString *type = fileArray[0];
        
        if ([type isEqualToString:@"file"]) { // 如果是文件
            
            self.fileData = [NSMutableData data];
            
            self.fileName = fileArray[1];
            
            self.fileLength = [fileArray[2] intValue];
            
            NSData *subData = [data subdataWithRange:NSMakeRange(50, data.length - 50)];
            
            [self.fileData appendData:subData];
            
        }else{
            
            
            
        }
        
    }else{
        
        [self.fileData appendData:data];
        
    }
    
    
    if (self.fileData.length == self.fileLength)
    {
        
        NSString *filePath = [@"/Users/imread/DeskTop" stringByAppendingPathComponent:self.fileName];
        
        [self.fileData writeToFile:filePath atomically:YES];
        
    }
    
    [self.socketNew readDataWithTimeout:-1 tag:0];
    
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
