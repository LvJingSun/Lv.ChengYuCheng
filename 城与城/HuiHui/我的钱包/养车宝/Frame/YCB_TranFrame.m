//
//  YCB_TranFrame.m
//  HuiHui
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "YCB_TranFrame.h"
#import "LJConst.h"
#import "YCB_TranModel.h"

@implementation YCB_TranFrame

-(void)setTranmodel:(YCB_TranModel *)tranmodel {

    _tranmodel = tranmodel;
    
    CGFloat typeX = _WindowViewWidth * 0.05;
    
    CGFloat typeY = 15;
    
    CGFloat typeW = _WindowViewWidth * 0.45;
    
    CGFloat typeH = 20;
    
    _typeF = CGRectMake(typeX, typeY, typeW, typeH);
    
    CGFloat countX = _WindowViewWidth * 0.5;
    
    CGFloat countY = typeY;
    
    CGFloat countW = typeW;
    
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
