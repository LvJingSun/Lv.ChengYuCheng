//
//  New_HL_PriceFrame.m
//  HuiHui
//
//  Created by mac on 2017/12/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "New_HL_PriceFrame.h"
#import "LJConst.h"
#import "New_HL_PriceModel.h"

@implementation New_HL_PriceFrame

-(void)setModel:(New_HL_PriceModel *)model {
    
    _model = model;
    
}

- (CGSize)getCellSize {
    
    CGFloat lineX = _WindowViewWidth * 0.05;
    
    CGFloat lineY = 0;
    
    CGFloat lineW = _WindowViewWidth * 0.9;
    
    CGFloat lineH = 1;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat titleH = 25;
    
    CGSize titleSize = [self sizeWithText:@"优惠价：" font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(0, titleH)];
    
    CGFloat titleX = lineX;
    
    CGFloat titleY = CGRectGetMaxY(_lineF) + 10;
    
    CGFloat titleW = titleSize.width;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGSize priceSize = [self sizeWithText:self.model.price font:[UIFont systemFontOfSize:18] maxSize:CGSizeMake(0, titleH)];
    
    CGFloat priceX = CGRectGetMaxX(_titleF);
    
    CGFloat priceY = titleY;
    
    CGFloat priceW = priceSize.width;
    
    CGFloat priceH = titleH;
    
    _priceF = CGRectMake(priceX, priceY, priceW, priceH);
    
    CGSize danweiSize = [self sizeWithText:@"游戏币" font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(0, titleH)];
    
    _danweiF = CGRectMake(CGRectGetMaxX(_priceF) + 5, titleY, danweiSize.width, titleH);
    
    CGFloat sureX = _WindowViewWidth * 0.05;
    
    CGFloat sureY = CGRectGetMaxY(_titleF) + 20;
    
    CGFloat sureW = _WindowViewWidth * 0.9;
    
    CGFloat sureH = 50;
    
    _rechargeF = CGRectMake(sureX, sureY, sureW, sureH);
    
    _size = CGSizeMake(_WindowViewWidth, CGRectGetMaxY(_rechargeF));
    
    return _size;
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
