//
//  HL_RechargeOrderFrame.m
//  HuiHui
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_Recharge_Sure_OrderFrame.h"
#import "HL_Recharge_Sure_OrderModel.h"
#import "LJConst.h"

@implementation HL_Recharge_Sure_OrderFrame

-(void)setOrderModel:(HL_Recharge_Sure_OrderModel *)orderModel {
    
    _orderModel = orderModel;
    
    CGFloat marginX = _WindowViewWidth * 0.05;
    
    CGFloat marginY = marginX;
    
    CGFloat margin = 10;
    
    CGFloat orderidtitleX = _WindowViewWidth * 0.1;
    
    CGFloat orderidtitleY = margin + marginY;
    
    CGFloat orderidtitleH = 30;
    
    CGSize orderidtitleSize = [self sizeWithText:@"订单编号:" font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(0, orderidtitleH)];
    
    CGFloat orderidtitleW = orderidtitleSize.width;
    
    _OrderIDTitleF = CGRectMake(orderidtitleX, orderidtitleY, orderidtitleW, orderidtitleH);
    
    CGFloat orderidX = CGRectGetMaxX(_OrderIDTitleF) + 10;
    
    CGFloat orderidY = orderidtitleY;
    
    CGFloat orderidW = _WindowViewWidth * 0.9 - orderidX;
    
    CGFloat orderidH = orderidtitleH;
    
    _OrderIDF = CGRectMake(orderidX, orderidY, orderidW, orderidH);
    
    CGFloat lineX = _WindowViewWidth * 0.05;
    
    CGFloat lineY = CGRectGetMaxY(_OrderIDTitleF) + margin;
    
    CGFloat lineW = _WindowViewWidth - 2 * lineX;
    
    CGFloat lineH = 1;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat ordertitleX = orderidtitleX;
    
    CGFloat ordertitleY = CGRectGetMaxY(_lineF) + margin;
    
    CGFloat ordertitleW = _WindowViewWidth - 2 * ordertitleX;
    
    CGFloat ordertitleH = 20;
    
    _OrderTitleF = CGRectMake(ordertitleX, ordertitleY, ordertitleW, ordertitleH);
    
    CGFloat originaltitleX = orderidtitleX;
    
    CGFloat originaltitleY = CGRectGetMaxY(_OrderTitleF) + margin;
    
    CGFloat originaltitleW = _WindowViewWidth * 0.5 - originaltitleX;
    
    CGFloat originaltitleH = ordertitleH;
    
    _OriginalPriceTitleF = CGRectMake(originaltitleX, originaltitleY, originaltitleW, originaltitleH);
    
    CGSize originalSize = [self sizeWithText:[NSString stringWithFormat:@"¥%@",orderModel.OriginalPrice] font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(0, orderidtitleH)];
    
    CGFloat originalW = originalSize.width;
    
    CGFloat originalX = _WindowViewWidth * 0.9 - originalW;
    
    CGFloat originalY = originaltitleY;
    
    CGFloat originalH = originaltitleH;
    
    _OriginalPriceF = CGRectMake(originalX, originalY, originalW, originalH);
    
    CGFloat or_lineX = originalX - 2;
    
    CGFloat or_lineY = originalY + originalH * 0.5;
    
    CGFloat or_lineW = originalW + 4;
    
    CGFloat or_lineH = 1;
    
    _OriginalPriceLineF = CGRectMake(or_lineX, or_lineY, or_lineW, or_lineH);
    
    CGFloat PresenttitleX = orderidtitleX;
    
    CGFloat PresenttitleY = CGRectGetMaxY(_OriginalPriceTitleF) + margin;
    
    CGFloat PresenttitleW = _WindowViewWidth * 0.5 - PresenttitleX;
    
    CGFloat PresenttitleH = ordertitleH;
    
    _PresentPriceTitleF = CGRectMake(PresenttitleX, PresenttitleY, PresenttitleW, PresenttitleH);
    
    CGFloat PresentX = CGRectGetMaxX(_PresentPriceTitleF);
    
    CGFloat PresentY = PresenttitleY;
    
    CGFloat PresentW = _WindowViewWidth * 0.9 - PresentX;
    
    CGFloat PresentH = PresenttitleH;
    
    _PresentPriceF = CGRectMake(PresentX, PresentY, PresentW, PresentH);
    
    CGFloat CounttitleX = orderidtitleX;
    
    CGFloat CounttitleY = CGRectGetMaxY(_PresentPriceTitleF) + margin;
    
    CGFloat CounttitleW = _WindowViewWidth * 0.5 - CounttitleX;
    
    CGFloat CounttitleH = ordertitleH;
    
    _CountTitleF = CGRectMake(CounttitleX, CounttitleY, CounttitleW, CounttitleH);
    
    CGFloat CountX = CGRectGetMaxX(_CountTitleF);
    
    CGFloat CountY = CounttitleY;
    
    CGFloat CountW = _WindowViewWidth * 0.9 - CountX;
    
    CGFloat CountH = CounttitleH;
    
    _CountF = CGRectMake(CountX, CountY, CountW, CountH);
    
    CGFloat DiscounttitleX = orderidtitleX;
    
    CGFloat DiscounttitleY = CGRectGetMaxY(_CountTitleF) + margin;
    
    CGFloat DiscounttitleW = _WindowViewWidth * 0.6 - DiscounttitleX;
    
    CGFloat DiscounttitleH = ordertitleH;
    
    _DiscountTitleF = CGRectMake(DiscounttitleX, DiscounttitleY, DiscounttitleW, DiscounttitleH);
    
    CGFloat DiscountX = CGRectGetMaxX(_DiscountTitleF);
    
    CGFloat DiscountY = DiscounttitleY;
    
    CGFloat DiscountW = _WindowViewWidth * 0.9 - DiscountX;
    
    CGFloat DiscountH = DiscounttitleH;
    
    _DiscountF = CGRectMake(DiscountX, DiscountY, DiscountW, DiscountH);
    
    CGFloat TotaltitleX = orderidtitleX;
    
    CGFloat TotaltitleY = CGRectGetMaxY(_DiscountTitleF) + margin;
    
    CGFloat TotaltitleW = _WindowViewWidth * 0.5 - TotaltitleX;
    
    CGFloat TotaltitleH = ordertitleH;
    
    _TotalTitleF = CGRectMake(TotaltitleX, TotaltitleY, TotaltitleW, TotaltitleH);
    
    CGFloat TotalX = CGRectGetMaxX(_TotalTitleF);
    
    CGFloat TotalY = TotaltitleY;
    
    CGFloat TotalW = _WindowViewWidth * 0.9 - TotalX;
    
    CGFloat TotalH = TotaltitleH;
    
    _TotalF = CGRectMake(TotalX, TotalY, TotalW, TotalH);
    
    CGFloat bgX = marginX;
    
    CGFloat bgY = marginY;
    
    CGFloat bgW = _WindowViewWidth - 2 * bgX;
    
    CGFloat bgH = CGRectGetMaxY(_TotalF) + margin;
    
    _bgF = CGRectMake(bgX, bgY, bgW, bgH);
    
    CGFloat payX = _WindowViewWidth * 0.05;
    
    CGFloat payY = CGRectGetMaxY(_bgF) + 40;
    
    CGFloat payW = _WindowViewWidth * 0.9;
    
    CGFloat payH = 20;
    
    _PayTitleF = CGRectMake(payX, payY, payW, payH);
    
    CGFloat zfbX = payX;
    
    CGFloat zfbY = CGRectGetMaxY(_PayTitleF) + 5;
    
    CGFloat zfbW = _WindowViewWidth - 2 * zfbX;
    
    CGFloat zfbH = 50;
    
    _ZFB_TypeF = CGRectMake(zfbX, zfbY, zfbW, zfbH);
    
    CGFloat wxX = payX;
    
    CGFloat wxY = CGRectGetMaxY(_ZFB_TypeF);
    
    CGFloat wxW = _WindowViewWidth - 2 * wxX;
    
    CGFloat wxH = zfbH;
    
    _WX_TypeF = CGRectMake(wxX, wxY, wxW, wxH);
    
    CGFloat cycX = payX;
    
    CGFloat cycY = CGRectGetMaxY(_WX_TypeF);
    
    CGFloat cycW = _WindowViewWidth - 2 * cycX;
    
    CGFloat cycH = zfbH;
    
    _CYC_TypeF = CGRectMake(cycX, cycY, cycW, cycH);
    
    CGFloat fsbX = payX;
    
    CGFloat fsbY = CGRectGetMaxY(_CYC_TypeF);
    
    CGFloat fsbW = _WindowViewWidth - 2 * cycX;
    
    CGFloat fsbH = zfbH;
    
    _FSB_TypeF = CGRectMake(fsbX, fsbY, fsbW, fsbH);
    
    _height = CGRectGetMaxY(_FSB_TypeF) + margin;
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
