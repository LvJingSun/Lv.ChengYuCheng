//
//  T_Detail2Frame.m
//  HuiHui
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_Detail2Frame.h"
//#import "T_TaskMember.h"
#import "TH_TaskMemberModel.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation T_Detail2Frame

-(void)setTh_memberModel:(TH_TaskMemberModel *)th_memberModel {

    _th_memberModel = th_memberModel;
    
    CGFloat iconX = SCREEN_WIDTH * 0.05;
    
    CGFloat iconY = 10;
    
    CGFloat iconW = 30;
    
    CGFloat iconH = iconW;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat nameX = CGRectGetMaxX(_iconF) + 10;
    
    CGFloat nameY = iconY;
    
    CGFloat nameW = SCREEN_WIDTH * 0.35 - nameX - 5;
    
    CGFloat nameH = iconH;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat statusX = SCREEN_WIDTH * 0.4;
    
    CGFloat statusY = iconY;
    
    CGFloat statusW = SCREEN_WIDTH * 0.2;
    
    CGFloat statusH = iconH;
    
    _statusF = CGRectMake(statusX, statusY, statusW, statusH);
    
    CGFloat countX = CGRectGetMaxX(_statusF) + 10;
    
    CGFloat countY = iconY;
    
    CGFloat countW = SCREEN_WIDTH * 0.95 - countX;
    
    CGFloat countH = iconH;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    _height = CGRectGetMaxY(_countF) + 10;
    
}

@end
