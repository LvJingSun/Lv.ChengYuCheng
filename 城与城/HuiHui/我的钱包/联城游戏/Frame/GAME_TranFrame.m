//
//  GAME_TranFrame.m
//  HuiHui
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GAME_TranFrame.h"
#import "LJConst.h"
#import "GAME_TranModel.h"

@implementation GAME_TranFrame

-(void)setTranmodel:(GAME_TranModel *)tranmodel {

    _tranmodel = tranmodel;
    
    CGFloat typeX = _WindowViewWidth * 0.05;
    
    CGFloat typeY = 15;
    
    CGFloat typeW = _WindowViewWidth * 0.55;
    
    CGFloat typeH = 20;
    
    _typeF = CGRectMake(typeX, typeY, typeW, typeH);
    
    CGFloat countX = CGRectGetMaxX(_typeF);
    
    CGFloat countY = typeY;
    
    CGFloat countW = _WindowViewWidth * 0.35;
    
    CGFloat countH = typeH;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat dateX = typeX;
    
    CGFloat dateY = CGRectGetMaxY(_typeF) + 5;
    
    CGFloat dateW = typeW;
    
    CGFloat dateH = 10;
    
    _dateF = CGRectMake(dateX, dateY, dateW, dateH);
    
    CGFloat statusX = countX;
    
    CGFloat statusY = dateY;
    
    CGFloat statusW = countW;
    
    CGFloat statusH = dateH;
    
    _statusF = CGRectMake(statusX, statusY, statusW, statusH);
    
    CGFloat lineX = _WindowViewWidth * 0.05;
    
    CGFloat lineY = CGRectGetMaxY(_statusF) + typeY;
    
    CGFloat lineW = _WindowViewWidth * 0.95;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
