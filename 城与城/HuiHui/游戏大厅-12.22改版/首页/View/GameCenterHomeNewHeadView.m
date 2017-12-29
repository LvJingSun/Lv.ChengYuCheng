//
//  GameCenterHomeNewHeadView.m
//  HuiHui
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameCenterHomeNewHeadView.h"
#import "GameCenterRechargeBtnView.h"
#import "GameCenterMyBtnView.h"
#import "LJConst.h"

#define CountFont [UIFont systemFontOfSize:45]
#define MingChengFont [UIFont systemFontOfSize:14]
#define TextColor [UIColor colorWithRed:224/255. green:182/255. blue:115/255. alpha:1.]

@interface GameCenterHomeNewHeadView ()

@property (nonatomic, weak) UIImageView *bgImg;

@property (nonatomic, weak) UIView *maskView;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *mingchengLab;

@property (nonatomic, weak) GameCenterRechargeBtnView *recordView;

@property (nonatomic, weak) GameCenterRechargeBtnView *rechargeView;

@property (nonatomic, weak) UILabel *lineLab;

@property (nonatomic, weak) UILabel *line2Lab;

@property (nonatomic, weak) GameCenterMyBtnView *infoView;

@property (nonatomic, weak) GameCenterMyBtnView *teamView;

@property (nonatomic, weak) GameCenterMyBtnView *invitationView;

@property (nonatomic, weak) GameCenterMyBtnView *commissionView;

@end

@implementation GameCenterHomeNewHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *bgImg = [[UIImageView alloc] init];
        
        self.bgImg = bgImg;
        
        [self addSubview:bgImg];
        
        UIView *maskView = [[UIView alloc] init];
        
        self.maskView = maskView;
        
        maskView.layer.masksToBounds = YES;
        
        maskView.layer.cornerRadius = 5;
        
        [self addSubview:maskView];
        
        UILabel *title = [[UILabel alloc] init];
        
        title.textColor = TextColor;
        
        title.font = [UIFont systemFontOfSize:15];
        
        self.titleLab = title;
        
        [maskView addSubview:title];
        
        UILabel *countLab = [[UILabel alloc] init];
        
        self.countLab = countLab;
        
        countLab.textColor = TextColor;
        
        countLab.font = CountFont;
        
        [maskView addSubview:countLab];
        
        UILabel *mingchengLab = [[UILabel alloc] init];
        
        self.mingchengLab = mingchengLab;
        
        mingchengLab.textColor = TextColor;
        
        mingchengLab.font = MingChengFont;
        
        [maskView addSubview:mingchengLab];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:line];
        
        UILabel *line2 = [[UILabel alloc] init];
        
        self.line2Lab = line2;
        
        line2.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line2];
        
    }
    
    return self;
    
}

-(void)setCount:(NSString *)count {
    
    _count = count;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    CGFloat bgX = 0;
    
    CGFloat bgY = 0;
    
    CGFloat bgW = _WindowViewWidth;
    
    CGFloat bgH = bgW * 0.4861;
    
    self.bgImg.frame = CGRectMake(bgX, bgY, bgW, bgH);
    
    CGFloat maskX = _WindowViewWidth * 0.05;
    
    CGFloat maskY = 20;
    
    CGFloat maskW = _WindowViewWidth - 2 * maskX;
    
    CGFloat maskH = CGRectGetMaxY(self.bgImg.frame) - 70;
    
    self.maskView.frame = CGRectMake(maskX, maskY, maskW, maskH);
    
    CGSize countSize = [self sizeWithText:self.count font:CountFont maxSize:CGSizeMake(0, 0)];
    
    CGFloat margin = 10;
    
    CGFloat countW = countSize.width;
    
    CGFloat countH = countSize.height;
    
    CGFloat titleX = maskW * 0.05;
    
    CGFloat titleH = 15;

    CGFloat titleY = (maskH - titleH - countH - margin) * 0.5;

    CGFloat titleW = maskW - 2 * titleX;

    self.titleLab.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat countX = titleX;
    
    CGFloat countY = CGRectGetMaxY(self.titleLab.frame) + margin;
    
    self.countLab.frame = CGRectMake(countX, countY, countW, countH);
    
    CGSize mingchengSize = [self sizeWithText:@"游戏币" font:MingChengFont maxSize:CGSizeMake(0, 0)];
    
    CGFloat mingchengX = CGRectGetMaxX(self.countLab.frame) + 15;
    
    CGFloat mingchengH = mingchengSize.height;
    
    CGFloat mingchengY = countY + (countH - mingchengH) * 0.7;
    
    CGFloat mingchengW = mingchengSize.width;
    
    self.mingchengLab.frame = CGRectMake(mingchengX, mingchengY, mingchengW, mingchengH);
    
    CGFloat recordX = 0;
    
    CGFloat recordY = CGRectGetMaxY(self.maskView.frame) + 10;
    
    CGFloat recordW = _WindowViewWidth * 0.5 - 1;
    
    CGFloat recordH = 30;
    
    GameCenterRechargeBtnView *record = [[GameCenterRechargeBtnView alloc] initWithFrame:CGRectMake(recordX, recordY, recordW, recordH)];
    
    self.recordView = record;
    
    [self addSubview:record];
    
    CGFloat lineX = CGRectGetMaxX(self.recordView.frame);
    
    CGFloat lineH = recordH;
    
    CGFloat lineW = 2;
    
    CGFloat lineY = recordY;
    
    self.lineLab.frame = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat rechargeX = CGRectGetMaxX(self.lineLab.frame);
    
    CGFloat rechargeY = recordY;
    
    CGFloat rechargeW = recordW;
    
    CGFloat rechargeH = recordH;
    
    GameCenterRechargeBtnView *recharge = [[GameCenterRechargeBtnView alloc] initWithFrame:CGRectMake(rechargeX, rechargeY, rechargeW, rechargeH)];
    
    self.rechargeView = recharge;
    
    [self addSubview:recharge];
    
    CGFloat line2X = 0;
    
    CGFloat line2Y = CGRectGetMaxY(self.bgImg.frame);
    
    CGFloat line2W = _WindowViewWidth;
    
    CGFloat line2H = SectionHeight;
    
    self.line2Lab.frame = CGRectMake(line2X, line2Y, line2W, line2H);
    
    CGFloat myviewW = _WindowViewWidth * 0.25;
    
    CGFloat myviewH = 105;
    
    CGFloat infoX = 0;
    
    CGFloat myviewY = CGRectGetMaxY(self.line2Lab.frame);
    
    GameCenterMyBtnView *infoview = [[GameCenterMyBtnView alloc] initWithFrame:CGRectMake(infoX, myviewY, myviewW, myviewH)];
    
    self.infoView = infoview;
    
    [self addSubview:infoview];
    
    CGFloat teamX = CGRectGetMaxX(infoview.frame);
    
    GameCenterMyBtnView *teamview = [[GameCenterMyBtnView alloc] initWithFrame:CGRectMake(teamX, myviewY, myviewW, myviewH)];
    
    self.teamView = teamview;
    
    [self addSubview:teamview];
    
    CGFloat invitationX = CGRectGetMaxX(teamview.frame);
    
    GameCenterMyBtnView *invitationview = [[GameCenterMyBtnView alloc] initWithFrame:CGRectMake(invitationX, myviewY, myviewW, myviewH)];
    
    self.invitationView = invitationview;
    
    [self addSubview:invitationview];
    
    CGFloat commissionX = CGRectGetMaxX(invitationview.frame);
    
    GameCenterMyBtnView *commissionview = [[GameCenterMyBtnView alloc] initWithFrame:CGRectMake(commissionX, myviewY, myviewW, myviewH)];
    
    self.commissionView = commissionview;
    
    [self addSubview:commissionview];
    
    self.height = CGRectGetMaxY(self.infoView.frame);
    
}

- (void)setContent {
    
    self.bgImg.image = [UIImage imageNamed:@"GC_Home_top_bg.png"];
    
    self.maskView.backgroundColor = [UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:0.2];
    
    self.titleLab.text = @"账户余额";
    
    self.countLab.text = self.count;
    
    self.mingchengLab.text = @"游戏币";
    
    self.recordView.iconImg.image = [UIImage imageNamed:@"GC_RechargeIcon.png"];
    
    self.recordView.titleLab.text = @"记录";
    
    [self.recordView.clickBtn addTarget:self action:@selector(recordClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.rechargeView.iconImg.image = [UIImage imageNamed:@"GC_RechargeIcon.png"];
    
    self.rechargeView.titleLab.text = @"充值";
    
    [self.rechargeView.clickBtn addTarget:self action:@selector(rechargeClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.infoView.iconImg.image = [UIImage imageNamed:@"GC_MyInfo.png"];
    
    self.infoView.titleLab.text = @"我的资料";
    
    [self.infoView.clickBtn addTarget:self action:@selector(infoClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.teamView.iconImg.image = [UIImage imageNamed:@"GC_MyTeam.png"];
    
    self.teamView.titleLab.text = @"我的团队";
    
    [self.teamView.clickBtn addTarget:self action:@selector(teamClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.invitationView.iconImg.image = [UIImage imageNamed:@"GC_MyInvitation.png"];
    
    self.invitationView.titleLab.text = @"我的邀请";
    
    [self.invitationView.clickBtn addTarget:self action:@selector(invitationClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.commissionView.iconImg.image = [UIImage imageNamed:@"GC_MyCommission.png"];
    
    self.commissionView.titleLab.text = @"我的佣金";
    
    [self.commissionView.clickBtn addTarget:self action:@selector(commissionClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)recordClick {
    
    if (self.RecordBlock) {
        
        self.RecordBlock();
        
    }
    
}

- (void)rechargeClick {
    
    if (self.RechargeBlock) {
        
        self.RechargeBlock();
        
    }
    
}

- (void)infoClick {
    
    if (self.MyInfoBlock) {
        
        self.MyInfoBlock();
        
    }
    
}

- (void)teamClick {
    
    if (self.MyTeamBlock) {
        
        self.MyTeamBlock();
        
    }
    
}

- (void)invitationClick {
    
    if (self.MyInvitationBlock) {
        
        self.MyInvitationBlock();
        
    }
    
}

- (void)commissionClick {
    
    if (self.MyCommissionBlock) {
        
        self.MyCommissionBlock();
        
    }
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
