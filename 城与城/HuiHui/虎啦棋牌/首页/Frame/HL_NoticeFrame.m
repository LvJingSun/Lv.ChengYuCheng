//
//  HL_NoticeFrame.m
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_NoticeFrame.h"
#import "LJConst.h"
#import "HL_NoticeModel.h"

@implementation HL_NoticeFrame

-(void)setNoticeModel:(HL_NoticeModel *)noticeModel {
    
    _noticeModel = noticeModel;
    
    CGFloat upX = 0;
    
    CGFloat upY = 0;
    
    CGFloat upW = _WindowViewWidth;
    
    CGFloat upH = SectionHeight;
    
    _upLineF = CGRectMake(upX, upY, upW, upH);
    
    CGFloat titleX = _WindowViewWidth * 0.05;
    
    CGFloat titleY = 10 + CGRectGetMaxY(_upLineF);
    
    CGFloat titleW = _WindowViewWidth * 0.55;
    
    CGFloat titleH = 20;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat notice1X = titleX;
    
    CGFloat notice1Y = CGRectGetMaxY(_titleF) + 10;
    
    CGFloat notice1W = titleW;
    
    CGFloat notice1H = 15;
    
    _notice1F = CGRectMake(notice1X, notice1Y, notice1W, notice1H);
    
    CGFloat notice2X = titleX;
    
    CGFloat notice2Y = CGRectGetMaxY(_notice1F) + 5;
    
    CGFloat notice2W = titleW;
    
    CGFloat notice2H = 15;
    
    _notice2F = CGRectMake(notice2X, notice2Y, notice2W, notice2H);
    
    CGFloat boX = 0;
    
    CGFloat boY = CGRectGetMaxY(_notice2F) + 10;
    
    CGFloat boW = _WindowViewWidth;
    
    CGFloat boH = SectionHeight;
    
    _bottomLineF = CGRectMake(boX, boY, boW, boH);
    
    _height = CGRectGetMaxY(_bottomLineF);
    
    CGFloat imgX = _WindowViewWidth * 0.65;
    
    CGFloat imgH = 60;
    
    CGFloat imgY = (_height - imgH) * 0.5;
    
    CGFloat imgW = _WindowViewWidth * 0.3;
    
    _imgF = CGRectMake(imgX, imgY, imgW, imgH);
    
}

@end
