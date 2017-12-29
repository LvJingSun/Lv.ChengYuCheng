//
//  GameCenterMyBtnView.m
//  HuiHui
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameCenterMyBtnView.h"

@implementation GameCenterMyBtnView

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
        
        icon.layer.masksToBounds = YES;
        
        icon.layer.cornerRadius = iconW * 0.5;
        
        [self addSubview:icon];
        
        CGFloat titleX = 0;
        
        CGFloat titleY = CGRectGetMaxY(icon.frame) + 10;
        
        CGFloat titleW = width;
        
        CGFloat titleH = 15;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        
        self.titleLab = title;
        
        title.textColor = [UIColor darkTextColor];
        
        title.font = [UIFont systemFontOfSize:15];
        
        title.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:title];
        
        UIButton *click = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        
        self.clickBtn = click;
        
        [self addSubview:click];
        
    }
    
    return self;
    
}

@end
