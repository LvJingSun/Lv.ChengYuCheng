//
//  GoldBrokenLineFrame.m
//  HuiHui
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GoldBrokenLineFrame.h"
#import "GoldBrokenLineModel.h"
#import "RedHorseHeader.h"

@implementation GoldBrokenLineFrame

-(void)setBrokenModel:(GoldBrokenLineModel *)brokenModel {

    _brokenModel = brokenModel;
    
    CGFloat titleX = ScreenWidth * 0.05;
    
    CGFloat titleY = 12;
    
    CGFloat titleW = ScreenWidth * 0.9;
    
    CGFloat titleH = 20;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat lineX = ScreenWidth * 0.05;
    
    CGFloat lineY = CGRectGetMaxY(_titleF) + 12;
    
    CGFloat lineW = ScreenWidth * 0.9;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat brokenX = 0;
    
    CGFloat brokenY = CGRectGetMaxY(_lineF);
    
    CGFloat brokenW = ScreenWidth;
    
    CGFloat brokenH = 120;
    
    _brokenF = CGRectMake(brokenX, brokenY, brokenW, brokenH);
    
    _height = CGRectGetMaxY(_brokenF) + 10;
    
}

@end
