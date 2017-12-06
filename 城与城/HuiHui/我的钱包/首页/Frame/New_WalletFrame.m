//
//  New_WalletFrame.m
//  HuiHui
//
//  Created by mac on 2017/8/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "New_WalletFrame.h"
#import "New_WalletModel.h"
#import "RedHorseHeader.h"

@implementation New_WalletFrame

-(void)setWalletmodel:(New_WalletModel *)walletmodel {

    _walletmodel = walletmodel;
    
    CGFloat iconX = ScreenWidth * 0.05;
    
    CGFloat iconY = 15;
    
    CGFloat iconW = 40;
    
    CGFloat iconH = 30;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_iconF) + iconY;
    
    CGFloat lineW = ScreenWidth;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
    CGSize titlesize = [self sizeWithText:walletmodel.title font:[UIFont systemFontOfSize:18] maxSize:CGSizeMake(0,0)];
    
    CGFloat titleX = CGRectGetMaxX(_iconF) + ScreenWidth * 0.04;
    
    CGFloat titleY = (_height - titlesize.height) * 0.5;
    
    CGFloat titleW = titlesize.width;
    
    CGFloat titleH = titlesize.height;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat rightW = 15;
    
    CGFloat rightH = rightW;
    
    CGFloat rightX = ScreenWidth * 0.95 - rightW;
    
    CGFloat rightY = (_height - rightH) * 0.5;
    
    _rightF = CGRectMake(rightX, rightY, rightW, rightH);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}


@end
