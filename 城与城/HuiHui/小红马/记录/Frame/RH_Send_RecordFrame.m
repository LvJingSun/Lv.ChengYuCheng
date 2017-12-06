//
//  RH_Send_RecordFrame.m
//  HuiHui
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_Send_RecordFrame.h"
#import "RedHorseHeader.h"
#import "RH_Send_RecordModel.h"

@implementation RH_Send_RecordFrame

-(void)setListModel:(RH_Send_RecordModel *)listModel {

    _listModel = listModel;
    
    CGFloat nameX = ScreenWidth * 0.05;
    
    CGFloat nameY = 15;
    
    CGFloat nameW = ScreenWidth * 0.45;
    
    CGFloat nameH = 30;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat proX = nameX;
    
    CGFloat proY = CGRectGetMaxY(_nameF) + 10;
    
    CGFloat proW = nameW;
    
    CGFloat proH = 20;
    
    _productF = CGRectMake(proX, proY, proW, proH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_productF) + 15;
    
    CGFloat lineW = ScreenWidth;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
    CGFloat countX = ScreenWidth * 0.5;
    
    CGFloat countY = nameY;
    
    CGFloat countW = ScreenWidth * 0.45;
    
    CGFloat countH = nameH;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat timeX = countX;
    
    CGFloat timeY = proY;
    
    CGFloat timeW = countW;
    
    CGFloat timeH = proH;
    
    _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
}

@end
