//
//  HttpClientRequest.h
//  CashierDeskIphone
//
//  Created by Steven.lv on 13-9-1.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "AFHTTPClient.h"
#import "JSONKit.h"
@interface HttpClientRequest : AFHTTPClient
+(HttpClientRequest*)sharedInstance;
- (void)request:(NSString*)path parameters:(NSDictionary*)parameters successed:(void(^)(JSONDecoder* jsonDecoder,id responseObject))successed failured:(void(^)(NSError* error))failure;
-(void)multipartFormRequest:(NSString*)path parameter:(NSDictionary*)parameters file:(NSDictionary*)files successed:(void(^)(JSONDecoder* json,id responseObject))successed failured:(void(^)(NSError* error))failured;
@end
