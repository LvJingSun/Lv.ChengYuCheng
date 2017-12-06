//
//  GameScrollFrame.m
//  HuiHui
//
//  Created by mac on 2017/5/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameScrollFrame.h"
#import "GameScrollModel.h"
#import "LJConst.h"

@implementation GameScrollFrame

-(void)setScrollmodel:(GameScrollModel *)scrollmodel {

    _scrollmodel = scrollmodel;
    
    CGFloat scrX = 0;
    
    CGFloat scrY = 0;
    
    CGFloat scrW = _WindowViewWidth;
    
    CGFloat scrH = _WindowViewWidth / 2.5;
    
    _scrollF = CGRectMake(scrX, scrY, scrW, scrH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_scrollF);
    
    CGFloat lineW = _WindowViewWidth;
    
    CGFloat lineH = 15;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
