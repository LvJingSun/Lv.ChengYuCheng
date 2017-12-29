//
//  GameCenterGameArrayFrame.m
//  HuiHui
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameCenterGameArrayFrame.h"
#import "GameCenterGameArrayModel.h"
#import "LJConst.h"

@implementation GameCenterGameArrayFrame

-(void)setArrayModel:(GameCenterGameArrayModel *)arrayModel {
    
    _arrayModel = arrayModel;
    
    CGFloat titleX = _WindowViewWidth * 0.05;
    
    CGFloat titleY = 10;
    
    CGFloat titleW = _WindowViewWidth * 0.9;
    
    CGFloat titleH = 20;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    if (arrayModel.gameArray.count == 1) {
        
        [self OneBtn];
        
    }else if (arrayModel.gameArray.count == 2) {
        
        [self TwoBtn];
        
    }else if (arrayModel.gameArray.count == 3) {
        
        [self ThreeBtn];
        
    }else if (arrayModel.gameArray.count == 4) {
        
        [self FourBtn];
        
    }else if (arrayModel.gameArray.count == 5) {
        
        [self FiveBtn];
        
    }else if (arrayModel.gameArray.count == 6) {
        
        [self SixBtn];
        
    }
    
}

- (void)OneBtn {
    
    CGFloat oneX = 0;
    
    CGFloat oneY = CGRectGetMaxY(_titleF);
    
    CGFloat oneW = _WindowViewWidth * 0.3333333;
    
    CGFloat oneH = 115;
    
    _game1F = CGRectMake(oneX, oneY, oneW, oneH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_game1F) + 10;
    
    CGFloat lineW = _WindowViewWidth;
    
    CGFloat lineH = SectionHeight;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

- (void)TwoBtn {
    
    CGFloat oneX = 0;
    
    CGFloat oneY = CGRectGetMaxY(_titleF);
    
    CGFloat oneW = _WindowViewWidth * 0.3333333;
    
    CGFloat oneH = 115;
    
    _game1F = CGRectMake(oneX, oneY, oneW, oneH);
    
    CGFloat twoX = CGRectGetMaxX(_game1F);
    
    CGFloat twoY = CGRectGetMaxY(_titleF);
    
    CGFloat twoW = _WindowViewWidth * 0.3333333;
    
    CGFloat twoH = 115;
    
    _game2F = CGRectMake(twoX, twoY, twoW, twoH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_game1F) + 10;
    
    CGFloat lineW = _WindowViewWidth;
    
    CGFloat lineH = SectionHeight;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

- (void)ThreeBtn {
    
    CGFloat oneX = 0;
    
    CGFloat oneY = CGRectGetMaxY(_titleF);
    
    CGFloat oneW = _WindowViewWidth * 0.3333333;
    
    CGFloat oneH = 115;
    
    _game1F = CGRectMake(oneX, oneY, oneW, oneH);
    
    CGFloat twoX = CGRectGetMaxX(_game1F);
    
    CGFloat twoY = CGRectGetMaxY(_titleF);
    
    CGFloat twoW = _WindowViewWidth * 0.3333333;
    
    CGFloat twoH = 115;
    
    _game2F = CGRectMake(twoX, twoY, twoW, twoH);
    
    CGFloat threeX = CGRectGetMaxX(_game2F);
    
    CGFloat threeY = CGRectGetMaxY(_titleF);
    
    CGFloat threeW = _WindowViewWidth * 0.3333333;
    
    CGFloat threeH = 115;
    
    _game3F = CGRectMake(threeX, threeY, threeW, threeH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_game1F) + 10;
    
    CGFloat lineW = _WindowViewWidth;
    
    CGFloat lineH = SectionHeight;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

- (void)FourBtn {
    
    CGFloat oneX = 0;
    
    CGFloat oneY = CGRectGetMaxY(_titleF);
    
    CGFloat oneW = _WindowViewWidth * 0.3333333;
    
    CGFloat oneH = 115;
    
    _game1F = CGRectMake(oneX, oneY, oneW, oneH);
    
    CGFloat twoX = CGRectGetMaxX(_game1F);
    
    CGFloat twoY = CGRectGetMaxY(_titleF);
    
    CGFloat twoW = _WindowViewWidth * 0.3333333;
    
    CGFloat twoH = 115;
    
    _game2F = CGRectMake(twoX, twoY, twoW, twoH);
    
    CGFloat threeX = CGRectGetMaxX(_game2F);
    
    CGFloat threeY = CGRectGetMaxY(_titleF);
    
    CGFloat threeW = _WindowViewWidth * 0.3333333;
    
    CGFloat threeH = 115;
    
    _game3F = CGRectMake(threeX, threeY, threeW, threeH);
    
    CGFloat fourX = 0;
    
    CGFloat fourY = CGRectGetMaxY(_game1F);
    
    CGFloat fourW = _WindowViewWidth * 0.3333333;
    
    CGFloat fourH = 115;
    
    _game4F = CGRectMake(fourX, fourY, fourW, fourH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_game4F) + 10;
    
    CGFloat lineW = _WindowViewWidth;
    
    CGFloat lineH = SectionHeight;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

- (void)FiveBtn {
    
    CGFloat oneX = 0;
    
    CGFloat oneY = CGRectGetMaxY(_titleF);
    
    CGFloat oneW = _WindowViewWidth * 0.3333333;
    
    CGFloat oneH = 115;
    
    _game1F = CGRectMake(oneX, oneY, oneW, oneH);
    
    CGFloat twoX = CGRectGetMaxX(_game1F);
    
    CGFloat twoY = CGRectGetMaxY(_titleF);
    
    CGFloat twoW = _WindowViewWidth * 0.3333333;
    
    CGFloat twoH = 115;
    
    _game2F = CGRectMake(twoX, twoY, twoW, twoH);
    
    CGFloat threeX = CGRectGetMaxX(_game2F);
    
    CGFloat threeY = CGRectGetMaxY(_titleF);
    
    CGFloat threeW = _WindowViewWidth * 0.3333333;
    
    CGFloat threeH = 115;
    
    _game3F = CGRectMake(threeX, threeY, threeW, threeH);
    
    CGFloat fourX = 0;
    
    CGFloat fourY = CGRectGetMaxY(_game1F);
    
    CGFloat fourW = _WindowViewWidth * 0.3333333;
    
    CGFloat fourH = 115;
    
    _game4F = CGRectMake(fourX, fourY, fourW, fourH);
    
    CGFloat fiveX = CGRectGetMaxX(_game4F);
    
    CGFloat fiveY = CGRectGetMaxY(_game2F);
    
    CGFloat fiveW = _WindowViewWidth * 0.3333333;
    
    CGFloat fiveH = 100;
    
    _game5F = CGRectMake(fiveX, fiveY, fiveW, fiveH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_game4F) + 10;
    
    CGFloat lineW = _WindowViewWidth;
    
    CGFloat lineH = SectionHeight;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

- (void)SixBtn {
    
    CGFloat oneX = 0;
    
    CGFloat oneY = CGRectGetMaxY(_titleF);
    
    CGFloat oneW = _WindowViewWidth * 0.3333333;
    
    CGFloat oneH = 115;
    
    _game1F = CGRectMake(oneX, oneY, oneW, oneH);
    
    CGFloat twoX = CGRectGetMaxX(_game1F);
    
    CGFloat twoY = CGRectGetMaxY(_titleF);
    
    CGFloat twoW = _WindowViewWidth * 0.3333333;
    
    CGFloat twoH = 115;
    
    _game2F = CGRectMake(twoX, twoY, twoW, twoH);
    
    CGFloat threeX = CGRectGetMaxX(_game2F);
    
    CGFloat threeY = CGRectGetMaxY(_titleF);
    
    CGFloat threeW = _WindowViewWidth * 0.3333333;
    
    CGFloat threeH = 115;
    
    _game3F = CGRectMake(threeX, threeY, threeW, threeH);
    
    CGFloat fourX = 0;
    
    CGFloat fourY = CGRectGetMaxY(_game1F);
    
    CGFloat fourW = _WindowViewWidth * 0.3333333;
    
    CGFloat fourH = 115;
    
    _game4F = CGRectMake(fourX, fourY, fourW, fourH);
    
    CGFloat fiveX = CGRectGetMaxX(_game4F);
    
    CGFloat fiveY = CGRectGetMaxY(_game2F);
    
    CGFloat fiveW = _WindowViewWidth * 0.3333333;
    
    CGFloat fiveH = 115;
    
    _game5F = CGRectMake(fiveX, fiveY, fiveW, fiveH);
    
    CGFloat sixX = CGRectGetMaxX(_game5F);
    
    CGFloat sixY = CGRectGetMaxY(_game3F);
    
    CGFloat sixW = _WindowViewWidth * 0.3333333;
    
    CGFloat sixH = 115;
    
    _game6F = CGRectMake(sixX, sixY, sixW, sixH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_game4F) + 10;
    
    CGFloat lineW = _WindowViewWidth;
    
    CGFloat lineH = SectionHeight;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
