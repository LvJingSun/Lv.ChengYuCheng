//
//  FSB_GameHeadView.m
//  HuiHui
//
//  Created by mac on 2017/5/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_GameHeadView.h"
#import "LJConst.h"
#import "FSB_ScrollView.h"

@implementation FSB_GameHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewWidth * 0.33)];
        
        imageview.image = [UIImage imageNamed:@"head.png"];
        
        [self addSubview:imageview];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(_WindowViewWidth * 0.5 - 35, CGRectGetMaxY(imageview.frame) - 30, 70, 70)];
        
        self.iconImageview = icon;
        
        icon.layer.masksToBounds = YES;
        
        icon.layer.cornerRadius = 35;
        
        [self addSubview:icon];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(_WindowViewWidth * 0.05, CGRectGetMaxY(icon.frame) + 10, _WindowViewWidth * 0.9, 30)];
        
        self.nameLab = name;
        
        name.textColor = FSB_GamePersonCOLOR;
        
        name.font = FSB_GamePersonFont;
        
        name.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:name];
        
        UILabel *yue = [[UILabel alloc] initWithFrame:CGRectMake(_WindowViewWidth * 0.05, CGRectGetMaxY(name.frame) + 10, _WindowViewWidth * 0.45, 20)];
        
        self.zhanghuLab = yue;
        
        yue.textColor = FSB_GameYuECOLOR;
        
        yue.font = FSB_GameYuEFont;
        
        yue.textAlignment = NSTextAlignmentRight;
        
        yue.text = @"账户余额";
        
        [self addSubview:yue];
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(_WindowViewWidth * 0.5 + 10, CGRectGetMaxY(name.frame) + 10, _WindowViewWidth * 0.45, 20)];
        
        self.countLab = count;
        
        count.textColor = FSB_GameCOuntCOLOR;
        
        count.font = FSB_GameCountFont;
        
        count.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:count];
        
        UIButton *recharge = [[UIButton alloc] initWithFrame:CGRectMake(_WindowViewWidth * 0.5 - 25, CGRectGetMaxY(count.frame) + 5, 50, 25)];
        
        [recharge setTitle:@"充值" forState:0];
        
        [recharge setTitleColor:FSB_StyleCOLOR forState:0];
        
        recharge.titleLabel.font = [UIFont systemFontOfSize:15];
        
        recharge.layer.masksToBounds = YES;
        
        recharge.layer.cornerRadius = 4;
        
        recharge.layer.borderWidth = 1;
        
        recharge.layer.borderColor = FSB_StyleCOLOR.CGColor;
        
        [recharge addTarget:self action:@selector(rechargeClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:recharge];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(recharge.frame) + 10, _WindowViewWidth, 15)];
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line];
        
        self.height = CGRectGetMaxY(line.frame);
        
    }
    
    return self;
    
}

- (void)rechargeClick {
    
    if (self.rechargeBlock) {
        
        self.rechargeBlock();
        
    }
    
}

@end
