//
//  HL_MyInfoFrame.m
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_MyInfoFrame.h"
#import "LJConst.h"
#import "HL_MyInfoModel.h"

@implementation HL_MyInfoFrame

-(void)setInfoModel:(HL_MyInfoModel *)infoModel {
    
    _infoModel = infoModel;
    
    CGFloat titleX = _WindowViewWidth * 0.05;
    
    CGFloat titleY = 10;
    
    CGFloat titleW = _WindowViewWidth * 0.4;
    
    CGFloat titleH = 30;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat contentX = _WindowViewWidth * 0.5;
    
    CGFloat contentY = titleY;
    
    CGFloat contentW = _WindowViewWidth * 0.45;
    
    CGFloat contentH = titleH;
    
    _contentF = CGRectMake(contentX, contentY, contentW, contentH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_titleF) + titleY;
    
    CGFloat lineW = _WindowViewWidth;
    
    CGFloat lineH = 1;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
