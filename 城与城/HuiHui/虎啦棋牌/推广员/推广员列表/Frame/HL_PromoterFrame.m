//
//  HL_PromoterFrame.m
//  HuiHui
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_PromoterFrame.h"
#import "LJConst.h"
#import "HL_PromoterModel.h"

@implementation HL_PromoterFrame

-(void)setPromoterModel:(HL_PromoterModel *)promoterModel {
    
    _promoterModel = promoterModel;
    
    CGFloat iconX = _WindowViewWidth * 0.05;
    
    CGFloat iconY = 10;
    
    CGFloat iconW = 50;
    
    CGFloat iconH = iconW;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat nameX = CGRectGetMaxX(_iconF) + 15;
    
    CGFloat nameY = iconY;
    
    CGFloat nameW = _WindowViewWidth * 0.8 - nameX;
    
    CGFloat nameH = 25;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat delegateX = nameX;
    
    CGFloat delegateY = CGRectGetMaxY(_nameF) + 5;
    
    CGFloat delegateW = nameW;
    
    CGFloat delegateH = 20;
    
    _delegateF = CGRectMake(delegateX, delegateY, delegateW, delegateH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_iconF) + iconY;
    
    CGFloat lineW = _WindowViewWidth;
    
    CGFloat lineH = 1;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
    CGFloat countX = CGRectGetMaxX(_nameF);
    
    CGFloat countH = 30;
    
    CGFloat countY = (_height - countH) * 0.5;
    
    CGFloat countW = _WindowViewWidth * 0.95 - countX;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
}

@end
