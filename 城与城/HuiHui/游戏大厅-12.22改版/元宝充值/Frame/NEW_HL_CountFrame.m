//
//  NEW_HL_CountFrame.m
//  HuiHui
//
//  Created by mac on 2017/12/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "NEW_HL_CountFrame.h"
#import "LJConst.h"
#import "New_HL_CountModel.h"

@implementation NEW_HL_CountFrame

-(void)setModel:(New_HL_CountModel *)model {
    
    _model = model;
    
    CGFloat margin = 10;
    
    CGFloat width = (_WindowViewWidth * 0.9 - 2 * margin) * 0.333333;
    
    CGFloat height = width * 0.5;
    
    _countF = CGRectMake(0, 0, width, height);
    
    _size = CGSizeMake(width, height);
    
}

@end
