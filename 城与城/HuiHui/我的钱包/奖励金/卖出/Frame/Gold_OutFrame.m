//
//  Gold_OutFrame.m
//  HuiHui
//
//  Created by mac on 2017/9/19.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Gold_OutFrame.h"
#import "GameGoldHeader.h"
#import "Gold_OutModel.h"

@implementation Gold_OutFrame

-(void)setOutModel:(Gold_OutModel *)outModel {

    _outModel = outModel;
    
    CGFloat titleX = ScreenWidth * 0.05;
    
    CGFloat titleY = 20;
    
    CGFloat titleW = ScreenWidth * 0.9;
    
    CGFloat titleH = 20;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat qualityX = ScreenWidth * 0.05;
    
    CGFloat qualityY = CGRectGetMaxY(_titleF) + 20;
    
    CGFloat qualityW = ScreenWidth * 0.9;
    
    CGFloat qualityH = 50;
    
    _qualityF = CGRectMake(qualityX, qualityY, qualityW, qualityH);
    
    CGFloat lookX = ScreenWidth * 0.3;
    
    CGFloat lookY = CGRectGetMaxY(_qualityF) + 20;
    
    CGFloat lookW = ScreenWidth * 0.4;
    
    CGFloat lookH = 30;
    
    _lookF = CGRectMake(lookX, lookY, lookW, lookH);
    
    CGFloat countX = 0;
    
    CGFloat countY = CGRectGetMaxY(_lookF) + 50;
    
    CGFloat countW = ScreenWidth;
    
    CGFloat countH = 50;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat moneyX = ScreenWidth * 0.05;
    
    CGFloat moneyY = CGRectGetMaxY(_countF) + 10;
    
    CGFloat moneyW = ScreenWidth * 0.9;
    
    CGFloat moneyH = 15;
    
    _moneyF = CGRectMake(moneyX, moneyY, moneyW, moneyH);
    
    CGFloat sureX = ScreenWidth * 0.05;
    
    CGFloat sureY = CGRectGetMaxY(_moneyF) + 30;
    
    CGFloat sureW = ScreenWidth * 0.9;
    
    CGFloat sureH = 50;
    
    _sureF = CGRectMake(sureX, sureY, sureW, sureH);
    
    _height = CGRectGetMaxY(_sureF);
    
}

@end
