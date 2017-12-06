//
//  AppHttpClient.m
//  bazhifuApp
//
//  Created by mac on 13-6-8.
//  Copyright (c) 2013Âπ?mac. All rights reserved.
//

#import "AppHttpClient.h"
#import "AFJSONRequestOperation.h"

//222.191.251.180:8010 test    221.228.197.77:8010  zhengshi
//APP_API
static NSString * const kAFAppDotNetAPIBaseURLString = @"http://221.228.197.77:8010/HuiHuiApple/";

//APP_CityPay
static NSString * const kAFAppCityPayNetAPIBaseURLString = @"http://221.228.197.77:8010/CityPay/";
//空间
static NSString * const kAFAppSpaceDotNetAPIBaseURLString = @"http://221.228.197.77:8010/HuiHuiSpace/";

//携程   221.228.197.77:8013/  正式   222.191.251.180:8019/ 测试
static NSString * const kAFAppCtripDotNetAPIBaseURLString = @"http://221.228.197.77:8013/";

//去哪儿    221.228.197.77:8012 正式   222.191.251.180:8018 测试
static NSString * const kAFAppFlightsDotNetAPIBaseURLString = @"http://221.228.197.77:8012/";

// 同城景点门票   221.228.197.77:8014 正式   222.191.251.180:8020 测试
static NSString * const kAFAppSceneryDotNetAPIBaseURLString = @"http://221.228.197.77:8014/";

//虎啦游戏
static NSString * const kAFAppHuLaGameNetAPIBaseURLString = @"http://221.228.197.77:8010/HLChess/";


//大众点评
//222.191.251.180:8022测试    221.228.197.77:8015/DianPing
static NSString * const kAFAppDPDotNetAPIBaseURLString = @"http://221.228.197.77:8015/DianPing/";

//游戏
static NSString * const kAFAppGameDotNetAPIBaseURLString = @"http://221.228.197.77:8010/Game/";

//绿生网
static NSString * const kAFAppGreenDotNetAPIBaseURLString = @"http://221.228.197.77:8010/CGLN/";

//小红马
static NSString * const kAFAppHorseDotNetAPIBaseURLString = @"http://221.228.197.77:8010/RedHorse/";

//奖励金
static NSString * const kAFAppBonusDotNetAPIBaseURLString = @"http://221.228.197.77:8010/Bonus/";

//聚合电影票
static NSString * const kAFAppFilmDotNetAPIBaseURLString = @"http://v.juhe.cn/wepiao/";

//聚合数据 手机充值
static NSString * const kAFAppBillRechargeDotNetAPIBaseURLString = @"http://op.juhe.cn/ofpay/mobile/";

//城与城后台 手机充值
static NSString * const kAFAppHuiHuiRechargeDotNetAPIBaseURLString = @"http://221.228.197.77:8010/ExtensionBusiness/";

//请求协议
static NSString * const kAFAppExtensionDotNetAPIBaseURLString = @"http://221.228.197.77:8010/ExtensionBusiness/";


@implementation AppHttpClient


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

//话费充值 城与城后台接口
+ (AppHttpClient *)sharedHuiHuiRecharge {
    static AppHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AppHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppHuiHuiRechargeDotNetAPIBaseURLString]];
    });
    return _sharedClient;
}

//话费充值 城与城后台接口
- (void)HuiHuiRechargeRequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedHuiHuiRecharge];
    [httpClient postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

//请求协议
+ (AppHttpClient *)sharedExtension {
    static AppHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AppHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppExtensionDotNetAPIBaseURLString]];
    });
    return _sharedClient;
}

//协议
- (void)ExtensionRequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedExtension];
    [httpClient postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

//话费充值
+ (AppHttpClient *)sharedBillRecharge {
    static AppHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AppHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppBillRechargeDotNetAPIBaseURLString]];
    });
    return _sharedClient;
}

//话费充值
- (void)billRechargeRequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedBillRecharge];
    [httpClient postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

//诲诲APPle
+ (AppHttpClient *)sharedClient {
    static AppHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AppHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppDotNetAPIBaseURLString]];
    });
    return _sharedClient;
}

//诲诲CityPay
+ (AppHttpClient *)sharedCityPay {
    static AppHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AppHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppCityPayNetAPIBaseURLString]];
    });
    return _sharedClient;
}

//诲诲空间
+ (AppHttpClient *)sharedSpace {
    static AppHttpClient *_sharedSpace  = nil;
    static dispatch_once_t onceTokenSpace;
    dispatch_once(&onceTokenSpace, ^{
        _sharedSpace  = [[AppHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppSpaceDotNetAPIBaseURLString]];
    });
    return _sharedSpace ;
}

//诲诲-携程
+ (AppHttpClient *)sharedCtrip {
    static AppHttpClient *_sharedCtrip  = nil;
    static dispatch_once_t onceTokenCtrip;
    dispatch_once(&onceTokenCtrip, ^{
        _sharedCtrip  = [[AppHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppCtripDotNetAPIBaseURLString]];
    });
    return _sharedCtrip ;
}

//诲诲-大众点评
+ (AppHttpClient *)sharedDP {
    static AppHttpClient *_sharedDP  = nil;
    static dispatch_once_t onceTokenDP;
    dispatch_once(&onceTokenDP, ^{
        _sharedDP  = [[AppHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppDPDotNetAPIBaseURLString]];
    });
    return _sharedDP ;
}

+ (AppHttpClient *)sharedHuLa {
    
    static AppHttpClient *_sharedHula  = nil;
    static dispatch_once_t onceTokenCtrip;
    dispatch_once(&onceTokenCtrip, ^{
        _sharedHula  = [[AppHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppHuLaGameNetAPIBaseURLString]];
    });
    return _sharedHula;
    
}
- (void)HuLarequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    
    AFHTTPClient* httpClient = [AppHttpClient sharedHuLa];
    [httpClient postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
}


//诲诲APPle
- (void)request:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedClient];
    [httpClient postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
                
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

+ (AppHttpClient *) sharedGreen {
    
    static AppHttpClient *_sharedGreen = nil;
    static dispatch_once_t onceTokenGreen;
    dispatch_once(&onceTokenGreen, ^{
        _sharedGreen  = [[AppHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppGreenDotNetAPIBaseURLString]];
    });
    return _sharedGreen ;
    
}
- (void)Greenrequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    
    AFHTTPClient* httpClient = [AppHttpClient sharedGreen];
    [httpClient postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
}

//诲诲-游戏
+ (AppHttpClient *)sharedGame {
    static AppHttpClient *_sharedGame = nil;
    static dispatch_once_t onceTokenGame;
    dispatch_once(&onceTokenGame, ^{
        _sharedGame  = [[AppHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppGameDotNetAPIBaseURLString]];
    });
    return _sharedGame ;
}

//游戏 sharedGame
- (void)gamerequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedGame];
    [httpClient postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

+ (AppHttpClient *)sharedBonus {

    static AppHttpClient *_sharedBonus = nil;
    static dispatch_once_t onceTokenBonus;
    dispatch_once(&onceTokenBonus, ^{
        _sharedBonus  = [[AppHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppBonusDotNetAPIBaseURLString]];
    });
    return _sharedBonus ;
    
}
- (void)Bonusrequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {

    AFHTTPClient* httpClient = [AppHttpClient sharedBonus];
    [httpClient postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
}

//诲诲-小红马
+ (AppHttpClient *)sharedRedHorse {
    static AppHttpClient *_sharedGame = nil;
    static dispatch_once_t onceTokenGame;
    dispatch_once(&onceTokenGame, ^{
        _sharedGame  = [[AppHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppHorseDotNetAPIBaseURLString]];
    });
    return _sharedGame ;
}

//小红马 sharedRedHorse
- (void)horserequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedRedHorse];
    [httpClient postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

//小红马上传图片和参数
- (void)horsemultiRequest:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedRedHorse];
    NSMutableURLRequest* multiRequest = [httpClient multipartFormRequestWithMethod:@"POST" path:path parameters:parameters constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        NSEnumerator *keys = files.keyEnumerator;
        for (NSString *key in keys) {
            [formData appendPartWithFileData:[files objectForKey:key] name:key fileName:[NSString stringWithFormat:@"%@.jpg", key] mimeType:@"image/jpg"];
        }
    }];
    
    AFHTTPRequestOperation *operation = [httpClient HTTPRequestOperationWithRequest:multiRequest success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    [self enqueueHTTPRequestOperation:operation];
}


//诲诲-电影
+ (AppHttpClient *)sharedFilm {
    static AppHttpClient *_sharedFilm = nil;
    static dispatch_once_t onceTokenFilm;
    dispatch_once(&onceTokenFilm, ^{
        _sharedFilm  = [[AppHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppFilmDotNetAPIBaseURLString]];
    });
    return _sharedFilm ;
}

//电影 sharedFilm
- (void)filmrequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedFilm];
    [httpClient postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

- (void)requestCityPay:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {

    AFHTTPClient* httpClient = [AppHttpClient sharedCityPay];
    [httpClient postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
}
- (void)multiRequestCityPay:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {

    AFHTTPClient* httpClient = [AppHttpClient sharedCityPay];
    NSMutableURLRequest* multiRequest = [httpClient multipartFormRequestWithMethod:@"POST" path:path parameters:parameters constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        NSEnumerator *keys = files.keyEnumerator;
        for (NSString *key in keys) {
            [formData appendPartWithFileData:[files objectForKey:key] name:key fileName:[NSString stringWithFormat:@"%@.jpg", key] mimeType:@"image/jpg"];
        }
    }];
    
    AFHTTPRequestOperation *operation = [httpClient HTTPRequestOperationWithRequest:multiRequest success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    [self enqueueHTTPRequestOperation:operation];
    
}

- (void)multiRequest:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedClient];
    NSMutableURLRequest* multiRequest = [httpClient multipartFormRequestWithMethod:@"POST" path:path parameters:parameters constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        NSEnumerator *keys = files.keyEnumerator;
        for (NSString *key in keys) {
            [formData appendPartWithFileData:[files objectForKey:key] name:key fileName:[NSString stringWithFormat:@"%@.jpg", key] mimeType:@"image/jpg"];
        }
    }];
    
	AFHTTPRequestOperation *operation = [httpClient HTTPRequestOperationWithRequest:multiRequest success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    [self enqueueHTTPRequestOperation:operation];
}



//空间
- (void)requestSpace:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedSpace];
    [httpClient postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

- (void)multiRequestSpace:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedSpace];
    NSMutableURLRequest* multiRequest = [httpClient multipartFormRequestWithMethod:@"POST" path:path parameters:parameters constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        NSEnumerator *keys = files.keyEnumerator;
        for (NSString *key in keys) {
            [formData appendPartWithFileData:[files objectForKey:key] name:key fileName:[NSString stringWithFormat:@"%@.jpg", key] mimeType:@"image/jpg"];
        }
    }];
	AFHTTPRequestOperation *operation = [httpClient HTTPRequestOperationWithRequest:multiRequest success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    [self enqueueHTTPRequestOperation:operation];
}





//诲诲-携程
- (void)requestCtrip:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedCtrip];
    [httpClient postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

- (void)multiRequestCtrip:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedCtrip];
    NSMutableURLRequest* multiRequest = [httpClient multipartFormRequestWithMethod:@"POST" path:path parameters:parameters constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        NSEnumerator *keys = files.keyEnumerator;
        for (NSString *key in keys) {
            [formData appendPartWithFileData:[files objectForKey:key] name:key fileName:[NSString stringWithFormat:@"%@.jpg", key] mimeType:@"image/jpg"];
        }
    }];
	AFHTTPRequestOperation *operation = [httpClient HTTPRequestOperationWithRequest:multiRequest success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    [self enqueueHTTPRequestOperation:operation];
}



//诲诲APPle - 机票
+ (AppHttpClient *)sharedClient1 {
    static AppHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AppHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppFlightsDotNetAPIBaseURLString]];
    });
    return _sharedClient;
}

//诲诲APPle - 机票
- (void)requestFlights:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedClient1];
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

// - 机票
- (void)multiRequestFlights:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedClient1];
    NSMutableURLRequest* multiRequest = [httpClient multipartFormRequestWithMethod:@"POST" path:path parameters:parameters constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        NSEnumerator *keys = files.keyEnumerator;
        for (NSString *key in keys) {
            [formData appendPartWithFileData:[files objectForKey:key] name:key fileName:[NSString stringWithFormat:@"%@.jpg", key] mimeType:@"image/jpg"];
            //[formData appendPartWithFormData:[files objectForKey:key] name:key];
        }
    }];
    //    NSDictionary *info = [multiRequest allHTTPHeaderFields];
    //    for (NSString *key in info.keyEnumerator) {
    //        NSLog(@"%@=%@",key, [info objectForKey:key]);
    //    }
    
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



//诲诲APPle - 景点门票
+ (AppHttpClient *)scenerySharedClient {
    static AppHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AppHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppSceneryDotNetAPIBaseURLString]];
    });
    return _sharedClient;
}

//诲诲APPle - 景点门票
- (void)requestScenery:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient scenerySharedClient];
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

// - 景点门票
- (void)multiRequestScenery:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient scenerySharedClient];
    NSMutableURLRequest* multiRequest = [httpClient multipartFormRequestWithMethod:@"POST" path:path parameters:parameters constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        NSEnumerator *keys = files.keyEnumerator;
        for (NSString *key in keys) {
            [formData appendPartWithFileData:[files objectForKey:key] name:key fileName:[NSString stringWithFormat:@"%@.jpg", key] mimeType:@"image/jpg"];
            //[formData appendPartWithFormData:[files objectForKey:key] name:key];
        }
    }];
    //    NSDictionary *info = [multiRequest allHTTPHeaderFields];
    //    for (NSString *key in info.keyEnumerator) {
    //        NSLog(@"%@=%@",key, [info objectForKey:key]);
    //    }
    
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



// get方法请求
- (void)getRequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedClient];
//    [httpClient postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
    
    [httpClient getPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {

        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"Error params:%@, reason:%@", parameters, error.description);
            if (failure) {
                failure(error);
            }
            return;
        }
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

//大众点评
- (void)requestDP:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedDP];
    [httpClient postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

- (void)multiRequestDP:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedDP];
    NSMutableURLRequest* multiRequest = [httpClient multipartFormRequestWithMethod:@"POST" path:path parameters:parameters constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        NSEnumerator *keys = files.keyEnumerator;
        for (NSString *key in keys) {
            [formData appendPartWithFileData:[files objectForKey:key] name:key fileName:[NSString stringWithFormat:@"%@.jpg", key] mimeType:@"image/jpg"];
        }
    }];
    AFHTTPRequestOperation *operation = [httpClient HTTPRequestOperationWithRequest:multiRequest success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    [self enqueueHTTPRequestOperation:operation];
}


@end
