//
//  HL_RechargeOrderCell.m
//  HuiHui
//
//  Created by mac on 2017/12/20.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_RechargeOrderCell.h"
#import "HL_RechargeOrderModel.h"
#import "HL_RechargeOrderFrame.h"
#import "LJConst.h"
#import "HL_PayTypeView.h"

@interface HL_RechargeOrderCell ()

@property (nonatomic, weak) UIView *orderbgView;

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) UILabel *orderidtitleLab;

@property (nonatomic, weak) UILabel *orderidLab;

@property (nonatomic, weak) UILabel *lineLab;

@property (nonatomic, weak) UILabel *gameIDtitleLab;

@property (nonatomic, weak) UILabel *gameIDLab;

@property (nonatomic, weak) UILabel *gameNicktitleLab;

@property (nonatomic, weak) UILabel *gameNickLab;

@property (nonatomic, weak) UILabel *ordertitleLab;

@property (nonatomic, weak) UILabel *originaltitleLab;

@property (nonatomic, weak) UILabel *originalLab;

@property (nonatomic, weak) UILabel *originalLineLab;

@property (nonatomic, weak) UILabel *delegatetitleLab;

@property (nonatomic, weak) UILabel *delegateLab;

@property (nonatomic, weak) UILabel *counttitleLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *totaltitleLab;

@property (nonatomic, weak) UILabel *totalLab;

@property (nonatomic, weak) UILabel *payTitleLab;

@property (nonatomic, weak) HL_PayTypeView *ZFB_View;

@property (nonatomic, weak) UIButton *zfbBtn;

@property (nonatomic, weak) HL_PayTypeView *WX_View;

@property (nonatomic, weak) UIButton *wxBtn;

@property (nonatomic, weak) HL_PayTypeView *CYC_View;

@property (nonatomic, weak) UIButton *cycBtn;

@property (nonatomic, weak) HL_PayTypeView *FSB_View;

@property (nonatomic, weak) UIButton *fsbBtn;

@end

@implementation HL_RechargeOrderCell

+ (instancetype)HL_RechargeOrderCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"HL_RechargeOrderCell";
    
    HL_RechargeOrderCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[HL_RechargeOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = FSB_ViewBGCOLOR;
        
        UIView *orderbg = [[UIView alloc] init];
        
        self.orderbgView = orderbg;
        
        orderbg.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:orderbg];
        
        UIView *bg = [[UIView alloc] init];
        
        self.bgView = bg;
        
        bg.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:bg];
        
        UILabel *orderidtitle = [[UILabel alloc] init];
        
        self.orderidtitleLab = orderidtitle;
        
        orderidtitle.textColor = [UIColor darkTextColor];
        
        orderidtitle.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:orderidtitle];
        
        UILabel *orderid = [[UILabel alloc] init];
        
        self.orderidLab = orderid;
        
        orderid.textColor = [UIColor darkGrayColor];
        
        orderid.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:orderid];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line];
        
        UILabel *gameIDtitle = [[UILabel alloc] init];
        
        self.gameIDtitleLab = gameIDtitle;
    
        gameIDtitle.textColor = [UIColor darkTextColor];
        
        gameIDtitle.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:gameIDtitle];
        
        UILabel *gameID = [[UILabel alloc] init];
        
        self.gameIDLab = gameID;
        
        gameID.textColor = [UIColor darkGrayColor];
        
        gameID.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:gameID];
        
        UILabel *gameNicktitle = [[UILabel alloc] init];
        
        self.gameNicktitleLab = gameNicktitle;
        
        gameNicktitle.textColor = [UIColor darkTextColor];
        
        gameNicktitle.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:gameNicktitle];
        
        UILabel *gamenick = [[UILabel alloc] init];
        
        self.gameNickLab = gamenick;
        
        gamenick.textColor = [UIColor darkGrayColor];
        
        gamenick.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:gamenick];
        
        UILabel *ordertitle = [[UILabel alloc] init];
        
        self.ordertitleLab = ordertitle;
        
        ordertitle.textColor = [UIColor darkTextColor];
        
        ordertitle.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:ordertitle];
        
        UILabel *originaltitle = [[UILabel alloc] init];
        
        self.originaltitleLab = originaltitle;
        
        originaltitle.textColor = [UIColor darkTextColor];
        
        originaltitle.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:originaltitle];
        
        UILabel *original = [[UILabel alloc] init];
        
        self.originalLab = original;
        
        original.textColor = [UIColor darkGrayColor];
        
        original.textAlignment = NSTextAlignmentRight;
        
        original.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:original];
        
        UILabel *originalline = [[UILabel alloc] init];
        
        self.originalLineLab = originalline;
        
        originalline.backgroundColor = [UIColor darkGrayColor];
        
        [self addSubview:originalline];
        
        UILabel *presenttitle = [[UILabel alloc] init];
        
        self.delegatetitleLab = presenttitle;
        
        presenttitle.textColor = [UIColor darkTextColor];
        
        presenttitle.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:presenttitle];
        
        UILabel *present = [[UILabel alloc] init];
        
        self.delegateLab = present;
        
        present.textColor = [UIColor redColor];
        
        present.textAlignment = NSTextAlignmentRight;
        
        present.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:present];
        
        UILabel *counttitle = [[UILabel alloc] init];
        
        self.counttitleLab = counttitle;
        
        counttitle.textColor = [UIColor darkTextColor];
        
        counttitle.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:counttitle];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.textColor = [UIColor darkGrayColor];
        
        count.textAlignment = NSTextAlignmentRight;
        
        count.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:count];
        
        UILabel *totaltitle = [[UILabel alloc] init];
        
        self.totaltitleLab = totaltitle;
        
        totaltitle.textColor = [UIColor darkTextColor];
        
        totaltitle.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:totaltitle];
        
        UILabel *total = [[UILabel alloc] init];
        
        self.totalLab = total;
        
        total.textColor = [UIColor redColor];
        
        total.textAlignment = NSTextAlignmentRight;
        
        total.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:total];
        
        UILabel *paytitle = [[UILabel alloc] init];
        
        self.payTitleLab = paytitle;
        
        paytitle.textColor = FSB_StyleCOLOR;
        
        paytitle.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:paytitle];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(HL_RechargeOrderFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.orderbgView.frame = self.frameModel.OrderBgF;
    
    self.bgView.frame = self.frameModel.bgF;
    
    self.orderidtitleLab.frame = self.frameModel.OrderIDTitleF;
    
    self.orderidLab.frame = self.frameModel.OrderIDF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
    self.gameIDtitleLab.frame = self.frameModel.GameIDTitleF;
    
    self.gameIDLab.frame = self.frameModel.GameIDF;
    
    self.gameNicktitleLab.frame = self.frameModel.GameNickTitleF;
    
    self.gameNickLab.frame = self.frameModel.GameNickF;
    
    self.ordertitleLab.frame = self.frameModel.OrderTitleF;
    
    self.originaltitleLab.frame = self.frameModel.OriginalPriceTitleF;
    
    self.originalLab.frame = self.frameModel.OriginalPriceF;
    
    self.originalLineLab.frame = self.frameModel.OriginalPriceLineF;
    
    self.delegatetitleLab.frame = self.frameModel.DelegatePriceTitleF;
    
    self.delegateLab.frame = self.frameModel.DelegatePriceF;
    
    self.counttitleLab.frame = self.frameModel.CountTitleF;
    
    self.countLab.frame = self.frameModel.CountF;
    
    self.totaltitleLab.frame = self.frameModel.TotalTitleF;
    
    self.totalLab.frame = self.frameModel.TotalF;
    
    self.payTitleLab.frame = self.frameModel.PayTitleF;
    
    HL_PayTypeView *zfbview = [[HL_PayTypeView alloc] initWithFrame:self.frameModel.ZFB_TypeF];
    
    self.ZFB_View = zfbview;
    
    zfbview.iconImg.image = [UIImage imageNamed:@"HL_AliPay.jpeg"];
    
    zfbview.titleLab.text = @"支付宝支付";
    
    zfbview.descLab.text = @"";
    
    [self addSubview:zfbview];
    
    UIButton *zfbbtn = [[UIButton alloc] initWithFrame:self.frameModel.ZFB_TypeF];
    
    self.zfbBtn = zfbbtn;
    
    [zfbbtn addTarget:self action:@selector(zfbClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:zfbbtn];
    
    HL_PayTypeView *wxview = [[HL_PayTypeView alloc] initWithFrame:self.frameModel.WX_TypeF];
    
    self.WX_View = wxview;
    
    wxview.iconImg.image = [UIImage imageNamed:@"Pay_weixin.png"];
    
    wxview.titleLab.text = @"微信支付";
    
    wxview.descLab.text = @"";
    
    [self addSubview:wxview];
    
    UIButton *wxbtn = [[UIButton alloc] initWithFrame:self.frameModel.WX_TypeF];
    
    self.wxBtn = wxbtn;
    
    [self addSubview:wxbtn];
    
    [wxbtn addTarget:self action:@selector(wxClick) forControlEvents:UIControlEventTouchUpInside];
    
    HL_PayTypeView *cycview = [[HL_PayTypeView alloc] initWithFrame:self.frameModel.CYC_TypeF];
    
    self.CYC_View = cycview;
    
    cycview.iconImg.image = [UIImage imageNamed:@"Pay_CYC.png"];
    
    cycview.titleLab.text = @"城与城余额支付";
    
    cycview.descLab.text = @"";
    
    [self addSubview:cycview];
    
    UIButton *cycbtn = [[UIButton alloc] initWithFrame:self.frameModel.CYC_TypeF];
    
    self.cycBtn = cycbtn;
    
    [self addSubview:cycbtn];
    
    [cycbtn addTarget:self action:@selector(cycClick) forControlEvents:UIControlEventTouchUpInside];
    
    HL_PayTypeView *fsbview = [[HL_PayTypeView alloc] initWithFrame:self.frameModel.FSB_TypeF];
    
    self.FSB_View = fsbview;
    
    fsbview.iconImg.image = [UIImage imageNamed:@"Order_FSB.png"];
    
    fsbview.titleLab.text = @"粉丝宝红包支付";
    
    fsbview.descLab.text = @"";
    
    [self addSubview:fsbview];
    
    UIButton *fsbbtn = [[UIButton alloc] initWithFrame:self.frameModel.FSB_TypeF];
    
    self.fsbBtn = fsbbtn;
    
    [self addSubview:fsbbtn];
    
    [fsbbtn addTarget:self action:@selector(fsbClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setContent {
    
    HL_RechargeOrderModel *model = self.frameModel.model;
    
    self.orderidtitleLab.text = @"订单编号:";
    
    self.orderidLab.text = model.OrderID;
    
    self.gameIDtitleLab.text = @"游戏ID:";
    
    self.gameIDLab.text = model.GameID;
    
    self.gameNicktitleLab.text = @"游戏昵称:";
    
    self.gameNickLab.text = model.GameNick;
    
    self.ordertitleLab.text = model.OrderTitle;
    
    self.originaltitleLab.text = @"原价:";
    
    self.originalLab.text = [NSString stringWithFormat:@"¥%@",model.OriginalPrice];
    
    self.delegatetitleLab.text = @"现价:";
    
    self.delegateLab.text = [NSString stringWithFormat:@"¥%@",model.DelegatePrice];
    
    self.counttitleLab.text = @"数量:";
    
    self.countLab.text =[NSString stringWithFormat:@"X%@", model.Count];

    self.totaltitleLab.text = @"总价:";
    
    self.totalLab.text = [NSString stringWithFormat:@"¥%@",model.Total];
    
    self.payTitleLab.text = @"选择支付";
    
    if ([model.payType isEqualToString:@"1"]) {
        
        self.ZFB_View.chooseImg.image = [UIImage imageNamed:@"checkblueyes.png"];
        
        self.WX_View.chooseImg.image = [UIImage imageNamed:@"checkblueno.png"];
        
        self.CYC_View.chooseImg.image = [UIImage imageNamed:@"checkblueno.png"];
        
        self.FSB_View.chooseImg.image = [UIImage imageNamed:@"checkblueno.png"];
        
    }else if ([model.payType isEqualToString:@"2"]) {
        
        self.ZFB_View.chooseImg.image = [UIImage imageNamed:@"checkblueno.png"];
        
        self.WX_View.chooseImg.image = [UIImage imageNamed:@"checkblueyes.png"];
        
        self.CYC_View.chooseImg.image = [UIImage imageNamed:@"checkblueno.png"];
        
        self.FSB_View.chooseImg.image = [UIImage imageNamed:@"checkblueno.png"];
        
    }else if ([model.payType isEqualToString:@"3"]) {
        
        self.ZFB_View.chooseImg.image = [UIImage imageNamed:@"checkblueno.png"];
        
        self.WX_View.chooseImg.image = [UIImage imageNamed:@"checkblueno.png"];
        
        self.CYC_View.chooseImg.image = [UIImage imageNamed:@"checkblueyes.png"];
        
        self.FSB_View.chooseImg.image = [UIImage imageNamed:@"checkblueno.png"];
        
    }else if ([model.payType isEqualToString:@"4"]) {
        
        self.ZFB_View.chooseImg.image = [UIImage imageNamed:@"checkblueno.png"];
        
        self.WX_View.chooseImg.image = [UIImage imageNamed:@"checkblueno.png"];
        
        self.CYC_View.chooseImg.image = [UIImage imageNamed:@"checkblueno.png"];
        
        self.FSB_View.chooseImg.image = [UIImage imageNamed:@"checkblueyes.png"];
        
    }
    
}

- (void)fsbClick {
    
    if (self.fsbBlock) {
        
        self.fsbBlock();
        
    }
    
}

- (void)zfbClick {
    
    if (self.zfbBlock) {
        
        self.zfbBlock();
        
    }
    
}

- (void)wxClick {
    
    if (self.wxBlock) {
        
        self.wxBlock();
        
    }
    
}

- (void)cycClick {
    
    if (self.cycBlock) {
        
        self.cycBlock();
        
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
