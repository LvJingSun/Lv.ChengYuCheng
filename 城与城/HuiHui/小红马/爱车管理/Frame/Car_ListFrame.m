//
//  Car_ListFrame.m
//  HuiHui
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Car_ListFrame.h"
#import "RH_CarModel.h"
#import "RedHorseHeader.h"

@implementation Car_ListFrame

-(void)setCarmodel:(RH_CarModel *)carmodel {

    _carmodel = carmodel;
    
    CGFloat lineX = 0;
    
    CGFloat lineY = 0;
    
    CGFloat lineW = ScreenWidth;
    
    CGFloat lineH = 15;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat imgX = ScreenWidth * 0.05;
    
    CGFloat imgY = CGRectGetMaxY(_lineF) + 10;
    
    CGFloat imgW = 50;
    
    CGFloat imgH = imgW;
    
    _imgF = CGRectMake(imgX, imgY, imgW, imgH);
    
    CGFloat d_iconX = ScreenWidth * 0.036;
    
    CGFloat d_iconY = CGRectGetMaxY(_imgF) + 10;

    CGSize d_titleSize = [self sizeWithText:@"默认车辆" font:Administration_DefaultTitleFont maxSize:CGSizeMake(0,0)];
    
    CGFloat d_iconW = d_titleSize.height;
    
    CGFloat d_iconH = d_iconW;
    
    _defaultImgF = CGRectMake(d_iconX, d_iconY, d_iconW, d_iconH);
    
    CGFloat d_titleX = d_iconX + d_iconW + 5;
    
    CGFloat d_titleW = d_titleSize.width;
    
    CGFloat d_titleH = d_titleSize.height;
    
    CGFloat d_titleY = _defaultImgF.origin.y;
    
    _defaultTitleF = CGRectMake(d_titleX, d_titleY, d_titleW, d_titleH);
    
    _height = CGRectGetMaxY(_defaultTitleF) + 5;
    
    CGSize carModelSize = [self sizeWithText:carmodel.carModel font:Administration_CarModelFont maxSize:CGSizeMake(0,0)];
    
    CGSize carPlateSize = [self sizeWithText:carmodel.carPlate font:Administration_CarPlateFont maxSize:CGSizeMake(0,0)];
    
    CGFloat modelX = CGRectGetMaxX(_defaultTitleF) + 30;
    
    CGFloat margin = (_height - CGRectGetMaxY(_lineF) - carModelSize.height - carPlateSize.height) * 0.33333;
    
    CGFloat modelY = CGRectGetMaxY(_lineF) + margin;
    
    CGFloat modelW = carModelSize.width;
    
    CGFloat modelH = carModelSize.height;
    
    _carModelF = CGRectMake(modelX, modelY, modelW, modelH);
    
    CGFloat plateX = modelX;
    
    CGFloat plateY = CGRectGetMaxY(_carModelF) + margin;
    
    CGFloat plateW = carPlateSize.width;
    
    CGFloat plateH = carPlateSize.height;
    
    _carPlateF = CGRectMake(plateX, plateY, plateW, plateH);
    
    CGFloat statusW = 50;
    
    CGFloat statusH = statusW;
    
    CGFloat statusX = ScreenWidth * 0.968 - statusW;
    
    CGFloat statusY = (_height - CGRectGetMaxY(_lineF) - statusH) * 0.5 + CGRectGetMaxY(_lineF);
    
    _carStatusF = CGRectMake(statusX, statusY, statusW, statusH);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
