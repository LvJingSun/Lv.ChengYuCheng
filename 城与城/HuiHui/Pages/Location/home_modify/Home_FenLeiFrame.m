//
//  Home_FenLeiFrame.m
//  HuiHui
//
//  Created by mac on 2017/9/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Home_FenLeiFrame.h"
#import "Home_FenLeiModel.h"
#import "RedHorseHeader.h"

@implementation Home_FenLeiFrame

-(void)setFenleiModel:(Home_FenLeiModel *)fenleiModel {

    _fenleiModel = fenleiModel;
    
    CGFloat width = (ScreenWidth - 3) * 0.25;
    
    CGFloat iconW = 50;
    
    CGFloat iconX = (width - iconW) * 0.5;
    
    CGFloat iconY = 20;
    
    CGFloat iconH = iconW;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat titleX = 0;
    
    CGFloat titleY = CGRectGetMaxY(_iconF) + 5;
    
    CGFloat titleW = width;
    
    CGFloat titleH = 20;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    _size = CGSizeMake(width, CGRectGetMaxY(_titleF) + iconY);
    
}

@end
