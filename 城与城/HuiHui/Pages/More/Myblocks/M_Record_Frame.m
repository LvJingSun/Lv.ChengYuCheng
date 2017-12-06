//
//  M_Record_Frame.m
//  HuiHui
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "M_Record_Frame.h"
#import "M_Record_Model.h"
#import "LJConst.h"

@implementation M_Record_Frame

-(void)setRecordModel:(M_Record_Model *)recordModel {
    
    _recordModel = recordModel;
    
    CGFloat typeX = _WindowViewWidth * 0.05;
    
    CGFloat typeY = 10;
    
    CGFloat typeW = _WindowViewWidth * 0.45;
    
    CGFloat typeH = 20;
    
    _typeF = CGRectMake(typeX, typeY, typeW, typeH);
    
    CGFloat dateX = typeX;
    
    CGFloat dateY = CGRectGetMaxY(_typeF) + 5;
    
    CGFloat dateW = typeW;
    
    CGFloat dateH = 10;
    
    _dateF = CGRectMake(dateX, dateY, dateW, dateH);
    
    CGFloat countX = _WindowViewWidth * 0.5;
    
    CGFloat countY = typeY;
    
    CGFloat countW = _WindowViewWidth * 0.45;
    
    CGFloat countH = 35;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_dateF) + 9.5;
    
    CGFloat lineW = _WindowViewWidth;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
