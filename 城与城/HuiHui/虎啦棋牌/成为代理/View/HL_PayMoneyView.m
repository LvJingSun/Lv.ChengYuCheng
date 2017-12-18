//
//  HL_PayMoneyView.m
//  HuiHui
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_PayMoneyView.h"
#import "LJConst.h"

@implementation HL_PayMoneyView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat width = frame.size.width;
        
        CGFloat height = frame.size.height;
        
        CGFloat moneyX = width * 0.05;
        
        CGFloat moneyW = width * 0.4;
        
        CGFloat moneyH = 30;
        
        CGFloat moneyY = (height - moneyH) * 0.5;
        
        UILabel *moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(moneyX, moneyY, moneyW, moneyH)];
        
        self.moneyLab = moneyLab;
        
        moneyLab.textColor = FSB_StyleCOLOR;
        
        moneyLab.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:moneyLab];
        
        UIButton *surebtn = [[UIButton alloc] initWithFrame:CGRectMake(width * 0.5, 0, width * 0.5, height)];
        
        [surebtn setTitle:@"确认支付" forState:0];
        
        [surebtn setBackgroundColor:FSB_StyleCOLOR];
        
        surebtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        [surebtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:surebtn];
        
    }
    
    return self;
    
}

- (void)sureClick {
    
    if (self.sureBlock) {
        
        self.sureBlock();
        
    }
    
}

@end
