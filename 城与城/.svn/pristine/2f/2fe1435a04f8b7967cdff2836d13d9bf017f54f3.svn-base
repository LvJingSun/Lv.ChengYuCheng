//
//  Ctrip_Config.m
//  HuiHui
//
//  Created by 冯海强 on 14-9-23.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "Ctrip_Config.h"

@implementation Ctrip_Config


+(NSString *)CategoryCodes:(NSString *)Code
{
    switch ([Code integerValue]) {
        case 1:
            return CategoryCodes_1;
            break;
        case 2:
            return CategoryCodes_2;
            break;
        case 3:
            return CategoryCodes_3;
            break;
        case 4:
            return CategoryCodes_4;
        case 5:
            return CategoryCodes_5;
            break;
        case 6:
            return CategoryCodes_6;
            break;
        case 7:
            return CategoryCodes_7;
            break;
        case 8:
            return CategoryCodes_8;
            break;
        case 9:
            return CategoryCodes_9;
            break;
        case 10:
            return CategoryCodes_10;
            break;
        case 11:
            return CategoryCodes_11;
            break;
        case 12:
            return CategoryCodes_12;
            break;
        case 13:
            return CategoryCodes_13;
            break;
        case 14:
            return CategoryCodes_14;
            break;
        case 15:
            return CategoryCodes_15;
            break;
        case 16:
            return CategoryCodes_16;
            break;
        case 17:
            return CategoryCodes_17;
            break;
        case 18:
            return CategoryCodes_18;
            break;
        case 19:
            return CategoryCodes_19;
            break;
        case 20:
            return CategoryCodes_20;
            break;
        case 21:
            return CategoryCodes_21;
            break;
        case 22:
            return CategoryCodes_22;
            break;
        case 23:
            return CategoryCodes_23;
            break;
            
        default:
            return nil;
            break;
    }
    
}



+(NSString *)distanceBetweenOrderBy:(float)lat1 :(float)lat2 :(float)lng1 :(float)lng2{
    double dd = M_PI/180;
    double x1=lat1*dd,x2=lat2*dd;
    double y1=lng1*dd,y2=lng2*dd;
    double R = 6371004;
    int distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    //km  返回
    //     return  distance*1000;
    if (distance>=1000) {
        return [NSString stringWithFormat:@"%dkm",distance/1000];
    }
 //返回 m
    return   [NSString stringWithFormat:@"%d米",distance];
    
}



@end
