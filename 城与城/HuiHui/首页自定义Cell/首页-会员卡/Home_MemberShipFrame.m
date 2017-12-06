//
//  Home_MemberShipFrame.m
//  HuiHui
//
//  Created by mac on 2017/8/9.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Home_MemberShipFrame.h"
#import "Home_MemberShipModel.h"
#import "RedHorseHeader.h"

@implementation Home_MemberShipFrame

-(void)setCellModel:(Home_MemberShipModel *)cellModel {

    _cellModel = cellModel;
    
    CGFloat img1X = ScreenWidth * 0.032;
    
    CGFloat img1Y = 8;
    
    CGFloat img1W = (ScreenWidth - img1X * 3) * 0.5;
    
    CGFloat img1H = img1W * 0.44;
    
    _memberF = CGRectMake(img1X, img1Y, img1W, img1H);
    
    CGFloat dingX = CGRectGetMaxX(_memberF) + img1X;
    
    CGFloat dingY = img1Y;
    
    CGFloat dingW = img1W;
    
    CGFloat dingH = img1H;
    
    _diandanF = CGRectMake(dingX, dingY, dingW, dingH);
    
    _height = CGRectGetMaxY(_diandanF) + img1Y;
    
}

@end
