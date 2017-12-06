//
//  GoldFooterView.m
//  HuiHui
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GoldFooterView.h"
#import "RedHorseHeader.h"
#import "LJConst.h"

@implementation GoldFooterView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat lineX = 0;
        
        CGFloat lineY = 0;
        
        CGFloat lineW = ScreenWidth;
        
        CGFloat lineH = 0.5;
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
        
        line.backgroundColor = [UIColor colorWithRed:235/255. green:235/255. blue:235/255. alpha:1.];
        
        [self addSubview:line];
        
        CGFloat line2W = 0.5;
        
        CGFloat line2H = 60;
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth - line2W) * 0.5, 0, line2W, line2H)];
        
        line2.backgroundColor = [UIColor colorWithRed:235/255. green:235/255. blue:235/255. alpha:1.];
        
        [self addSubview:line2];
        
        CGFloat inX = 0;
        
        CGFloat inY = CGRectGetMaxY(line.frame);
        
        CGFloat inW = (ScreenWidth - line2W) * 0.5;
        
        CGFloat inH = line2H;
        
        UIButton *inBtn = [[UIButton alloc] initWithFrame:CGRectMake(inX, inY, inW, inH)];
        
        [inBtn setTitleColor:FSB_StyleCOLOR forState:0];
        
        inBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        
        [inBtn setTitle:@"获取" forState:0];
        
        [inBtn addTarget:self action:@selector(inClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:inBtn];
        
        CGFloat outX = CGRectGetMaxX(line2.frame);
        
        CGFloat outY = CGRectGetMaxY(line.frame);
        
        CGFloat outW = (ScreenWidth - line2W) * 0.5;
        
        CGFloat outH = line2H;
        
        UIButton *outBtn = [[UIButton alloc] initWithFrame:CGRectMake(outX, outY, outW, outH)];
        
        [outBtn setTitleColor:FSB_StyleCOLOR forState:0];
        
        outBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        
        [outBtn setTitle:@"卖出" forState:0];
        
        [outBtn addTarget:self action:@selector(outClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:outBtn];
        
        self.height = CGRectGetMaxY(outBtn.frame);
        
    }
    
    return self;
    
}

- (void)inClick {

    if (self.getInBlock) {
        
        self.getInBlock();
        
    }
    
}

- (void)outClick {

    if (self.getOutBlock) {
        
        self.getOutBlock();
        
    }
    
}

@end
