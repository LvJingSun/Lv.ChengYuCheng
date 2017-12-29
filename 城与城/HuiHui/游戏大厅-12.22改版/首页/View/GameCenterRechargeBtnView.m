//
//  GameCenterRechargeBtnView.m
//  HuiHui
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameCenterRechargeBtnView.h"

@implementation GameCenterRechargeBtnView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat width = frame.size.width;
        
        CGFloat height = frame.size.height;
        
        CGFloat iconW = 20;
        
        CGFloat iconH = iconW;
        
        CGFloat iconX = width * 0.5 - 5 - iconW;
        
        CGFloat iconY = (height - iconH) * 0.5;
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
        
        self.iconImg = icon;
        
        [self addSubview:icon];
        
        CGFloat titleX = width * 0.5 + 5;
        
        CGFloat titleY = iconY;
        
        CGFloat titleW = width - titleX;
        
        CGFloat titleH = iconH;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        
        self.titleLab = title;
        
        title.font = [UIFont systemFontOfSize:15];
        
        title.textColor = [UIColor whiteColor];
        
        [self addSubview:title];
        
        UIButton *click = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        
        self.clickBtn = click;
        
        [self addSubview:click];
        
    }
    
    return self;
    
}

@end
