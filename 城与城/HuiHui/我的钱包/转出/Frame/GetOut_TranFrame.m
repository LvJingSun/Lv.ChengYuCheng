//
//  GetOut_TranFrame.m
//  HuiHui
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GetOut_TranFrame.h"
#import "RedHorseHeader.h"
#import "GetOut_TranModel.h"

@implementation GetOut_TranFrame

-(void)setTranmodel:(GetOut_TranModel *)tranmodel {

    _tranmodel = tranmodel;
    
    CGFloat countX = 0;
    
    CGFloat countY = 25;
    
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
