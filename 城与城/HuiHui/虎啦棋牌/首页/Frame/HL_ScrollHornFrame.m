//
//  HL_ScrollHornFrame.m
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_ScrollHornFrame.h"
#import "HL_ScrollHornModel.h"
#import "LJConst.h"

@implementation HL_ScrollHornFrame

-(void)setScrollHornModel:(HL_ScrollHornModel *)scrollHornModel {
    
    _scrollHornModel = scrollHornModel;
    
    CGFloat imgX = _WindowViewWidth * 0.05;
    
    CGFloat imgY = 5;
    
    CGFloat imgW = 30;
    
    CGFloat imgH = imgW;
    
    _hornImgF = CGRectMake(imgX, imgY, imgW, imgH);
    
    CGFloat hornViewX = CGRectGetMaxX(_hornImgF) + imgX;
    
    CGFloat hornViewY = imgY;
    
    CGFloat hornViewW = _WindowViewWidth * 0.95 - hornViewX;
    
    CGFloat hornViewH = imgH;
    
    _hornTextF = CGRectMake(hornViewX, hornViewY, hornViewW, hornViewH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_hornImgF) + imgY;
    
    CGFloat lineW = _WindowViewWidth;
    
    CGFloat lineH = SectionHeight;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
