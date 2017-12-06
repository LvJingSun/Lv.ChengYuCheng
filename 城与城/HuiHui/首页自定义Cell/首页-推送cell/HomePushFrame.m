//
//  HomePushFrame.m
//  HuiHui
//
//  Created by mac on 2017/9/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HomePushFrame.h"
#import "HomePushModel.h"
#import "RedHorseHeader.h"

@implementation HomePushFrame

-(void)setPushmodel:(HomePushModel *)pushmodel {

    _pushmodel = pushmodel;
    
    CGFloat lineviewX = 0;
    
    CGFloat lineviewY = 0;
    
    CGFloat lineviewW = ScreenWidth;
    
    CGFloat lineviewH = 15;
    
    _lineviewF = CGRectMake(lineviewX, lineviewY, lineviewW, lineviewH);
    
    CGFloat imgX = ScreenWidth * 0.032;
    
    CGFloat imgY = 10 + CGRectGetMaxY(_lineviewF);
    
    CGFloat imgW = 40;
    
    CGFloat imgH = imgW;
    
    _iconF = CGRectMake(imgX, imgY, imgW, imgH);
    
    CGFloat titleX = CGRectGetMaxX(_iconF) + 3;
    
    CGFloat titleY = imgY;
    
    CGFloat titleW = ScreenWidth * 0.968 - titleX;
    
    CGFloat titleH = 20;
    
    _nameF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat timeX = titleX;
    
    CGFloat timeY = CGRectGetMaxY(_nameF);
    
    CGFloat timeW = titleW;
    
    CGFloat timeH = titleH;
    
    _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
    if ([pushmodel.Type isEqualToString:@"4"] || [pushmodel.Type isEqualToString:@"5"]) {
        
        CGFloat contentX = imgX;
        
        CGFloat contentY = CGRectGetMaxY(_iconF) + 10;
        
        CGFloat contentW = ScreenWidth * 0.936;
        
        CGFloat contentH = contentW * 0.4;
        
        _contentImgF= CGRectMake(contentX, contentY, contentW, contentH);
        
        CGFloat lineX = ScreenWidth * 0.032;
        
        CGFloat lineY = CGRectGetMaxY(_contentImgF) + 10;
        
        CGFloat lineW = ScreenWidth * 0.936;
        
        CGFloat lineH = 0.5;
        
        _lineF = CGRectMake(lineX, lineY, lineW, lineH);
        
    }else {
    
        CGFloat count1X = ScreenWidth * 0.2;
        
        CGFloat count1W = ScreenWidth * 0.968 - count1X;
        
        CGFloat count1H = 30;
        
        CGFloat count1Y = CGRectGetMaxY(_iconF) + 15;
        
        _resultF = CGRectMake(count1X, count1Y, count1W, count1H);
        
        CGFloat count2Y = CGRectGetMaxY(_resultF) + 15;
        
        CGFloat count2H = 20;
        
        _descF = CGRectMake(count1X, count2Y, count1W, count2H);
        
        CGFloat lineX = ScreenWidth * 0.032;
        
        CGFloat lineY = CGRectGetMaxY(_descF) + 10;
        
        CGFloat lineW = ScreenWidth * 0.936;
        
        CGFloat lineH = 0.5;
        
        _lineF = CGRectMake(lineX, lineY, lineW, lineH);
        
    }
    
    CGFloat btnX = 0;
    
    CGFloat btnY = CGRectGetMaxY(_lineF) + 5;
    
    CGFloat btnW = ScreenWidth;
    
    CGFloat btnH = 40;
    
    _moreBtnF = CGRectMake(btnX, btnY, btnW, btnH);
    
    CGFloat x = 0;
    
    CGFloat y = 0;
    
    CGFloat w = ScreenWidth;
    
    CGFloat h = CGRectGetMaxY(_moreBtnF) + 5;
    
    _btnF = CGRectMake(x, y, w, h);
    
    _height = CGRectGetMaxY(_btnF);
    
}

@end
