//
//  New_HL_GameInfoFrame.m
//  HuiHui
//
//  Created by mac on 2017/12/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "New_HL_GameInfoFrame.h"
#import "LJConst.h"
#import "New_HL_GameInfoModel.h"

@implementation New_HL_GameInfoFrame

-(void)setModel:(New_HL_GameInfoModel *)model {
    
    _model = model;
    
    CGFloat line1X = 0;
    
    CGFloat line1Y = 0;
    
    CGFloat line1W = _WindowViewWidth;
    
    CGFloat line1H = SectionHeight;
    
    _line1F = CGRectMake(line1X, line1Y, line1W, line1H);
    
    CGFloat IDX = _WindowViewWidth * 0.05;
    
    CGFloat IDY = CGRectGetMaxY(_line1F) + 10;
    
    CGFloat IDW = _WindowViewWidth - 2 * IDX;
    
    CGFloat IDH = 35;
    
    _gameIDF = CGRectMake(IDX, IDY, IDW, IDH);
    
    CGFloat line2X = IDX;
    
    CGFloat line2Y = CGRectGetMaxY(_gameIDF) + 5;
    
    CGFloat line2W = _WindowViewWidth - line2X;
    
    CGFloat line2H = 1;
    
    _line2F = CGRectMake(line2X, line2Y, line2W, line2H);
    
    CGFloat countX = IDX;
    
    CGFloat countY = CGRectGetMaxY(_line2F) + 10;
    
    CGFloat countW = IDW;
    
    CGFloat countH = IDH;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat line3X = line1X;
    
    CGFloat line3Y = CGRectGetMaxY(_countF) + 5;
    
    CGFloat line3W = line1W;
    
    CGFloat line3H = line1H;
    
    _line3F = CGRectMake(line3X, line3Y, line3W, line3H);
    
    _size = CGSizeMake(_WindowViewWidth, CGRectGetMaxY(_line3F));
    
}

@end
