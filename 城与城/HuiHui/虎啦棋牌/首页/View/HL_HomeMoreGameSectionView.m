//
//  HL_HomeMoreGameSectionView.m
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_HomeMoreGameSectionView.h"
#import "LJConst.h"

@implementation HL_HomeMoreGameSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
//
//        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, SectionHeight, _WindowViewWidth, 40)];
//
//        bg.backgroundColor = [UIColor whiteColor];
//
//        [self addSubview:bg];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(_WindowViewWidth * 0.05, 0, _WindowViewWidth * 0.4, 40)];
        
        title.text = @"更多游戏";
        
        title.font = [UIFont systemFontOfSize:16];
        
        title.textColor = [UIColor darkTextColor];
        
        [self addSubview:title];
        
        UILabel *more = [[UILabel alloc] initWithFrame:CGRectMake(_WindowViewWidth * 0.7, 0, _WindowViewWidth * 0.25, 40)];
        
        more.textColor = [UIColor darkGrayColor];
        
        more.text = @"查看";
        
        more.textAlignment = NSTextAlignmentRight;
        
        more.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:more];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, 40)];
        
        [btn addTarget:self action:@selector(lookClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(_WindowViewWidth * 0.05, CGRectGetMaxY(title.frame), _WindowViewWidth * 0.9, 1)];
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line];
        
        self.height = CGRectGetMaxY(line.frame);
        
    }
    
    return self;
    
}

- (void)lookClick {
    
    if (self.lookBlock) {
        
        self.lookBlock();
        
    }
    
}

@end
