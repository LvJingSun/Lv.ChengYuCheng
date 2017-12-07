//
//  GameTranFrame.m
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameTranFrame.h"
#import "LJConst.h"
#import "GameTranModel.h"

@implementation GameTranFrame

-(void)setTranModel:(GameTranModel *)tranModel {
    
    _tranModel = tranModel;
    
    CGFloat typeX = _WindowViewWidth * 0.05;
    
    CGFloat typeY = 15;
    
    CGFloat typeW = _WindowViewWidth * 0.6;
    
    CGFloat typeH = 30;
    
    _typeF = CGRectMake(typeX, typeY, typeW, typeH);
    
    CGFloat countX = CGRectGetMaxX(_typeF);
    
    CGFloat countY = 10;
    
    CGFloat countW = _WindowViewWidth * 0.3;
    
    CGFloat countH = 20;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat dateX = countX;
    
    CGFloat dateY = CGRectGetMaxY(_countF) + 5;
    
    CGFloat dateW = countW;
    
    CGFloat dateH = countH;
    
    _dateF = CGRectMake(dateX, dateY, dateW, dateH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_typeF) + typeY;
    
    CGFloat lineW = _WindowViewWidth;
    
    CGFloat lineH = 1;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
