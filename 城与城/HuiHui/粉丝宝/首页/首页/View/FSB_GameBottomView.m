//
//  FSB_GameBottomView.m
//  HuiHui
//
//  Created by mac on 2017/6/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_GameBottomView.h"
#import "LJConst.h"

@implementation FSB_GameBottomView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(_WindowViewWidth * 0.05, 10, _WindowViewWidth * 0.9, 20)];
        
        title.text = @"游戏专区";
        
        title.textAlignment = NSTextAlignmentCenter;
        
        title.textColor = [UIColor blackColor];
        
        [self addSubview:title];
        
        CGFloat game1Y = CGRectGetMaxY(title.frame) + 10;
        
        CGFloat game1W = 70;
        
        CGFloat margin = (_WindowViewWidth - 2 * game1W) * 0.33333;
        
        CGFloat game1X = margin;
        
        CGFloat game1H = game1W;
        
        UIButton *game1 = [[UIButton alloc] initWithFrame:CGRectMake(game1X, game1Y, game1W, game1H)];
        
        self.game1Btn = game1;
        
        [game1 addTarget:self action:@selector(game1Click) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:game1];
        
        UILabel *game1name = [[UILabel alloc] initWithFrame:CGRectMake(game1X, CGRectGetMaxY(game1.frame) + 10, game1W, 15)];
        
        self.game1NameLab = game1name;
        
        game1name.textAlignment = NSTextAlignmentCenter;
        
        game1name.font = [UIFont systemFontOfSize:15];
        
        game1name.textColor = [UIColor blackColor];
        
        [self addSubview:game1name];
        
        UIButton *game2 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(game1.frame) + margin, game1Y, game1W, game1H)];
        
        self.game2Btn = game2;
        
        [game2 addTarget:self action:@selector(game2Click) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:game2];
        
        UILabel *game2name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(game1.frame) + margin, CGRectGetMaxY(game2.frame) + 10, game1W, 15)];
        
        self.game2NameLab = game2name;
        
        game2name.textAlignment = NSTextAlignmentCenter;
        
        game2name.font = [UIFont systemFontOfSize:15];
        
        game2name.textColor = [UIColor blackColor];
        
        [self addSubview:game2name];
        
        self.height = CGRectGetMaxY(game1name.frame) + 5;
        
    }
    
    return self;
    
}

- (void)game1Click {

    if (self.game1Block) {
        
        self.game1Block();
        
    }
    
}

- (void)game2Click {
    
    if (self.game2Block) {
        
        self.game2Block();
        
    }
    
}

@end
