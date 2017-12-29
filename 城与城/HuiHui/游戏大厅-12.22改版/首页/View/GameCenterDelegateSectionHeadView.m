//
//  GameCenterDelegateSectionHeadView.m
//  HuiHui
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameCenterDelegateSectionHeadView.h"
#import "LJConst.h"

@implementation GameCenterDelegateSectionHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat titleX = _WindowViewWidth * 0.05;
        
        CGFloat titleY = 10;
        
        CGFloat titleW = _WindowViewWidth * 0.9;
        
        CGFloat titleH = 20;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        
        self.titleLab = title;
        
        title.textColor = [UIColor darkTextColor];
        
        title.font = [UIFont systemFontOfSize:16];
        
        title.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:title];
        
        self.height = CGRectGetMaxY(title.frame);
        
    }
    
    return self;
    
}

@end
