//
//  H_BecomeDelegateFrame.m
//  HuiHui
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "H_BecomeDelegateFrame.h"
#import "LJConst.h"
#import "H_BecomeDelegateModel.h"

@implementation H_BecomeDelegateFrame

-(void)setModel:(H_BecomeDelegateModel *)model {
    
    _model = model;
    
    CGFloat titleX = 0;
    
    CGFloat titleY = 20;
    
    CGFloat titleW = _WindowViewWidth * 0.25;
    
    CGFloat titleH = 30;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat priceX = CGRectGetMaxX(_titleF);
    
    CGFloat priceY = 15;
    
    CGFloat priceW = _WindowViewWidth * 0.25;
    
    CGFloat priceH = 25;
    
    _priceF = CGRectMake(priceX, priceY, priceW, priceH);
    
    CGFloat originalY = CGRectGetMaxY(_priceF);
    
    CGFloat originalH = 15;
    
    CGSize size = [self sizeWithText:model.OriginalPrice font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(0, originalH)];
    
    CGFloat originalX = priceX + (priceW - size.width) * 0.5;
    
    CGFloat originalW = size.width;
    
    _OriginalF = CGRectMake(originalX, originalY, originalW, originalH);
    
    CGFloat lineX = originalX;
    
    CGFloat lineY = originalY + originalH * 0.5;
    
    CGFloat lineW = originalW;
    
    CGFloat lineH = 1;
    
    _OriginalLineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat lookX = CGRectGetMaxX(_priceF);
    
    CGFloat lookY = titleY;
    
    CGFloat lookW = _WindowViewWidth * 0.25;
    
    CGFloat lookH = titleH;
    
    _lookF = CGRectMake(lookX, lookY, lookW, lookH);
    
    CGFloat buyX = CGRectGetMaxX(_lookF) + _WindowViewWidth * 0.05;
    
    CGFloat buyY = titleY;
    
    CGFloat buyW = _WindowViewWidth * 0.15;
    
    CGFloat buyH = titleH;
    
    _buyF = CGRectMake(buyX, buyY, buyW, buyH);
    
    _height = CGRectGetMaxY(_buyF) + 5;
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
