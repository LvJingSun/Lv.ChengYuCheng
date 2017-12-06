//
//  M_TiXianFrame.m
//  HuiHui
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "M_TiXianFrame.h"
#import "LJConst.h"
#import "M_TiXianModel.h"

@implementation M_TiXianFrame

-(void)setTixianModel:(M_TiXianModel *)tixianModel {
    
    _tixianModel = tixianModel;
    
    CGFloat balanceX = _WindowViewWidth * 0.05;
    
    CGFloat balanceY = 20;
    
    CGFloat balanceW = _WindowViewWidth * 0.9;
    
    CGFloat balanceH = 20;
    
    _balanceF = CGRectMake(balanceX, balanceY, balanceW, balanceH);
    
    CGFloat jifenX = balanceX;
    
    CGFloat jifenY = CGRectGetMaxY(_balanceF) + 10;
    
    CGFloat jifenW = balanceW;
    
    CGFloat jifenH = 15;
    
    _jifenF = CGRectMake(jifenX, jifenY, jifenW, jifenH);
    
    CGFloat countX = 0;
    
    CGFloat countY = CGRectGetMaxY(_jifenF) + 5;
    
    CGFloat countW = _WindowViewWidth;
    
    CGFloat countH = 50;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat noticeX = balanceX;
    
    CGFloat noticeY = CGRectGetMaxY(_countF) + 10;
    
    CGFloat noticeW = _WindowViewWidth * 0.6;
    
    CGFloat noticeH = 15;
    
    _noticeF = CGRectMake(noticeX, noticeY, noticeW, noticeH);
    
    CGFloat needX = CGRectGetMaxX(_noticeF);
    
    CGFloat needY = noticeY;
    
    CGFloat needW = _WindowViewWidth * 0.3;
    
    CGFloat needH = noticeH;
    
    _needF = CGRectMake(needX, needY, needW, needH);
    
    CGFloat sureX = _WindowViewWidth * 0.05;
    
    CGFloat sureY = CGRectGetMaxY(_needF) + 50;
    
    CGFloat sureW = _WindowViewWidth * 0.9;
    
    CGFloat sureH = 50;
    
    _sureF = CGRectMake(sureX, sureY, sureW, sureH);
    
    _height = CGRectGetMaxY(_sureF);
    
}

@end
