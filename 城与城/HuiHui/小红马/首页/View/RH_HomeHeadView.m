//
//  RH_HomeHeadView.m
//  HuiHui
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_HomeHeadView.h"
#import "RedHorseHeader.h"
#import "RH_HomeBtnView.h"

@implementation RH_HomeHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *phone = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.05, 10, ScreenWidth * 0.45, 15)];
        
        self.phoneLab = phone;
        
        phone.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:phone];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.05, CGRectGetMaxY(phone.frame) + 10, 70, 70)];
        
        self.redHorseImg = icon;
        
        [self addSubview:icon];
        
        UILabel *descTitle = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.4, CGRectGetMaxY(phone.frame) + 10, ScreenWidth * 0.4, 20)];
        
        self.descTitleLab = descTitle;
        
        descTitle.font = [UIFont systemFontOfSize:13];
        
        descTitle.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:descTitle];
        
        UILabel *descContent = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.4, CGRectGetMaxY(descTitle.frame) + 5, ScreenWidth * 0.4, CGRectGetMaxY(icon.frame) - CGRectGetMaxY(descTitle.frame) - 5)];
        
        self.descContentLab = descContent;
        
        descContent.numberOfLines = 0;
        
        descContent.font = [UIFont systemFontOfSize:11];
        
        [self addSubview:descContent];
        
        UILabel *rhTitle = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.05, CGRectGetMaxY(icon.frame) + 10, ScreenWidth * 0.5, 15)];
        
        self.redHorseTitleLab = rhTitle;
        
        rhTitle.textColor = RH_NAVTextColor;
        
        rhTitle.font = [UIFont systemFontOfSize:11];
        
        [self addSubview:rhTitle];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth * 0.95 - 40, CGRectGetMaxY(descTitle.frame) + 10, 40, 20)];
        
        self.detailBtn = btn;
        
        [btn setTitle:@"详情" forState:0];
        
        [btn setTitleColor:RH_NAVTextColor forState:0];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:11];
        
        btn.layer.masksToBounds = YES;
        
        btn.layer.borderColor = RH_NAVTextColor.CGColor;
        
        btn.layer.borderWidth = 1;
        
        btn.layer.cornerRadius = 5;
        
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(rhTitle.frame) + 10, ScreenWidth, 15)];
        
        line.backgroundColor = RH_ViewBGColor;
        
        [self addSubview:line];
        
        CGFloat viewW = ScreenWidth * 0.33333;
        
        CGFloat viewH = 99;
        
        RH_HomeBtnView *youfei = [[RH_HomeBtnView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), viewW, viewH)];
        
        self.youfeiView = youfei;
        
        [self addSubview:youfei];
        
        RH_HomeBtnView *luntai = [[RH_HomeBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(youfei.frame), CGRectGetMaxY(line.frame), viewW, viewH)];
        
        self.luntaiView = luntai;
        
        [self addSubview:luntai];
        
        RH_HomeBtnView *baoyang = [[RH_HomeBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(luntai.frame), CGRectGetMaxY(line.frame), viewW, viewH)];
        
        self.baoyangView = baoyang;
        
        [self addSubview:baoyang];
        
        RH_HomeBtnView *xiuli = [[RH_HomeBtnView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(youfei.frame), viewW, viewH)];
        
        self.xiuliView = xiuli;
        
        [self addSubview:xiuli];
        
        RH_HomeBtnView *baoxian = [[RH_HomeBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(youfei.frame), CGRectGetMaxY(luntai.frame), viewW, viewH)];
        
        self.baoxianView = baoxian;
        
        [self addSubview:baoxian];
    
        RH_HomeBtnView *shenghuo = [[RH_HomeBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(luntai.frame), CGRectGetMaxY(baoyang.frame), viewW, viewH)];
        
        self.shenghuoView = shenghuo;
        
        [self addSubview:shenghuo];
        
        UILabel *bottom = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(shenghuo.frame) + 10, ScreenWidth, 15)];
        
        bottom.backgroundColor = RH_ViewBGColor;
        
        [self addSubview:bottom];
        
        self.height = CGRectGetMaxY(bottom.frame);
        
    }
    
    return self;
    
}

- (void)btnClick {

    if (self.detailBlock) {
        
        self.detailBlock();
        
    }
    
}

@end
