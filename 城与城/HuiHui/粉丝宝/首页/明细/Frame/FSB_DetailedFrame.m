//
//  FSB_DetailedFrame.m
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_DetailedFrame.h"
#import "FSB_DetailedModel.h"
#import "LJConst.h"

@implementation FSB_DetailedFrame

-(void)setDetailedModel:(FSB_DetailedModel *)detailedModel {

    _detailedModel = detailedModel;
    
    CGFloat topX = 0;
    
    CGFloat topY = 0;
    
    CGFloat topW = _WindowViewWidth;
    
    CGFloat topH = 0.5;
    
    _topF = CGRectMake(topX, topY, topW, topH);
    
    CGFloat sourceX = _WindowViewWidth * 0.05;
    
    CGFloat sourceY = 10;
    
    CGFloat sourceW = _WindowViewWidth * 0.45;
    
    CGFloat sourceH = 20;
    
    _SourceF = CGRectMake(sourceX, sourceY, sourceW, sourceH);
    
    CGFloat statusX = _WindowViewWidth * 0.5;
    
    CGFloat statusY = sourceY;
    
    CGFloat statusW = sourceW;
    
    CGFloat statusH = sourceH;
    
    _StatusF = CGRectMake(statusX, statusY, statusW, statusH);
    
    CGFloat proX = _WindowViewWidth * 0.1;
    
    CGFloat proY = CGRectGetMaxY(_StatusF) + 10;
    
    CGFloat proW = _WindowViewWidth * 0.8;
    
    CGFloat proH = 10;
    
    _progressF = CGRectMake(proX, proY, proW, proH);
    
    CGFloat toX = proX;
    
    CGFloat toY = CGRectGetMaxY(_progressF) + 10;
    
    CGFloat toH = 15;
    
    CGSize size = [self sizeWithText:[NSString stringWithFormat:@"%@",detailedModel.Total] font:FSB_DetailedCountFont maxSize:CGSizeMake(0, toH)];
    
    CGFloat toW = size.width;
    
    _TotalF = CGRectMake(toX, toY, toW, toH);
    
    CGFloat allX = CGRectGetMaxX(_TotalF);
    
    CGFloat allY = toY;
    
    CGFloat allW = _WindowViewWidth * 0.5 - allX;
    
    CGFloat allH = toH;
    
    _totaleduF = CGRectMake(allX, allY, allW, allH);
    
    CGFloat gressX = _WindowViewWidth * 0.5;
    
    CGFloat gressY = toY;
    
    CGFloat gressW = _WindowViewWidth * 0.4;
    
    CGFloat gressH = toH;
    
    _progressCountF = CGRectMake(gressX, gressY, gressW, gressH);

    CGFloat bgX = _WindowViewWidth * 0.05;
    
    CGFloat bgY = CGRectGetMaxY(_StatusF) + 5;
    
    CGFloat bgW = _WindowViewWidth * 0.9;
    
    CGFloat bgH = CGRectGetMaxY(_progressCountF) + 10 - bgY;
    
    _bgviewF = CGRectMake(bgX, bgY, bgW, bgH);
    
    CGFloat fanliX = sourceX;
    
    CGFloat fanliY = CGRectGetMaxY(_bgviewF) + 8;
    
    CGFloat fanliW = sourceW;
    
    CGFloat fanliH = sourceH;
    
    _FanliIDF = CGRectMake(fanliX, fanliY, fanliW, fanliH);
    
    CGFloat dayX = statusX;
    
    CGFloat dayY = fanliY;
    
    CGFloat dayW = fanliW;
    
    CGFloat dayH = fanliH;
    
    _DaysF = CGRectMake(dayX, dayY, dayW, dayH);
    
    CGFloat dateX = sourceX;
    
    CGFloat dateY = CGRectGetMaxY(_DaysF) + 8;
    
    CGFloat dateW = dayW;
    
    CGFloat dateH = dayH;
    
    _dateF = CGRectMake(dateX, dateY, dateW, dateH);
    
    CGFloat goodX = statusX;
    
    CGFloat goodY = dateY;
    
    CGFloat goodW = dateW;
    
    CGFloat goodH = dateH;
    
    _goodF = CGRectMake(goodX, goodY, goodW, goodH);
    
    if ([detailedModel.Status isEqualToString:@"2"]) {
        
        CGFloat liyouX = sourceX;
        
        CGFloat liyouY = CGRectGetMaxY(_dateF) + 8;
        
        CGFloat liyouW = dateW;
        
        CGFloat liyouH = dateH;
        
        _liyouF = CGRectMake(liyouX, liyouY, liyouW, liyouH);
        
        CGFloat phoneX = _WindowViewWidth * 0.95 - 40;
        
        CGFloat phoneY = CGRectGetMaxY(_goodF) + 8;
        
        CGFloat phoneW = 40;
        
        CGFloat phoneH = goodH;
        
        _phoneF = CGRectMake(phoneX, phoneY, phoneW, phoneH);
        
        CGFloat bottomX = 0;
        
        CGFloat bottomY = CGRectGetMaxY(_phoneF) + 9.5;
        
        CGFloat bottomW = _WindowViewWidth;
        
        CGFloat bottomH = 0.5;
        
        _bottomF = CGRectMake(bottomX, bottomY, bottomW, bottomH);
        
        CGFloat lineX = 0;
        
        CGFloat lineY = CGRectGetMaxY(_bottomF);
        
        CGFloat lineW = _WindowViewWidth;
        
        CGFloat lineH = 20;
        
        _lineF = CGRectMake(lineX, lineY, lineW, lineH);
        
        _height = CGRectGetMaxY(_lineF);
        
    }else {
    
        CGFloat bottomX = 0;
        
        CGFloat bottomY = CGRectGetMaxY(_dateF) + 9.5;
        
        CGFloat bottomW = _WindowViewWidth;
        
        CGFloat bottomH = 0.5;
        
        _bottomF = CGRectMake(bottomX, bottomY, bottomW, bottomH);
        
        CGFloat lineX = 0;
        
        CGFloat lineY = CGRectGetMaxY(_bottomF);
        
        CGFloat lineW = _WindowViewWidth;
        
        CGFloat lineH = 20;
        
        _lineF = CGRectMake(lineX, lineY, lineW, lineH);
        
        _height = CGRectGetMaxY(_lineF);
        
    }
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
