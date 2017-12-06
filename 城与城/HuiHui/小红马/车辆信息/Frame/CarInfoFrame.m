//
//  CarInfoFrame.m
//  HuiHui
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "CarInfoFrame.h"
#import "RedHorseHeader.h"
#import "RH_CarModel.h"

@implementation CarInfoFrame

-(void)setCarModel:(RH_CarModel *)carModel {

    _carModel = carModel;
    
    CGFloat carImgX = ScreenWidth * 0.036;
    
    CGFloat carImgY = 20;
    
    CGFloat carImgW = 50;
    
    CGFloat carImgH = carImgW;
    
    _carImgF = CGRectMake(carImgX, carImgY, carImgW, carImgH);
    
    CGFloat carModelX = CGRectGetMaxX(_carImgF) + 15;
    
    CGFloat carModelH = 30;
    
    CGFloat carModelY = carImgY + (carImgH - carModelH) * 0.5;
    
    CGFloat carModelW = ScreenWidth - 44 - carModelX;

    _carModelF = CGRectMake(carModelX, carModelY, carModelW, carModelH);
    
    CGFloat rightImgW = 24;
    
    CGFloat rightImgH = rightImgW;
    
    CGFloat rightImgX = CGRectGetMaxX(_carModelF) + 10;
    
    CGFloat rightImgY = carImgY + (carImgH - rightImgH) * 0.5;
    
    _rightImgF = CGRectMake(rightImgX, rightImgY, rightImgW, rightImgH);
    
    CGFloat chooseX = 0;
    
    CGFloat chooseY = 0;
    
    CGFloat chooseW = ScreenWidth;
    
    CGFloat chooseH = CGRectGetMaxY(_carImgF) + carImgY;
    
    _chooseBrandF = CGRectMake(chooseX, chooseY, chooseW, chooseH);
    
    CGFloat line1X = 0;
    
    CGFloat line1Y = CGRectGetMaxY(_carImgF) + carImgY;
    
    CGFloat line1W = ScreenWidth;
    
    CGFloat line1H = 20;
    
    _Line1F = CGRectMake(line1X, line1Y, line1W, line1H);
    
    CGFloat margin = 15;
    
    CGSize carPlateTitleSize = [self sizeWithText:@"车牌号码" font:CarInfo_TitleFont maxSize:CGSizeMake(0,0)];
    
    CGFloat platetitleX = ScreenWidth * 0.05;
    
    CGFloat platetitleY = CGRectGetMaxY(_Line1F) + margin;
    
    CGFloat platetitleW = carPlateTitleSize.width;
    
    CGFloat platetitleH = carPlateTitleSize.height;
    
    _carPlateTitleF = CGRectMake(platetitleX, platetitleY, platetitleW, platetitleH);
    
    CGFloat plateX = CGRectGetMaxX(_carPlateTitleF) + 20;
    
    CGFloat plateH = 30;
    
    CGFloat plateY = (platetitleH + 2 * margin - plateH) * 0.5 + CGRectGetMaxY(_Line1F);
    
    CGFloat plateW = ScreenWidth * 0.95 - plateX;
    
    _carPlateF = CGRectMake(plateX, plateY, plateW, plateH);
    
    CGFloat plateLineX = 0;
    
    CGFloat plateLineY = CGRectGetMaxY(_carPlateTitleF) + margin;
    
    CGFloat plateLineW = ScreenWidth;
    
    CGFloat plateLineH = 0.5;
    
    _carPlateLineF = CGRectMake(plateLineX, plateLineY, plateLineW, plateLineH);
    
    CGSize timeTitleSize = [self sizeWithText:@"购车时间" font:CarInfo_TitleFont maxSize:CGSizeMake(0,0)];
    
    CGFloat timetitleX = ScreenWidth * 0.05;
    
    CGFloat timetitleY = CGRectGetMaxY(_carPlateLineF) + margin;
    
    CGFloat timetitleW = timeTitleSize.width;
    
    CGFloat timetitleH = timeTitleSize.height;
    
    _timeTitleF = CGRectMake(timetitleX, timetitleY, timetitleW, timetitleH);
    
    CGFloat timeX = CGRectGetMaxX(_timeTitleF) + 20;
    
    CGFloat timeH = 30;
    
    CGFloat timeY = (timetitleH + 2 * margin - timeH) * 0.5 + CGRectGetMaxY(_carPlateLineF);
    
    CGFloat timeW = ScreenWidth * 0.95 - plateX;
    
    _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
    _timeBtnF = CGRectMake(timeX, timeY, timeW, timeH);
    
    CGFloat timeLineX = 0;
    
    CGFloat timeLineY = CGRectGetMaxY(_timeTitleF) + margin;
    
    CGFloat timeLineW = ScreenWidth;
    
    CGFloat timeLineH = 0.5;
    
    _timeLineF = CGRectMake(timeLineX, timeLineY, timeLineW, timeLineH);
    
    CGSize moneyTitleSize = [self sizeWithText:@"购车款" font:CarInfo_TitleFont maxSize:CGSizeMake(0,0)];
    
    CGFloat moneytitleX = ScreenWidth * 0.05;
    
    CGFloat moneytitleY = CGRectGetMaxY(_timeLineF) + margin;
    
    CGFloat moneytitleW = moneyTitleSize.width;
    
    CGFloat moneytitleH = moneyTitleSize.height;
    
    _moneyTitleF = CGRectMake(moneytitleX, moneytitleY, moneytitleW, moneytitleH);
    
    CGFloat moneyX = CGRectGetMaxX(_moneyTitleF) + 20;
    
    CGFloat moneyH = 30;
    
    CGFloat moneyY = (moneytitleH + 2 * margin - moneyH) * 0.5 + CGRectGetMaxY(_timeLineF);
    
    CGFloat moneyW = ScreenWidth * 0.95 - moneyX;
    
    _moneyF = CGRectMake(moneyX, moneyY, moneyW, moneyH);
    
    CGFloat moneyLineX = 0;
    
    CGFloat moneyLineY = CGRectGetMaxY(_moneyTitleF) + margin;
    
    CGFloat moneyLineW = ScreenWidth;
    
    CGFloat moneyLineH = 0.5;
    
    _moneyLineF = CGRectMake(moneyLineX, moneyLineY, moneyLineW, moneyLineH);
    
    CGSize EngineNumberTitleSize = [self sizeWithText:@"发动机号" font:CarInfo_TitleFont maxSize:CGSizeMake(0,0)];
    
    CGFloat EngineNumbertitleX = ScreenWidth * 0.05;
    
    CGFloat EngineNumbertitleY = CGRectGetMaxY(_moneyLineF) + margin;
    
    CGFloat EngineNumbertitleW = EngineNumberTitleSize.width;
    
    CGFloat EngineNumbertitleH = EngineNumberTitleSize.height;
    
    _EngineNumberTitleF = CGRectMake(EngineNumbertitleX, EngineNumbertitleY, EngineNumbertitleW, EngineNumbertitleH);
    
    CGFloat EngineNumberX = CGRectGetMaxX(_moneyTitleF) + 20;
    
    CGFloat EngineNumberH = 30;
    
    CGFloat EngineNumberY = (EngineNumbertitleH + 2 * margin - EngineNumberH) * 0.5 + CGRectGetMaxY(_moneyLineF);
    
    CGFloat EngineNumberW = ScreenWidth * 0.95 - EngineNumberX;
    
    _EngineNumberF = CGRectMake(EngineNumberX, EngineNumberY, EngineNumberW, EngineNumberH);
    
    CGFloat EngineNumberLineX = 0;
    
    CGFloat EngineNumberLineY = CGRectGetMaxY(_EngineNumberTitleF) + margin;
    
    CGFloat EngineNumberLineW = ScreenWidth;
    
    CGFloat EngineNumberLineH = 0.5;
    
    _EngineNumberLineF = CGRectMake(EngineNumberLineX, EngineNumberLineY, EngineNumberLineW, EngineNumberLineH);
    
    CGSize MileageTitleSize = [self sizeWithText:@"行驶里程" font:CarInfo_TitleFont maxSize:CGSizeMake(0,0)];
    
    CGFloat MileagetitleX = ScreenWidth * 0.05;
    
    CGFloat MileagetitleY = CGRectGetMaxY(_EngineNumberLineF) + margin;
    
    CGFloat MileagetitleW = MileageTitleSize.width;
    
    CGFloat MileagetitleH = MileageTitleSize.height;
    
    _MileageTitleF = CGRectMake(MileagetitleX, MileagetitleY, MileagetitleW, MileagetitleH);
    
    CGFloat MileageX = CGRectGetMaxX(_MileageTitleF) + 20;
    
    CGFloat MileageH = 30;
    
    CGFloat MileageY = (MileagetitleH + 2 * margin - MileageH) * 0.5 + CGRectGetMaxY(_EngineNumberLineF);
    
    CGFloat MileageW = ScreenWidth * 0.95 - MileageX;
    
    _MileageF = CGRectMake(MileageX, MileageY, MileageW, MileageH);
    
    CGFloat MileageLineX = 0;
    
    CGFloat MileageLineY = CGRectGetMaxY(_MileageTitleF) + margin;
    
    CGFloat MileageLineW = ScreenWidth;
    
    CGFloat MileageLineH = 0.5;
    
    _MileageLineF = CGRectMake(MileageLineX, MileageLineY, MileageLineW, MileageLineH);
    
    CGSize InvoiceTitleSize = [self sizeWithText:@"请上传发票" font:CarInfo_TitleFont maxSize:CGSizeMake(0,0)];
    
    CGFloat InvoicetitleX = ScreenWidth * 0.05;
    
    CGFloat InvoicetitleY = CGRectGetMaxY(_MileageLineF) + margin;
    
    CGFloat InvoicetitleW = InvoiceTitleSize.width;
    
    CGFloat InvoicetitleH = InvoiceTitleSize.height;
    
    _InvoiceTitleF = CGRectMake(InvoicetitleX, InvoicetitleY, InvoicetitleW, InvoicetitleH);

    CGFloat AddBtnX = InvoicetitleX;
    
    CGFloat AddBtnH = 50;
    
    CGFloat AddBtnY = CGRectGetMaxY(_InvoiceTitleF) + margin;
    
    CGFloat AddBtnW = AddBtnH;
    
    _AddInvoiceBtnF = CGRectMake(AddBtnX, AddBtnY, AddBtnW, AddBtnH);
    
    CGFloat SureBtnX = ScreenWidth * 0.1;
    
    CGFloat SureBtnH = 45;
    
    CGFloat SureBtnY = CGRectGetMaxY(_AddInvoiceBtnF) + margin + 40;
    
    CGFloat SureBtnW = ScreenWidth * 0.8;
    
    _SureBtnF = CGRectMake(SureBtnX, SureBtnY, SureBtnW, SureBtnH);
    
    CGFloat bgX = 0;
    
    CGFloat bgY = CGRectGetMaxY(_AddInvoiceBtnF) + margin;
    
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
