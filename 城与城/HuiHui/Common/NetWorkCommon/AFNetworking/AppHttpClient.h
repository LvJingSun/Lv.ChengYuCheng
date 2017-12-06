//
//  AppHttpClient.h
//  bazhifuApp
//
//  Created by mac on 13-6-8.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface AppHttpClient : AFHTTPClient



+ (AppHttpClient *) sharedClient;
- (void)request:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;
- (void)multiRequest:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;

//绿生网
+ (AppHttpClient *) sharedGreen;
- (void)Greenrequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;

//虎啦游戏
+ (AppHttpClient *)sharedHuLa;
- (void)HuLarequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;

//奖励金
+ (AppHttpClient *)sharedBonus;
- (void)Bonusrequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;

//游戏 sharedGame
+ (AppHttpClient *)sharedGame;
- (void)gamerequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;

//话费充值
+ (AppHttpClient *)sharedBillRecharge;
- (void)billRechargeRequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;

//诲诲-小红马
+ (AppHttpClient *)sharedRedHorse;

//小红马 sharedRedHorse
- (void)horserequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;

//小红马上传图片和参数
- (void)horsemultiRequest:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;

//诲诲-电影
+ (AppHttpClient *)sharedFilm;

//电影 sharedFilm
- (void)filmrequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;

//话费充值 城与城后台接口
+ (AppHttpClient *)sharedHuiHuiRecharge;

//话费充值 城与城后台接口
- (void)HuiHuiRechargeRequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;


+ (AppHttpClient *)sharedSpace;
- (void)requestSpace:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;
- (void)multiRequestSpace:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;


//请求协议
+ (AppHttpClient *)sharedExtension;

//协议
- (void)ExtensionRequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;

+ (AppHttpClient *)sharedCtrip;
- (void)requestCtrip:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;
- (void)multiRequestCtrip:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;



//诲诲APPle - 机票
+ (AppHttpClient *)sharedClient1;
- (void)requestFlights:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;
- (void)multiRequestFlights:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;

// get请求
- (void)getRequest:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;

// 诲诲Apple-景点门票
+ (AppHttpClient *)scenerySharedClient;
- (void)requestScenery:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;
- (void)multiRequestScenery:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;


//大众点评
+ (AppHttpClient *)sharedDP;
- (void)requestDP:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;
- (void)multiRequestDP:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;

+ (AppHttpClient *)sharedCityPay;
- (void)requestCityPay:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;
- (void)multiRequestCityPay:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;


@end
