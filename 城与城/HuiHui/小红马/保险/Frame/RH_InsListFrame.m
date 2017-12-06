//
//  RH_InsListFrame.m
//  HuiHui
//
//  Created by mac on 2017/6/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_InsListFrame.h"
#import "RH_InsListModel.h"
#import "RedHorseHeader.h"

@implementation RH_InsListFrame

-(void)setListModel:(RH_InsListModel *)listModel {

    _listModel = listModel;
    
    CGFloat CoTitleX = ScreenWidth * 0.1;
    
    CGFloat CoTitleY = 20;
    
    CGSize titleSize = [self sizeWithText:@"保险公司" font:Ins_TitleFont maxSize:CGSizeMake(0,0)];
    
    CGFloat CoTitleW = titleSize.width;
    
    CGFloat CoTitleH = titleSize.height;
    
    _COTitleF = CGRectMake(CoTitleX, CoTitleY, CoTitleW, CoTitleH);
    
    CGFloat CoContentX = CGRectGetMaxX(_COTitleF) + 20;
    
    CGFloat CoContentY = CoTitleY;
    
    CGFloat CoContentW = ScreenWidth * 0.9 - CoContentX;
    
    CGFloat CoContentH = CoTitleH;
    
    _COF = CGRectMake(CoContentX, CoContentY, CoContentW, CoContentH);
    
    CGFloat TimeTitleX = CoTitleX;
    
    CGFloat TimeTitleY = CGRectGetMaxY(_COTitleF) + 10;
    
    CGFloat TitmeTitleW = CoTitleW;
    
    CGFloat TitmeTitleH = CoTitleH;
    
    _TimeTitleF = CGRectMake(TimeTitleX, TimeTitleY, TitmeTitleW, TitmeTitleH);
    
    CGFloat TimeX = CoContentX;
    
    CGFloat TimeY = TimeTitleY;
    
    CGFloat TimeW = CoContentW;
    
    CGFloat TimeH = CoContentH;
    
    _TimeF = CGRectMake(TimeX, TimeY, TimeW, TimeH);
    
    CGFloat CountTitleX = CoTitleX;
    
    CGFloat CountTitleY = CGRectGetMaxY(_TimeTitleF) + 10;
    
    CGFloat CountTitleW = CoTitleW;
    
    CGFloat CountTitleH = CoTitleH;
    
    _CountTitleF = CGRectMake(CountTitleX, CountTitleY, CountTitleW, CountTitleH);
    
    CGFloat CountX = CoContentX;
    
    CGFloat CountY = CountTitleY;
    
    CGFloat CountW = CoContentW;
    
    CGFloat CountH = CoContentH;
    
    _CountF = CGRectMake(CountX, CountY, CountW, CountH);
    
    CGFloat PlateTitleX = CoTitleX;
    
    CGFloat PlateTitleY = CGRectGetMaxY(_CountTitleF) + 10;
    
    CGFloat PlateTitleW = CoTitleW;
    
    CGFloat PlateTitleH = CoTitleH;
    
    _PlateTitleF = CGRectMake(PlateTitleX, PlateTitleY, PlateTitleW, PlateTitleH);
    
    CGFloat PlateX = CoContentX;
    
    CGFloat PlateY = PlateTitleY;
    
    CGFloat PlateW = CoContentW;
    
    CGFloat PlateH = CoContentH;
    
    _PlateF = CGRectMake(PlateX, PlateY, PlateW, PlateH);
    
    CGFloat DrivingYearTitleX = CoTitleX;
    
    CGFloat DrivingYearTitleY = CGRectGetMaxY(_PlateTitleF) + 10;
    
    CGFloat DrivingYearTitleW = CoTitleW;
    
    CGFloat DrivingYearTitleH = CoTitleH;
    
    _DrivingYearTitleF = CGRectMake(DrivingYearTitleX, DrivingYearTitleY, DrivingYearTitleW, DrivingYearTitleH);
    
    CGFloat DrivingYearX = CoContentX;
    
    CGFloat DrivingYearY = DrivingYearTitleY;
    
    CGFloat DrivingYearW = CoContentW;
    
    CGFloat DrivingYearH = CoContentH;
    
    _DrivingYearF = CGRectMake(DrivingYearX, DrivingYearY, DrivingYearW, DrivingYearH);
    
    CGFloat CarYearTitleX = CoTitleX;
    
    CGFloat CarYearTitleY = CGRectGetMaxY(_DrivingYearTitleF) + 10;
    
    CGFloat CarYearTitleW = CoTitleW;
    
    CGFloat CarYearTitleH = CoTitleH;
    
    _CarYearTitleF = CGRectMake(CarYearTitleX, CarYearTitleY, CarYearTitleW, CarYearTitleH);
    
    CGFloat CarYearX = CoContentX;
    
    CGFloat CarYearY = CarYearTitleY;
    
    CGFloat CarYearW = CoContentW;
    
    CGFloat CarYearH = CoContentH;
    
    _CarYearF = CGRectMake(CarYearX, CarYearY, CarYearW, CarYearH);
    
    _height = CGRectGetMaxY(_CarYearTitleF) + 20;
    
    CGFloat iconX = ScreenWidth * 0.95 - 55;
    
    CGFloat iconY = (ScreenHeight - 45) * 0.5;
    
    CGFloat iconW = 55;
    
    CGFloat iconH = 45;
    
    _StatusIconF = CGRectMake(iconX, iconY, iconW, iconH);

}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}


@end
