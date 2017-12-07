//
//  HuLaHomeCell.m
//  HuiHui
//
//  Created by mac on 2017/11/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HuLaHomeCell.h"
#import "HuLaHomeModel.h"
#import "HuLaHomeFrame.h"
#import "LJConst.h"
#import "RH_RadioView.h"

@interface HuLaHomeCell () 

@property (nonatomic, weak) UIImageView *logoImg;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *delegateLab;

@property (nonatomic, weak) UIButton *delegateBtn;

@property (nonatomic, weak) UILabel *roomcard_titleLab;

@property (nonatomic, weak) UILabel *money_titleLab;

@property (nonatomic, weak) UILabel *roomcardLab;

@property (nonatomic, weak) UILabel *moneyLab;

@property (nonatomic, weak) UILabel *recharge_titleLab;

@property (nonatomic, weak) UILabel *gameIDLab;

@property (nonatomic, weak) UIButton *bindBtn;

@property (nonatomic, weak) UILabel *bindLineLab;

@property (nonatomic, weak) UIButton *rechargeOtherBtn;

@property (nonatomic, weak) UIButton *rechargeBtn;

@property (nonatomic, weak) UIButton *sendBtn;

@property (nonatomic, weak) UIImageView *contentImg;

@property (nonatomic, weak) UILabel *sectionLineLab;

@end

@implementation HuLaHomeCell

+ (instancetype)HuLaHomeCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"HuLaHomeCell";
    
    HuLaHomeCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[HuLaHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *logo = [[UIImageView alloc] init];
        
        self.logoImg = logo;
        
        [self addSubview:logo];
        
        UILabel *title = [[UILabel alloc] init];
        
        self.titleLab = title;
        
        title.textColor = [UIColor darkTextColor];
        
        title.font = [UIFont systemFontOfSize:20];
        
        [self addSubview:title];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = [UIColor darkTextColor];
        
        name.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:name];
        
        UILabel *delegate = [[UILabel alloc] init];
        
        self.delegateLab = delegate;
        
        delegate.font = [UIFont systemFontOfSize:14];
        
        delegate.textColor = [UIColor orangeColor];
        
        [self addSubview:delegate];
        
        UIButton *delegateBtn = [[UIButton alloc] init];
        
        self.delegateBtn = delegateBtn;
        
        [self addSubview:delegateBtn];
        
        UILabel *r_title = [[UILabel alloc] init];
        
        self.roomcard_titleLab = r_title;
        
        r_title.textColor = [UIColor darkTextColor];
        
        r_title.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:r_title];
        
        UILabel *roomcard = [[UILabel alloc] init];
        
        self.roomcardLab = roomcard;
        
        roomcard.textColor = FSB_StyleCOLOR;
        
        roomcard.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:roomcard];
        
        UILabel *m_title = [[UILabel alloc] init];
        
        self.money_titleLab = m_title;
        
        m_title.textColor = [UIColor darkTextColor];
        
        m_title.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:m_title];
        
        UILabel *money = [[UILabel alloc] init];
        
        self.moneyLab = money;
        
        money.textColor = FSB_StyleCOLOR;
        
        money.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:money];
        
        UILabel *recharge_title = [[UILabel alloc] init];
        
        self.recharge_titleLab = recharge_title;
        
        recharge_title.textColor = [UIColor darkTextColor];
        
        recharge_title.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:recharge_title];
        
        UILabel *gameID = [[UILabel alloc] init];
        
        self.gameIDLab = gameID;
        
        gameID.font = [UIFont systemFontOfSize:16];
        
        gameID.textColor = FSB_StyleCOLOR;
        
        [self addSubview:gameID];
        
        UIButton *bind = [[UIButton alloc] init];
        
        self.bindBtn = bind;
        
        [bind setTitleColor:FSB_StyleCOLOR forState:0];
        
        bind.titleLabel.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:bind];
        
        UILabel *bindline = [[UILabel alloc] init];
        
        self.bindLineLab = bindline;
        
        bindline.backgroundColor = FSB_StyleCOLOR;
        
        [self addSubview:bindline];
        
        UIButton *otherBtn = [[UIButton alloc] init];
        
        self.rechargeOtherBtn = otherBtn;
        
        otherBtn.backgroundColor = FSB_StyleCOLOR;
        
        otherBtn.layer.masksToBounds = YES;
        
        otherBtn.layer.cornerRadius = 3;
        
        [otherBtn setTitleColor:[UIColor whiteColor] forState:0];
        
        otherBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:otherBtn];
        
        UIButton *recharge = [[UIButton alloc] init];
        
        self.rechargeBtn = recharge;
        
        recharge.backgroundColor = FSB_StyleCOLOR;
        
        recharge.layer.masksToBounds = YES;
        
        recharge.layer.cornerRadius = 3;
        
        recharge.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [recharge setTitleColor:[UIColor whiteColor] forState:0];
        
        [self addSubview:recharge];
        
        UIButton *send = [[UIButton alloc] init];
        
        self.sendBtn = send;
        
        send.backgroundColor = FSB_StyleCOLOR;
        
        send.layer.masksToBounds = YES;
        
        send.layer.cornerRadius = 3;
        
        send.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [send setTitleColor:[UIColor whiteColor] forState:0];
        
        [self addSubview:send];
        
        UIImageView *content = [[UIImageView alloc] init];
        
        self.contentImg = content;
        
        [self addSubview:content];
        
        UILabel *sectionline = [[UILabel alloc] init];
        
        self.sectionLineLab = sectionline;
        
        sectionline.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:sectionline];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(HuLaHomeFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.logoImg.frame = self.frameModel.logoF;
    
    self.titleLab.frame = self.frameModel.titleF;
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.delegateLab.frame = self.frameModel.delegateF;
    
    self.delegateBtn.frame = self.frameModel.delegateF;
    
    self.roomcard_titleLab.frame = self.frameModel.roomcard_titleF;
    
    self.roomcardLab.frame = self.frameModel.roomcardF;
    
    self.money_titleLab.frame = self.frameModel.money_titleF;
    
    self.moneyLab.frame = self.frameModel.moneyF;
    
    self.recharge_titleLab.frame = self.frameModel.gameID_titleF;
    
    self.gameIDLab.frame = self.frameModel.gameIDF;
    
    self.bindBtn.frame = self.frameModel.bindF;
    
    self.bindLineLab.frame = self.frameModel.bindLineF;

    self.rechargeOtherBtn.frame = self.frameModel.rechargeOtherF;
    
    self.rechargeBtn.frame = self.frameModel.rechargeF;
    
    self.sendBtn.frame = self.frameModel.sendF;
    
    self.contentImg.frame = self.frameModel.content_imgF;
    
    self.sectionLineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    HuLaHomeModel *model = self.frameModel.hulaModel;
    
    [self.logoImg setImageWithURL:[NSURL URLWithString:model.logo]];
    
    self.titleLab.text = model.title;
    
    self.nameLab.text = model.name;
    
    self.delegateLab.text = model.delegate;
    
    [self.delegateBtn addTarget:self action:@selector(delegateClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.roomcard_titleLab.text = @"房卡";
    
    self.money_titleLab.text = @"元宝";
    
    self.roomcardLab.text = model.RoomCard_Balance;
    
    self.moneyLab.text = model.Money_Balance;
    
    if (model.isBind) {
        
        self.recharge_titleLab.text = @"游戏ID:";
        
        self.gameIDLab.text = model.gameID;
        
    }else {
        
        [self.bindBtn setTitle:@"绑定游戏ID" forState:0];
        
        [self.bindBtn addTarget:self action:@selector(bindClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    [self.rechargeOtherBtn setTitle:@"给他人充值" forState:0];
    
    [self.rechargeOtherBtn addTarget:self action:@selector(ToOtherClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.rechargeBtn setTitle:@"充值" forState:0];
    
    [self.rechargeBtn addTarget:self action:@selector(ToMeClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.sendBtn setTitle:@"赠送" forState:0];
    
    [self.sendBtn addTarget:self action:@selector(SendClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentImg setImageWithURL:[NSURL URLWithString:model.Content_Img]];
    
}

- (void)delegateClick {
    
    if (self.delegate_Block) {
        
        self.delegate_Block();
        
    }
    
}

- (void)SendClick {

    if (self.Send_Block) {

        self.Send_Block();

    }

}

- (void)ToOtherClick {
    
    if (self.ToOther_Block) {
        
        self.ToOther_Block();
        
    }
    
}

- (void)ToMeClick {
    
    if (self.ToMe_Block) {
        
        self.ToMe_Block();
        
    }
    
}

- (void)bindClick {
    
    if (self.bindBlock) {
        
        self.bindBlock();
        
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
