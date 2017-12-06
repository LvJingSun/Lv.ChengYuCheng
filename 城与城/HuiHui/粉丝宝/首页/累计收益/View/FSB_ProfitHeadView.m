//
//  FSB_ProfitHeadView.m
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_ProfitHeadView.h"
#import "LJConst.h"

@implementation FSB_ProfitHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat titleX = _WindowViewWidth * 0.05;
        
        CGFloat titleY = 15;
        
        CGFloat titleW = _WindowViewWidth * 0.9;
        
        CGFloat titleH = 10;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        
        title.font = FSB_YesterdayProfitTitleFont;
        
        title.textColor = FSB_CumulativeProfitTitleCOLOR;
        
        title.textAlignment = NSTextAlignmentCenter;
        
        title.text = @"累计收益(元)";
        
        [self addSubview:title];
        
        CGFloat countX = _WindowViewWidth * 0.05;
        
        CGFloat countY = CGRectGetMaxY(title.frame) + 10;
        
        CGFloat countW = _WindowViewWidth * 0.9;
        
        CGFloat countH = 50;
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(countX, countY, countW, countH)];
        
        self.countLab = count;
        
        count.textAlignment = NSTextAlignmentCenter;
        
        count.textColor = FSB_StyleCOLOR;
        
        count.font = FSB_YesterdayProfitFont;
        
        [self addSubview:count];
        
        CGFloat lineX = 0;
        
        CGFloat lineY = CGRectGetMaxY(count.frame) + 9;
        
        CGFloat lineW = _WindowViewWidth;
        
        CGFloat lineH = 1;
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
        
        line.backgroundColor = FSB_LineCOLOR;
        
        [self addSubview:line];
        
        self.height = CGRectGetMaxY(line.frame);
        
    }
    
    return self;
    
}

@end
