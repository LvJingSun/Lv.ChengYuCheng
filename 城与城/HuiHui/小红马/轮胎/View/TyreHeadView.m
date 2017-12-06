//
//  TyreHeadView.m
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "TyreHeadView.h"
#import "TyreView.h"
#import "RedHorseHeader.h"

@implementation TyreHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat viewW = (ScreenWidth - 0.5) * 0.5;
        
        CGFloat viewH = 170;
        
        TyreView *ty1 = [[TyreView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewH)];
        
        self.luntai1view = ty1;
        
        [self addSubview:ty1];
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ty1.frame), 0, 0.5, viewH * 2)];
        
        line1.backgroundColor = Near_LineColor;
        
        [self addSubview:line1];
        
        TyreView *ty2 = [[TyreView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line1.frame), 0, viewW, viewH)];
        
        self.luntai2view = ty2;
        
        [self addSubview:ty2];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(ty1.frame), viewW, 0.5)];
        
        line2.backgroundColor = Near_LineColor;
        
        [self addSubview:line2];
        
        UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line1.frame), CGRectGetMaxY(ty2.frame), viewW, 0.5)];
        
        line3.backgroundColor = Near_LineColor;
        
        [self addSubview:line3];
        
        TyreView *ty3 = [[TyreView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line2.frame), viewW, viewH)];
        
        self.luntai3view = ty3;
        
        [self addSubview:ty3];
        
        TyreView *ty4 = [[TyreView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line1.frame), CGRectGetMaxY(line3.frame), viewW, viewH)];
        
        self.luntai4view = ty4;
        
        [self addSubview:ty4];
        
        self.height = CGRectGetMaxY(ty4.frame);
        
    }
    
    return self;
    
}

@end
