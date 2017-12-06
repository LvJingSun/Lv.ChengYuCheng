//
//  FSB_AllWealthHeadView.m
//  HuiHui
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_AllWealthHeadView.h"
#import "LJConst.h"

@interface FSB_AllWealthHeadView ()

@property (nonatomic, weak) UIButton *YesterdayProfitButton;

@property (nonatomic, weak) UILabel *YesterdayProfitTitleLabel;

@property (nonatomic, weak) UIButton *AllQuotaButton;

@property (nonatomic, weak) UIView *BGView;

@property (nonatomic, weak) UILabel *CumulativeProfitTitleLabel;

@property (nonatomic, weak) UIButton *CumulativeProfitButton;

@property (nonatomic, weak) UILabel *CumulativeConsumptionTitleLabel;

@property (nonatomic, weak) UIButton *CumulativeConsumptionButton;

@property (nonatomic, weak) UILabel *GroupLineLabel;

@end

@implementation FSB_AllWealthHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat zuoriX = _WindowViewWidth * 0.05;
        
        CGFloat zuoriY = 15;
        
        CGFloat zuoriW = _WindowViewWidth * 0.9;
        
        CGFloat zuoriH = 50;
        
        UILabel *ypl = [[UILabel alloc] initWithFrame:CGRectMake(zuoriX, zuoriY, zuoriW, zuoriH)];
        
        self.YesterdayProfitLabel = ypl;
        
        ypl.textAlignment = NSTextAlignmentCenter;
        
        ypl.font = FSB_YesterdayProfitFont;
        
        ypl.textColor = FSB_YesterdayProfitColor;
        
        CGFloat zuoritX = zuoriX;
        
        CGFloat zuoritY = CGRectGetMaxY(ypl.frame) + 10;
        
        CGFloat zuoritW = zuoriW;
        
        CGFloat zuoritH = 10;
        
        UILabel *ypt = [[UILabel alloc] initWithFrame:CGRectMake(zuoritX, zuoritY, zuoritW, zuoritH)];
        
        self.YesterdayProfitTitleLabel = ypt;
        
        ypt.textAlignment = NSTextAlignmentCenter;
        
        ypt.font = FSB_YesterdayProfitTitleFont;
        
        ypt.textColor = FSB_YesterdayProfitColor;
        
        ypt.text = @"今日红包(元)";
        
        CGFloat z_buttonX = _WindowViewWidth * 0.2;
        
        CGFloat z_buttonY = zuoriY - 10;
        
        CGFloat z_buttonW = _WindowViewWidth * 0.6;
        
        CGFloat z_buttonH = zuoritY - z_buttonY;
        
        UIButton *ypb = [[UIButton alloc] initWithFrame:CGRectMake(z_buttonX, z_buttonY, z_buttonW, z_buttonH)];
        
        self.YesterdayProfitButton = ypb;
        
        [ypb addTarget:self action:@selector(ZuoRiShouYiClicked) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat allH = 30;
        
        CGFloat allX = _WindowViewWidth * 0.05;
        
        CGFloat allY = CGRectGetMaxY(ypt.frame) + 20;
        
        CGFloat allW = _WindowViewWidth * 0.9;
        
        UILabel *aql = [[UILabel alloc] initWithFrame:CGRectMake(allX, allY, allW, allH)];
        
        self.AllQuotaLabel = aql;
        
        aql.textAlignment = NSTextAlignmentCenter;
        
        aql.font = FSB_AllQuotaFont;
        
        aql.textColor = FSB_YesterdayProfitColor;
        
        CGFloat allBH = 30;
        
        CGFloat allBX = _WindowViewWidth * 0.2;
        
        CGFloat allBY = CGRectGetMaxY(ypt.frame) + 20;
        
        CGFloat allBW = _WindowViewWidth * 0.6;
        
        UIButton *aqb = [[UIButton alloc] initWithFrame:CGRectMake(allBX, allBY, allBW, allBH)];
        
        self.AllQuotaButton = aqb;
        
        [aqb addTarget:self action:@selector(zongeduClicked) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat bgX = 0;
        
        CGFloat bgY = 0;
        
        CGFloat bgW = _WindowViewWidth;
        
        CGFloat bgH = CGRectGetMaxY(aql.frame) + 10;
        
        UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(bgX, bgY, bgW, bgH)];
        
        self.BGView = bgview;
        
        bgview.backgroundColor = FSB_StyleCOLOR;
        
        [self addSubview:bgview];

        [self addSubview:ypl];
 
        [self addSubview:ypt];
    
        [self addSubview:ypb];

        [self addSubview:aql];

        [self addSubview:aqb];
        
        CGFloat shouyiX = _WindowViewWidth * 0.05;
        
        CGFloat shouyiY = CGRectGetMaxY(bgview.frame) + 10;
        
        CGFloat shouyiW = _WindowViewWidth * 0.4;
        
        CGFloat shouyiH = 25;
        
        UILabel *cpl = [[UILabel alloc] initWithFrame:CGRectMake(shouyiX, shouyiY, shouyiW, shouyiH)];
        
        self.CumulativeProfitLabel = cpl;
        
        cpl.textAlignment = NSTextAlignmentCenter;
        
        cpl.font = FSB_CumulativeProfitFont;
        
        cpl.textColor = FSB_StyleCOLOR;
        
        [self addSubview:cpl];
        
        CGFloat s_titleX = shouyiX;
        
        CGFloat s_titleY = CGRectGetMaxY(cpl.frame) + 5;
        
        CGFloat s_titleW = shouyiW;
        
        CGFloat s_titleH = 20;
        
        UILabel *cpt = [[UILabel alloc] initWithFrame:CGRectMake(s_titleX, s_titleY, s_titleW, s_titleH)];
        
        self.CumulativeProfitTitleLabel = cpt;
        
        cpt.textAlignment = NSTextAlignmentCenter;
        
        cpt.font = FSB_CumulativeProfitTextFont;
        
        cpt.textColor = FSB_CumulativeProfitTitleCOLOR;
        
        cpt.text = @"累计收益";
        
        [self addSubview:cpt];
        
        CGFloat lineX = 0;
        
        CGFloat lineY = CGRectGetMaxY(cpt.frame) + 10;
        
        CGFloat lineW = _WindowViewWidth;
        
        CGFloat lineH = 20;
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
        
        self.GroupLineLabel = line;
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line];
        
        self.height = CGRectGetMaxY(line.frame);
        
        CGFloat s_buttonX = _WindowViewWidth * 0.05;
        
        CGFloat s_buttonY = CGRectGetMaxY(bgview.frame);
        
        CGFloat s_buttonW = shouyiW;
        
        CGFloat s_buttonH = self.height - s_buttonY;
        
        UIButton *cpb = [[UIButton alloc] initWithFrame:CGRectMake(s_buttonX, s_buttonY, s_buttonW, s_buttonH)];
        
        self.CumulativeProfitButton = cpb;
        
        [cpb addTarget:self action:@selector(LeiJiShouYiClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:cpb];
        
        CGFloat xiaofeiX = _WindowViewWidth * 0.55;
        
        CGFloat xiaofeiY = shouyiY;
        
        CGFloat xiaofeiW = shouyiW;
        
        CGFloat xiaofeiH = shouyiH;
        
        UILabel *ccl = [[UILabel alloc] initWithFrame:CGRectMake(xiaofeiX, xiaofeiY, xiaofeiW, xiaofeiH)];
        
        self.CumulativeConsumptionLabel = ccl;
        
        ccl.textAlignment = NSTextAlignmentCenter;
        
        ccl.font = FSB_CumulativeProfitFont;
        
        ccl.textColor = FSB_StyleCOLOR;
        
        [self addSubview:ccl];
        
        CGFloat x_titleX = xiaofeiX;
        
        CGFloat x_titleY = s_titleY;
        
        CGFloat x_titleW = s_titleW;
        
        CGFloat x_titleH = s_titleH;
        
        UILabel *cct = [[UILabel alloc] initWithFrame:CGRectMake(x_titleX, x_titleY, x_titleW, x_titleH)];
        
        self.CumulativeConsumptionTitleLabel = cct;
        
        cct.textAlignment = NSTextAlignmentCenter;
        
        cct.font = FSB_CumulativeProfitTextFont;
        
        cct.textColor = FSB_CumulativeProfitTitleCOLOR;
        
        cct.text = @"商家优惠";
        
        [self addSubview:cct];
        
        CGFloat x_buttonX = xiaofeiX;
        
        CGFloat x_buttonY = s_buttonY;
        
        CGFloat x_buttonW = s_buttonW;
        
        CGFloat x_buttonH = s_buttonH;
        
        UIButton *ccb = [[UIButton alloc] initWithFrame:CGRectMake(x_buttonX, x_buttonY, x_buttonW, x_buttonH)];
        
        self.CumulativeConsumptionButton = ccb;
        
        [ccb addTarget:self action:@selector(LeiJiXiaoFeiClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:ccb];
        
    }
    
    return self;
    
}

//昨日收益点击
- (void)ZuoRiShouYiClicked {
    
    if ([self.delegate respondsToSelector:@selector(YesterdayProfitButtonClicked)]) {
        
        [self.delegate YesterdayProfitButtonClicked];
        
    }
    
}

//总额度点击
- (void)zongeduClicked {
    
    if ([self.delegate respondsToSelector:@selector(AllQuotaButtonClicked)]) {
        
        [self.delegate AllQuotaButtonClicked];
        
    }
    
}

//累计收益点击
- (void)LeiJiShouYiClicked {
    
    if ([self.delegate respondsToSelector:@selector(CumulativeProfitButtonClicked)]) {
        
        [self.delegate CumulativeProfitButtonClicked];
        
    }
    
}

//累计消费点击
- (void)LeiJiXiaoFeiClicked {
    
    if ([self.delegate respondsToSelector:@selector(CumulativeConsumptionButtonClicked)]) {
        
        [self.delegate CumulativeConsumptionButtonClicked];
        
    }
    
}

@end
