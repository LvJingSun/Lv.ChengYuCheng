//
//  HL_RecommendFrame.m
//  HuiHui
//
//  Created by mac on 2017/12/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_RecommendFrame.h"
#import "HL_RecommendModel.h"
#import "LJConst.h"

@implementation HL_RecommendFrame

-(void)setModel:(HL_RecommendModel *)model {
    
    _model = model;
    
    CGFloat bgW = 200;
    
    CGFloat bgX = (_WindowViewWidth - bgW) * 0.5;
    
    CGFloat bgY = 50;
    
    CGFloat bgH = bgW;
    
    _bgF = CGRectMake(bgX, bgY, bgW, bgH);
    
    CGFloat titleY = bgY + 10;
    
    CGFloat titleW = bgW;
    
    CGFloat titleX = bgX;
    
    CGFloat titleH = 20;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat imgY = CGRectGetMaxY(_titleF) + 15;
    
    CGFloat imgW = 140;
    
    CGFloat imgX = (_WindowViewWidth - imgW) * 0.5;
    
    CGFloat imgH = imgW;
    
    _iconF = CGRectMake(imgX, imgY, imgW, imgH);
    
    CGSize shareSize = [self sizeWithText:@"分享" font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(0, 0)];
    
    CGFloat shareW = shareSize.width + 20;
    
    CGFloat shareX = (_WindowViewWidth - shareW) * 0.5;
    
    CGFloat shareY = CGRectGetMaxY(_bgF) + 100;
    
    CGFloat shareH = shareSize.height;
    
    _contentF = CGRectMake(shareX, shareY, shareW, shareH);
    
    CGFloat lineW = (_WindowViewWidth * 0.7 - shareW) * 0.5;
    
    CGFloat lineH = 2;
    
    CGFloat line1X = _WindowViewWidth * 0.15;
    
    CGFloat lineY = shareY + (shareH - lineH) * 0.5;
    
    _line1F = CGRectMake(line1X, lineY, lineW, lineH);
    
    CGFloat line2X = CGRectGetMaxX(_contentF);
    
    _line2F = CGRectMake(line2X, lineY, lineW, lineH);
    
    CGFloat btnW = 50;
    
    CGFloat margin = (_WindowViewWidth - 6 * btnW) * 0.14285714;
    
    CGFloat btnY = CGRectGetMaxY(_contentF) + 20;
    
    _QQF = CGRectMake(margin, btnY, btnW, btnW);
    
    _QZoneF = CGRectMake(CGRectGetMaxX(_QQF) + margin, btnY, btnW, btnW);
    
    _WXF = CGRectMake(CGRectGetMaxX(_QZoneF) + margin, btnY, btnW, btnW);
    
    _CircleF = CGRectMake(CGRectGetMaxX(_WXF) + margin, btnY, btnW, btnW);
    
    _MessageF = CGRectMake(CGRectGetMaxX(_CircleF) + margin, btnY, btnW, btnW);
    
    _CopyF = CGRectMake(CGRectGetMaxX(_MessageF) + margin, btnY, btnW, btnW);
    
    _height = CGRectGetMaxY(_MessageF);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
