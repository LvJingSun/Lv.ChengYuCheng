//
//  GoldPriceRecordFrame.m
//  HuiHui
//
//  Created by mac on 2017/9/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GoldPriceRecordFrame.h"
#import "RedHorseHeader.h"
#import "GoldPriceModel.h"

@implementation GoldPriceRecordFrame

-(void)setPriceModel:(GoldPriceModel *)priceModel {

    _priceModel = priceModel;
    
    CGFloat dateX = ScreenWidth * 0.05;
    
    CGFloat dateY = 10;
    
    CGFloat dateW = ScreenWidth * 0.45;
    
    CGFloat dateH = 25;
    
    _dateF = CGRectMake(dateX, dateY, dateW, dateH);
    
    CGFloat priceX = CGRectGetMaxX(_dateF);
    
    CGFloat priceY = dateY;
    
    CGFloat priceW = dateW;
    
    CGFloat priceH = dateH;
    
    _priceF = CGRectMake(priceX, priceY, priceW, priceH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_dateF) + 10;
    
    CGFloat lineW = ScreenWidth;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
