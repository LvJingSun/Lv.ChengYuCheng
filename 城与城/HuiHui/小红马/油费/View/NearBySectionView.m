//
//  NearBySectionView.m
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "NearBySectionView.h"
#import "RedHorseHeader.h"

@implementation NearBySectionView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
        
        line.backgroundColor = Near_LineColor;
        
        [self addSubview:line];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.036, 10, 30, 30)];
        
        icon.image = [UIImage imageNamed:@"Near_location.png"];
        
        [self addSubview:icon];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + 10, CGRectGetMaxY(line.frame) + 9.5, ScreenWidth * 0.5, 30)];
        
        self.titleLab = title;
        
        title.font = Near_TitleFont;
        
        title.textColor = Near_TitleColor;
        
        [self addSubview:title];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 34, 13, 24, 24)];
        
        [btn setImage:[UIImage imageNamed:@"NearBy_More.png"] forState:0];
        
        [self addSubview:btn];

        self.height = CGRectGetMaxY(title.frame) + 10;
        
        UIButton *clickBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.height)];
        
        [clickBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:clickBtn];
        
    }
    
    return self;
    
}

- (void)btnClick {

    if (self.nearByBlock) {
        
        self.nearByBlock();
        
    }
    
}

@end
