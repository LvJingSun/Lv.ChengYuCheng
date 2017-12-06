//
//  TiXianTotalView.m
//  HuiHui
//
//  Created by mac on 2017/5/9.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "TiXianTotalView.h"

@implementation TiXianTotalView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        UILabel *noticeLab = [[UILabel alloc] initWithFrame:CGRectMake(WindowSizeWidth * 0.05, 15, WindowSizeWidth * 0.3, 20)];
        
        noticeLab.text = @"总提现金额";
        
        noticeLab.textColor = [UIColor blackColor];
        
        noticeLab.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:noticeLab];
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(WindowSizeWidth * 0.4, 15, WindowSizeWidth * 0.55, 20)];
        
        self.countLab = count;
        
        count.textAlignment = NSTextAlignmentRight;
        
        count.textColor = [UIColor darkGrayColor];
        
        count.font = [UIFont systemFontOfSize:18];
        
        [self addSubview:count];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(count.frame) + 14, WindowSizeWidth, 1)];
        
        line.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:line];
        
        self.height = CGRectGetMaxY(line.frame);
        
    }
    
    return self;
    
}

@end
