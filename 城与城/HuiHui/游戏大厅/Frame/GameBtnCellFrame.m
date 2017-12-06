//
//  GameBtnCellFrame.m
//  HuiHui
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameBtnCellFrame.h"
#import "GameBtnCellModel.h"
#import "LJConst.h"

@implementation GameBtnCellFrame

-(void)setGameBtnCellModel:(GameBtnCellModel *)gameBtnCellModel {

    _gameBtnCellModel = gameBtnCellModel;
    
    CGFloat titleX = _WindowViewWidth * 0.05;
    
    CGFloat titleY = 15;
    
    CGFloat titleW = _WindowViewWidth * 0.9;
    
    CGFloat titleH = 30;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    if (gameBtnCellModel.games.count == 1) {
        
        [self allocOneBtn];
        
    }else if (gameBtnCellModel.games.count == 2) {
    
        [self allocTwoBtn];
        
    }else if (gameBtnCellModel.games.count == 3) {
    
        [self allocThreeBtn];
        
    }else if (gameBtnCellModel.games.count == 4) {
        
        [self allocFourBtn];
        
    }else if (gameBtnCellModel.games.count == 5) {
        
        [self allocFiveBtn];
        
    }else if (gameBtnCellModel.games.count == 6) {
        
        [self allocSixBtn];
        
    }else if (gameBtnCellModel.games.count == 0) {
    
        _height = 20 + CGRectGetMaxY(_titleF);
        
    }
    
}

- (void)allocFourBtn {
    
    CGFloat margin = 35;
    
    CGFloat btn1X = margin;
    
    CGFloat btn1Y = 20 + CGRectGetMaxY(_titleF);
    
    CGFloat btn1W = (_WindowViewWidth - 4 * margin) * 0.33333;
    
    CGFloat btn1H = btn1W;
    
    _game1F = CGRectMake(btn1X, btn1Y, btn1W, btn1H);
    
    CGFloat btn2X = CGRectGetMaxX(_game1F) + margin;
    
    CGFloat btn2Y = btn1Y;
    
    CGFloat btn2W = btn1W;
    
    CGFloat btn2H = btn2W;
    
    _game2F = CGRectMake(btn2X, btn2Y, btn2W, btn2H);
    
    CGFloat btn3X = CGRectGetMaxX(_game2F) + margin;
    
    CGFloat btn3Y = btn2Y;
    
    CGFloat btn3W = btn2W;
    
    CGFloat btn3H = btn3W;
    
    _game3F = CGRectMake(btn3X, btn3Y, btn3W, btn3H);
    
    CGFloat btn4Y = CGRectGetMaxY(_game1F) + 20;
    
    _game4F = CGRectMake(btn1X, btn4Y, btn1W, btn1H);
    
    _height = CGRectGetMaxY(_game4F) + 20;
    
}

- (void)allocFiveBtn {
    
    CGFloat margin = 35;
    
    CGFloat btn1X = margin;
    
    CGFloat btn1Y = 20 + CGRectGetMaxY(_titleF);
    
    CGFloat btn1W = (_WindowViewWidth - 4 * margin) * 0.33333;
    
    CGFloat btn1H = btn1W;
    
    _game1F = CGRectMake(btn1X, btn1Y, btn1W, btn1H);
    
    CGFloat btn2X = CGRectGetMaxX(_game1F) + margin;
    
    CGFloat btn2Y = btn1Y;
    
    CGFloat btn2W = btn1W;
    
    CGFloat btn2H = btn2W;
    
    _game2F = CGRectMake(btn2X, btn2Y, btn2W, btn2H);
    
    CGFloat btn3X = CGRectGetMaxX(_game2F) + margin;
    
    CGFloat btn3Y = btn2Y;
    
    CGFloat btn3W = btn2W;
    
    CGFloat btn3H = btn3W;
    
    _game3F = CGRectMake(btn3X, btn3Y, btn3W, btn3H);
    
    CGFloat btn4Y = CGRectGetMaxY(_game1F) + 20;
    
    _game4F = CGRectMake(btn1X, btn4Y, btn1W, btn1H);
    
    _height = CGRectGetMaxY(_game4F) + 20;
    
    _game5F = CGRectMake(btn2X, btn4Y, btn2W, btn2H);
    
}

- (void)allocSixBtn {
    
    CGFloat margin = 35;
    
    CGFloat btn1X = margin;
    
    CGFloat btn1Y = 20 + CGRectGetMaxY(_titleF);
    
    CGFloat btn1W = (_WindowViewWidth - 4 * margin) * 0.33333;
    
    CGFloat btn1H = btn1W;
    
    _game1F = CGRectMake(btn1X, btn1Y, btn1W, btn1H);
    
    CGFloat btn2X = CGRectGetMaxX(_game1F) + margin;
    
    CGFloat btn2Y = btn1Y;
    
    CGFloat btn2W = btn1W;
    
    CGFloat btn2H = btn2W;
    
    _game2F = CGRectMake(btn2X, btn2Y, btn2W, btn2H);
    
    CGFloat btn3X = CGRectGetMaxX(_game2F) + margin;
    
    CGFloat btn3Y = btn2Y;
    
    CGFloat btn3W = btn2W;
    
    CGFloat btn3H = btn3W;
    
    _game3F = CGRectMake(btn3X, btn3Y, btn3W, btn3H);
    
    CGFloat btn4Y = CGRectGetMaxY(_game1F) + 20;
    
    _game4F = CGRectMake(btn1X, btn4Y, btn1W, btn1H);
    
    _height = CGRectGetMaxY(_game4F) + 20;
    
    _game5F = CGRectMake(btn2X, btn4Y, btn2W, btn2H);
    
    _game6F = CGRectMake(btn3X, btn4Y, btn3W, btn3H);
    
}

- (void)allocOneBtn {
    
    CGFloat margin = 35;
    
    CGFloat btn1X = margin;
    
    CGFloat btn1Y = 20 + CGRectGetMaxY(_titleF);
    
    CGFloat btn1W = (_WindowViewWidth - 4 * margin) * 0.33333;
    
    CGFloat btn1H = btn1W;
    
    _game1F = CGRectMake(btn1X, btn1Y, btn1W, btn1H);
    
    _height = CGRectGetMaxY(_game1F) + 20;
    
}

- (void)allocTwoBtn {
    
    CGFloat margin = 35;
    
    CGFloat btn1X = margin;
    
    CGFloat btn1Y = 20 + CGRectGetMaxY(_titleF);
    
    CGFloat btn1W = (_WindowViewWidth - 4 * margin) * 0.33333;
    
    CGFloat btn1H = btn1W;
    
    _game1F = CGRectMake(btn1X, btn1Y, btn1W, btn1H);
    
    _height = CGRectGetMaxY(_game1F) + 20;
    
    CGFloat btn2X = CGRectGetMaxX(_game1F) + margin;
    
    CGFloat btn2Y = btn1Y;
    
    CGFloat btn2W = btn1W;
    
    CGFloat btn2H = btn2W;
    
    _game2F = CGRectMake(btn2X, btn2Y, btn2W, btn2H);
    
}

- (void)allocThreeBtn {
    
    CGFloat margin = 35;
    
    CGFloat btn1X = margin;
    
    CGFloat btn1Y = 20 + CGRectGetMaxY(_titleF);
    
    CGFloat btn1W = (_WindowViewWidth - 4 * margin) * 0.33333;
    
    CGFloat btn1H = btn1W;
    
    _game1F = CGRectMake(btn1X, btn1Y, btn1W, btn1H);
    
    _height = CGRectGetMaxY(_game1F) + 20;
    
    CGFloat btn2X = CGRectGetMaxX(_game1F) + margin;
    
    CGFloat btn2Y = btn1Y;
    
    CGFloat btn2W = btn1W;
    
    CGFloat btn2H = btn2W;
    
    _game2F = CGRectMake(btn2X, btn2Y, btn2W, btn2H);
    
    CGFloat btn3X = CGRectGetMaxX(_game2F) + margin;
    
    CGFloat btn3Y = btn2Y;
    
    CGFloat btn3W = btn2W;
    
    CGFloat btn3H = btn3W;
    
    _game3F = CGRectMake(btn3X, btn3Y, btn3W, btn3H);
    
}

@end
