//
//  RepairMaintainFrame.m
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RepairMaintainFrame.h"
#import "RepairMaintainModel.h"
#import "RedHorseHeader.h"

@implementation RepairMaintainFrame

-(void)setRepairModel:(RepairMaintainModel *)repairModel {

    _repairModel = repairModel;
    
    CGFloat imgX = ScreenWidth * 0.036;
    
    CGFloat imgY = 40;
    
    CGFloat imgW = 48;
    
    CGFloat imgH = 48;
    
    _imgF = CGRectMake(imgX, imgY, imgW, imgH);
    
    _height = CGRectGetMaxY(_imgF) + imgY;
    
    CGFloat bgX = CGRectGetMaxX(_imgF) + imgX;
    
    CGFloat bgY = 5;
    
    CGFloat bgW = ScreenWidth - bgX;
    
    CGFloat bgH = _height - bgY * 2;
    
    _bgviewF = CGRectMake(bgX, bgY, bgW, bgH);
    
    CGSize titleSize = [self sizeWithText:@"金额：" font:Oil_TitleFont maxSize:CGSizeMake(0,0)];
    
    CGFloat titleW = titleSize.width;
    
    CGFloat titleH = titleSize.height;
    
    CGFloat titleX = bgX + 20;
    
    CGFloat margin = (bgH - titleH * 3) * 0.25;
    
    CGFloat titleY = margin + bgY;
    
    _CountTitleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGSize countSize = [self sizeWithText:[NSString stringWithFormat:@"%@元",repairModel.count] font:Oil_ContentFont maxSize:CGSizeMake(0, 0)];
    
    CGFloat countX = CGRectGetMaxX(_CountTitleF) + 5;
    
    CGFloat countY = titleY;
    
    CGFloat countW = countSize.width;
    
    CGFloat countH = countSize.height;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat statustitleY = CGRectGetMaxY(_CountTitleF) + margin;
    
    _StatusTitleF = CGRectMake(titleX, statustitleY, titleW, titleH);
    
    CGSize statusSize = [self sizeWithText:repairModel.status font:Oil_ContentFont maxSize:CGSizeMake(0, 0)];
    
    CGFloat statusX = countX;
    
    CGFloat statusY = statustitleY;
    
    CGFloat statusW = statusSize.width;
    
    CGFloat statusH = statusSize.height;
    
    _statusF = CGRectMake(statusX, statusY, statusW, statusH);
    
    CGSize contentTitleSize = [self sizeWithText:@"服务内容：" font:Oil_TitleFont maxSize:CGSizeMake(0, 0)];
    
    CGFloat contentTitleW = contentTitleSize.width;
    
    CGFloat contentTitleH = contentTitleSize.height;
    
    CGFloat contentTitleX = titleX;
    
    CGFloat contentTitleY = CGRectGetMaxY(_StatusTitleF) + margin;
    
    _ContentTitleF = CGRectMake(contentTitleX, contentTitleY, contentTitleW, contentTitleH);
    
    CGSize contentSize = [self sizeWithText:repairModel.content font:Oil_ContentFont maxSize:CGSizeMake(0, 0)];
    
    CGFloat contentX = CGRectGetMaxX(_ContentTitleF) + 5;
    
    CGFloat contentY = contentTitleY;
    
    CGFloat contentW = contentSize.width;
    
    CGFloat contentH = contentSize.height;
    
    _contentF = CGRectMake(contentX, contentY, contentW, contentH);
    
    CGSize timeSize = [self sizeWithText:repairModel.time font:Oil_TimeFont maxSize:CGSizeMake(0, 0)];
    
    CGFloat timeW = timeSize.width;
    
    CGFloat timeH = timeSize.height;
    
    CGFloat timeX = ScreenWidth * 0.95 - timeW;
    
    CGFloat timeY = bgY + margin;
    
    _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
