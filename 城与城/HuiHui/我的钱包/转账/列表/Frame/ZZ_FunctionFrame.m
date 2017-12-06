//
//  ZZ_FunctionFrame.m
//  HuiHui
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "ZZ_FunctionFrame.h"
#import "ZZ_FunctionModel.h"
#import "RedHorseHeader.h"

@implementation ZZ_FunctionFrame

-(void)setFunctionModel:(ZZ_FunctionModel *)functionModel {

    _functionModel = functionModel;
    
    CGFloat iconX = ScreenWidth * 0.05;
    
    CGFloat iconY = 10;
    
    CGFloat iconW = 45;
    
    CGFloat iconH = iconW;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    _height = CGRectGetMaxY(_iconF) + iconY;
    
    CGFloat nameX = CGRectGetMaxX(_iconF) + iconX;
    
    CGFloat nameH = 30;
    
    CGFloat nameY = (_height - nameH) * 0.5;
    
    CGFloat nameW = ScreenWidth * 0.95 - nameX;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat lineX = nameX;
    
    CGFloat lineH = 0.5;
    
    CGFloat lineY = _height - lineH;
    
    CGFloat lineW = ScreenWidth - lineX;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
}

@end
