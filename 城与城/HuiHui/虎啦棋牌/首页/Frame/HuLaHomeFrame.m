//
//  HuLaHomeFrame.m
//  HuiHui
//
//  Created by mac on 2017/11/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HuLaHomeFrame.h"
#import "HuLaHomeModel.h"
#import "LJConst.h"

@implementation HuLaHomeFrame

-(void)setHulaModel:(HuLaHomeModel *)hulaModel {
    
    _hulaModel = hulaModel;
    
    CGFloat logoX = _WindowViewWidth * 0.05;
    
    CGFloat logoY = 5;
    
    CGFloat logoW = 35;
    
    CGFloat logoH = logoW;
    
    _logoF = CGRectMake(logoX, logoY, logoW, logoH);
    
    CGFloat titleX = CGRectGetMaxX(_logoF) + 10;
    
    CGFloat titleH = 30;
    
    CGFloat titleY = logoY + (logoH - titleH) * 0.5;
    
    CGFloat titleW = _WindowViewWidth * 0.95 - titleX;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat nameX = logoX;
    
    CGFloat nameY = 10 + CGRectGetMaxY(_logoF);
    
    CGFloat nameH = 25;
    
    CGSize nameSize = [self sizeWithText:hulaModel.name font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(0, nameH)];
    
    CGFloat nameW = nameSize.width;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat delegateX = CGRectGetMaxX(_nameF) + 5;
    
    CGFloat delegateW = _WindowViewWidth * 0.2;
    
    CGFloat delegateH = nameH;
    
    CGFloat delegateY = nameY + (nameH - delegateH) * 0.5;
    
    _delegateF = CGRectMake(delegateX, delegateY, delegateW, delegateH);
    
    CGFloat roomcardH = nameH;
    
    CGSize r_size = [self sizeWithText:hulaModel.RoomCard_Balance font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(0, roomcardH)];
    
    CGFloat roomcardW = r_size.width;
    
    CGFloat roomcardX = _WindowViewWidth * 0.8 + 10;
    
    CGFloat roomcardY = nameY;
    
    _roomcardF = CGRectMake(roomcardX, roomcardY, roomcardW, roomcardH);
    
    CGSize r_titleSize = [self sizeWithText:@"房卡" font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(0, roomcardH)];
    
    CGFloat r_titleW = r_titleSize.width;
    
    CGFloat t_titleH = roomcardH;
    
    CGFloat r_titleX = _WindowViewWidth * 0.8 - r_titleW;
    
    CGFloat r_titleY = roomcardY;
    
    _roomcard_titleF = CGRectMake(r_titleX, r_titleY, r_titleW, t_titleH);
    
    CGSize m_size = [self sizeWithText:hulaModel.Money_Balance font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(0, roomcardH)];
    
    CGFloat moneyY = CGRectGetMaxY(_nameF) + 10;
    
    _moneyF = CGRectMake(roomcardX, moneyY, m_size.width, roomcardH);
    
    CGSize m_titleSize = [self sizeWithText:@"元宝" font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(0, roomcardH)];
    
    CGFloat m_titleY = moneyY;
    
    CGFloat m_titleX = _WindowViewWidth * 0.8 - m_titleSize.width;
    
    _money_titleF = CGRectMake(m_titleX, m_titleY, m_titleSize.width, roomcardH);
    
    CGFloat IDHeight;
    
    if (hulaModel.isBind) {
        
        CGFloat recharge_titleH = 25;
        
        CGSize recharge_titleSize = [self sizeWithText:@"游戏ID:" font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(0, recharge_titleH)];
        
        CGFloat recharge_titleY = CGRectGetMaxY(_nameF) + 10;
        
        CGFloat recharge_titleX = nameX;
        
        _gameID_titleF = CGRectMake(recharge_titleX, recharge_titleY, recharge_titleSize.width, recharge_titleH);
        
        CGFloat gameIDX = CGRectGetMaxX(_gameID_titleF) + 10;
        
        CGFloat gameIDY = recharge_titleY;
        
        CGFloat gameIDW = _WindowViewWidth * 0.3;
        
        CGFloat gameIDH = recharge_titleH;
        
        _gameIDF = CGRectMake(gameIDX, gameIDY, gameIDW, gameIDH);
        
        IDHeight = CGRectGetMaxY(_gameIDF);
        
    }else {
        
        CGFloat bingH = 25;
        
        CGSize bindSize = [self sizeWithText:@"绑定游戏ID" font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(0, bingH)];
        
        CGFloat bindW = bindSize.width + 5;
        
        CGFloat bindX = nameX;
        
        CGFloat bindY = CGRectGetMaxY(_nameF) + 10;
        
        _bindF = CGRectMake(bindX, bindY, bindW, bingH);
        
        _bindLineF = CGRectMake(bindX, CGRectGetMaxY(_bindF), bindW, 1);
        
        IDHeight = CGRectGetMaxY(_bindLineF);
        
    }

    CGFloat rechargeOtherH = 30;
    
    CGSize rechargeOtherSize = [self sizeWithText:@"给他人充值" font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(0, rechargeOtherH)];
    
    CGFloat rechargeOtherW = rechargeOtherSize.width + 20;
    
    CGFloat rechargeOtherX = _WindowViewWidth * 0.1;
    
    CGFloat rechargeOtherY = IDHeight + 10;
    
    _rechargeOtherF = CGRectMake(rechargeOtherX, rechargeOtherY, rechargeOtherW, rechargeOtherH);
    

    
    CGFloat rechargeW = rechargeOtherW;
    
    CGFloat rechargeX = _WindowViewWidth * 0.9 - rechargeW;
    
    CGFloat rechargeY = rechargeOtherY;
    
    _rechargeF = CGRectMake(rechargeX, rechargeY, rechargeW, rechargeOtherH);
    
    CGFloat contentX = 0;
    
    CGFloat contentY = CGRectGetMaxY(_rechargeF) + 10;
    
    CGFloat contentW = _WindowViewWidth;
    
    CGFloat contentH = contentW * 0.47;
    
    _content_imgF = CGRectMake(contentX, contentY, contentW, contentH);
    
    _height = CGRectGetMaxY(_content_imgF);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
