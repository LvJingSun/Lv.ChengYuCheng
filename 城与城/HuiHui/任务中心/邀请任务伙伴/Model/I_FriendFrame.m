//
//  I_FriendFrame.m
//  HuiHui
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "I_FriendFrame.h"
#import "I_Friend.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation I_FriendFrame

-(void)setFriendModel:(I_Friend *)friendModel {

    _friendModel = friendModel;
    
    CGFloat iconX = SCREEN_WIDTH * 0.2;
    
    CGFloat iconY = 15;
    
    CGFloat iconW = 70;
    
    CGFloat iconH = iconW;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGSize size = [self sizeWithText:[NSString stringWithFormat:@"%@",friendModel.NickName] font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(0, iconH * 0.6)];
    
    CGFloat nickX = CGRectGetMaxX(_iconF) + 10;
    
    CGFloat nickY = iconY;
    
    CGFloat nickW = size.width;
    
    CGFloat nickH = iconH * 0.6;
    
    _nickF = CGRectMake(nickX, nickY, nickW, nickH);
    
    CGFloat nameX = CGRectGetMaxX(_nickF) + 5;
    
    CGFloat nameY = nickY;
    
    CGFloat nameW = SCREEN_WIDTH * 0.95 - nameX;
    
    CGFloat nameH = nickH;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat phoneX = nickX;
    
    CGFloat phoneY = CGRectGetMaxY(_nickF) + iconH * 0.1;
    
    CGFloat phoneW = SCREEN_WIDTH * 0.95 - phoneX;
    
    CGFloat phoneH = iconH * 0.3;
    
    _phoneF = CGRectMake(phoneX, phoneY, phoneW, phoneH);
    
    CGFloat lineX = iconX;
    
    CGFloat lineY = CGRectGetMaxY(_iconF) + iconY - 1;
    
    CGFloat lineW = SCREEN_WIDTH - lineX;
    
    CGFloat lineH = 1;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
    CGFloat chooseH = 40;
    
    CGFloat chooseY = (_height - chooseH) * 0.5;
    
    CGFloat chooseW = chooseH;
    
    CGFloat chooseX = (SCREEN_WIDTH * 0.15 - chooseW) * 0.5;
    
    _chooseF = CGRectMake(chooseX, chooseY, chooseW, chooseH);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
