//
//  HL_PromoterDetailHeadView.m
//  HuiHui
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_PromoterDetailHeadView.h"
#import "LJConst.h"

@implementation HL_PromoterDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat iconW = 70;
        
        CGFloat iconH = iconW;
        
        CGFloat iconX = (_WindowViewWidth - iconW) * 0.5;
        
        CGFloat iconY = 10;
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
        
        self.iconImg = icon;
        
        icon.layer.masksToBounds = YES;
        
        icon.layer.cornerRadius = iconH * 0.5;
        
        icon.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:icon];
        
        CGFloat nickX = _WindowViewWidth * 0.05;
        
        CGFloat nickY = 10 + CGRectGetMaxY(icon.frame);
        
        CGFloat nickW = _WindowViewWidth * 0.9;
        
        CGFloat nickH = 20;
        
        UILabel *nick = [[UILabel alloc] initWithFrame:CGRectMake(nickX, nickY, nickW, nickH)];
        
        self.nickLab = nick;
        
        nick.textColor = [UIColor darkTextColor];
        
        nick.textAlignment = NSTextAlignmentCenter;
        
        nick.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:nick];
        
        CGFloat nameX = _WindowViewWidth * 0.05;
        
        CGFloat nameY = 5 + CGRectGetMaxY(nick.frame);
        
        CGFloat nameW = _WindowViewWidth * 0.9;
        
        CGFloat nameH = 15;
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        
        self.nameLab = name;
        
        name.textColor = [UIColor darkTextColor];
        
        name.textAlignment = NSTextAlignmentCenter;
        
        name.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:name];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(name.frame) + 10, _WindowViewWidth, 10)];
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line];
        
        self.height = CGRectGetMaxY(line.frame);
        
    }
    
    return self;
    
}

@end
