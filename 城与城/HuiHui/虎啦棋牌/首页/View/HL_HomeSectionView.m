//
//  HL_HomeSectionView.m
//  HuiHui
//
//  Created by mac on 2017/11/6.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_HomeSectionView.h"
#import "LJConst.h"

@implementation HL_HomeSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat width = _WindowViewWidth * 0.25;
        
        CGFloat height = 40;
        
        UIButton *becomeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        
        self.becomeDelegateBtn = becomeBtn;
        
        [becomeBtn setTitle:@"成为代理" forState:0];
        
        [becomeBtn addTarget:self action:@selector(becomeClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:becomeBtn];
        
        UILabel *becomeLine = [[UILabel alloc] initWithFrame:CGRectMake(0, height, width, 2)];
        
        self.becomeDelegateLine = becomeLine;
        
        becomeLine.backgroundColor = FSB_StyleCOLOR;
        
        [self addSubview:becomeLine];
        
        self.height = CGRectGetMaxY(becomeLine.frame);
        
        UIButton *tuijianBtn = [[UIButton alloc] initWithFrame:CGRectMake(width, 0, width, height)];
        
        self.tuijianDelegateBtn = tuijianBtn;
        
        [tuijianBtn setTitle:@"推荐代理" forState:0];
        
        [tuijianBtn addTarget:self action:@selector(tuijianClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:tuijianBtn];
        
        UILabel *tuijianLine = [[UILabel alloc] initWithFrame:CGRectMake(width, height, width, 2)];
        
        self.tuijianDelegateLine = tuijianLine;
        
        tuijianLine.backgroundColor = FSB_StyleCOLOR;
        
        [self addSubview:tuijianLine];
        
        UIButton *myteamBtn = [[UIButton alloc] initWithFrame:CGRectMake(width * 2, 0, width, height)];
        
        self.myTeamBtn = myteamBtn;
        
        [myteamBtn setTitle:@"我的团队" forState:0];
        
        [myteamBtn addTarget:self action:@selector(myTeamClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:myteamBtn];
        
        UILabel *myteamLine = [[UILabel alloc] initWithFrame:CGRectMake(width * 2, height, width, 2)];
        
        self.myTeamLine = myteamLine;
        
        myteamLine.backgroundColor = FSB_StyleCOLOR;
        
        [self addSubview:myteamLine];
        
        UIButton *mymoneyBtn = [[UIButton alloc] initWithFrame:CGRectMake(width * 3, 0, width, height)];
        
        self.myMoneyBtn = mymoneyBtn;
        
        [mymoneyBtn setTitle:@"我的佣金" forState:0];
        
        [mymoneyBtn addTarget:self action:@selector(myMoneyClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:mymoneyBtn];
        
        UILabel *mymoneyLine = [[UILabel alloc] initWithFrame:CGRectMake(width * 3, height, width, 2)];
        
        self.myMoneyBLine = mymoneyLine;
        
        mymoneyLine.backgroundColor = FSB_StyleCOLOR;
        
        [self addSubview:mymoneyLine];
        
    }
    
    return self;
    
}

- (void)becomeClick {
    
    if (self.becomeDelegateBlock) {
        
        self.becomeDelegateBlock();
        
    }
    
}

- (void)tuijianClick {
    
    if (self.tuijianDelegateBlock) {
        
        self.tuijianDelegateBlock();
        
    }
    
}

- (void)myTeamClick {
    
    if (self.myTeamBlock) {
        
        self.myTeamBlock();
        
    }
    
}

- (void)myMoneyClick {
    
    if (self.myMoneyBlock) {
        
        self.myMoneyBlock();
        
    }
    
}

@end
