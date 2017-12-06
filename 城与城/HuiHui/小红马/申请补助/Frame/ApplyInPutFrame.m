//
//  ApplyInPutFrame.m
//  HuiHui
//
//  Created by mac on 2017/6/10.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "ApplyInPutFrame.h"
#import "ApplySubsidyModel.h"
#import "RedHorseHeader.h"

@implementation ApplyInPutFrame

-(void)setApplymodel:(ApplySubsidyModel *)applymodel {

    _applymodel = applymodel;
    
    CGFloat titleX = ScreenWidth * 0.032;
    
    CGFloat titleY = 15;
    
    CGFloat titleW = ScreenWidth * 0.936;
    
    CGFloat titleH = 20;
    
    _typeTitleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat margin = 20;
    
    CGFloat youfeiX = ScreenWidth * 0.1;
    
    CGFloat radioW = (ScreenWidth - 2 * youfeiX) * 0.33333;
    
    CGFloat radioH = 30;

    CGFloat youfeiY = CGRectGetMaxY(_typeTitleF) + margin;
    
    _youfeiF = CGRectMake(youfeiX, youfeiY, radioW, radioH);
    
//    CGFloat baoxianX = CGRectGetMaxX(_youfeiF);
//    
//    _baoxianF = CGRectMake(baoxianX, youfeiY, radioW, radioH);
    
    CGFloat baoyangX = CGRectGetMaxX(_youfeiF);
    
    _baoyangF = CGRectMake(baoyangX, youfeiY, radioW, radioH);
    
//    CGFloat luntaiX = CGRectGetMaxX(_baoyangF);
    
//    _luntaiF = CGRectMake(luntaiX, youfeiY, radioW, radioH);
    
    CGFloat xiuliX = CGRectGetMaxX(_baoyangF);
    
    _xiuliF = CGRectMake(xiuliX, youfeiY, radioW, radioH);
    
    CGFloat line1X = 0;
    
    CGFloat line1Y = CGRectGetMaxY(_youfeiF) + margin;
    
    CGFloat line1W = ScreenWidth;
    
    CGFloat line1H = 10;
    
    _line1F = CGRectMake(line1X, line1Y, line1W, line1H);
    
    CGFloat mm = 15;
    
    CGSize countSize = [self sizeWithText:@"金额" font:CarInfo_TitleFont maxSize:CGSizeMake(0,0)];
    
    CGFloat counttitleX = ScreenWidth * 0.05;
    
    CGFloat counttitleY = mm + CGRectGetMaxY(_line1F);
    
    CGFloat counttitleW = countSize.width;
    
    CGFloat counttitleH = countSize.height;
    
    _countTitleF = CGRectMake(counttitleX, counttitleY, counttitleW, counttitleH);
    
    CGFloat countX = CGRectGetMaxX(_countTitleF) + 20;
    
    CGFloat countH = 30;
    
    CGFloat countY = (counttitleH + 2 * mm - countH) * 0.5 + CGRectGetMaxY(_line1F);
    
    CGFloat countW = ScreenWidth * 0.95 - countX;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat countLineX = 0;
    
    CGFloat countLineY = CGRectGetMaxY(_countTitleF) + mm;
    
    CGFloat countLineW = ScreenWidth;
    
    CGFloat countLineH = 10;
    
    _line2F = CGRectMake(countLineX, countLineY, countLineW, countLineH);
    

    
    CGSize InvoiceTitleSize = [self sizeWithText:@"请上传发票" font:CarInfo_TitleFont maxSize:CGSizeMake(0,0)];
    
    CGFloat InvoicetitleX = ScreenWidth * 0.05;
    
    CGFloat InvoicetitleY = CGRectGetMaxY(_line2F) + mm;
    
    CGFloat InvoicetitleW = InvoiceTitleSize.width;
    
    CGFloat InvoicetitleH = InvoiceTitleSize.height;
    
    _InvoiceTitleF = CGRectMake(InvoicetitleX, InvoicetitleY, InvoicetitleW, InvoicetitleH);
    
    CGFloat AddBtnX = InvoicetitleX;
    
    CGFloat AddBtnH = 50;
    
    CGFloat AddBtnY = CGRectGetMaxY(_InvoiceTitleF) + mm;
    
    CGFloat AddBtnW = AddBtnH;
    
    _AddInvoiceBtnF = CGRectMake(AddBtnX, AddBtnY, AddBtnW, AddBtnH);
    
    CGFloat bgX = ScreenWidth * 0.025;
    
    CGFloat bgY = CGRectGetMaxY(_line2F);
    
    CGFloat bgW = ScreenWidth * 0.95;
    
    CGFloat bgH = CGRectGetMaxY(_AddInvoiceBtnF) + mm - bgY;
    
    _InvoiceBGviewF = CGRectMake(bgX, bgY, bgW, bgH);
    
    CGFloat SureBtnX = ScreenWidth * 0.1;
    
    CGFloat SureBtnH = 45;
    
    CGFloat SureBtnY = CGRectGetMaxY(_InvoiceBGviewF) + 90;
    
    CGFloat SureBtnW = ScreenWidth * 0.8;
    
    _SureBtnF = CGRectMake(SureBtnX, SureBtnY, SureBtnW, SureBtnH);
    
    CGFloat viewbgX = 0;
    
    CGFloat viewbgY = CGRectGetMaxY(_line2F);
    
    CGFloat viewbgH = CGRectGetMaxY(_SureBtnF) + margin - bgY;
    
    CGFloat viewbgW = ScreenWidth;
    
    _SureBtnBGViewF = CGRectMake(viewbgX, viewbgY, viewbgW, viewbgH);
    
    _height = CGRectGetMaxY(_SureBtnBGViewF);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}


@end
