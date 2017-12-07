//
//  H_MyTeamHeadFrame.m
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "H_MyTeamHeadFrame.h"
#import "LJConst.h"
#import "H_MyTeamHeadModel.h"

@implementation H_MyTeamHeadFrame

-(void)setHeadModel:(H_MyTeamHeadModel *)headModel {
    
    _headModel = headModel;
    
    CGFloat margin = 1;
    
    CGFloat onex = 0;
    
    CGFloat oney = 0;
    
    CGFloat onew = (_WindowViewWidth - margin) * 0.5;
    
    CGFloat oneh = 80;
    
    _OneF = CGRectMake(onex, oney, onew, oneh);
    
    CGFloat twox = CGRectGetMaxX(_OneF) + margin;
    
    CGFloat twoY = oney;
    
    CGFloat twoW = onew;
    
    CGFloat twoh = oneh;
    
    _TwoF = CGRectMake(twox, twoY, twoW, twoh);
    
    CGFloat threex = onex;
    
    CGFloat threey = CGRectGetMaxY(_OneF) + margin;
    
    CGFloat threeW = onew;
    
    CGFloat threeh = oneh;
    
    _ThreeF = CGRectMake(threex, threey, threeW, threeh);
    
    CGFloat fourx = twox;
    
    CGFloat foury = threey;
    
    CGFloat fourw = onew;
    
    CGFloat fourh = oneh;
    
    _FourF = CGRectMake(fourx, foury, fourw, fourh);
    
    CGFloat Width = _WindowViewWidth * 0.25;
    
    CGFloat nameX = 0;
    
    CGFloat nameY = CGRectGetMaxY(_FourF);
    
    CGFloat nameW = Width;
    
    CGFloat nameH = 50;
    
    _huiyuanmingF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat jibieX = CGRectGetMaxX(_huiyuanmingF);
    
    _jibieF = CGRectMake(jibieX, nameY, nameW, nameH);
    
    CGFloat renshuX = CGRectGetMaxX(_jibieF);
    
    _renshuF = CGRectMake(renshuX, nameY, nameW, nameH);
    
    CGFloat shouyiX = CGRectGetMaxX(_renshuF);
    
    _shouyiF = CGRectMake(shouyiX, nameY, nameW, nameH);
    
    _height = CGRectGetMaxY(_shouyiF);
    
}

@end
