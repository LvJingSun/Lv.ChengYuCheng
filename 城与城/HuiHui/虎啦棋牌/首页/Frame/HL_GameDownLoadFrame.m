//
//  HL_GameDownLoadFrame.m
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_GameDownLoadFrame.h"
#import "LJConst.h"
#import "HL_GameDownLoadModel.h"

@implementation HL_GameDownLoadFrame

-(void)setGameModel:(HL_GameDownLoadModel *)gameModel {
    
    _gameModel = gameModel;
    
    CGFloat iconX = _WindowViewWidth * 0.05;
    
    CGFloat iconY = 10;
    
    CGFloat iconW = 40;
    
    CGFloat iconH = iconW;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat nameX = CGRectGetMaxX(_iconF) + 20;
    
    CGFloat nameY = iconY;
    
    CGFloat nameW = _WindowViewWidth * 0.8 - nameX;
    
    CGFloat nameH = 25;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat countX = nameX;
    
    CGFloat countY = CGRectGetMaxY(_nameF);
    
    CGFloat countW = nameW;
    
    CGFloat countH = 15;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat lineX = _WindowViewWidth * 0.05;
    
    CGFloat lineY = CGRectGetMaxY(_iconF) + iconY;
    
    CGFloat lineW = _WindowViewWidth * 0.9;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
    CGFloat btnH = 30;
    
    CGSize size = [self sizeWithText:@"下载" font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(0, btnH)];
    
    CGFloat btnW = size.width + 30;
    
    CGFloat btnX = _WindowViewWidth * 0.95 - btnW;
    
    CGFloat btnY = (_height - btnH) * 0.5;
    
    _downF = CGRectMake(btnX, btnY, btnW, btnH);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
