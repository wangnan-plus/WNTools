//
//  WNStartUploadViewController.m
//  WNTools
//
//  Created by imread on 8/11/16.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import "WNStartUploadViewController.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>
#import "AsyncSocket.h"

#define IOS_CELLULAR @"pdp_ip0"
#define IOS_WIFI     @"en0"
#define IP_ADDR_IPv4 @"ipv4"
#define IP_ADDR_IPv6 @"ipv6"

@interface WNStartUploadViewController ()<AsyncSocketDelegate>
@property(nonatomic,strong)AsyncSocket *socketServer;
@property(nonatomic,strong)AsyncSocket *socketNew;
@property(nonatomic,assign)long fileSize;
@property(nonatomic,strong)NSMutableData *fileData;
@property(nonatomic,copy)NSString *fileName;
@property(nonatomic,assign)NSInteger fileLength;

@property(nonatomic,strong)UILabel *addressLabel;

@end

@implementation WNStartUploadViewController

-(UILabel *)addressLabel
{
    if (!_addressLabel)
    {
        self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-100, 150, 200, 40)];
        self.addressLabel.backgroundColor = [UIColor darkGrayColor];
        self.addressLabel.textAlignment = NSTextAlignmentCenter;
        self.addressLabel.textColor = [UIColor blackColor];
        
    }
    return _addressLabel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *port = @":12321";
    NSString *address = [self getIPAddress:YES];
    self.addressLabel.text=[address stringByAppendingString:port];
    [self.view addSubview:self.addressLabel];
    
    self.socketServer = [[AsyncSocket alloc]initWithDelegate:self];
     [self.socketServer acceptOnPort:12321 error:nil];
    
}

-(NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4?@[IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6]:@[IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4];
    NSDictionary *addresses = [self getIPAddresses];
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        address = addresses[obj];
        if (addresses)
        {
            *stop = YES;
        }
    }];
    return address?address:@"0.0.0.0";
}

- (NSDictionary *)getIPAddresses
{
NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];

// retrieve the current interfaces - returns 0 on success
struct ifaddrs *interfaces;
if(!getifaddrs(&interfaces))
{
    // Loop through linked list of interfaces
    struct ifaddrs *interface;
    for(interface=interfaces; interface; interface=interface->ifa_next)
    {
        if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ )
        {
            continue; // deeply nested code harder to read
        }
        const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
        char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
        if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6))
        {
            NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
            NSString *type;
            if(addr->sin_family == AF_INET)
            {
                if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN))
                {
                    type = IP_ADDR_IPv4;
                }
            } else
            {
                const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN))
                {
                    type = IP_ADDR_IPv6;
                }
            }
            if(type)
            {
                NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                addresses[key] = [NSString stringWithUTF8String:addrBuf];
            }
        }
    }
    // Free memory
    freeifaddrs(interfaces);
}
return [addresses count] ? addresses : nil;
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
    if (headerString && [headerString componentsSeparatedByString:@"&&"].count == 3)
    {
        
        NSArray *fileArray = [headerString componentsSeparatedByString:@"&&"];
        NSString *type = fileArray[0];
        if ([type isEqualToString:@"file"])
        { // 如果是文件
            
            self.fileData = [NSMutableData data];
            self.fileName = fileArray[1];
            self.fileLength = [fileArray[2] intValue];
            NSData *subData = [data subdataWithRange:NSMakeRange(50, data.length - 50)];
            [self.fileData appendData:subData];
        }else
        {
        
            
        }
    }else
    {
        
        [self.fileData appendData:data];
        
    }
    
    
    if (self.fileData.length == self.fileLength)
    {
        
        
        NSString *doucumentPath = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"upload"] stringByAppendingPathComponent:@"music"];
        NSFileManager *manager = [NSFileManager defaultManager];
        if (![manager fileExistsAtPath:doucumentPath])
        {
            [manager createDirectoryAtPath:doucumentPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        NSString *filePath = [doucumentPath stringByAppendingPathComponent:self.fileName];
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
