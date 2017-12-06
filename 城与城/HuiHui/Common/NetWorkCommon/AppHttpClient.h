//
//  AppHttpClient.h
//  HuiHui
//
//  Created by mac on 13-10-14.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "AFHTTPClient.h"

#import <Foundation/Foundation.h>

@interface AppHttpClient : AFHTTPClient

+ (AppHttpClient *)sharedClient;


- (void)request:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;

- (void)multiRequest:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;

@end
