//
//  RH_ChildCarFrame.m
//  HuiHui
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_ChildCarFrame.h"
#import "RH_CarBrandModel.h"
#import "RedHorseHeader.h"

@implementation RH_ChildCarFrame

-(void)setBrandmodel:(RH_CarBrandModel *)brandmodel {
    
    _brandmodel = brandmodel;
    
    CGFloat titleX = ScreenWidth * 0.1;
    
    CGFloat titleH = 30;
    
    CGFloat titleY = 10;
    
    CGFloat titleW = ScreenWidth * 0.6 - titleX;

    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat lineX = ScreenWidth * 0.05;
    
    CGFloat lineY = CGRectGetMaxY(_titleF) + titleY;
    
    CGFloat lineW = ScreenWidth * 0.65;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
