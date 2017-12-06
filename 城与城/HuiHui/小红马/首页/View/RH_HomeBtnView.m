//
//  RH_HomeBtnView.m
//  HuiHui
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_HomeBtnView.h"
#import "RedHorseHeader.h"

@implementation RH_HomeBtnView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        CGFloat btnW = 64;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.width - btnW) * 0.5, 10, btnW, btnW)];
        
        self.button = btn;
        
        [self addSubview:btn];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame) + 5, frame.size.width, 15)];
        
        self.label = lab;
        
        lab.textAlignment = NSTextAlignmentCenter;
        
        lab.textColor = [UIColor colorWithRed:20/255. green:20/255. blue:20/255. alpha:1.];
        
        lab.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:lab];
        
    }
    
    return self;
    
}

@end
