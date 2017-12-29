//
//  HL_CommitPromoterFrame.m
//  HuiHui
//
//  Created by mac on 2017/12/19.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_CommitPromoterFrame.h"
#import "HL_CommitPromoterModel.h"
#import "LJConst.h"

@implementation HL_CommitPromoterFrame

-(void)setModel:(HL_CommitPromoterModel *)model {
    
    _model = model;
    
    CGFloat phoneX = 0;
    
    CGFloat phoneY = 30;
    
    CGFloat phoneW = _WindowViewWidth;
    
    CGFloat phoneH = 50;
    
    _phoneF = CGRectMake(phoneX, phoneY, phoneW, phoneH);
    
    CGFloat lineX = _WindowViewWidth * 0.05;
    
    CGFloat lineY = CGRectGetMaxY(_phoneF) - 1;
    
    CGFloat lineW = _WindowViewWidth * 0.9;
    
    CGFloat lineH = 1;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat countX = 0;
    
    CGFloat countY = CGRectGetMaxY(_phoneF);
    
    CGFloat countW = _WindowViewWidth;
    
    CGFloat countH = phoneH;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat sureX = 0;
    
    CGFloat sureY = CGRectGetMaxY(_countF) + 100;
    
    CGFloat sureW = _WindowViewWidth;
    
    CGFloat sureH = 50;
    
    _sureF = CGRectMake(sureX, sureY, sureW, sureH);
    
    _height = CGRectGetMaxY(_sureF);
    
}

@end
