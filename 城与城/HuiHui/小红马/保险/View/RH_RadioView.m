//
//  RH_RadioView.m
//  HuiHui
//
//  Created by mac on 2017/6/9.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_RadioView.h"
#import "RedHorseHeader.h"

@implementation RH_RadioView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, (frame.size.height - 20) * 0.5, 20, 20)];
        
        self.btn = btn;
        
        [self addSubview:btn];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame) + 3, 0, frame.size.width - CGRectGetMaxX(btn.frame) - 3, frame.size.height)];
        
        self.title = title;
        
        title.textColor = CarInfo_TitleColor;
        
        title.font = RH_RadioFont;
        
        title.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:title];
        
    }
    
    return self;
    
}

@end
