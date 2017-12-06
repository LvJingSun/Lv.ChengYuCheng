//
//  MyWallet_HeadView.m
//  HuiHui
//
//  Created by mac on 2017/6/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "MyWallet_HeadView.h"
#import "RedHorseHeader.h"

@implementation MyWallet_HeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.05, 20, ScreenWidth * 0.9, 20)];
        
        title.text = @"我的余额（元）";
        
        title.textColor = [UIColor whiteColor];
        
        title.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:title];
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.05, CGRectGetMaxY(title.frame) + 20, ScreenWidth * 0.9, 50)];
        
        count.textColor = [UIColor whiteColor];
        
        count.font = [UIFont systemFontOfSize:50];
        
        count.text = @"0.00";
        
        self.balanceLab = count;
        
        [self addSubview:count];
        
        self.height = CGRectGetMaxY(count.frame) + 20;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.height)];
        
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
    }
    
    return self;
    
}

- (void)btnClick {

    if (self.countBlock) {
        
        self.countBlock();
        
    }
    
}

@end
