//
//  HttpClientRequest.m
//  CashierDeskIphone
//
//  Created by Steven.lv on 13-9-1.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "Configuration.h"
#import "HttpClientRequest.h"
#import "AFJSONRequestOperation.h"
static HttpClientRequest* _sharedHttpClient = nil;

@implementation HttpClientRequest
+(HttpClientRequest*)sharedInstance
{
    if (_sharedHttpClient == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedHttpClient = [[HttpClientRequest alloc]initWithBaseURL:[NSURL URLWithString:CDHTTPRequestURL]];
        });
    }
    return _sharedHttpClient;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    //设置头域
    [self setDefaultHeader:@"Accept" value:@"text/plain"];
    return self;
}

-(void)request:(NSString *)path parameters:(NSDictionary *)parameters successed:(void (^)(JSONDecoder *json,id responseObject))successed failured:(void (^)(NSError *error))failure
{
    HttpClientRequest* request = [HttpClientRequest sharedInstance];
    [request postPath:path parameters:parameters success:^(AFHTTPRequestOperation* operation,id responseObject){
        JSONDecoder* json = [[JSONDecoder alloc]init];
        if (successed) {
            successed(json,responseObject);
        }
    } failure:^(AFHTTPRequestOperation* operation,NSError* error){
        if (failure) {
            failure(error);
        }
     NSLog(@"Error:%@",parameters);
    }];
}

-(void)multipartFormRequest:(NSString*)path parameter:(NSDictionary*)parameters file:(NSDictionary*)files successed:(void(^)(JSONDecoder* json,id responseObject))successed failured:(void(^)(NSError* error))failured
{
    HttpClientRequest* RequestClient = [HttpClientRequest sharedInstance];
    NSMutableURLRequest* multiRequest = [RequestClient multipartFormRequestWithMethod:@"POST" path:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>formData){
        NSEnumerator* keys = files.keyEnumerator;
        for (NSString* key in keys) {
            [formData appendPartWithFileData:[files objectForKey:key] name:key fileName:[NSString stringWithFormat:@"%@.jpg",key] mimeType:@"image/jpg"];
        }
    }];
    NSDictionary* info = [multiRequest allHTTPHeaderFields];
    for (NSString* key in info.keyEnumerator) {
        NSLog(@"key=%@,object=%@",key,[info objectForKey:key]);
    }
    
    AFHTTPRequestOperation* operation = [RequestClient HTTPRequestOperationWithRequest:multiRequest success:^(AFHTTPRequestOperation* operation,id responseObject){
        JSONDecoder* json = [[JSONDecoder alloc]init];
        if (successed) {
            successed(json,responseObject);
        }
    } failure:^(AFHTTPRequestOperation* operation,NSError* error){
        if (failured) {
            failured(error);
        }
    }];
    
    [self enqueueHTTPRequestOperation:operation];
}

@end
