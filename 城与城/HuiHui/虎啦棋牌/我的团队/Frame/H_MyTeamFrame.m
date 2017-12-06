//
//  H_MyTeamFrame.m
//  HuiHui
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "H_MyTeamFrame.h"
#import "H_MyTeamModel.h"
#import "LJConst.h"

@implementation H_MyTeamFrame

-(void)setModel:(H_MyTeamModel *)model {
    
    _model = model;
    
    CGFloat Width = _WindowViewWidth * 0.25;
    
    CGFloat nameX = 0;
    
    CGFloat nameY = 0;
    
    CGFloat nameW = Width;
    
    CGFloat nameH = 40;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    _levelF = CGRectMake(CGRectGetMaxX(_nameF), nameY, nameW, nameH);
    
    _delegateF = CGRectMake(CGRectGetMaxX(_levelF), nameY, nameW, nameH);
    
    _memberF = CGRectMake(CGRectGetMaxX(_delegateF), nameY, nameW, nameH);
    
    _lineF = CGRectMake(0, CGRectGetMaxY(_nameF), _WindowViewWidth, 1);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
