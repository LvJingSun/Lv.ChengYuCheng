//
//  GameRechargeFrame.m
//  HuiHui
//
//  Created by mac on 2017/10/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameRechargeFrame.h"
#import "RedHorseHeader.h"
#import "GameRechargeModel.h"

@implementation GameRechargeFrame

-(void)setTranmodel:(GameRechargeModel *)tranmodel {
    
    _tranmodel = tranmodel;
    
    CGFloat idX = 0;
    
    CGFloat idY = 25;
    
    CGFloat idW = ScreenWidth;
    
    CGFloat idH = 60;
    
    _qipaiIDF = CGRectMake(idX, idY, idW, idH);
    
    CGSize qipaisize = [self sizeWithText:@"游戏ID获取？？？" font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(0, 0)];
    
    CGFloat qipaiX = ScreenWidth * 0.968 - qipaisize.width;
    
    CGFloat qipaiY = CGRectGetMaxY(_qipaiIDF) + 5;
    
    CGFloat qipaiW = qipaisize.width;
    
    CGFloat qipaiH = qipaisize.height;
    
    _qipaiNoticeF = CGRectMake(qipaiX, qipaiY, qipaiW, qipaiH);
    
    CGFloat nickX = ScreenWidth * 0.05;
    
    CGFloat nickY = qipaiY;
    
    CGFloat nickW = ScreenWidth * 0.3;
    
    CGFloat nickH = qipaiH;
    
    _qipaiNickF = CGRectMake(nickX, nickY, nickW, nickH);
    
//    CGFloat YBX = ScreenWidth * 0.1;
//
//    CGFloat YBY = 20 + CGRectGetMaxY(_qipaiNoticeF);
//
//    CGFloat YBW = ScreenWidth * 0.4;
//
//    CGFloat YBH = 40;
//
//    _YBF = CGRectMake(YBX, YBY, YBW, YBH);
//
//    CGFloat FKX = CGRectGetMaxX(_YBF);
//
//    CGFloat FKY = YBY;
//
//    CGFloat FKW = YBW;
//
//    CGFloat FKH = YBH;
//
//    _FKF = CGRectMake(FKX, FKY, FKW, FKH);
    
    CGFloat countX = 0;
    
    CGFloat countY = 20 + CGRectGetMaxY(_qipaiNoticeF);
    
    CGFloat countW = ScreenWidth;
    
    CGFloat countH = 60;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat sureX = ScreenWidth * 0.05;
    
    CGFloat sureY = CGRectGetMaxY(_countF) + 30;
    
    CGFloat sureW = ScreenWidth * 0.9;
    
    CGFloat sureH = 40;
    
    _sureF = CGRectMake(sureX, sureY, sureW, sureH);
    
    CGFloat noticeX = sureX;
    
    CGFloat noticeY = CGRectGetMaxY(_sureF) + 20;
    
    CGFloat noticeW = sureW;
    
    CGSize size = [self sizeWithText:tranmodel.notice font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(noticeW, 0)];
    
    CGFloat noticeH = size.height;
    
    _noticeF = CGRectMake(noticeX, noticeY, noticeW, noticeH);
    
    _height = CGRectGetMaxY(_noticeF);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
