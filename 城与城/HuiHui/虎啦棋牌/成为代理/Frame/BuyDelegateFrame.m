//
//  BuyDelegateFrame.m
//  HuiHui
//
//  Created by mac on 2017/11/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "BuyDelegateFrame.h"
#import "LJConst.h"
#import "BuyDelegateModel.h"

@implementation BuyDelegateFrame

-(void)setBuyModel:(BuyDelegateModel *)buyModel {
    
    _buyModel = buyModel;
    
    CGFloat priceX = _WindowViewWidth * 0.05;
    
    CGFloat priceY = 15;
    
    CGFloat priceW = _WindowViewWidth * 0.9;
    
    CGFloat priceH = 20;
    
    _priceF = CGRectMake(priceX, priceY, priceW, priceH);
    
    CGFloat timeBGX = 0;
    
    CGFloat timeBGY = CGRectGetMaxY(_priceF) + 10;
    
    CGFloat timeBGW = _WindowViewWidth;
    
    CGFloat timeBGH = 40;
    
    _timeBGF = CGRectMake(timeBGX, timeBGY, timeBGW, timeBGH);
    
    CGFloat oneX = _WindowViewWidth * 0.05;
    
    CGFloat oneY = timeBGY + 5;
    
    CGFloat oneW = _WindowViewWidth * 0.3;
    
    CGFloat oneH = 30;
    
    _oneYearF = CGRectMake(oneX, oneY, oneW, oneH);
    
    CGFloat twoX = CGRectGetMaxX(_oneYearF);
    
    CGFloat twoY = oneY;
    
    CGFloat twoW = oneW;
    
    CGFloat twoH = oneH;
    
    _twoYearF = CGRectMake(twoX, twoY, twoW, twoH);
    
    CGFloat threeX = CGRectGetMaxX(_twoYearF);
    
    CGFloat threeY = twoY;
    
    CGFloat threeW = twoW;
    
    CGFloat threeH = twoH;
    
    _threeYearF = CGRectMake(threeX, threeY, threeW, threeH);
    
    CGFloat titleX = _WindowViewWidth * 0.05;
    
    CGFloat titleY = CGRectGetMaxY(_timeBGF) + 40;
    
    CGFloat titleW = _WindowViewWidth * 0.9;
    
    CGFloat titleH = 20;
    
    _typeTitleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    
    
    CGFloat CYC_BGX = 0;
    
    CGFloat CYC_BGY = CGRectGetMaxY(_typeTitleF) + 5;
    
    CGFloat CYC_BGW = _WindowViewWidth;
    
    CGFloat CYC_BGH = 50;
    
    _type_CYC_BGF = CGRectMake(CYC_BGX, CYC_BGY, CYC_BGW, CYC_BGH);
    
    CGFloat cycX = _WindowViewWidth * 0.05;
    
    CGFloat cycH = 30;
    
    CGFloat cycW = cycH;
    
    CGFloat cycY = CYC_BGY + (CYC_BGH - cycH) * 0.5;
    
    _type_CYC_IconF = CGRectMake(cycX, cycY, cycW, cycH);
    
    CGFloat CYC_TitleX = CGRectGetMaxX(_type_CYC_IconF) + 10;
    
    CGFloat CYC_TitleH = 30;
    
    CGFloat CYC_TitleY = CYC_BGY + (CYC_BGH - CYC_TitleH) * 0.5;
    
    CGFloat CYC_TitleW = _WindowViewWidth * 0.6;
    
    _type_CYC_TitleF = CGRectMake(CYC_TitleX, CYC_TitleY, CYC_TitleW, CYC_TitleH);
    
    CGFloat CYC_ImgW = 20;
    
    CGFloat CYC_ImgH = CYC_ImgW;
    
    CGFloat CYC_ImgX = _WindowViewWidth * 0.95 - CYC_ImgW;
    
    CGFloat CYC_ImgY = (CYC_BGH - CYC_ImgH) * 0.5 + CYC_BGY;
    
    _type_CYC_ImgF = CGRectMake(CYC_ImgX, CYC_ImgY, CYC_ImgW, CYC_ImgH);
    
    
    CGFloat WX_BGX = 0;
    
    CGFloat WX_BGY = CGRectGetMaxY(_type_CYC_BGF) + 2;
    
    CGFloat WX_BGW = _WindowViewWidth;
    
    CGFloat WX_BGH = CYC_BGH;
    
    _type_WX_BGF = CGRectMake(WX_BGX, WX_BGY, WX_BGW, WX_BGH);
    
    CGFloat wxY = WX_BGY + (WX_BGH - cycH) * 0.5;
    
    _type_WX_IconF = CGRectMake(cycX, wxY, cycW, cycH);
    
    CGFloat WX_TitleX = CGRectGetMaxX(_type_WX_IconF) + 10;
    
    CGFloat WX_TitleH = CYC_TitleH;
    
    CGFloat WX_TitleY = WX_BGY + (WX_BGH - WX_TitleH) * 0.5;
    
    CGFloat WX_TitleW = _WindowViewWidth * 0.6;
    
    _type_WX_TitleF = CGRectMake(WX_TitleX, WX_TitleY, WX_TitleW, WX_TitleH);
    
    CGFloat WX_ImgW = CYC_ImgW;
    
    CGFloat WX_ImgH = WX_ImgW;
    
    CGFloat WX_ImgX = _WindowViewWidth * 0.95 - WX_ImgW;
    
    CGFloat WX_ImgY = (WX_BGH - WX_ImgH) * 0.5 + WX_BGY;
    
    _type_WX_ImgF = CGRectMake(WX_ImgX, WX_ImgY, WX_ImgW, WX_ImgH);
    
    
    CGFloat ZFB_BGX = 0;
    
    CGFloat ZFB_BGY = CGRectGetMaxY(_type_WX_BGF) + 2;
    
    CGFloat ZFB_BGW = _WindowViewWidth;
    
    CGFloat ZFB_BGH = CYC_BGH;
    
    _type_ZFB_BGF = CGRectMake(ZFB_BGX, ZFB_BGY, ZFB_BGW, ZFB_BGH);
    
    CGFloat zfbY = ZFB_BGY + (ZFB_BGH - cycH) * 0.5;
    
    _type_ZFB_IconF = CGRectMake(cycX, zfbY, cycW, cycH);
    
    CGFloat ZFB_TitleX = CGRectGetMaxX(_type_ZFB_IconF) + 10;
    
    CGFloat ZFB_TitleH = CYC_TitleH;
    
    CGFloat ZFB_TitleY = ZFB_BGY + (ZFB_BGH - ZFB_TitleH) * 0.5;
    
    CGFloat ZFB_TitleW = _WindowViewWidth * 0.6;
    
    _type_ZFB_TitleF = CGRectMake(ZFB_TitleX, ZFB_TitleY, ZFB_TitleW, ZFB_TitleH);
    
    CGFloat ZFB_ImgW = CYC_ImgW;
    
    CGFloat ZFB_ImgH = ZFB_ImgW;
    
    CGFloat ZFB_ImgX = _WindowViewWidth * 0.95 - ZFB_ImgW;
    
    CGFloat ZFB_ImgY = (ZFB_BGH - ZFB_ImgH) * 0.5 + ZFB_BGY;
    
    _type_ZFB_ImgF = CGRectMake(ZFB_ImgX, ZFB_ImgY, ZFB_ImgW, ZFB_ImgH);
    
    
    
    CGFloat sureX = _WindowViewWidth * 0.1;
    
    CGFloat sureY = CGRectGetMaxY(_type_ZFB_BGF) + 50;
    
    CGFloat sureW = _WindowViewWidth * 0.8;
    
    CGFloat sureH = 50;
    
    _sureF = CGRectMake(sureX, sureY, sureW, sureH);
    
    _height = CGRectGetMaxY(_sureF);
    
}

@end
