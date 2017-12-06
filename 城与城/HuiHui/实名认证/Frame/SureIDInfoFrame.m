//
//  SureIDInfoFrame.m
//  HuiHui
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "SureIDInfoFrame.h"
#import "LJConst.h"
#import "AuthenticationModel.h"

@implementation SureIDInfoFrame

-(void)setAuthModel:(AuthenticationModel *)authModel {

    _authModel = authModel;
    
    CGFloat nametitleX = _WindowViewWidth * 0.1;
    
    CGFloat nametitleY = 15;
    
    CGFloat nametitleH = 20;
    
    CGSize namesize = [self sizeWithText:@"姓名：" font:FSB_ConsumptionOrderStatusFont maxSize:CGSizeMake(0, nametitleH)];
    
    CGFloat nametitleW = namesize.width;
    
    _nameTitleF = CGRectMake(nametitleX, nametitleY, nametitleW, nametitleH);
    
    CGFloat nameX = CGRectGetMaxX(_nameTitleF) + 10;
    
    CGFloat nameY = nametitleY;
    
    CGFloat nameW = _WindowViewWidth * 0.9 - nameX;
    
    CGFloat nameH = nametitleH;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat numtitleX = nametitleX;
    
    CGFloat numtitleY = 15 + CGRectGetMaxY(_nameTitleF);
    
    CGFloat numtitleH = nametitleH;
    
    CGSize numsize = [self sizeWithText:@"身份证号码：" font:FSB_ConsumptionOrderStatusFont maxSize:CGSizeMake(0, numtitleH)];
    
    CGFloat numtitleW = numsize.width;
    
    _numTitleF = CGRectMake(numtitleX, numtitleY, numtitleW, numtitleH);
    
    CGFloat numX = CGRectGetMaxX(_numTitleF) + 10;
    
    CGFloat numY = numtitleY;
    
    CGFloat numW = _WindowViewWidth * 0.9 - numX;
    
    CGFloat numH = numtitleH;
    
    _numF = CGRectMake(numX, numY, numW, numH);
    
    CGFloat datetitleX = nametitleX;
    
    CGFloat datetitleY = 15 + CGRectGetMaxY(_numTitleF);
    
    CGFloat datetitleH = nametitleH;
    
    CGSize datesize = [self sizeWithText:@"有效期限：" font:FSB_ConsumptionOrderStatusFont maxSize:CGSizeMake(0, datetitleH)];
    
    CGFloat datetitleW = datesize.width;
    
    _dateTitleF = CGRectMake(datetitleX, datetitleY, datetitleW, datetitleH);
    
    CGFloat dateX = CGRectGetMaxX(_dateTitleF) + 10;
    
    CGFloat dateY = datetitleY;
    
    CGFloat dateW = _WindowViewWidth * 0.9 - dateX;
    
    CGFloat dateH = datetitleH;
    
    _dateF = CGRectMake(dateX, dateY, dateW, dateH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_dateF) + 15;
    
    CGFloat lineW = _WindowViewWidth;
    
    CGFloat lineH = 10;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat facetitleX = _WindowViewWidth * 0.1;
    
    CGFloat facetitleY = CGRectGetMaxY(_lineF) + 30;
    
    CGFloat facetitleW = _WindowViewWidth * 0.35;
    
    CGFloat facetitleH = 20;
    
    _faceTitleF = CGRectMake(facetitleX, facetitleY, facetitleW, facetitleH);
    
    CGFloat faceX = facetitleX;
    
    CGFloat faceY = CGRectGetMaxY(_faceTitleF) + 10;
    
    CGFloat faceW = facetitleW;
    
    CGFloat faceH = faceW * 0.63;
    
    _faceF = CGRectMake(faceX, faceY, faceW, faceH);
    
    CGFloat backtitleX = CGRectGetMaxX(_faceF) + facetitleX;
    
    CGFloat backtitleY = facetitleY;
    
    CGFloat backtitleW = facetitleW;
    
    CGFloat backtitleH = facetitleH;
    
    _backTitleF = CGRectMake(backtitleX, backtitleY, backtitleW, backtitleH);
    
    CGFloat backX = backtitleX;
    
    CGFloat backY = CGRectGetMaxY(_backTitleF) + 10;
    
    CGFloat backW = faceW;
    
    CGFloat backH = faceH;
    
    _backF = CGRectMake(backX, backY, backW, backH);
    
    CGFloat sureX = _WindowViewWidth * 0.1;
    
    CGFloat sureY = CGRectGetMaxY(_backF) + 50 + 70;
    
    CGFloat sureW = _WindowViewWidth * 0.8;
    
    CGFloat sureH = 50;
    
    _sureF = CGRectMake(sureX, sureY, sureW, sureH);
    
    CGFloat bgX = 0;
    
    CGFloat bgY = CGRectGetMaxY(_backF) + 50;
    
    CGFloat bgW = _WindowViewWidth;
    
    CGFloat bgH = CGRectGetMaxY(_sureF) - bgY;
    
    _sureBGF = CGRectMake(bgX, bgY, bgW, bgH);
    
    _height = CGRectGetMaxY(_sureBGF);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
