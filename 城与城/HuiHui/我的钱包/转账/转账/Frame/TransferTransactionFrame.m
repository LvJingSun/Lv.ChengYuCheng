//
//  TransferTransactionFrame.m
//  HuiHui
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "TransferTransactionFrame.h"
#import "TransferTransactionModel.h"
#import "RedHorseHeader.h"

@implementation TransferTransactionFrame

-(void)setTranModel:(TransferTransactionModel *)tranModel {

    _tranModel = tranModel;
    
    CGFloat iconW = 70;
    
    CGFloat iconH = iconW;
    
    CGFloat iconX = (ScreenWidth - iconW) * 0.5;
    
    CGFloat iconY = 20;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat nameX = ScreenWidth * 0.1;
    
    CGFloat nameY = CGRectGetMaxY(_iconF) + 10;
    
    CGFloat nameW = ScreenWidth * 0.8;
    
    CGFloat nameH = 20;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat bgX = 0;
    
    CGFloat bgY = CGRectGetMaxY(_nameF) + 25;
    
    CGFloat bgW = ScreenWidth;
    
    CGFloat bgH = 130;
    
    _bgF = CGRectMake(bgX, bgY, bgW, bgH);
    
    CGFloat titleX = ScreenWidth * 0.032;
    
    CGFloat titleY = 10;
    
    CGFloat titleW = ScreenWidth * 0.5;
    
    CGFloat titleH = 20;
    
    _countTitleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat countX = ScreenWidth * 0.032;
    
    CGFloat countY = CGRectGetMaxY(_countTitleF) + 20;
    
    CGFloat countW = ScreenWidth * 0.936;
    
    CGFloat countH = 50;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat sureX = ScreenWidth * 0.1;
    
    CGFloat sureY = CGRectGetMaxY(_bgF) + 100;
    
    CGFloat sureW = ScreenWidth * 0.8;
    
    CGFloat sureH = 50;
    
    _sureF = CGRectMake(sureX, sureY, sureW, sureH);
    
    _height = CGRectGetMaxY(_sureF);
    
}

@end
