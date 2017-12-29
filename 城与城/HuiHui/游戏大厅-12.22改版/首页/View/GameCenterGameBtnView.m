//
//  GameCenterGameBtnView.m
//  HuiHui
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameCenterGameBtnView.h"

@implementation GameCenterGameBtnView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat width = frame.size.width;
        
        CGFloat height = frame.size.height;
        
        CGFloat iconW = 60;
        
        CGFloat iconH = iconW;
        
        CGFloat iconX = (width - iconW) * 0.5;
        
        CGFloat iconY = 10;
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
        
        self.iconImg = icon;
        
        [self addSubview:icon];
        
        CGFloat titleX = 0;
        
        CGFloat titleY = CGRectGetMaxY(icon.frame) + 5;
        
        CGFloat titleW = width;
        
        CGFloat titleH = 15;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        
        self.titleLab = title;
        
        title.font = [UIFont systemFontOfSize:15];
        
        title.textAlignment = NSTextAlignmentCenter;
        
        title.textColor = [UIColor darkTextColor];
        
        [self addSubview:title];
        
        CGFloat comeX = iconX;
        
        CGFloat comeY = CGRectGetMaxY(title.frame) + 5;
        
        CGFloat comeW = iconW;
        
        CGFloat comeH = 20;
        
        UIButton *come = [[UIButton alloc] initWithFrame:CGRectMake(comeX, comeY, comeW, comeH)];
        
        self.comeBtn = come;
        
        come.titleLabel.font = [UIFont systemFontOfSize:14];
        
        come.layer.masksToBounds = YES;
        
        come.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        come.layer.borderWidth = 0.8;
        
        come.layer.cornerRadius = 3;
        
        [come setTitle:@"进入" forState:0];
        
        [come setTitleColor:[UIColor darkTextColor] forState:0];
        
        [self addSubview:come];
        
        UIButton *click = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        
        self.clickBtn = click;
        
        [self addSubview:click];
        
    }
    
    return self;
    
}

@end
