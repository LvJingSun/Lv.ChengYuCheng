//
//  AppHttpClient.m
//  HuiHui
//
//  Created by mac on 13-10-14.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "AppHttpClient.h"

#import "Configuration.h"

#import "AFJSONRequestOperation.h"

@implementation AppHttpClient

+ (AppHttpClient *)sharedClient{
    
    static AppHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AppHttpClient alloc] initWithBaseURL:[NSURL URLWithString:CDHTTPRequestURL]];
    });
    
    return _sharedClient;

}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"text/plain"];//text/plain
    
    return self;
}

- (void)request:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedClient];
    [httpClient postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"Error params:%@, reason:%@", parameters, error.description);
            if (failure) {
                failure(error);
            }
            return;
        }
        NSLog(@"Success params:%@ result:%@", parameters, json);
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error params:%@, reason:%@", parameters, error.description);
        if (failure) {
            failure(error);
        }
        
    }];
}

- (void)multiRequest:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedClient];
    NSMutableURLRequest* multiRequest = [httpClient multipartFormRequestWithMethod:@"POST" path:path parameters:parameters constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        NSEnumerator *keys = files.keyEnumerator;
        for (NSString *key in keys) {
            [formData appendPartWithFileData:[files objectForKey:key] name:key fileName:[NSString stringWithFormat:@"%@.jpg", key] mimeType:@"image/jpg"];
            //[formData appendPartWithFormData:[files objectForKey:key] name:key];
        }
    }];
    NSDictionary *info = [multiRequest allHTTPHeaderFields];
    for (NSString *key in info.keyEnumerator) {
        NSLog(@"%@=%@",key, [info objectForKey:key]);
    }
    
	AFHTTPRequestOperation *operation = [httpClient HTTPRequestOperationWithRequest:multiRequest success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"Error params:%@, reason:%@", parameters, error.description);
            if (failure) {
                failure(error);
            }
            return;
        }
        NSLog(@"Success params:%@ result:%@", parameters, json);
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error params:%@, reason:%@", parameters, error.description);
        if (failure) {
            failure(error);
        }
        
    }];
    [self enqueueHTTPRequestOperation:operation];
}


@end
