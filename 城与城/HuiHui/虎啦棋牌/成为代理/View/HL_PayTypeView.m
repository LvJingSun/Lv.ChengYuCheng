//
//  HL_PayTypeView.m
//  HuiHui
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_PayTypeView.h"
#import "LJConst.h"

@implementation HL_PayTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat width = frame.size.width;
        
        CGFloat height = frame.size.height;
        
        CGFloat iconX = width * 0.05;
        
        CGFloat iconW = 30;
        
        CGFloat iconH = iconW;
        
        CGFloat iconY = (height - iconH) * 0.5;
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
        
        self.iconImg = icon;
        
        [self addSubview:icon];
        
        CGFloat titleX = CGRectGetMaxX(icon.frame) + iconX;
        
        CGFloat titleY = iconY;
        
        CGFloat titleW = width * 0.6 - titleX;
        
        CGFloat titleH = iconH;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        
        self.titleLab = title;
        
        title.textColor = [UIColor darkTextColor];
        
        title.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:title];
        
        CGFloat descX = CGRectGetMaxX(title.frame) + 10;
        
        CGFloat descY = iconY;
        
        CGFloat chooseW = 20;
        
        CGFloat descW = width * 0.9 - chooseW - descX;
        
        CGFloat descH = iconH;
        
        UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(descX, descY, descW, descH)];
        
        self.descLab = desc;
        
        desc.textColor = [UIColor darkGrayColor];
        
        desc.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:desc];
        
        CGFloat chooseX = CGRectGetMaxX(desc.frame) + iconX;
        
        CGFloat chooseH = chooseW;
        
        CGFloat chooseY = (height - chooseH) * 0.5;
        
        UIImageView *choose = [[UIImageView alloc] initWithFrame:CGRectMake(chooseX, chooseY, chooseW, chooseH)];
        
        self.chooseImg = choose;
        
        [self addSubview:choose];
        
        CGFloat lineX = width * 0.05;
        
        CGFloat lineY = height - 1;
        
        CGFloat lineW = width * 0.9;
        
        CGFloat lineH = 1;
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

@end
