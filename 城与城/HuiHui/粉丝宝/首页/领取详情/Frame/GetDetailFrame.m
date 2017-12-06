//
//  GetDetailFrame.m
//  HuiHui
//
//  Created by mac on 2017/7/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GetDetailFrame.h"
#import "LJConst.h"
#import "GetDetailModel.h"

@implementation GetDetailFrame

-(void)setDetailModel:(GetDetailModel *)detailModel {

    _detailModel = detailModel;
    
    CGFloat iconX = _WindowViewWidth * 0.05;
    
    CGFloat iconY = 10;
    
    CGFloat iconW = 40;
    
    CGFloat iconH = iconW;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat nameX = CGRectGetMaxX(_iconF) + 10;
    
    CGFloat nameY = iconY;
    
    CGFloat nameW = _WindowViewWidth * 0.6 - nameX;
    
    CGFloat nameH = 25;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat dateX = nameX;
    
    CGFloat dateY = CGRectGetMaxY(_nameF);
    
    CGFloat dateW = nameW;
    
    CGFloat dateH = 15;
    
    _dateF = CGRectMake(dateX, dateY, dateW, dateH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_dateF) + 9.5;
    
    CGFloat lineW = _WindowViewWidth;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
    CGFloat countX = CGRectGetMaxX(_nameF);
    
    CGFloat countH = 30;
    
    CGFloat countW = _WindowViewWidth * 0.95 - countX;
    
    CGFloat countY = (_height - countH) * 0.5;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
}

@end
