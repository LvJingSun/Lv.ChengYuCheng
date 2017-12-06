//
//  SwitchCarFrame.m
//  HuiHui
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "SwitchCarFrame.h"

#import "RH_CarModel.h"
#import "RedHorseHeader.h"

@implementation SwitchCarFrame

-(void)setCarmodel:(RH_CarModel *)carmodel {
    
    _carmodel = carmodel;
    
    CGFloat lineX = 0;
    
    CGFloat lineY = 0;
    
    CGFloat lineW = ScreenWidth;
    
    CGFloat lineH = 10;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat imgX = ScreenWidth * 0.05;
    
    CGFloat imgY = CGRectGetMaxY(_lineF) + 20;
    
    CGFloat imgW = 50;
    
    CGFloat imgH = imgW;
    
    _imgF = CGRectMake(imgX, imgY, imgW, imgH);
    
    _height = CGRectGetMaxY(_imgF) + 20;
    
    CGSize carModelSize = [self sizeWithText:carmodel.carModel font:Administration_CarModelFont maxSize:CGSizeMake(0,0)];
    
    CGSize carPlateSize = [self sizeWithText:carmodel.carPlate font:Administration_CarPlateFont maxSize:CGSizeMake(0,0)];
    
    CGFloat margin = (_height - CGRectGetMaxY(_lineF) - carModelSize.height - carPlateSize.height) * 0.33333;
    
    CGFloat modelX = CGRectGetMaxX(_imgF) + imgX;
    
    CGFloat modelY = CGRectGetMaxY(_lineF) + margin;
    
    CGFloat modelW = carModelSize.width;
    
    CGFloat modelH = carModelSize.height;
    
    _carModelF = CGRectMake(modelX, modelY, modelW, modelH);
    
    CGFloat plateX = modelX;
    
    CGFloat plateY = CGRectGetMaxY(_carModelF) + margin;
    
    CGFloat plateW = carPlateSize.width;
    
    CGFloat plateH = carPlateSize.height;
    
    _carPlateF = CGRectMake(plateX, plateY, plateW, plateH);
    
    CGFloat statusW = 40;
    
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
