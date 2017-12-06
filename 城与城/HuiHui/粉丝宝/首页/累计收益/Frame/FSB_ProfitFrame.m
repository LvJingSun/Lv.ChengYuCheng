//
//  FSB_ProfitFrame.m
//  HuiHui
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_ProfitFrame.h"
#import "FSB_ProfitModel.h"
#import "LJConst.h"

@implementation FSB_ProfitFrame

-(void)setProfitModel:(FSB_ProfitModel *)profitModel {

    _profitModel = profitModel;
    
    CGFloat dateX = _WindowViewWidth * 0.05;
    
    CGFloat dateY = 10;
    
    CGFloat dateW = _WindowViewWidth * 0.45;
    
    CGFloat dateH = 20;
    
    _TypeF = CGRectMake(dateX, dateY, dateW, dateH);
    
    CGFloat typeX = dateX;
    
    CGFloat typeY = CGRectGetMaxY(_TypeF) + 10;
    
    CGFloat typeW = dateW;
    
    CGFloat typeH = dateH;
    
    _DateF = CGRectMake(typeX, typeY, typeW, typeH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_DateF) + 9.5;
    
    CGFloat lineW = _WindowViewWidth;
    
    CGFloat lineH = 0.5;
    
    _LineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_LineF);
    
    CGFloat proX = _WindowViewWidth * 0.5;
    
    CGFloat proH = 40;
    
    CGFloat proY = (_height - proH) * 0.5;
    
    CGFloat proW = _WindowViewWidth * 0.45;

    _ProfitF = CGRectMake(proX, proY, proW, proH);
    
}

@end
