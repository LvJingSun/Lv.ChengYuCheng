//
//  R_PersonFrame.m
//  HuiHui
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "R_PersonFrame.h"
#import "LJConst.h"
#import "R_PersonModel.h"

@implementation R_PersonFrame

-(void)setPersonModel:(R_PersonModel *)personModel {
    
    _personModel = personModel;
    
    CGFloat bgX = 4;
    
    CGFloat bgY = 0.5;
    
    CGFloat bgW = _WindowViewWidth - bgX * 2;
    
    CGFloat bgH = 50;
    
    _bgF = CGRectMake(bgX, bgY, bgW, bgH);
    
    CGFloat imgX = _WindowViewWidth * 0.05;
    
    CGFloat imgY = bgY + 10;
    
    CGFloat imgW = 40;
    
    CGFloat imgH = 30;
    
    _iconF = CGRectMake(imgX, imgY, imgW, imgH);
    
    CGFloat titleX = CGRectGetMaxX(_iconF) + 10;
    
    CGFloat titleY = imgY;
    
    CGFloat titleW = _WindowViewWidth * 0.6 - titleX;
    
    CGFloat titleH = imgH;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat markW = 15;
    
    CGFloat markH = 30;
    
    CGFloat markX = _WindowViewWidth * 0.95 - markW;
    
    CGFloat markY = (CGRectGetMaxY(_bgF) + bgY - markH) * 0.5;
    
    _markF = CGRectMake(markX, markY, markW, markH);
    
    CGFloat contentX = CGRectGetMaxX(_titleF);
    
    CGFloat contentY = titleY;
    
    CGFloat contentW = markX - 15 - contentX;
    
    CGFloat contentH = titleH;
    
    _contentF = CGRectMake(contentX, contentY, contentW, contentH);
    
    _height = CGRectGetMaxY(_bgF) + bgY;
    
}

@end
