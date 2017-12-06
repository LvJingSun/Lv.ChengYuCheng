//
//  F_H_CellFrame.m
//  HuiHui
//
//  Created by mac on 2017/6/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "F_H_CellFrame.h"
#import "F_H_CellModel.h"
#import "LJConst.h"

@implementation F_H_CellFrame

-(void)setCellModel:(F_H_CellModel *)cellModel {

    _cellModel = cellModel;
    
    CGFloat bgX = 0;
    
    CGFloat bgY = 20;
    
    CGFloat bgW = _WindowViewWidth;
    
    CGFloat bgH = _WindowViewWidth * 0.3;
    
    _BGF = CGRectMake(bgX, bgY, bgW, bgH);
    
    _height = CGRectGetMaxY(_BGF);
    
    CGFloat leftWidth = _WindowViewWidth * 0.75;
    
    CGFloat rightWidth = _WindowViewWidth * 0.25;
    
    CGFloat margin = 15;
    
    CGFloat iconW = bgH - 3 * margin - 20;
    
    CGFloat iconH = iconW;
    
    CGFloat iconX = leftWidth + (rightWidth - _WindowViewWidth * 0.03 - iconW) * 0.5;
    
    CGFloat iconY = bgY + margin;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat buttonW = 50;
    
    CGFloat buttonH = 20;
    
    CGFloat buttonX = leftWidth + (rightWidth - _WindowViewWidth * 0.03 - buttonW) * 0.5;
    
    CGFloat buttonY = CGRectGetMaxY(_iconF) + margin;
    
    _getF = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    
    CGFloat nameX = _WindowViewWidth * 0.1;
    
    CGFloat nameY = margin + bgY;
    
    CGFloat nameW = leftWidth - _WindowViewWidth * 0.03 - nameX;
    
    CGFloat nameH = 30;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat marginHeight = bgH * 0.04;
    
    CGFloat imgX = _WindowViewWidth * 0.04;
    
    CGFloat imgY = bgY + marginHeight;
    
    CGFloat imgW = leftWidth - imgX;
    
    CGFloat imgH = bgH - 2 * marginHeight;
    
    _ImgF = CGRectMake(imgX, imgY, imgW, imgH);
    
    if (![self isBlankString:cellModel.ztinfo]) {
        
        CGFloat countX = nameX;
        
        CGFloat countY = CGRectGetMaxY(_nameF) + margin * 0.5;
        
        CGFloat countW = nameW;
        
        CGFloat countH = 20;
        
        _countF = CGRectMake(countX, countY, countW, countH);
        
        CGFloat descX = nameX;
        
        CGFloat descY = CGRectGetMaxY(_countF) + margin * 0.5;
        
        CGFloat descW = nameW;
        
        CGFloat descH = 20;
        
        _ztDescF = CGRectMake(descX, descY, descW, descH);
        
    }else {
    
        CGFloat countX = nameX;
        
        CGFloat countY = CGRectGetMaxY(_nameF) + margin;
        
        CGFloat countW = nameW;
        
        CGFloat countH = 20;
        
        _countF = CGRectMake(countX, countY, countW, countH);
        
    }
    
}

- (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
