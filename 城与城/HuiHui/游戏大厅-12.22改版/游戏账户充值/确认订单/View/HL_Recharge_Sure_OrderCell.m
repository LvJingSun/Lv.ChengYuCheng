//
//  HL_RechargeOrderCell.m
//  HuiHui
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_Recharge_Sure_OrderCell.h"
#import "LJConst.h"
#import "HL_PayTypeView.h"
#import "HL_Recharge_Sure_OrderModel.h"
#import "HL_Recharge_Sure_OrderFrame.h"

@interface HL_Recharge_Sure_OrderCell ()

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) UILabel *orderidtitleLab;

@property (nonatomic, weak) UILabel *orderidLab;

@property (nonatomic, weak) UILabel *lineLab;

@property (nonatomic, weak) UILabel *ordertitleLab;

@property (nonatomic, weak) UILabel *originaltitleLab;

@property (nonatomic, weak) UILabel *originalLab;

@property (nonatomic, weak) UILabel *originalLineLab;

@property (nonatomic, weak) UILabel *presenttitleLab;

@property (nonatomic, weak) UILabel *presentLab;

@property (nonatomic, weak) UILabel *counttitleLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *discounttitleLab;

@property (nonatomic, weak) UILabel *discountLab;

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

@implementation HL_Recharge_Sure_OrderCell

+ (instancetype)HL_Recharge_Sure_OrderCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"HL_Recharge_Sure_OrderCell";
    
    HL_Recharge_Sure_OrderCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[HL_Recharge_Sure_OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = FSB_ViewBGCOLOR;
        
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
        
        self.presenttitleLab = presenttitle;
        
        presenttitle.textColor = [UIColor darkTextColor];
        
        presenttitle.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:presenttitle];
        
        UILabel *present = [[UILabel alloc] init];
        
        self.presentLab = present;
        
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
        
        UILabel *discounttitle = [[UILabel alloc] init];
        
        self.discounttitleLab = discounttitle;
        
        discounttitle.textColor = [UIColor darkTextColor];
        
        discounttitle.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:discounttitle];
        
        UILabel *discount = [[UILabel alloc] init];
        
        self.discountLab = discount;
        
        discount.textColor = [UIColor redColor];
        
        discount.textAlignment = NSTextAlignmentRight;
        
        discount.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:discount];
        
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

-(void)setFrameModel:(HL_Recharge_Sure_OrderFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.bgView.frame = self.frameModel.bgF;
    
    self.orderidtitleLab.frame = self.frameModel.OrderIDTitleF;
    
    self.orderidLab.frame = self.frameModel.OrderIDF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
    self.ordertitleLab.frame = self.frameModel.OrderTitleF;
    
    self.originaltitleLab.frame = self.frameModel.OriginalPriceTitleF;
    
    self.originalLab.frame = self.frameModel.OriginalPriceF;
    
    self.originalLineLab.frame = self.frameModel.OriginalPriceLineF;
    
    self.presenttitleLab.frame = self.frameModel.PresentPriceTitleF;
    
    self.presentLab.frame = self.frameModel.PresentPriceF;
    
    self.counttitleLab.frame = self.frameModel.CountTitleF;
    
    self.countLab.frame = self.frameModel.CountF;
    
    self.discounttitleLab.frame = self.frameModel.DiscountTitleF;
    
    self.discountLab.frame = self.frameModel.DiscountF;
    
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
    
    
    
    //    self.zfbBtn.frame = self.frameModel.ZFB_TypeF;
    
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
    
    
    
    //    self.wxBtn.frame = self.frameModel.WX_TypeF;
    
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
    
    //    self.cycBtn.frame = self.frameModel.CYC_TypeF;
    
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
    
    HL_Recharge_Sure_OrderModel *model = self.frameModel.orderModel;
    
    self.orderidtitleLab.text = @"订单编号:";
    
    self.orderidLab.text = model.OrderID;
    
    self.ordertitleLab.text = model.OrderTitle;
    
    self.originaltitleLab.text = @"原价:";
    
    self.originalLab.text = [NSString stringWithFormat:@"¥%@",model.OriginalPrice];
    
    self.presenttitleLab.text = @"现价:";
    
    self.presentLab.text = [NSString stringWithFormat:@"¥%@",model.PresentPrice];
    
    self.counttitleLab.text = @"数量:";
    
    self.countLab.text =[NSString stringWithFormat:@"X%@", model.Count];
    
    self.discounttitleLab.text = @"折扣:(购买会员一个月内)";
    
    self.discountLab.text = [NSString stringWithFormat:@"¥%@",model.Discount];
    
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

- (void)fsbClick {
    
    if (self.fsbBlock) {
        
        self.fsbBlock();
        
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
