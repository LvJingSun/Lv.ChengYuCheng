//
//  T_S_FriendFrame.m
//  HuiHui
//
//  Created by mac on 2017/5/10.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_S_FriendFrame.h"
#import "T_S_FriendModel.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define NameFont [UIFont systemFontOfSize:18]

@implementation T_S_FriendFrame

-(void)setFriendModel:(T_S_FriendModel *)friendModel {

    _friendModel = friendModel;
    
    CGFloat iconX = SCREEN_WIDTH * 0.05;
    
    CGFloat iconY = 10;
    
    CGFloat iconW = 70;
    
    CGFloat iconH = iconW;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat nickX = CGRectGetMaxX(_iconF) + SCREEN_WIDTH * 0.05;
    
    CGFloat nickY = iconY;
    
    CGFloat nickH = (iconH - 10) * 0.5;
    
    CGSize size = [self sizeWithText:[NSString stringWithFormat:@"%@",friendModel.NickName] font:NameFont maxSize:CGSizeMake(0, nickH)];
    
    CGFloat nickW = size.width;
    
    _nickF = CGRectMake(nickX, nickY, nickW, nickH);
    
    CGFloat nameX = CGRectGetMaxX(_nickF);
    
    CGFloat nameY = iconY;
    
    CGFloat nameW = SCREEN_WIDTH * 0.8 - nameX;
    
    CGFloat nameH = nickH;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat accountX = nickX;
    
    CGFloat accountY = CGRectGetMaxY(_nickF) + 10;
    
    CGFloat accountW = SCREEN_WIDTH * 0.8 - accountX;
    
    CGFloat accountH = nickH;
    
    _accountF = CGRectMake(accountX, accountY, accountW, accountH);
    
    CGFloat addH = 30;
    
    CGFloat addY = iconY + (iconH - addH) * 0.5;
    
    CGFloat addW = 60;
    
    CGFloat addX = SCREEN_WIDTH * 0.95 - addW;
    
    _addF = CGRectMake(addX, addY, addW, addH);
    
    CGFloat lineX = nickX;
    
    CGFloat lineY = CGRectGetMaxY(_iconF) + iconY;
    
    CGFloat lineW = SCREEN_WIDTH - lineX;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
