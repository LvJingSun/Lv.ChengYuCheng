//
//  RH_Get_RecordFrame.m
//  HuiHui
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_Get_RecordFrame.h"
#import "RedHorseHeader.h"
#import "RH_Get_RecordModel.h"

@implementation RH_Get_RecordFrame

-(void)setGetModel:(RH_Get_RecordModel *)getModel {

    _getModel = getModel;
    
    CGFloat dateX = ScreenWidth * 0.05;
    
    CGFloat dateY = 10;
    
    CGFloat dateW = ScreenWidth * 0.45;
    
    CGFloat dateH = 20;
    
    _TypeF = CGRectMake(dateX, dateY, dateW, dateH);
    
    CGFloat typeX = dateX;
    
    CGFloat typeY = CGRectGetMaxY(_TypeF) + 10;
    
    CGFloat typeW = dateW;
    
    CGFloat typeH = dateH;
    
    _DateF = CGRectMake(typeX, typeY, typeW, typeH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_DateF) + 9.5;
    
    CGFloat lineW = ScreenWidth;
    
    CGFloat lineH = 0.5;
    
    _LineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_LineF);
    
    CGFloat proX = ScreenWidth * 0.5;
    
    CGFloat proH = 40;
    
    CGFloat proY = (_height - proH) * 0.5;
    
    CGFloat proW = ScreenWidth * 0.45;
    
    _ProfitF = CGRectMake(proX, proY, proW, proH);
    
}

@end
