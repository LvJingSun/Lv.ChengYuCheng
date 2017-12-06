//
//  RH_BoFrame.m
//  HuiHui
//
//  Created by mac on 2017/8/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_BoFrame.h"
#import "RedHorseHeader.h"
#import "RH_BoModel.h"

@implementation RH_BoFrame

-(void)setBomodel:(RH_BoModel *)bomodel {

    _bomodel = bomodel;
    
    CGSize size = [self sizeWithText:bomodel.title font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(0, 0)];
    
    CGFloat titleW = size.width;
    
    CGFloat titleH = size.height;
    
    CGFloat titleX = (ScreenWidth - titleW) * 0.5;
    
    CGFloat titleY = 20;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    _height = CGRectGetMaxY(_titleF) + titleY;
    
    CGFloat leftX = ScreenWidth * 0.05;
    
    CGFloat leftH = 0.5;
    
    CGFloat leftY = (self.height - leftH) * 0.5;
    
    CGFloat leftW = titleX - leftX * 2;
    
    _leftF = CGRectMake(leftX, leftY, leftW, leftH);
    
    CGFloat rightX = CGRectGetMaxX(_titleF) + leftX;
    
    CGFloat rightH = leftH;
    
    CGFloat rightW = ScreenWidth - leftX - rightX;
    
    CGFloat rightY = leftY;
    
    _rightF = CGRectMake(rightX, rightY, rightW, rightH);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
