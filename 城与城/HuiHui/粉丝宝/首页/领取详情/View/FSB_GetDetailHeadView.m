//
//  FSB_GetDetailHeadView.m
//  HuiHui
//
//  Created by mac on 2017/7/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_GetDetailHeadView.h"
#import "LJConst.h"

@implementation FSB_GetDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = FSB_ViewBGCOLOR;
        
        CGFloat iconW = 70;
        
        CGFloat iconX = (_WindowViewWidth - iconW) * 0.5;
        
        CGFloat iconY = 20;
        
        CGFloat iconH = iconW;
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
        
        self.iconImg = icon;
        
        icon.layer.masksToBounds = YES;
        
        icon.layer.cornerRadius = iconW * 0.5;
        
        [self addSubview:icon];
        
        CGFloat nameX = _WindowViewWidth * 0.1;
        
        CGFloat nameY = CGRectGetMaxY(icon.frame) + 10;
        
        CGFloat nameW = _WindowViewWidth * 0.8;
        
        CGFloat nameH = 20;
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        
        self.nameLab = name;
        
        name.textColor = [UIColor blackColor];
        
        name.font = [UIFont systemFontOfSize:17];
        
        name.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:name];
        
        CGFloat countX = _WindowViewWidth * 0.1;
        
        CGFloat countY = CGRectGetMaxY(name.frame) + 20;
        
        CGFloat countW = _WindowViewWidth * 0.8;
        
        CGFloat countH = 40;
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(countX, countY, countW, countH)];
        
        self.countLab = count;
        
        count.textColor = [UIColor colorWithRed:0/255. green:182/255. blue:255/255. alpha:1.];
        
        count.font = [UIFont systemFontOfSize:40];
        
        count.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:count];
        
        self.height = CGRectGetMaxY(count.frame) + 20;
        
    }
    
    return self;
    
}

@end
