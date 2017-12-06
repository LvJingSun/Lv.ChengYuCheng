//
//  RH_GetHeadView.m
//  HuiHui
//
//  Created by mac on 2017/8/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_GetHeadView.h"
#import "RedHorseHeader.h"
#import "LJConst.h"

@implementation RH_GetHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat titleX = ScreenWidth * 0.05;
        
        CGFloat titleY = 15;
        
        CGFloat titleW = ScreenWidth * 0.9;
        
        CGFloat titleH = 10;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        
        title.font = FSB_YesterdayProfitTitleFont;
        
        title.textColor = FSB_CumulativeProfitTitleCOLOR;
        
        title.textAlignment = NSTextAlignmentCenter;
        
        self.titleLab = title;
        
        [self addSubview:title];
        
        CGFloat countX = _WindowViewWidth * 0.05;
        
        CGFloat countY = CGRectGetMaxY(title.frame) + 10;
        
        CGFloat countW = _WindowViewWidth * 0.9;
        
        CGFloat countH = 50;
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(countX, countY, countW, countH)];
        
        self.countLab = count;
        
        count.textAlignment = NSTextAlignmentCenter;
        
        count.textColor = RH_ThemeColor;
        
        count.font = FSB_YesterdayProfitFont;
        
        count.text = @"暂无数据";
        
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
