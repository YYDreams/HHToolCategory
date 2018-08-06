//
//  NetworkTestController.m
//  HHExtend
//
//  Created by flowerflower on 2018/4/25.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "NetworkTestController.h"
#import <AFNetworking.h>
@interface NetworkTestController ()

@end

@implementation NetworkTestController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"接口测试";
    
    [self loadDataFromNetwork];
}

-(void)xx{
    
    
    
    
}

- (void)loadDataFromNetwork{
    
    
    AFHTTPSessionManager  *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    
    //解决不接受类型为"text/html"
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/jpeg",@"image/png", nil];
    
    
    [manager GET:@"http://rapapi.org/mockjsdata/33272/AllOrder" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
        NSLog(@"error:--------------------%@",error);
    }];
    
    
}

@end
