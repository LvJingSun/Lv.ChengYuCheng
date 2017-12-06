//
//  YCB_TranDetailFrame.m
//  HuiHui
//
//  Created by mac on 2017/9/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "YCB_TranDetailFrame.h"
#import "RedHorseHeader.h"
#import "YCB_TranModel.h"

@implementation YCB_TranDetailFrame

-(void)setTranmodel:(YCB_TranModel *)tranmodel {

    _tranmodel = tranmodel;
    
    CGFloat iconW = 40;
    
    CGFloat iconH = iconW;
    
    CGFloat iconX = ScreenWidth * 0.45 - iconW;
    
    CGFloat iconY = 20;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat nameX = CGRectGetMaxX(_iconF) + 10;
    
    CGFloat nameY = iconY;
    
    CGFloat nameW = ScreenWidth * 0.95 - nameX;
    
    CGFloat nameH = iconH;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat countX = ScreenWidth * 0.1;
    
    CGFloat countY = CGRectGetMaxY(_iconF) + 20;
    
    CGFloat countW = ScreenWidth * 0.8;
    
    CGFloat countH = 50;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat statusX = ScreenWidth * 0.1;
    
    CGFloat statusY = CGRectGetMaxY(_countF) + 20;
    
    CGFloat statusW = ScreenWidth * 0.8;
    
    CGFloat statusH = 20;
    
    _statusF = CGRectMake(statusX, statusY, statusW, statusH);
    
    CGFloat costTitleX = ScreenWidth * 0.05;
    
    CGFloat costTitleY = CGRectGetMaxY(_statusF) + 40;
    
    CGFloat costTitleW = ScreenWidth * 0.25;
    
    CGFloat costTitleH = 20;
    
    _feiyongTitleF = CGRectMake(costTitleX, costTitleY, costTitleW, costTitleH);
    
    CGFloat costX = CGRectGetMaxX(_feiyongTitleF);
    
    CGFloat costY = costTitleY;
    
    CGFloat costW = ScreenWidth * 0.95 - costX;
    
    CGFloat costH = costTitleH;
    
    _feiyongF = CGRectMake(costX, costY, costW, costH);
    
    CGFloat typeTitleX = costTitleX;
    
    CGFloat typeTitleY = CGRectGetMaxY(_feiyongTitleF) + 20;
    
    CGFloat typeTitleW = costTitleW;
    
    CGFloat typeTitleH = costTitleH;
    
    _typeTitleF = CGRectMake(typeTitleX, typeTitleY, typeTitleW, typeTitleH);
    
    CGFloat typeX = costX;
    
    CGFloat typeY = typeTitleY;
    
    CGFloat typeW = costW;
    
    CGFloat typeH = costH;
    
    _typeF = CGRectMake(typeX, typeY, typeW, typeH);
    
    CGFloat goodTitleX = typeTitleX;
    
    CGFloat goodTitleY = CGRectGetMaxY(_typeTitleF) + 20;
    
    CGFloat goodTitleW = typeTitleW;
    
    CGFloat goodTitleH = typeTitleH;
    
    _descTitleF = CGRectMake(goodTitleX, goodTitleY, goodTitleW, goodTitleH);
    
    CGFloat goodX = typeX;
    
    CGFloat goodY = goodTitleY;
    
    CGFloat goodW = typeW;
    
    CGFloat goodH = typeH;
    
    _descF = CGRectMake(goodX, goodY, goodW, goodH);
    
    CGFloat lineX = ScreenWidth * 0.05;
    
    CGFloat lineY = CGRectGetMaxY(_descF) + 20;
    
    CGFloat lineW = ScreenWidth * 0.9;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat timeTitleX = goodTitleX;
    
    CGFloat timeTitleY = CGRectGetMaxY(_lineF) + 20;
    
    CGFloat timeTitleW = goodTitleW;
    
    CGFloat timeTitleH = goodTitleH;
    
    _dateTitleF = CGRectMake(timeTitleX, timeTitleY, timeTitleW, timeTitleH);
    
    CGFloat timeX = goodX;
    
    CGFloat timeY = timeTitleY;
    
    CGFloat timeW = goodW;
    
    CGFloat timeH = goodH;
    
    _dateF = CGRectMake(timeX, timeY, timeW, timeH);
    
    CGFloat NoTitleX = timeTitleX;
    
    CGFloat NoTitleY = CGRectGetMaxY(_dateTitleF) + 20;
    
    CGFloat NoTitleW = timeTitleW;
    
    CGFloat NoTitleH = timeTitleH;
    
    _NoTitleF = CGRectMake(NoTitleX, NoTitleY, NoTitleW, NoTitleH);
    
    CGFloat NoX = timeX;
    
    CGFloat NoY = NoTitleY;
    
    CGFloat NoW = timeW;
    
    CGFloat NoH = timeH;
    
    _NoF = CGRectMake(NoX, NoY, NoW, NoH);
    
    _height = CGRectGetMaxY(_NoF) + 20;
    
}

@end
