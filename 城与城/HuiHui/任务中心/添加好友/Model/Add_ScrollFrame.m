//
//  Add_ScrollFrame.m
//  HuiHui
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Add_ScrollFrame.h"

@implementation Add_ScrollFrame

-(void)setFriendModel:(Add_MoreFriends *)friendModel {

    _friendModel = friendModel;
    
    CGFloat iconX = 10;
    
    CGFloat iconY = 15;
    
    CGFloat iconW = 70;
    
    CGFloat iconH = iconW;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat nameX = 0;
    
    CGFloat nameY = CGRectGetMaxY(_iconF) + 10;
    
    CGFloat nameW = 90;
    
    CGFloat nameH = 20;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat addX = iconX;
    
    CGFloat addY = CGRectGetMaxY(_nameF) + 5;
    
    CGFloat addW = iconW;
    
    CGFloat addH = 30;
    
    _addF = CGRectMake(addX, addY, addW, addH);
    
    _scr_size = CGSizeMake(CGRectGetMaxX(_iconF) + 10, CGRectGetMaxY(_addF) + 5);
    
}

@end
