//
//  C_FriendFrame.m
//  HuiHui
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "C_FriendFrame.h"

@implementation C_FriendFrame

-(void)setFriendModel:(I_Friend *)friendModel {

    _friendModel = friendModel;
    
    CGFloat iconX = 0;
    
    CGFloat iconY = 0;
    
    CGFloat iconW = 50;
    
    CGFloat iconH = iconW;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    _c_size = _iconF.size;
    
}

@end
