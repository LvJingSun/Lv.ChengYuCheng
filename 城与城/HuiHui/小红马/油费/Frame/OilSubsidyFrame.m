//
//  OilSubsidyFrame.m
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "OilSubsidyFrame.h"
#import "RedHorseHeader.h"
#import "OilSubsidyModel.h"

@implementation OilSubsidyFrame

-(void)setSubsidyModel:(OilSubsidyModel *)subsidyModel {

    _subsidyModel = subsidyModel;
    
    CGFloat imgX = 0;
    
    CGFloat imgY = 0;
    
    CGFloat imgW = 35;
    
    CGFloat imgH = 105;
    
    _imgF = CGRectMake(imgX, imgY, imgW, imgH);
    
    _height = CGRectGetMaxY(_imgF);
    
    CGFloat bgX = CGRectGetMaxX(_imgF) + 20;
    
    CGFloat bgY = imgY + 10;
    
    CGFloat bgW = ScreenWidth - bgX;
    
    CGFloat bgH = imgH - bgY * 2;
    
    _bgviewF = CGRectMake(bgX, bgY, bgW, bgH);
    
    CGSize titleSize = [self sizeWithText:@"金额：" font:Oil_TitleFont maxSize:CGSizeMake(0,0)];
    
    CGFloat titleW = titleSize.width;
    
    CGFloat titleH = titleSize.height;
    
    CGFloat titleX = bgX + 10;
    
    CGFloat margin = (bgH - titleH * 2) * 0.33333;
    
    CGFloat titleY = margin + bgY;
    
    _CountTitleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGSize countSize = [self sizeWithText:[NSString stringWithFormat:@"%@元",subsidyModel.count] font:Oil_ContentFont maxSize:CGSizeMake(0, 0)];
    
    CGFloat countX = CGRectGetMaxX(_CountTitleF) + 5;
    
    CGFloat countY = titleY;
    
    CGFloat countW = countSize.width;
    
    CGFloat countH = countSize.height;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat statustitleY = CGRectGetMaxY(_CountTitleF) + margin;
    
    _StatusTitleF = CGRectMake(titleX, statustitleY, titleW, titleH);
    
    CGSize statusSize = [self sizeWithText:subsidyModel.status font:Oil_ContentFont maxSize:CGSizeMake(0, 0)];
    
    CGFloat statusX = countX;
    
    CGFloat statusY = statustitleY;
    
    CGFloat statusW = statusSize.width;
    
    CGFloat statusH = statusSize.height;
    
    _statusF = CGRectMake(statusX, statusY, statusW, statusH);
    
    CGSize timeSize = [self sizeWithText:subsidyModel.time font:Oil_TimeFont maxSize:CGSizeMake(0, 0)];
    
    CGFloat timeW = timeSize.width;
    
    CGFloat timeH = timeSize.height;
    
    CGFloat timeX = ScreenWidth * 0.95 - timeW;
    
    CGFloat timeY = bgY + (bgH - timeH) * 0.5;
    
    _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
