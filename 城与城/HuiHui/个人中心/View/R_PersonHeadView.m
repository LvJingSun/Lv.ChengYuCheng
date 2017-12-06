//
//  R_PersonHeadView.m
//  HuiHui
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "R_PersonHeadView.h"
#import "LJConst.h"

@implementation R_PersonHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = FSB_ViewBGCOLOR;
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, 170)];
        
        self.contentImg = img;
        
        [self addSubview:img];
        
        CGFloat iconX = _WindowViewWidth * 0.05;
        
        CGFloat iconY = 40;
        
        CGFloat iconW = 70;
        
        CGFloat iconH = iconW;
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
        
        self.iconImg = icon;
        
        icon.layer.masksToBounds = YES;
        
        icon.layer.cornerRadius = iconH * 0.5;
        
        icon.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:icon];
        
        UIButton *iconBtn = [[UIButton alloc] initWithFrame:icon.frame];
        
        [iconBtn addTarget:self action:@selector(iconClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:iconBtn];
        
        CGFloat nameX = CGRectGetMaxX(icon.frame) + 20;
        
        CGFloat nameY = iconY + 10;
        
        CGFloat nameW = _WindowViewWidth * 0.6 - nameX;
        
        CGFloat nameH = 25;
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        
        self.nameLab = name;
        
        name.font = [UIFont systemFontOfSize:18];
        
        name.textColor = [UIColor whiteColor];
        
        [self addSubview:name];
        
        CGFloat phoneX = nameX;
        
        CGFloat phoneY = CGRectGetMaxY(name.frame) + 10;
        
        CGFloat phoneW = nameW;
        
        CGFloat phoneH = 15;
        
        UILabel *phone = [[UILabel alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneW, phoneH)];
        
        self.phoneLab = phone;
        
        phone.textColor = [UIColor whiteColor];
        
        phone.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:phone];
        
        UILabel *balance = [[UILabel alloc] initWithFrame:CGRectMake(_WindowViewWidth * 0.65, nameY, _WindowViewWidth * 0.3, nameH)];
        
        self.balanceLab = balance;
        
        balance.textColor = [UIColor whiteColor];
        
        balance.font = [UIFont systemFontOfSize:16];
        
        balance.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:balance];
        
        UIButton *baBtn = [[UIButton alloc] initWithFrame:balance.frame];
        
        [baBtn addTarget:self action:@selector(balanceClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:baBtn];
        
        CGFloat bgx = iconX;
        
        CGFloat bgy = CGRectGetMaxY(icon.frame) + 20;
        
        CGFloat bgw = _WindowViewWidth - 2 * bgx;
        
        CGFloat bgH = 100;
        
        UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(bgx, bgy, bgw, bgH)];
        
        bgview.backgroundColor = [UIColor whiteColor];
        
        bgview.layer.masksToBounds = YES;
        
        bgview.layer.cornerRadius = 15;
        
        [self addSubview:bgview];
        
        CGFloat titleY = 25;
        
        CGFloat titleW = bgw * 0.25;
        
        CGFloat titleH = 25;
        
        UILabel *fsbCount = [[UILabel alloc] initWithFrame:CGRectMake(0, titleY, titleW, titleH)];
        
        fsbCount.textColor = [UIColor darkTextColor];
        
        fsbCount.font = [UIFont systemFontOfSize:17];
        
        fsbCount.textAlignment = NSTextAlignmentCenter;
        
        self.fsbCount = fsbCount;
        
        [bgview addSubview:fsbCount];
        
        UILabel *fsbtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fsbCount.frame) + 10, titleW, 15)];
        
        fsbtitle.textAlignment = NSTextAlignmentCenter;
        
        fsbtitle.font = [UIFont systemFontOfSize:14];
        
        fsbtitle.textColor = [UIColor darkTextColor];
        
        fsbtitle.text = @"粉丝宝";
        
        [bgview addSubview:fsbtitle];
        
        UIButton *fsbBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, titleY, titleW, 50)];
        
        [fsbBtn addTarget:self action:@selector(fsbClick) forControlEvents:UIControlEventTouchUpInside];
        
        [bgview addSubview:fsbBtn];
        
        UILabel *hhCount = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(fsbtitle.frame), titleY, titleW, titleH)];
        
        hhCount.textColor = [UIColor darkTextColor];
        
        hhCount.font = [UIFont systemFontOfSize:17];
        
        hhCount.textAlignment = NSTextAlignmentCenter;
        
        self.hhCount = hhCount;
        
        [bgview addSubview:hhCount];
        
        UILabel *hhtitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(fsbtitle.frame), CGRectGetMaxY(fsbCount.frame) + 10, titleW, 15)];
        
        hhtitle.textAlignment = NSTextAlignmentCenter;
        
        hhtitle.font = [UIFont systemFontOfSize:14];
        
        hhtitle.textColor = [UIColor darkTextColor];
        
        hhtitle.text = @"我的花花";
        
        [bgview addSubview:hhtitle];
        
        UIButton *hhBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(fsbtitle.frame), titleY, titleW, 50)];
        
        [hhBtn addTarget:self action:@selector(hhClick) forControlEvents:UIControlEventTouchUpInside];
        
        [bgview addSubview:hhBtn];
        
        UILabel *jljCount = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(hhtitle.frame), titleY, titleW, titleH)];
        
        jljCount.textColor = [UIColor darkTextColor];
        
        jljCount.font = [UIFont systemFontOfSize:17];
        
        jljCount.textAlignment = NSTextAlignmentCenter;
        
        self.jljCount = jljCount;
        
        [bgview addSubview:jljCount];
        
        UILabel *jljtitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(hhtitle.frame), CGRectGetMaxY(fsbCount.frame) + 10, titleW, 15)];
        
        jljtitle.textAlignment = NSTextAlignmentCenter;
        
        jljtitle.font = [UIFont systemFontOfSize:14];
        
        jljtitle.textColor = [UIColor darkTextColor];
        
        jljtitle.text = @"奖励金";
        
        [bgview addSubview:jljtitle];
        
        UIButton *jljBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(hhtitle.frame), titleY, titleW, 50)];
        
        [jljBtn addTarget:self action:@selector(jljClick) forControlEvents:UIControlEventTouchUpInside];
        
        [bgview addSubview:jljBtn];
        
        UILabel *jfCount = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(jljtitle.frame), titleY, titleW, titleH)];
        
        jfCount.textColor = [UIColor darkTextColor];
        
        jfCount.font = [UIFont systemFontOfSize:17];
        
        jfCount.textAlignment = NSTextAlignmentCenter;
        
        self.jfCount = jfCount;
        
        [bgview addSubview:jfCount];
        
        UILabel *jftitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(jljtitle.frame), CGRectGetMaxY(fsbCount.frame) + 10, titleW, 15)];
        
        jftitle.textAlignment = NSTextAlignmentCenter;
        
        jftitle.font = [UIFont systemFontOfSize:14];
        
        jftitle.textColor = [UIColor darkTextColor];
        
        jftitle.text = @"平台积分";
        
        [bgview addSubview:jftitle];
        
        UIButton *jfBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(jljtitle.frame), titleY, titleW, 50)];
        
        [jfBtn addTarget:self action:@selector(jfClick) forControlEvents:UIControlEventTouchUpInside];
        
        [bgview addSubview:jfBtn];
        
        self.height = CGRectGetMaxY(bgview.frame);
        
    }
    
    return self;
    
}

- (void)iconClick {
    
    if (self.iconBlock) {
        
        self.iconBlock();
        
    }
    
}

- (void)balanceClick {
    
    if (self.balanceBlock) {
        
        self.balanceBlock();
        
    }
    
}

- (void)fsbClick {
    
    if (self.fsbBlock) {
        
        self.fsbBlock();
        
    }
    
}

- (void)hhClick {
    
    if (self.hhBlock) {
        
        self.hhBlock();
        
    }
    
}

- (void)jljClick {
    
    if (self.jljBlock) {
        
        self.jljBlock();
        
    }
    
}

- (void)jfClick {
    
    if (self.jfBlock) {
        
        self.jfBlock();
        
    }
    
}

@end
