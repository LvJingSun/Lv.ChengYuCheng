//
//  RH_FilpCellFrame.m
//  HuiHui
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_FilpCellFrame.h"
#import "RH_FilpCellModel.h"
#import "RedHorseHeader.h"

@implementation RH_FilpCellFrame

-(void)setCellModel:(RH_FilpCellModel *)cellModel {

    _cellModel = cellModel;
    
    CGFloat titleH = 20;
    
    CGSize size = [self sizeWithText:cellModel.Title font:RH_SignFont maxSize:CGSizeMake(0, titleH)];
    
    CGFloat titleW = size.width;
    
    CGFloat titleX = (ScreenWidth - titleW) * 0.5;
    
    CGFloat titleY = 10;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat leftX = titleX * 0.5 - 10;
    
    CGFloat leftH = 1;
    
    CGFloat leftW = titleX * 0.5;
    
    CGFloat leftY = titleY + (titleH - leftH) * 0.5;
    
    _leftF = CGRectMake(leftX, leftY, leftW, leftH);
    
    CGFloat rightX = CGRectGetMaxX(_titleF) + 10;
    
    CGFloat rightH = 1;
    
    CGFloat rightW = titleX * 0.5;
    
    CGFloat rightY = titleY + (titleH - leftH) * 0.5;
    
    _rightF = CGRectMake(rightX, rightY, rightW, rightH);
    
    CGFloat margin = 5;
    
    CGFloat ad1X = 0;
    
    CGFloat ad1Y = CGRectGetMaxY(_titleF) + 10;
    
    CGFloat ad1W = (ScreenWidth - margin) * 0.5;
    
    CGFloat ad1H = 85;
    
    _AD1F = CGRectMake(ad1X, ad1Y, ad1W, ad1H);
    
    CGFloat ad2X = CGRectGetMaxX(_AD1F) + margin;
    
    CGFloat ad2Y = ad1Y;
    
    CGFloat ad2W = ad1W;
    
    CGFloat ad2H = ad1H;
    
    _AD2F = CGRectMake(ad2X, ad2Y, ad2W, ad2H);
    
    CGFloat ad3X = 0;
    
    CGFloat ad3Y = CGRectGetMaxY(_AD1F) + margin;
    
    CGFloat ad3W = ad1W;
    
    CGFloat ad3H = ad1H;
    
    _AD3F = CGRectMake(ad3X, ad3Y, ad3W, ad3H);
    
    CGFloat ad4X = CGRectGetMaxX(_AD3F) + margin;
    
    CGFloat ad4Y = ad3Y;
    
    CGFloat ad4W = ad3W;
    
    CGFloat ad4H = ad3H;
    
    _AD4F = CGRectMake(ad4X, ad4Y, ad4W, ad4H);
    
    _height = CGRectGetMaxY(_AD4F);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
