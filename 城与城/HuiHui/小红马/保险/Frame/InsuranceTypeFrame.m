//
//  InsuranceTypeFrame.m
//  HuiHui
//
//  Created by mac on 2017/6/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "InsuranceTypeFrame.h"
#import "InsuranceTypeModel.h"
#import "RedHorseHeader.h"

@implementation InsuranceTypeFrame

-(void)setTypemodel:(InsuranceTypeModel *)typemodel {

    _typemodel = typemodel;
    
    CGFloat viewWidth = ScreenWidth * 0.6 * 0.9;
    
    CGFloat nameX = viewWidth * 0.05;
    
    CGFloat nameY = 5;
    
    CGFloat nameW = viewWidth - 15 - nameX - 10;
    
    CGFloat nameH = 30;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    _lineF = CGRectMake(0, CGRectGetMaxY(_nameF) + 5, viewWidth, 1);
    
    CGFloat iconX = CGRectGetMaxX(_nameF);
    
    CGFloat iconW = 15;
    
    CGFloat iconH = iconW;
    
    CGFloat iconY = (CGRectGetMaxY(_lineF) - iconH) * 0.5;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
