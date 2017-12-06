//
//  MerchantGetFrame.m
//  HuiHui
//
//  Created by mac on 2017/7/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "MerchantGetFrame.h"
#import "LJConst.h"
#import "MerchantGetModel.h"

@implementation MerchantGetFrame

-(void)setDetailModel:(MerchantGetModel *)detailModel {

    _detailModel = detailModel;
    
    CGFloat nameX = _WindowViewWidth * 0.05;
    
    CGFloat nameY = 10;
    
    CGFloat nameW = _WindowViewWidth * 0.6 - nameX;
    
    CGFloat nameH = 25;
    
    _goodF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat dateX = nameX;
    
    CGFloat dateY = CGRectGetMaxY(_goodF);
    
    CGFloat dateW = nameW;
    
    CGFloat dateH = 15;
    
    _dateF = CGRectMake(dateX, dateY, dateW, dateH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_dateF) + 9.5;
    
    CGFloat lineW = _WindowViewWidth;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
    CGFloat countX = CGRectGetMaxX(_goodF);
    
    CGFloat countH = 30;
    
    CGFloat countW = _WindowViewWidth * 0.95 - countX;
    
    CGFloat countY = (_height - countH) * 0.5;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
}

@end
