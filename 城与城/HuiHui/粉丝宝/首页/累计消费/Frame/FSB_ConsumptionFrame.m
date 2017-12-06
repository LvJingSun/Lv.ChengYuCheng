//
//  FSB_ConsumptionFrame.m
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_ConsumptionFrame.h"
#import "FSB_ConsumptionModel.h"
#import "LJConst.h"

@implementation FSB_ConsumptionFrame

-(void)setConsumptionModel:(FSB_ConsumptionModel *)consumptionModel {

    _consumptionModel = consumptionModel;
    
    CGFloat typeX = _WindowViewWidth * 0.05;
    
    CGFloat typeY = 10;
    
    CGFloat typeH = 20;
    
    CGSize size = [self sizeWithText:[NSString stringWithFormat:@"%@",consumptionModel.OrderStatus] font:FSB_ConsumptionOrderStatusFont maxSize:CGSizeMake(0, typeH)];
    
    CGFloat typeW = size.width;
    
    _typeF = CGRectMake(typeX, typeY, typeW, typeH);
    
    CGFloat voucherX = CGRectGetMaxX(_typeF) + 5;
    
    CGFloat voucherY = 10;
    
    CGFloat voucherW = 20;
    
    CGFloat voucherH = voucherW;
    
    _voucherF = CGRectMake(voucherX, voucherY, voucherW, voucherH);
    
    CGFloat countX = _WindowViewWidth * 0.5;
    
    CGFloat countY = 10;
    
    CGFloat countW = _WindowViewWidth * 0.45;
    
    CGFloat countH = 20;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat dateX = _WindowViewWidth * 0.05;
    
    CGFloat dateY = CGRectGetMaxY(_typeF) + 5;
    
    CGFloat dateW = _WindowViewWidth * 0.45;
    
    CGFloat dateH = 20;
    
    _dateF = CGRectMake(dateX, dateY, dateW, dateH);
    
    CGFloat shopX = _WindowViewWidth * 0.5;
    
    CGFloat shopY = dateY;
    
    CGFloat shopW = dateW;
    
    CGFloat shopH = dateH;
    
    _shopF = CGRectMake(shopX, shopY, shopW, shopH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_shopF) + 9.5;
    
    CGFloat lineW = _WindowViewWidth;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
