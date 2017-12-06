//
//  GoldPriceFrame.m
//  HuiHui
//
//  Created by mac on 2017/9/1.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GoldPriceFrame.h"
#import "GoldPriceModel.h"
#import "GameGoldHeader.h"

@implementation GoldPriceFrame

-(void)setPricemodel:(GoldPriceModel *)pricemodel {

    _pricemodel = pricemodel;
    
    CGFloat titleX = ScreenWidth * 0.05;
    
    CGFloat titleY = 10;
    
    CGSize size = [self sizeWithText:@"奖励金金价：" font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(0, 0)];
    
    CGFloat titleW = size.width;
    
    CGFloat titleH = size.height;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat priceX = CGRectGetMaxX(_titleF);
    
    CGFloat priceY = titleY;
    
    CGFloat priceW = ScreenWidth * 0.75 - priceX;
    
    CGFloat priceH = titleH;
    
    _priceF = CGRectMake(priceX, priceY, priceW, priceH);
    
    CGFloat dateX = CGRectGetMaxX(_priceF);
    
    CGFloat dateY = titleY;
    
    CGFloat dateW = ScreenWidth * 0.15;
    
    CGFloat dateH = titleH;
    
    _dateF = CGRectMake(dateX, dateY, dateW, dateH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_titleF) + titleY;
    
    CGFloat lineW = ScreenWidth;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
