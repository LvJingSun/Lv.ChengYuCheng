//
//  RH_InsuranceInPutFrame.m
//  HuiHui
//
//  Created by mac on 2017/6/9.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_InsuranceInPutFrame.h"
#import "RedHorseHeader.h"
#import "RH_InsuranceModel.h"

@implementation RH_InsuranceInPutFrame

-(void)setInsuranceModel:(RH_InsuranceModel *)insuranceModel {

    _insuranceModel = insuranceModel;
    
    CGFloat margin = 15;
    
    CGSize carPriceTitleSize = [self sizeWithText:@"车价" font:CarInfo_TitleFont maxSize:CGSizeMake(0,0)];
    
    CGFloat carPricetitleX = ScreenWidth * 0.05;
    
    CGFloat carPricetitleY = margin;
    
    CGFloat carPricetitleW = carPriceTitleSize.width;
    
    CGFloat carPricetitleH = carPriceTitleSize.height;
    
    _carPriceTitleF = CGRectMake(carPricetitleX, carPricetitleY, carPricetitleW, carPricetitleH);
    
    CGFloat carPriceX = CGRectGetMaxX(_carPriceTitleF) + 20;
    
    CGFloat carPriceH = 30;
    
    CGFloat carPriceY = (carPricetitleH + 2 * margin - carPriceH) * 0.5;
    
    CGFloat carPriceW = ScreenWidth * 0.95 - carPriceX;
    
    _carPriceF = CGRectMake(carPriceX, carPriceY, carPriceW, carPriceH);
    
    CGFloat carPriceLineX = 0;
    
    CGFloat carPriceLineY = CGRectGetMaxY(_carPriceTitleF) + margin;
    
    CGFloat carPriceLineW = ScreenWidth;
    
    CGFloat carPriceLineH = 0.5;
    
    _carPriceLineF = CGRectMake(carPriceLineX, carPriceLineY, carPriceLineW, carPriceLineH);
    
    CGSize insurancePersonTitleSize = [self sizeWithText:@"被保险人" font:CarInfo_TitleFont maxSize:CGSizeMake(0,0)];
    
    CGFloat insurancePersontitleX = ScreenWidth * 0.05;
    
    CGFloat insurancePersontitleY = margin + CGRectGetMaxY(_carPriceLineF);
    
    CGFloat insurancePersontitleW = insurancePersonTitleSize.width;
    
    CGFloat insurancePersontitleH = insurancePersonTitleSize.height;
    
    _insurancePersonTitleF = CGRectMake(insurancePersontitleX, insurancePersontitleY, insurancePersontitleW, insurancePersontitleH);
    
    CGFloat insurancePersonX = CGRectGetMaxX(_insurancePersonTitleF) + 20;
    
    CGFloat insurancePersonH = 30;
    
    CGFloat insurancePersonY = (insurancePersontitleH + 2 * margin - insurancePersonH) * 0.5 + CGRectGetMaxY(_carPriceLineF);
    
    CGFloat insurancePersonW = ScreenWidth * 0.95 - insurancePersonX;
    
    _insurancePersonF = CGRectMake(insurancePersonX, insurancePersonY, insurancePersonW, insurancePersonH);
    
    CGFloat insurancePersonLineX = 0;
    
    CGFloat insurancePersonLineY = CGRectGetMaxY(_insurancePersonTitleF) + margin;
    
    CGFloat insurancePersonLineW = ScreenWidth;
    
    CGFloat insurancePersonLineH = 0.5;
    
    _insurancePersonLineF = CGRectMake(insurancePersonLineX, insurancePersonLineY, insurancePersonLineW, insurancePersonLineH);
    
    CGSize insurancePriceTitleSize = [self sizeWithText:@"保险费用" font:CarInfo_TitleFont maxSize:CGSizeMake(0,0)];
    
    CGFloat insurancePricetitleX = ScreenWidth * 0.05;
    
    CGFloat insurancePricetitleY = margin + CGRectGetMaxY(_insurancePersonLineF);
    
    CGFloat insurancePricetitleW = insurancePriceTitleSize.width;
    
    CGFloat insurancePricetitleH = insurancePriceTitleSize.height;
    
    _insurancePriceTitleF = CGRectMake(insurancePricetitleX, insurancePricetitleY, insurancePricetitleW, insurancePricetitleH);
    
    CGFloat insurancePriceX = CGRectGetMaxX(_insurancePriceTitleF) + 20;
    
    CGFloat insurancePriceH = 30;
    
    CGFloat insurancePriceY = (insurancePricetitleH + 2 * margin - insurancePriceH) * 0.5 + CGRectGetMaxY(_insurancePersonLineF);
    
    CGFloat insurancePriceW = ScreenWidth * 0.95 - insurancePriceX;
    
    _insurancePriceF = CGRectMake(insurancePriceX, insurancePriceY, insurancePriceW, insurancePriceH);
    
    CGFloat insurancePriceLineX = 0;
    
    CGFloat insurancePriceLineY = CGRectGetMaxY(_insurancePriceTitleF) + margin;
    
    CGFloat insurancePriceLineW = ScreenWidth;
    
    CGFloat insurancePriceLineH = 0.5;
    
    _insurancePriceLineF = CGRectMake(insurancePriceLineX, insurancePriceLineY, insurancePriceLineW, insurancePriceLineH);
    
    CGSize drivingAreaTitleSize = [self sizeWithText:@"行驶里程" font:CarInfo_TitleFont maxSize:CGSizeMake(0,0)];
    
    CGFloat drivingAreatitleX = ScreenWidth * 0.05;
    
    CGFloat drivingAreatitleY = margin + CGRectGetMaxY(_insurancePriceLineF);
    
    CGFloat drivingAreatitleW = drivingAreaTitleSize.width;
    
    CGFloat drivingAreatitleH = drivingAreaTitleSize.height;
    
    _drivingAreaTitleF = CGRectMake(drivingAreatitleX, drivingAreatitleY, drivingAreatitleW, drivingAreatitleH);
    
    CGFloat drivingAreaX = CGRectGetMaxX(_drivingAreaTitleF) + 20;
    
    CGFloat drivingAreaH = 30;
    
    CGFloat drivingAreaY = (drivingAreatitleH + 2 * margin - drivingAreaH) * 0.5 + CGRectGetMaxY(_insurancePriceLineF);
    
    CGFloat drivingAreaW = ScreenWidth * 0.95 - drivingAreaX;
    
    _drivingAreaF = CGRectMake(drivingAreaX, drivingAreaY, drivingAreaW, drivingAreaH);
    
    CGFloat drivingAreaLineX = 0;
    
    CGFloat drivingAreaLineY = CGRectGetMaxY(_drivingAreaTitleF) + margin;
    
    CGFloat drivingAreaLineW = ScreenWidth;
    
    CGFloat drivingAreaLineH = 0.5;
    
    _drivingAreaLineF = CGRectMake(drivingAreaLineX, drivingAreaLineY, drivingAreaLineW, drivingAreaLineH);
    
    CGSize drivingYearsTitleSize = [self sizeWithText:@"驾龄" font:CarInfo_TitleFont maxSize:CGSizeMake(0,0)];
    
    CGFloat d_y_t_X = ScreenWidth * 0.05;
    
    CGFloat d_y_t_Y = CGRectGetMaxY(_drivingAreaLineF) + margin;
    
    CGFloat d_y_t_W = drivingYearsTitleSize.width;
    
    CGFloat d_y_t_H = drivingYearsTitleSize.height;
    
    _drivingYearsTitleF = CGRectMake(d_y_t_X, d_y_t_Y, d_y_t_W, d_y_t_H);
    
    CGFloat OneYearX = CGRectGetMaxX(_drivingYearsTitleF) + 15;
    
    CGFloat radioW = (ScreenWidth * 0.95 - OneYearX) * 0.25;
    
    CGFloat OneYearH = 30;
    
    CGFloat OneYearY = (d_y_t_H + 2 * margin - OneYearH) * 0.5 + CGRectGetMaxY(_drivingAreaLineF);
    
    CGFloat OneYearW = radioW;
    
    _drivingYears_ONE_TitleF = CGRectMake(OneYearX, OneYearY, OneYearW, OneYearH);
    
    CGFloat OnetoThreeX = CGRectGetMaxX(_drivingYears_ONE_TitleF);
    
    CGFloat OnetoThreeH = OneYearH;
    
    CGFloat OnetoThreeY = OneYearY;
    
    CGFloat OnetoThreeW = radioW;
    
    _drivingYears_ONEtoTHREE_TitleF = CGRectMake(OnetoThreeX, OnetoThreeY, OnetoThreeW, OnetoThreeH);
    
    CGFloat moreThreeX = CGRectGetMaxX(_drivingYears_ONEtoTHREE_TitleF);
    
    CGFloat moreThreeH = OneYearH;
    
    CGFloat moreThreeY = OneYearY;
    
    CGFloat moreThreeW = radioW;
    
    _drivingYears_moreTHREE_TitleF = CGRectMake(moreThreeX, moreThreeY, moreThreeW, moreThreeH);
    
    CGSize carYearsTitleSize = [self sizeWithText:@"车龄" font:CarInfo_TitleFont maxSize:CGSizeMake(0,0)];
    
    CGFloat c_y_t_X = ScreenWidth * 0.05;
    
    CGFloat c_y_t_Y = CGRectGetMaxY(_drivingYearsTitleF) + margin;
    
    CGFloat c_y_t_W = carYearsTitleSize.width;
    
    CGFloat c_y_t_H = carYearsTitleSize.height;
    
    _carYearsTitleF = CGRectMake(c_y_t_X, c_y_t_Y, c_y_t_W, c_y_t_H);
    
    CGFloat c_OneX = CGRectGetMaxX(_carYearsTitleF) + 15;
    
    CGFloat c_OneH = 30;
    
    CGFloat c_OneY = (c_y_t_H - c_OneH) * 0.5 + c_y_t_Y;
    
    CGFloat c_OneW = radioW;
    
    _carYears_ONE_TitleF = CGRectMake(c_OneX, c_OneY, c_OneW, c_OneH);
    
    CGFloat c_OnetoTwoX = CGRectGetMaxX(_carYears_ONE_TitleF);
    
    CGFloat c_OnetoTwoH = c_OneH;
    
    CGFloat c_OnetoTwoY = c_OneY;
    
    CGFloat c_OnetoTwoW = radioW;
    
    _carYears_ONEtoTWO_TitleF = CGRectMake(c_OnetoTwoX, c_OnetoTwoY, c_OnetoTwoW, c_OnetoTwoH);
    
    CGFloat c_twotosixX = CGRectGetMaxX(_carYears_ONEtoTWO_TitleF);
    
    CGFloat c_twotosixH = c_OneH;
    
    CGFloat c_twotosixY = c_OneY;
    
    CGFloat c_twotosixW = radioW;
    
    _carYears_TWOtoSIX_TitleF = CGRectMake(c_twotosixX, c_twotosixY, c_twotosixW, c_twotosixH);
    
    CGFloat c_moresixX = CGRectGetMaxX(_carYears_TWOtoSIX_TitleF);
    
    CGFloat c_moresixH = c_OneH;
    
    CGFloat c_moresixY = c_OneY;
    
    CGFloat c_moresixW = radioW;
    
    _carYears_moreSIX_TitleF = CGRectMake(c_moresixX, c_moresixY, c_moresixW, c_moresixH);
    
    CGFloat SureBtnX = ScreenWidth * 0.1;
    
    CGFloat SureBtnH = 45;
    
    CGFloat SureBtnY = CGRectGetMaxY(_carYearsTitleF) + margin + 90;
    
    CGFloat SureBtnW = ScreenWidth * 0.8;
    
    _SureBtnF = CGRectMake(SureBtnX, SureBtnY, SureBtnW, SureBtnH);
    
    CGFloat bgX = 0;
    
    CGFloat bgY = CGRectGetMaxY(_carYearsTitleF) + margin;
    
    CGFloat bgH = CGRectGetMaxY(_SureBtnF) + margin - bgY;
    
    CGFloat bgW = ScreenWidth;
    
    _SureBtnBGViewF = CGRectMake(bgX, bgY, bgW, bgH);
    
    _height = CGRectGetMaxY(_SureBtnBGViewF);

    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
