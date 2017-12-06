//
//  ZZ_FriendFrame.m
//  HuiHui
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "ZZ_FriendFrame.h"
#import "RedHorseHeader.h"
#import "ZZ_FriendModel.h"

@implementation ZZ_FriendFrame

-(void)setFriendModel:(ZZ_FriendModel *)friendModel {

    _friendModel = friendModel;
    
    CGFloat iconX = ScreenWidth * 0.05;
    
    CGFloat iconY = 10;
    
    CGFloat iconW = 45;
    
    CGFloat iconH = iconW;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    _height = CGRectGetMaxY(_iconF) + iconY;
    
    CGFloat nameX = CGRectGetMaxX(_iconF) + iconX;
    
    CGFloat nameH = 25;
    
    CGFloat nameY = iconY;
    
    CGFloat nameW = ScreenWidth * 0.95 - nameX;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat phoneX = nameX;
    
    CGFloat phoneY = CGRectGetMaxY(_nameF) + 5;
    
    CGFloat phoneW = nameW;
    
    CGFloat phoneH = 15;
    
    _phoneF = CGRectMake(phoneX, phoneY, phoneW, phoneH);
    
    CGFloat lineX = nameX;
    
    CGFloat lineH = 0.5;
    
    CGFloat lineY = _height - lineH;
    
    CGFloat lineW = ScreenWidth - lineX;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
}

@end
