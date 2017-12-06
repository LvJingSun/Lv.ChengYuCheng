//
//  Life_CellFrame.m
//  HuiHui
//
//  Created by mac on 2017/6/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Life_CellFrame.h"
#import "RedHorseHeader.h"

@implementation Life_CellFrame

-(void)setCellModel:(Life_CellModel *)cellModel {

    _cellModel = cellModel;
    
    CGFloat imgX = 0;
    
    CGFloat imgY = 0;
    
    CGFloat imgW = ScreenWidth;
    
    CGFloat imgH = ScreenWidth * 0.4;
    
    _image1F = CGRectMake(imgX, imgY, imgW, imgH);
    
    CGFloat bgX = 0;
    
    CGFloat bgY = CGRectGetMaxY(_image1F);
    
    CGFloat bgW = ScreenWidth;
    
    CGFloat bgH = 20;
    
    _titleBGF = CGRectMake(bgX, bgY, bgW, bgH);
    
    CGFloat titleX = ScreenWidth * 0.03;
    
    CGFloat titleY = bgY;
    
    CGFloat titleW = ScreenWidth * 0.77;
    
    CGFloat titleH = bgH;
    
    _title1F = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat timeX = ScreenWidth * 0.8;
    
    CGFloat timeY = bgY;
    
    CGFloat timeW = ScreenWidth * 0.17;
    
    CGFloat timeH = bgH;
    
    _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_titleBGF);
    
    CGFloat lineW = ScreenWidth;
    
    CGFloat lineH = 15;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
