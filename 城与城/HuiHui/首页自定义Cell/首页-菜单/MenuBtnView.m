//
//  MenuBtnView.m
//  HuiHui
//
//  Created by mac on 2017/9/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "MenuBtnView.h"

@implementation MenuBtnView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-20)];
        
        self.btn = btn;
        
        [self addSubview:btn];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-20,frame.size.width, 20)];
        
        label.font = [UIFont systemFontOfSize:13.0f];
        
        label.textColor = [UIColor darkTextColor];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
        
        self.label = label;
        
    }
    
    return self;
    
}

@end
