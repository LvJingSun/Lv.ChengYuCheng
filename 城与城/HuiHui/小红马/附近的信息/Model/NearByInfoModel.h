//
//  NearByInfoModel.h
//  HuiHui
//
//  Created by mac on 2017/6/29.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearByInfoModel : NSObject

///POI名称
@property (nonatomic, strong) NSString* name;
///POIuid
@property (nonatomic, strong) NSString* uid;
///POI地址
@property (nonatomic, strong) NSString* address;
///POI所在城市
@property (nonatomic, strong) NSString* city;
///POI电话号码
@property (nonatomic, strong) NSString* phone;
///POI邮编
@property (nonatomic, strong) NSString* postcode;
///POI类型，0:普通点 1:公交站 2:公交线路 3:地铁站 4:地铁线路
@property (nonatomic) int epoitype;
///POI坐标
@property (nonatomic) CLLocationCoordinate2D pt;
///是否有全景
@property (nonatomic, assign) BOOL panoFlag;
///图片
@property (nonatomic, strong) NSString *picUrl;

@end
