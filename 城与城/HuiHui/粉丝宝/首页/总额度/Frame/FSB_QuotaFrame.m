//
//  FSB_QuotaFrame.m
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_QuotaFrame.h"
#import "FSB_QuotaModel.h"
#import "LJConst.h"

@implementation FSB_QuotaFrame

-(void)setQuotaModel:(FSB_QuotaModel *)quotaModel {

    _quotaModel = quotaModel;
    
    CGFloat typeX = _WindowViewWidth * 0.05;
    
    CGFloat typeY = 10;
    
    CGFloat typeH = 20;
    
    CGFloat typeW = _WindowViewWidth * 0.45;
    
    _typeF = CGRectMake(typeX, typeY, typeW, typeH);
    
    CGFloat countX = _WindowViewWidth * 0.5;
    
    CGFloat countY = 10;
    
    CGFloat countW = _WindowViewWidth * 0.45;
    
    CGFloat countH = 20;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat dateX = _WindowViewWidth * 0.05;
    
    CGFloat dateY = CGRectGetMaxY(_typeF) + 5;
    
    CGFloat dateW = _WindowViewWidth * 0.45;
    
    CGFloat dateH = 20;
    
    _dateF = CGRectMake(dateX, dateY, dateW, dateH);
    
    CGFloat shopX = _WindowViewWidth * 0.5;
    
    CGFloat shopY = dateY;
    
    CGFloat shopW = dateW;
    
    CGFloat shopH = dateH;
    
    _shopF = CGRectMake(shopX, shopY, shopW, shopH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_shopF) + 9.5;
    
    CGFloat lineW = _WindowViewWidth;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
