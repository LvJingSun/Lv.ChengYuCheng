//
//  ShareBtnView.m
//  HuiHui
//
//  Created by mac on 2017/6/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "ShareBtnView.h"

@implementation ShareBtnView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.width - 60) * 0.5, 10, 60, 60)];
        
        self.button = btn;
        
        [self addSubview:btn];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame) + 10, frame.size.width, 10)];
        
        self.title = lab;
        
        lab.textAlignment = NSTextAlignmentCenter;
        
        lab.textColor = [UIColor darkGrayColor];
        
        lab.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:lab];
        
    }
    
    return self;
    
}

@end
