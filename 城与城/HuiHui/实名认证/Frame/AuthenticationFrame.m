//
//  AuthenticationFrame.m
//  HuiHui
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "AuthenticationFrame.h"
#import "AuthenticationModel.h"
#import "LJConst.h"

@implementation AuthenticationFrame

-(void)setAuthenModel:(AuthenticationModel *)authenModel {

    _authenModel = authenModel;
    
    CGFloat facetitleX = _WindowViewWidth * 0.1;
    
    CGFloat facetitleY = 20;
    
    CGFloat facetitleW = _WindowViewWidth * 0.8;
    
    CGFloat facetitleH = 30;
    
    _faceTitleF = CGRectMake(facetitleX, facetitleY, facetitleW, facetitleH);
    
    CGFloat faceimgX = _WindowViewWidth * 0.2;
    
    CGFloat faceimgY = CGRectGetMaxY(_faceTitleF) + 10;
    
    CGFloat faceimgW = _WindowViewWidth * 0.6;
    
    CGFloat faceimgH = faceimgW * 0.63;
    
    _faceImgF = CGRectMake(faceimgX, faceimgY, faceimgW, faceimgH);
    
    CGFloat backtitleX = facetitleX;
    
    CGFloat backtitleY = 20 + CGRectGetMaxY(_faceImgF);
    
    CGFloat backtitleW = _WindowViewWidth * 0.8;
    
    CGFloat backtitleH = facetitleH;
    
    _backTitleF = CGRectMake(backtitleX, backtitleY, backtitleW, backtitleH);
    
    CGFloat backimgX = faceimgX;
    
    CGFloat backimgY = CGRectGetMaxY(_backTitleF) + 10;
    
    CGFloat backimgW = faceimgW;
    
    CGFloat backimgH = faceimgH;
    
    _backImgF = CGRectMake(backimgX, backimgY, backimgW, backimgH);
    
    CGFloat sureX = _WindowViewWidth * 0.1;
    
    CGFloat sureY = CGRectGetMaxY(_backImgF) + 40;
    
    CGFloat sureW = _WindowViewWidth * 0.8;
    
    CGFloat sureH = 50;
    
    _sureF = CGRectMake(sureX, sureY, sureW, sureH);
    
    _height = CGRectGetMaxY(_sureF);
    
}

@end
