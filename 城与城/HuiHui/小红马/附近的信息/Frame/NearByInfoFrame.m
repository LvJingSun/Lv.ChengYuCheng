//
//  NearByInfoFrame.m
//  HuiHui
//
//  Created by mac on 2017/6/29.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "NearByInfoFrame.h"
#import "NearByInfoModel.h"
#import "RedHorseHeader.h"

@implementation NearByInfoFrame

-(void)setInfoModel:(NearByInfoModel *)infoModel {

    _infoModel = infoModel;
    
    CGFloat iconX = ScreenWidth * 0.05;
    
    CGFloat iconY = 15;
    
    CGFloat iconW = 45;
    
    CGFloat iconH = iconW;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat nameX = CGRectGetMaxX(_iconF) + 10;
    
    CGFloat nameY = iconY;
    
    CGFloat nameW = ScreenWidth * 0.968 - nameX - 40;
    
    CGFloat nameH = 20;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat addX = nameX;
    
    CGFloat addY = CGRectGetMaxY(_nameF) + 10;
    
    CGFloat addW = nameW;
    
    CGFloat addH = 15;
    
    _addressF = CGRectMake(addX, addY, addW, addH);
    
    CGFloat lineX = ScreenWidth * 0.05;
    
    CGFloat lineY = CGRectGetMaxY(_iconF) + iconY;
    
    CGFloat lineW = ScreenWidth * 0.95;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
    CGFloat daoX = ScreenWidth * 0.968 - 40;
    
    CGFloat daoW = 30;
    
    CGFloat daoH = daoW;
    
    CGFloat daoY = (_height - daoW) * 0.5;
    
    _daohangF = CGRectMake(daoX, daoY, daoW, daoH);
    
}

@end
