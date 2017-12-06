//
//  HomeMenuFrame.m
//  HuiHui
//
//  Created by mac on 2017/9/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HomeMenuFrame.h"
#import "HomeMenuModel.h"
#import "RedHorseHeader.h"

@implementation HomeMenuFrame

-(void)setMenumodel:(HomeMenuModel *)menumodel {

    _menumodel = menumodel;
    
    CGFloat spacR = 15;
    
    CGFloat spacT = 10;
    
    CGFloat bntX = spacT;
    
    CGFloat btnW = (ScreenWidth - spacR * 6) * 0.2;
    
    CGFloat btnH = btnW + 20;
    
    _view1F = CGRectMake(spacR, bntX, btnW, btnH);
    
    CGFloat btn2X = CGRectGetMaxX(_view1F) + spacR;
    
    _view2F = CGRectMake(btn2X, bntX, btnW, btnH);
    
    CGFloat btn3X = CGRectGetMaxX(_view2F) + spacR;
    
    _view3F = CGRectMake(btn3X, bntX, btnW, btnH);
    
    CGFloat btn4x = CGRectGetMaxX(_view3F) + spacR;
    
    _view4F = CGRectMake(btn4x, bntX, btnW, btnH);
    
    CGFloat btn5x = CGRectGetMaxX(_view4F) + spacR;
    
    _view5F = CGRectMake(btn5x, bntX, btnW, btnH);
    
    CGFloat btn6x = spacR;
    
    CGFloat btn6y = CGRectGetMaxY(_view1F) + spacT;
    
    _view6F = CGRectMake(btn6x, btn6y, btnW, btnH);
    
    _view7F = CGRectMake(btn2X, btn6y, btnW, btnH);
    
    _view8F = CGRectMake(btn3X, btn6y, btnW, btnH);
    
    _view9F = CGRectMake(btn4x, btn6y, btnW, btnH);
    
    _view10F = CGRectMake(btn5x, btn6y, btnW, btnH);
    
    _height = CGRectGetMaxY(_view10F) + bntX;
    
}

@end
