//
//  GAME_RechargeFrame.m
//  HuiHui
//
//  Created by mac on 2017/9/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GAME_RechargeFrame.h"
#import "RedHorseHeader.h"
#import "GetOut_TranModel.h"

@implementation GAME_RechargeFrame

-(void)setTranmodel:(GetOut_TranModel *)tranmodel {
    
    _tranmodel = tranmodel;
    
    CGFloat titleX = ScreenWidth * 0.05;
    
    CGFloat titleY = 25;
    
    CGFloat titleH = 20;
    
    CGSize titleSize = [self sizeWithText:@"账户余额" font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(0, titleH)];
    
    CGFloat titleW = titleSize.width;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat balanceX = CGRectGetMaxX(_titleF) + 20;
    
    CGFloat balanceY = titleY;
    
    CGFloat balanceW = ScreenWidth * 0.95 - balanceX;
    
    CGFloat balanceH = titleH;
    
    _balanceF = CGRectMake(balanceX, balanceY, balanceW, balanceH);
    
    CGFloat countX = 0;
    
    CGFloat countY = 25 + CGRectGetMaxY(_titleF);
    
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
