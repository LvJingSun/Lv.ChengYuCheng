//
//  BuyDelegateCell.m
//  HuiHui
//
//  Created by mac on 2017/11/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "BuyDelegateCell.h"
#import "LJConst.h"
#import "BuyDelegateModel.h"
#import "BuyDelegateFrame.h"
#import "RH_RadioView.h"

@interface BuyDelegateCell ()

@property (nonatomic, weak) UILabel *priceLab;

@property (nonatomic, weak) UIView *timeBGView;

@property (nonatomic, weak) RH_RadioView *oneRadioView;

@property (nonatomic, weak) RH_RadioView *twoRadioView;

@property (nonatomic, weak) RH_RadioView *threeRadioView;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UIView *CYC_BGView;

@property (nonatomic, weak) UIImageView *cycIcon;

@property (nonatomic, weak) UILabel *CYC_TitleLab;

@property (nonatomic, weak) UIImageView *CYC_Img;

@property (nonatomic, weak) UIButton *CYC_Btn;

@property (nonatomic, weak) UIView *WX_BGView;

@property (nonatomic, weak) UIImageView *wxIcon;

@property (nonatomic, weak) UILabel *WX_TitleLab;

@property (nonatomic, weak) UIImageView *WX_Img;

@property (nonatomic, weak) UIButton *WX_Btn;

@property (nonatomic, weak) UIView *ZFB_BGView;

@property (nonatomic, weak) UIImageView *zfbIcon;

@property (nonatomic, weak) UILabel *ZFB_TitleLab;

@property (nonatomic, weak) UIImageView *ZFB_Img;

@property (nonatomic, weak) UIButton *ZFB_Btn;

@property (nonatomic, weak) UIButton *sureBtn;

@end

@implementation BuyDelegateCell

+ (instancetype)BuyDelegateCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"BuyDelegateCell";
    
    BuyDelegateCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[BuyDelegateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = FSB_ViewBGCOLOR;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *price = [[UILabel alloc] init];
        
        self.priceLab = price;
        
        price.textColor = [UIColor darkTextColor];
        
        price.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:price];
        
        UIView *timebg = [[UIView alloc] init];
        
        self.timeBGView = timebg;
        
        timebg.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:timebg];
        
        UILabel *title = [[UILabel alloc] init];
        
        self.titleLab = title;
        
        title.textColor = [UIColor darkTextColor];
        
        title.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:title];
        
        UIView *cycbg = [[UIView alloc] init];
        
        self.CYC_BGView = cycbg;
        
        cycbg.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:cycbg];
        
        UIImageView *cycicon = [[UIImageView alloc] init];
        
        self.cycIcon = cycicon;
        
        [self addSubview:cycicon];
        
        UILabel *cyctitle = [[UILabel alloc] init];
        
        self.CYC_TitleLab = cyctitle;
        
        cyctitle.textColor = [UIColor darkTextColor];
        
        cyctitle.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:cyctitle];
        
        UIImageView *cycimg = [[UIImageView alloc] init];
        
        self.CYC_Img = cycimg;
        
        [self addSubview:cycimg];
        
        UIButton *cycbtn = [[UIButton alloc] init];
        
        self.CYC_Btn = cycbtn;
        
        [self addSubview:cycbtn];
        
        
        UIView *wxbg = [[UIView alloc] init];
        
        self.WX_BGView = wxbg;
        
        wxbg.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:wxbg];
        
        UIImageView *wxicon = [[UIImageView alloc] init];
        
        self.wxIcon = wxicon;
        
        [self addSubview:wxicon];
        
        UILabel *wxtitle = [[UILabel alloc] init];
        
        self.WX_TitleLab = wxtitle;
        
        wxtitle.textColor = [UIColor darkTextColor];
        
        wxtitle.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:wxtitle];
        
        UIImageView *wximg = [[UIImageView alloc] init];
        
        self.WX_Img = wximg;
        
        [self addSubview:wximg];
        
        UIButton *wxbtn = [[UIButton alloc] init];
        
        self.WX_Btn = wxbtn;
        
        [self addSubview:wxbtn];
        
        
        UIView *zfbbg = [[UIView alloc] init];
        
        self.ZFB_BGView = zfbbg;
        
        zfbbg.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:zfbbg];
        
        UIImageView *zfbicon = [[UIImageView alloc] init];
        
        self.zfbIcon = zfbicon;
        
        [self addSubview:zfbicon];
        
        UILabel *zfbtitle = [[UILabel alloc] init];
        
        self.ZFB_TitleLab = zfbtitle;
        
        zfbtitle.textColor = [UIColor darkTextColor];
        
        zfbtitle.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:zfbtitle];
        
        UIImageView *zfbimg = [[UIImageView alloc] init];
        
        self.ZFB_Img = zfbimg;
        
        [self addSubview:zfbimg];
        
        UIButton *zfbbtn = [[UIButton alloc] init];
        
        self.ZFB_Btn = zfbbtn;
        
        [self addSubview:zfbbtn];
        
        
        
        
        
        UIButton *surebtn = [[UIButton alloc] init];
        
        self.sureBtn = surebtn;
        
        [surebtn setBackgroundColor:FSB_StyleCOLOR];
        
        [surebtn setTitleColor:[UIColor whiteColor] forState:0];
        
        surebtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        surebtn.layer.masksToBounds = YES;
        
        surebtn.layer.cornerRadius = 15;
        
        [self addSubview:surebtn];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(BuyDelegateFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.priceLab.frame = self.frameModel.priceF;
    
    self.timeBGView.frame = self.frameModel.timeBGF;
    
    RH_RadioView *one = [[RH_RadioView alloc] initWithFrame:self.frameModel.oneYearF];
    
    self.oneRadioView = one;
    
    [one.btn addTarget:self action:@selector(oneClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:one];
    
    RH_RadioView *two = [[RH_RadioView alloc] initWithFrame:self.frameModel.twoYearF];
    
    self.twoRadioView = two;
    
    [two.btn addTarget:self action:@selector(twoClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:two];
    
    RH_RadioView *three = [[RH_RadioView alloc] initWithFrame:self.frameModel.threeYearF];
    
    self.threeRadioView = three;
    
    [three.btn addTarget:self action:@selector(threeClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:three];
    
    self.titleLab.frame = self.frameModel.typeTitleF;
    
    self.CYC_BGView.frame = self.frameModel.type_CYC_BGF;
    
    self.cycIcon.frame = self.frameModel.type_CYC_IconF;
    
    self.CYC_TitleLab.frame = self.frameModel.type_CYC_TitleF;
    
    self.CYC_Img.frame = self.frameModel.type_CYC_ImgF;
    
    self.CYC_Btn.frame = self.frameModel.type_CYC_BGF;
    
    self.WX_BGView.frame = self.frameModel.type_WX_BGF;
    
    self.wxIcon.frame = self.frameModel.type_WX_IconF;
    
    self.WX_TitleLab.frame = self.frameModel.type_WX_TitleF;
    
    self.WX_Img.frame = self.frameModel.type_WX_ImgF;
    
    self.WX_Btn.frame = self.frameModel.type_WX_BGF;
    
    
    
    self.ZFB_BGView.frame = self.frameModel.type_ZFB_BGF;
    
    self.zfbIcon.frame = self.frameModel.type_ZFB_IconF;
    
    self.ZFB_TitleLab.frame = self.frameModel.type_ZFB_TitleF;
    
    self.ZFB_Img.frame = self.frameModel.type_ZFB_ImgF;
    
    self.ZFB_Btn.frame = self.frameModel.type_ZFB_BGF;
    
    
    self.sureBtn.frame = self.frameModel.sureF;
    
}

- (void)setContent {
    
    BuyDelegateModel *model = self.frameModel.buyModel;
    
    self.priceLab.text = [NSString stringWithFormat:@"选择代理年限：(%@)",model.price];
    
    self.oneRadioView.title.text = @"1年";
    
    self.twoRadioView.title.text = @"2年";
    
    self.threeRadioView.title.text = @"3年";
    
    if ([model.timeStatus isEqualToString:@"1"]) {
        
        [self.oneRadioView.btn setImage:[UIImage imageNamed:@"checkblueyes.png"] forState:0];
        
        [self.twoRadioView.btn setImage:[UIImage imageNamed:@"checkblueno.png"] forState:0];
        
        [self.threeRadioView.btn setImage:[UIImage imageNamed:@"checkblueno.png"] forState:0];
        
    }else if ([model.timeStatus isEqualToString:@"2"]) {
        
        [self.oneRadioView.btn setImage:[UIImage imageNamed:@"checkblueno.png"] forState:0];
        
        [self.twoRadioView.btn setImage:[UIImage imageNamed:@"checkblueyes.png"] forState:0];
        
        [self.threeRadioView.btn setImage:[UIImage imageNamed:@"checkblueno.png"] forState:0];
        
    }else if ([model.timeStatus isEqualToString:@"3"]) {
        
        [self.oneRadioView.btn setImage:[UIImage imageNamed:@"checkblueno.png"] forState:0];
        
        [self.twoRadioView.btn setImage:[UIImage imageNamed:@"checkblueno.png"] forState:0];
        
        [self.threeRadioView.btn setImage:[UIImage imageNamed:@"checkblueyes.png"] forState:0];
        
    }
    
    self.titleLab.text = @"选择支付方式:";
    
    self.CYC_TitleLab.text = @"城与城余额支付";
    
    self.cycIcon.image = [UIImage imageNamed:@"Pay_CYC.png"];
    
    self.WX_TitleLab.text = @"微信支付";
    
    self.wxIcon.image = [UIImage imageNamed:@"Pay_weixin.png"];
    
    self.ZFB_TitleLab.text = @"支付宝支付";
    
    self.zfbIcon.image = [UIImage imageNamed:@""];
    
    if ([model.payStatus isEqualToString:@"1"]) {
        
        self.CYC_Img.image = [UIImage imageNamed:@"checkblueyes.png"];
        
        self.WX_Img.image = [UIImage imageNamed:@"checkblueno.png"];
        
        self.ZFB_Img.image = [UIImage imageNamed:@"checkblueno.png"];
        
    }else if ([model.payStatus isEqualToString:@"2"]) {
        
        self.CYC_Img.image = [UIImage imageNamed:@"checkblueno.png"];
        
        self.WX_Img.image = [UIImage imageNamed:@"checkblueyes.png"];
        
        self.ZFB_Img.image = [UIImage imageNamed:@"checkblueno.png"];
        
    }else if ([model.payStatus isEqualToString:@"3"]) {
        
        self.CYC_Img.image = [UIImage imageNamed:@"checkblueno.png"];
        
        self.WX_Img.image = [UIImage imageNamed:@"checkblueno.png"];
        
        self.ZFB_Img.image = [UIImage imageNamed:@"checkblueyes.png"];
        
    }
    
    [self.CYC_Btn addTarget:self action:@selector(cycClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.WX_Btn addTarget:self action:@selector(wxClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.ZFB_Btn addTarget:self action:@selector(zfbClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.sureBtn setTitle:[NSString stringWithFormat:@"(%@元)确认充值",model.allCount] forState:0];
    
    [self.sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)oneClick {
    
    if (self.oneBlock) {
        
        self.oneBlock();
        
    }
    
}

- (void)twoClick {
    
    if (self.twoBlock) {
        
        self.twoBlock();
        
    }
    
}

- (void)threeClick {
    
    if (self.threeBlock) {
        
        self.threeBlock();
        
    }
    
}

- (void)cycClick {
    
    if (self.cycBlock) {
        
        self.cycBlock();
        
    }
    
}

- (void)wxClick {
    
    if (self.wxBlock) {
        
        self.wxBlock();
        
    }
    
}

- (void)zfbClick {
    
    if (self.zfbBlock) {
        
        self.zfbBlock();
        
    }
    
}

- (void)sureClick {
    
    if (self.sureBlock) {
        
        self.sureBlock();
        
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
