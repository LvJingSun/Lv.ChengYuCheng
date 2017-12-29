//
//  New_HL_OtherFrame.m
//  HuiHui
//
//  Created by mac on 2017/12/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "New_HL_OtherFrame.h"
#import "LJConst.h"
#import "New_HL_OtherModel.h"

@implementation New_HL_OtherFrame

-(void)setModel:(New_HL_OtherModel *)model {
    
    _model = model;
    
    CGFloat titleX = _WindowViewWidth * 0.05;
    
    CGFloat titleY = 20;
    
    CGFloat titleW = _WindowViewWidth * 0.9;
    
    CGFloat titleH = 20;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat countX = titleX;
    
    CGFloat countY = CGRectGetMaxY(_titleF) + 10;
    
    CGFloat countW = _WindowViewWidth * 0.9;
    
    CGFloat countH = 50;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    _size = CGSizeMake(_WindowViewWidth, CGRectGetMaxY(_countF) + 15);
    
}

@end
