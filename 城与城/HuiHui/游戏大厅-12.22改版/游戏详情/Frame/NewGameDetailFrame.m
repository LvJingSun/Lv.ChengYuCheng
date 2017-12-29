//
//  NewGameDetailFrame.m
//  HuiHui
//
//  Created by mac on 2017/12/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "NewGameDetailFrame.h"
#import "LJConst.h"
#import "NewGameDetailModel.h"

#define titleFont [UIFont systemFontOfSize:16]

@implementation NewGameDetailFrame

-(void)setModel:(NewGameDetailModel *)model {
    
    _model = model;
    
    CGFloat iconX = _WindowViewWidth * 0.05;
    
    CGFloat iconY = 20;
    
    CGFloat iconW = 70;
    
    CGFloat iconH = iconW;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat nameTitleX = CGRectGetMaxX(_iconF) + 20;
    
    CGFloat nameTitleH = 20;
    
    CGFloat margin = (iconH - nameTitleH * 2) * 0.33333;
    
    CGFloat nameTitleY = iconY + margin;
    
    CGSize nametitleSize = [self sizeWithText:@"游戏名称:" font:titleFont maxSize:CGSizeMake(0, nameTitleH)];
    
    CGFloat nameTitleW = nametitleSize.width;
    
    _nameTitleF = CGRectMake(nameTitleX, nameTitleY, nameTitleW, nameTitleH);
    
    CGFloat nameX = CGRectGetMaxX(_nameTitleF) + 10;
    
    CGFloat nameY = nameTitleY;
    
    CGFloat nameW = _WindowViewWidth * 0.95 - nameX;
    
    CGFloat nameH = nameTitleH;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat IDTitleX = nameTitleX;
    
    CGFloat IDTitleH = nameTitleH;
    
    CGFloat IDTitleY = CGRectGetMaxY(_nameTitleF) + margin;
    
    CGSize IDtitleSize = [self sizeWithText:@"游戏ID:" font:titleFont maxSize:CGSizeMake(0, IDTitleH)];
    
    CGFloat IDTitleW = IDtitleSize.width;
    
    _IDTitleF = CGRectMake(IDTitleX, IDTitleY, IDTitleW, IDTitleH);
    
    CGFloat IDX = CGRectGetMaxX(_IDTitleF) + 10;
    
    CGFloat IDY = IDTitleY;
    
    CGFloat IDW = _WindowViewWidth * 0.95 - IDX;
    
    CGFloat IDH = IDTitleH;
    
    _IDF = CGRectMake(IDX, IDY, IDW, IDH);
    
    CGSize size = [self sizeWithText:@"点击绑定" font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(0, IDH)];

    CGFloat bindW = size.width;
    
    _bindF = CGRectMake(IDX, IDY, bindW, IDH);
    
    CGFloat bindLineY = CGRectGetMaxY(_bindF);
    
    CGFloat bindLineH = 1;
    
    _bindLineF = CGRectMake(IDX, bindLineY, bindW, bindLineH);
    
    CGFloat line1X = 0;
    
    CGFloat line1Y = CGRectGetMaxY(_iconF) + iconY;
    
    CGFloat line1W = _WindowViewWidth;
    
    CGFloat line1H = SectionHeight;
    
    _line1F = CGRectMake(line1X, line1Y, line1W, line1H);
    
    CGFloat totalX = _WindowViewWidth * 0.05;
    
    CGFloat totalY = CGRectGetMaxY(_line1F) + 10;
    
    CGFloat totalW = _WindowViewWidth * 0.9;
    
    CGFloat totalH = 20;
    
    _totalTitleF = CGRectMake(totalX, totalY, totalW, totalH);
    
    CGFloat line2X = 0;
    
    CGFloat line2Y = CGRectGetMaxY(_totalTitleF) + 10;
    
    CGFloat line2W = _WindowViewWidth;
    
    CGFloat line2H = 2;
    
    _line2F = CGRectMake(line2X, line2Y, line2W, line2H);
    
    CGFloat counttitleX = _WindowViewWidth * 0.05;
    
    CGFloat counttitleY = CGRectGetMaxY(_line2F) + 10;
    
    CGFloat counttitleW = _WindowViewWidth * 0.9;
    
    CGFloat counttitleH = 20;
    
    _countTitleF = CGRectMake(counttitleX, counttitleY, counttitleW, counttitleH);
    
    CGFloat countX = counttitleX;
    
    CGFloat countY = CGRectGetMaxY(_countTitleF) + 10;
    
    CGFloat countW = counttitleW;
    
    CGFloat countH = 25;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat bgX = 0;
    
    CGFloat bgY = CGRectGetMaxY(_countF) + 10;
    
    CGFloat bgW = _WindowViewWidth;
    
    CGFloat bgH = 60;
    
    _bgF = CGRectMake(bgX, bgY, bgW, bgH);
    
    CGFloat rechargeX = _WindowViewWidth * 0.1;
    
    CGFloat rechargeY = bgY + 10;
    
    CGFloat rechargeW = _WindowViewWidth * 0.35;
    
    CGFloat rechargeH = 40;
    
    _rechargeF = CGRectMake(rechargeX, rechargeY, rechargeW, rechargeH);
    
    CGFloat sendX = _WindowViewWidth * 0.55;
    
    CGFloat sendY = rechargeY;
    
    CGFloat sendW = rechargeW;
    
    CGFloat sendH = rechargeH;
    
    _sendF = CGRectMake(sendX, sendY, sendW, sendH);
    
    CGFloat descTitleX = _WindowViewWidth * 0.05;
    
    CGFloat descTitleY = CGRectGetMaxY(_bgF) + 10;
    
    CGFloat descTitleW = _WindowViewWidth * 0.9;
    
    CGFloat descTitleH = 20;
    
    _descTitleF = CGRectMake(descTitleX, descTitleY, descTitleW, descTitleH);
    
    CGFloat line3X = 0;
    
    CGFloat line3Y = CGRectGetMaxY(_descTitleF) + 10;
    
    CGFloat line3W = _WindowViewWidth;
    
    CGFloat line3H = 2;
    
    _line3F = CGRectMake(line3X, line3Y, line3W, line3H);
    
    CGFloat descX = _WindowViewWidth * 0.03;
    
    CGFloat descY = CGRectGetMaxY(_line3F) + 10;
    
    CGFloat descW = _WindowViewWidth * 0.94;
    
    CGFloat descH = 0;
    
    _descF = CGRectMake(descX, descY, descW, descH);
    
    CGFloat getBGX = 0;
    
    CGFloat getBGY = CGRectGetMaxY(_descF) + 60;
    
    CGFloat getBGW = _WindowViewWidth;
    
    CGFloat getBGH = 100;
    
    _getInBGF = CGRectMake(getBGX, getBGY, getBGW, getBGH);
    
    CGFloat getX = _WindowViewWidth * 0.1;
    
    CGFloat getY = getBGY + 20;
    
    CGFloat getW = _WindowViewWidth * 0.8;
    
    CGFloat getH = 50;
    
    _getInF = CGRectMake(getX, getY, getW, getH);
    
    _height = CGRectGetMaxY(_getInBGF);
    
}

- (void)changeWebViewWith:(CGFloat)webHeight {
    
    CGFloat descX = _WindowViewWidth * 0.03;
    
    CGFloat descY = CGRectGetMaxY(_line3F) + 10;
    
    CGFloat descW = _WindowViewWidth * 0.94;
    
    CGFloat descH = webHeight;
    
    _descF = CGRectMake(descX, descY, descW, descH);
    
    CGFloat getBGX = 0;
    
    CGFloat getBGY = CGRectGetMaxY(_descF) + 20;
    
    CGFloat getBGW = _WindowViewWidth;
    
    CGFloat getBGH = 100;
    
    _getInBGF = CGRectMake(getBGX, getBGY, getBGW, getBGH);
    
    CGFloat getX = _WindowViewWidth * 0.1;
    
    CGFloat getY = getBGY + 20;
    
    CGFloat getW = _WindowViewWidth * 0.8;
    
    CGFloat getH = 50;
    
    _getInF = CGRectMake(getX, getY, getW, getH);
    
    _height = CGRectGetMaxY(_getInBGF);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
