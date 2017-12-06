//
//  Z_SearchFrame.m
//  HuiHui
//
//  Created by mac on 2017/7/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Z_SearchFrame.h"
#import "Z_SearchModel.h"
#import "RedHorseHeader.h"

@implementation Z_SearchFrame

-(void)setSearchModel:(Z_SearchModel *)searchModel {

    _searchModel = searchModel;
    
    CGFloat phoneX = 0;
    
    CGFloat phoneY = 20;
    
    CGFloat phoneW = ScreenWidth;
    
    CGFloat phoneH = 50;
    
    _phoneF = CGRectMake(phoneX, phoneY, phoneW, phoneH);
    
    CGFloat titleX = ScreenWidth * 0.05;
    
    CGFloat titleY = CGRectGetMaxY(_phoneF) + 20;
    
    CGFloat titleW = ScreenWidth * 0.9;
    
    CGFloat titleH = 15;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat btnX = titleX;
    
    CGFloat btnY = CGRectGetMaxY(_titleF) + 50;
    
    CGFloat btnW = ScreenWidth * 0.9;
    
    CGFloat btnH = 40;
    
    _nextF = CGRectMake(btnX, btnY, btnW, btnH);
    
    _height = CGRectGetMaxY(_nextF);
    
}

@end
