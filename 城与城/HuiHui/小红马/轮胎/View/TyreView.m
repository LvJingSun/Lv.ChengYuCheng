//
//  TyreView.m
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "TyreView.h"
#import "RedHorseHeader.h"

@implementation TyreView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width * 0.036, 5, frame.size.width * 0.5, 15)];
        
        self.titleLab = lab;
        
        lab.font = Tyre_TitleFont;
        
        lab.textColor = Tyre_TitleColor;
        
        [self addSubview:lab];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 100) * 0.5, 10, 100, 100)];
        
        self.tyreImg = icon;
        
        [self addSubview:icon];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.width - 60) * 0.5, CGRectGetMaxY(icon.frame) + 20, 60, 25)];
        
        self.sendBtn = btn;
        
        btn.titleLabel.font = Tyre_BtnTitleFont;
        
        [self addSubview:btn];
        
    }
    
    return self;
    
}

@end
