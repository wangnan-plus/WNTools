//
//  WNHttpServer.m
//  WNTools
//
//  Created by imread on 7/11/16.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import "WNHttpServer.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <CFNetwork/CFNetwork.h>

@implementation WNHttpServer


+(WNHttpServer *)shareHttpServer
{
    static WNHttpServer *httpServer;
    static dispatch_once_t onceTken;
    dispatch_once(&onceTken, ^{
        httpServer = [[WNHttpServer alloc]init];
    });
    return httpServer;
}


-(void)startAsyncSocket
{
   
}



-(void)start
{
    int error = -1;
    
    int socketid =socket(AF_INET, SOCK_STREAM, 0);
    BOOL success = (socketid !=-1);
    
    if (success)
    {
        NSLog(@"socket 创建成功");
        struct sockaddr_in addr;
        memset(&addr, 0, sizeof(addr));
        // 指定socket地址长度
        addr.sin_len = sizeof(addr);
        
        // 指定网络协议，比如这里使用的是TCP/UDP则指定为AF_INET
        addr.sin_family = AF_INET;
        
        // 指定端口号
        addr.sin_port = htons(1024);
        
        // 指定监听的ip，指定为INADDR_ANY时，表示监听所有的ip
        addr.sin_addr.s_addr = INADDR_ANY;
        
        // 绑定套接字
        error = bind(socketid, (const struct sockaddr *)&addr, sizeof(addr));
        success = (error == 0);
    }
    if (success) {
        NSLog(@"bind server socket success");
        error = listen(socketid, 5);
        success = (error == 0);
    }
    
    if (success)
    {
        NSLog(@"listen server socket success");
        
        while (true)
        {
            // p2p
            struct sockaddr_in peerAddr;
            int peerSocketId;
            socklen_t addrLen = sizeof(peerAddr);
            
            // 第四步：等待客户端连接
            // 服务器端等待从编号为serverSocketId的Socket上接收客户连接请求
            peerSocketId = accept(socketid, (struct sockaddr *)&peerAddr, &addrLen);
            success = (peerSocketId != -1);
            
            if (success)
            {
                NSLog(@"accept server socket success,remote address:%s,port:%d",
                      inet_ntoa(peerAddr.sin_addr),
                      ntohs(peerAddr.sin_port));
                char buf[1024];
                size_t len = sizeof(buf);
                
                // 第五步：接收来自客户端的信息
                // 当客户端输入exit时才退出
                do
                {
                    // 接收来自客户端的信息
                    recv(peerSocketId, buf, len, 0);
                    if (strlen(buf) != 0)
                    {
                        NSString *str = [NSString stringWithCString:buf encoding:NSUTF8StringEncoding];
                        if (str.length >= 1)
                        {
                            NSLog(@"received message from client：%@",str);
                        }
                    }
                } while (strcmp(buf, "exit") != 0);
                
                NSLog(@"收到exit信号，本次socket通信完毕");
                
                // 第六步：关闭socket
                close(peerSocketId);
            }
        }
    }
    
    
}

@end
