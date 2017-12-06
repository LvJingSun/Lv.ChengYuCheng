//
//  RH_CarBrandFrame.m
//  HuiHui
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_CarBrandFrame.h"
#import "RH_CarBrandModel.h"
#import "RedHorseHeader.h"

@implementation RH_CarBrandFrame

-(void)setBrandmodel:(RH_CarBrandModel *)brandmodel {

    _brandmodel = brandmodel;
    
    CGFloat iconX = ScreenWidth * 0.08;
    
    CGFloat iconY = 10;
    
    CGFloat iconW = 40;
    
    CGFloat iconH = iconW;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_iconF) + iconY;
    
    CGFloat lineW = ScreenWidth;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
    CGFloat titleX = CGRectGetMaxX(_iconF) + iconX;
    
    CGFloat titleH = 30;
    
    CGFloat titleY = iconY + (iconH - titleH) * 0.5;
    
    CGFloat titleW = ScreenWidth * 0.92 - titleX;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
}

@end
