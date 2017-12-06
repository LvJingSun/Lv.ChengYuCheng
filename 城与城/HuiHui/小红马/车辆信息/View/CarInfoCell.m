//
//  CarInfoCell.m
//  HuiHui
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "CarInfoCell.h"
#import "CarInfoFrame.h"
#import "RH_CarModel.h"
#import "RedHorseHeader.h"

@interface CarInfoCell ()

@property (nonatomic, weak) UIImageView *carImg;

@property (nonatomic, weak) UILabel *carModelLab;

@property (nonatomic, weak) UIImageView *rightImg;

@property (nonatomic, weak) UILabel *line1Lab;

@property (nonatomic, weak) UIButton *chooseBrandBtn;

@property (nonatomic, weak) UILabel *PlateTitleLab;

@property (nonatomic, weak) UITextField *PlateField;

@property (nonatomic, weak) UILabel *plateLine;

@property (nonatomic, weak) UILabel *timeTitleLab;

@property (nonatomic, weak) UITextField *timeField;

@property (nonatomic, weak) UIButton *timeBtn;

@property (nonatomic, weak) UILabel *timeLine;

@property (nonatomic, weak) UILabel *moneyTitleLab;

@property (nonatomic, weak) UITextField *moneyField;

@property (nonatomic, weak) UILabel *moneyLine;

@property (nonatomic, weak) UILabel *EngineNumberTitleLab;

@property (nonatomic, weak) UITextField *EngineNumberField;

@property (nonatomic, weak) UILabel *EngineNumberLine;

@property (nonatomic, weak) UILabel *MileageTitleLab;

@property (nonatomic, weak) UITextField *MileageField;

@property (nonatomic, weak) UILabel *MileageLine;

@property (nonatomic, weak) UILabel *InvoiceTitleLab;

@property (nonatomic, weak) UIButton *AddInvoiceBtn;

@property (nonatomic, weak) UIButton *SureBtn;

@property (nonatomic, weak) UIView *SureBtnBGView;

@end

@implementation CarInfoCell

+ (instancetype)CarInfoCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"CarInfoCell";
    
    CarInfoCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[CarInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *carimg = [[UIImageView alloc] init];
        
        self.carImg = carimg;
        
        [self addSubview:carimg];
        
        UILabel *carmodel = [[UILabel alloc] init];
        
        self.carModelLab = carmodel;
        
        carmodel.textColor = CarInfo_ModelColor;
        
        carmodel.font = CarInfo_ModelFont;
        
        [self addSubview:carmodel];
        
        UIImageView *rightimg = [[UIImageView alloc] init];
        
        self.rightImg = rightimg;
        
        [self addSubview:rightimg];
        
        UIButton *choose = [[UIButton alloc] init];
        
        self.chooseBrandBtn = choose;
        
        [self addSubview:choose];
        
        UILabel *line1 = [[UILabel alloc] init];
        
        self.line1Lab = line1;
        
        line1.backgroundColor = RH_ViewBGColor;
        
        [self addSubview:line1];
        
        UILabel *platetitle = [[UILabel alloc] init];
        
        self.PlateTitleLab = platetitle;
        
        platetitle.font = CarInfo_TitleFont;
        
        platetitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:platetitle];
        
        UITextField *platefield = [[UITextField alloc] init];
        
        self.PlateField = platefield;
        
        platefield.placeholder = @"填写完整车牌号码";
        
        platefield.textAlignment = NSTextAlignmentRight;
        
        [platefield addTarget:self action:@selector(plateChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self addSubview:platefield];
        
        UILabel *plateline = [[UILabel alloc] init];
        
        self.plateLine = plateline;
        
        plateline.backgroundColor = CarInfo_LineColor;
        
        [self addSubview:plateline];
        
        UILabel *timetitle = [[UILabel alloc] init];
        
        self.timeTitleLab = timetitle;
        
        timetitle.font = CarInfo_TitleFont;
        
        timetitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:timetitle];
        
        UITextField *timefield = [[UITextField alloc] init];
        
        self.timeField = timefield;
        
        timefield.placeholder = @"请选择";
        
        timefield.userInteractionEnabled = NO;
        
        timefield.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:timefield];
        
        UIButton *timeBtn = [[UIButton alloc] init];
        
        self.timeBtn = timeBtn;
        
        [self addSubview:timeBtn];
        
        UILabel *timeline = [[UILabel alloc] init];
        
        self.timeLine = timeline;
        
        timeline.backgroundColor = CarInfo_LineColor;
        
        [self addSubview:timeline];
        
        UILabel *moneytitle = [[UILabel alloc] init];
        
        self.moneyTitleLab = moneytitle;
        
        moneytitle.font = CarInfo_TitleFont;
        
        moneytitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:moneytitle];
        
        UITextField *moneyfield = [[UITextField alloc] init];
        
        self.moneyField = moneyfield;
        
        moneyfield.keyboardType = UIKeyboardTypeDecimalPad;
        
        moneyfield.placeholder = @"填写购车金额";
        
        moneyfield.textAlignment = NSTextAlignmentRight;
        
        [moneyfield addTarget:self action:@selector(moneyChange:) forControlEvents:UIControlEventEditingChanged];
        
        moneyfield.rightViewMode = UITextFieldViewModeWhileEditing;
        
        [self addSubview:moneyfield];
        
        UILabel *moneyline = [[UILabel alloc] init];
        
        self.moneyLine = moneyline;
        
        moneyline.backgroundColor = CarInfo_LineColor;
        
        [self addSubview:moneyline];
        
        UILabel *EngineNumbertitle = [[UILabel alloc] init];
        
        self.EngineNumberTitleLab = EngineNumbertitle;
        
        EngineNumbertitle.font = CarInfo_TitleFont;
        
        EngineNumbertitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:EngineNumbertitle];
        
        UITextField *EngineNumberfield = [[UITextField alloc] init];
        
        self.EngineNumberField = EngineNumberfield;
        
        EngineNumberfield.placeholder = @"填写发动机号";
        
        EngineNumberfield.textAlignment = NSTextAlignmentRight;
        
        [EngineNumberfield addTarget:self action:@selector(enginenumberChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self addSubview:EngineNumberfield];
        
        UILabel *EngineNumberline = [[UILabel alloc] init];
        
        self.EngineNumberLine = EngineNumberline;
        
        EngineNumberline.backgroundColor = CarInfo_LineColor;
        
        [self addSubview:EngineNumberline];
        
        UILabel *Mileagetitle = [[UILabel alloc] init];
        
        self.MileageTitleLab = Mileagetitle;
        
        Mileagetitle.font = CarInfo_TitleFont;
        
        Mileagetitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:Mileagetitle];
        
        UITextField *Mileagefield = [[UITextField alloc] init];
        
        self.MileageField = Mileagefield;
        
        Mileagefield.keyboardType = UIKeyboardTypeDecimalPad;
        
        Mileagefield.placeholder = @"填写行驶公里数";
        
        Mileagefield.textAlignment = NSTextAlignmentRight;
        
        [Mileagefield addTarget:self action:@selector(mileageChange:) forControlEvents:UIControlEventEditingChanged];
        
        Mileagefield.rightViewMode = UITextFieldViewModeWhileEditing;
        
        [self addSubview:Mileagefield];
        
        UILabel *Mileageline = [[UILabel alloc] init];
        
        self.MileageLine = Mileageline;
        
        Mileageline.backgroundColor = CarInfo_LineColor;
        
        [self addSubview:Mileageline];
        
        UILabel *Invoicetitle = [[UILabel alloc] init];
        
        self.InvoiceTitleLab = Invoicetitle;
        
        Invoicetitle.font = CarInfo_TitleFont;
        
        Invoicetitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:Invoicetitle];
        
        UIButton *addInvoiceBtn = [[UIButton alloc] init];
        
        self.AddInvoiceBtn = addInvoiceBtn;
        
        [self addSubview:addInvoiceBtn];
        
        UIView *bg = [[UIView alloc] init];
        
        self.SureBtnBGView = bg;
        
        bg.backgroundColor = RH_ViewBGColor;
        
        [self addSubview:bg];
        
        UIButton *sureBtn = [[UIButton alloc] init];
        
        self.SureBtn = sureBtn;
        
        [sureBtn setBackgroundColor:RH_NAVTextColor];
        
        [sureBtn setTitleColor:[UIColor whiteColor] forState:0];
        
        sureBtn.layer.masksToBounds = YES;
        
        sureBtn.layer.cornerRadius = 5;
        
        [self addSubview:sureBtn];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(CarInfoFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.carImg.frame = self.frameModel.carImgF;
    
    self.carModelLab.frame = self.frameModel.carModelF;
    
    self.rightImg.frame = self.frameModel.rightImgF;
    
    self.chooseBrandBtn.frame = self.frameModel.chooseBrandF;
    
    self.line1Lab.frame = self.frameModel.Line1F;
    
    self.PlateTitleLab.frame = self.frameModel.carPlateTitleF;
    
    self.PlateField.frame = self.frameModel.carPlateF;
    
    self.plateLine.frame = self.frameModel.carPlateLineF;
    
    self.timeTitleLab.frame = self.frameModel.timeTitleF;
    
    self.timeField.frame = self.frameModel.timeF;
    
    self.timeLine.frame = self.frameModel.timeLineF;
    
    self.timeBtn.frame = self.frameModel.timeBtnF;
    
    self.moneyTitleLab.frame = self.frameModel.moneyTitleF;
    
    self.moneyField.frame = self.frameModel.moneyF;
    
    self.moneyLine.frame = self.frameModel.moneyLineF;
    
    CGSize monetrightsize = [self sizeWithText:@"元" font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(0,self.frameModel.moneyF.size.height)];
    
    UILabel *moneylab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, monetrightsize.width + 10, self.frameModel.moneyF.size.height)];
    
    moneylab.text = @"元";
    
    moneylab.font = [UIFont systemFontOfSize:16];
    
    moneylab.textAlignment = NSTextAlignmentRight;
    
    self.moneyField.rightView = moneylab;
    
    self.EngineNumberTitleLab.frame = self.frameModel.EngineNumberTitleF;
    
    self.EngineNumberField.frame = self.frameModel.EngineNumberF;
    
    self.EngineNumberLine.frame = self.frameModel.EngineNumberLineF;
    
    self.MileageTitleLab.frame = self.frameModel.MileageTitleF;
    
    self.MileageField.frame = self.frameModel.MileageF;
    
    self.MileageLine.frame = self.frameModel.MileageLineF;
    
    CGSize mileagerightsize = [self sizeWithText:@"公里" font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(0,self.frameModel.MileageF.size.height)];
    
    UILabel *mileagelab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, mileagerightsize.width + 10, self.frameModel.MileageF.size.height)];
    
    mileagelab.text = @"公里";
    
    mileagelab.font = [UIFont systemFontOfSize:16];
    
    mileagelab.textAlignment = NSTextAlignmentRight;
    
    self.MileageField.rightView = mileagelab;
    
    self.InvoiceTitleLab.frame = self.frameModel.InvoiceTitleF;
        
    self.AddInvoiceBtn.frame = self.frameModel.AddInvoiceBtnF;
    
    self.SureBtn.frame = self.frameModel.SureBtnF;
    
    self.SureBtnBGView.frame = self.frameModel.SureBtnBGViewF;

}

- (void)setContent {

    RH_CarModel *model = self.frameModel.carModel;
    
    if ([self isNULLString:model.carImg]) {
        
        self.carImg.image = [UIImage imageNamed:@"Oil_BMW.png"];
        
    }else {
    
        [self.carImg setImageWithURL:[NSURL URLWithString:model.carImg] placeholderImage:[UIImage imageNamed:@"RH_CarPL.png"]];
        
    }
    
    if ([self isNULLString:model.carModel]) {
        
        self.carModelLab.text = @"请选择汽车品牌信息";
        
    }else {
        
        self.carModelLab.text = model.carModel;
        
    }

    self.rightImg.image = [UIImage imageNamed:@"NearBy_More.png"];
    
    [self.chooseBrandBtn addTarget:self action:@selector(chooseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.PlateTitleLab.text = @"车牌号码";
    
    if ([self isNULLString:model.carPlate]) {

        self.PlateField.text = @"";
        
    }else {
        
        self.PlateField.text = [NSString stringWithFormat:@"%@",model.carPlate];
        
    }
    
    self.timeTitleLab.text = @"购车时间";
    
    if ([self isNULLString:model.buyTime]) {
        
        self.timeField.text = @"";
        
    }else {
        
        self.timeField.text = model.buyTime;
        
    }
    
    [self.timeBtn addTarget:self action:@selector(timeClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.moneyTitleLab.text = @"购车款";
    
    if ([self isNULLString:model.buyMoney]) {
        
        self.moneyField.text = @"";
        
    }else {
        
        self.moneyField.text = model.buyMoney;
        
    }
    
    self.EngineNumberTitleLab.text = @"发动机号";
    
    if ([self isNULLString:model.EngineNumber]) {
        
        self.EngineNumberField.text = @"";
        
    }else {
        
        self.EngineNumberField.text = model.EngineNumber;
        
    }
    
    self.MileageTitleLab.text = @"行驶里程";
    
    if ([self isNULLString:model.Mileage]) {
        
        self.MileageField.text = @"";
        
    }else {
        
        self.MileageField.text = model.Mileage;
        
    }
    
    self.InvoiceTitleLab.text = @"请上传发票";
    
    if (model.InvoiceImg == nil) {
        
        [self.AddInvoiceBtn setImage:[UIImage imageNamed:@"Car_infoAdd.png"] forState:0];
        
    }else {
        
        [self.AddInvoiceBtn setImage:model.InvoiceImg forState:0];
        
    }
    
    [self.AddInvoiceBtn addTarget:self action:@selector(addInvoiceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.SureBtn setTitle:@"确定" forState:0];
    
    [self.SureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];

}

//确定上传信息点击
- (void)sureBtnClick {

    [self hideKeyBoard];
    
    if (self.SureBlock) {
        
        self.SureBlock();
        
    }
    
}

//上传发票按钮点击
- (void)addInvoiceBtnClick {

    [self hideKeyBoard];
    
    if (self.InvoiceBlock) {
        
        self.InvoiceBlock();
        
    }
    
}

//选择品牌按钮点击
- (void)chooseBtnClick {
    
    [self hideKeyBoard];

    if (self.ChooseBlock) {
        
        self.ChooseBlock();
        
    }
    
}

//时间按钮点击
- (void)timeClick {
    
    [self hideKeyBoard];

    if (self.timeBlock) {
        
        self.timeBlock();
        
    }
    
}

//车牌号代理
- (void)plateChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(PlateFieldChange:)]) {
        
        [self.delegate PlateFieldChange:field];
        
    }
    
}

//购车款代理
- (void)moneyChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(BuyMoneyFieldChange:)]) {
        
        [self.delegate BuyMoneyFieldChange:field];
        
    }
    
}

//发动机号代理
- (void)enginenumberChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(EngineNumberFieldChange:)]) {
        
        [self.delegate EngineNumberFieldChange:field];
        
    }
    
}

//行驶里程代理
- (void)mileageChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(MileageFieldChange:)]) {
        
        [self.delegate MileageFieldChange:field];
        
    }
    
}

- (BOOL)isNULLString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self hideKeyBoard];
    
}

- (void)hideKeyBoard {

    if ([self.PlateField isFirstResponder]) {
        
        [self.PlateField resignFirstResponder];
        
    }
    
    if ([self.moneyField isFirstResponder]) {
        
        [self.moneyField resignFirstResponder];
        
    }
    
    if ([self.EngineNumberField isFirstResponder]) {
        
        [self.EngineNumberField resignFirstResponder];
        
    }
    
    if ([self.MileageField isFirstResponder]) {
        
        [self.MileageField resignFirstResponder];
        
    }
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
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
