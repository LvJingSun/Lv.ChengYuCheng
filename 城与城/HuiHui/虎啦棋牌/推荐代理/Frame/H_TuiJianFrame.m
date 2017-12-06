//
//  H_TuiJianFrame.m
//  HuiHui
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "H_TuiJianFrame.h"
#import "LJConst.h"
#import "H_TuiJianModel.h"

@implementation H_TuiJianFrame

-(void)setModel:(H_TuiJianModel *)model {
    
    _model = model;
    
    CGFloat imgX = _WindowViewWidth * 0.05;
    
    CGFloat imgY = 20;
    
    CGFloat imgW = _WindowViewWidth * 0.4;
    
    CGFloat imgH = imgW;
    
    _imgF = CGRectMake(imgX, imgY, imgW, imgH);
    
    CGFloat shareX = CGRectGetMaxX(_imgF) + _WindowViewWidth * 0.05;
    
    CGFloat shareY = imgY;
    
    CGFloat shareW = _WindowViewWidth * 0.95 - shareX;
    
    CGFloat shareH = (imgH - 50) * 0.33333;
    
    _shareF = CGRectMake(shareX, shareY, shareW, shareH);
    
    CGFloat copyY = CGRectGetMaxY(_shareF) + 25;
    
    _copyF = CGRectMake(shareX, copyY, shareW, shareH);
    
    CGFloat emailY = CGRectGetMaxY(_copyF) + 25;
    
    _emailF = CGRectMake(shareX, emailY, shareW, shareH);
    
    _height = CGRectGetMaxY(_imgF) + imgY;
    
}

@end
