//
//  RH_InsuranceInPutCell.m
//  HuiHui
//
//  Created by mac on 2017/6/9.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_InsuranceInPutCell.h"
#import "RedHorseHeader.h"
#import "RH_InsuranceModel.h"
#import "RH_InsuranceInPutFrame.h"

#import "RH_RadioView.h"

@interface RH_InsuranceInPutCell ()

@property (nonatomic, weak) UILabel *carPriceTitle;

@property (nonatomic, weak) UITextField *carPrice;

@property (nonatomic, weak) UILabel *carPriceLine;

@property (nonatomic, weak) UILabel *insurancePersonTitle;

@property (nonatomic, weak) UITextField *insurancePerson;

@property (nonatomic, weak) UILabel *insurancePersonLine;

@property (nonatomic, weak) UILabel *insurancePriceTitle;

@property (nonatomic, weak) UITextField *insurancePrice;

@property (nonatomic, weak) UIButton *insuranceTypeBtn;

@property (nonatomic, weak) UILabel *insurancePriceLine;

@property (nonatomic, weak) UILabel *drivingAreaTitle;

@property (nonatomic, weak) UITextField *drivingArea;

@property (nonatomic, weak) UILabel *drivingAreaLine;

@property (nonatomic, weak) UILabel *drivingYearsTitle;

@property (nonatomic, weak) RH_RadioView *OneRadio;

@property (nonatomic, weak) RH_RadioView *OnetoThreeRadio;

@property (nonatomic, weak) RH_RadioView *moreThreeRadio;

@property (nonatomic, weak) UILabel *carYearsTitle;

@property (nonatomic, weak) RH_RadioView *c_OneRadio;

@property (nonatomic, weak) RH_RadioView *c_OnetoTwoRadio;

@property (nonatomic, weak) RH_RadioView *c_TwotoSixRadio;

@property (nonatomic, weak) RH_RadioView *c_moreSixRadio;

@property (nonatomic, weak) UIButton *SureBtn;

@property (nonatomic, weak) UIView *SureBtnBGView;

@end

@implementation RH_InsuranceInPutCell

+ (instancetype)RH_InsuranceInPutCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"RH_InsuranceInPutCell";
    
    RH_InsuranceInPutCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[RH_InsuranceInPutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *carpricetitle = [[UILabel alloc] init];
        
        self.carPriceTitle = carpricetitle;
        
        carpricetitle.font = CarInfo_TitleFont;
        
        carpricetitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:carpricetitle];
        
        UITextField *carprice = [[UITextField alloc] init];
        
        self.carPrice = carprice;
        
        carprice.placeholder = @"填写车辆价格";
        
        carprice.rightViewMode = UITextFieldViewModeWhileEditing;
        
        carprice.keyboardType = UIKeyboardTypeDecimalPad;
        
        carprice.textAlignment = NSTextAlignmentRight;
        
        [carprice addTarget:self action:@selector(priceChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self addSubview:carprice];
        
        UILabel *carpriceline = [[UILabel alloc] init];
        
        self.carPriceLine = carpriceline;
        
        carpriceline.backgroundColor = CarInfo_LineColor;
        
        [self addSubview:carpriceline];
        
        UILabel *insurancePersontitle = [[UILabel alloc] init];
        
        self.insurancePersonTitle = insurancePersontitle;
        
        insurancePersontitle.font = CarInfo_TitleFont;
        
        insurancePersontitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:insurancePersontitle];
        
        UITextField *insurancePerson = [[UITextField alloc] init];
        
        self.insurancePerson = insurancePerson;
        
        insurancePerson.placeholder = @"填写被保险人";
        
        insurancePerson.textAlignment = NSTextAlignmentRight;
        
        [insurancePerson addTarget:self action:@selector(personChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self addSubview:insurancePerson];
        
        UILabel *insurancePersonline = [[UILabel alloc] init];
        
        self.insurancePersonLine = insurancePersonline;
        
        insurancePersonline.backgroundColor = CarInfo_LineColor;
        
        [self addSubview:insurancePersonline];
        
        UILabel *insurancePricetitle = [[UILabel alloc] init];
        
        self.insurancePriceTitle = insurancePricetitle;
        
        insurancePricetitle.font = CarInfo_TitleFont;
        
        insurancePricetitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:insurancePricetitle];
        
        UITextField *insurancePrice = [[UITextField alloc] init];
        
        self.insurancePrice = insurancePrice;
        
        insurancePrice.placeholder = @"选择保险种类";
        
        insurancePrice.userInteractionEnabled = NO;
        
        insurancePrice.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:insurancePrice];
        
        UIButton *typeBtn = [[UIButton alloc] init];
        
        self.insuranceTypeBtn = typeBtn;
        
        [typeBtn addTarget:self action:@selector(TypeClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:typeBtn];
        
        UILabel *insurancePriceline = [[UILabel alloc] init];
        
        self.insurancePriceLine = insurancePriceline;
        
        insurancePriceline.backgroundColor = CarInfo_LineColor;
        
        [self addSubview:insurancePriceline];
        
        UILabel *drivingAreatitle = [[UILabel alloc] init];
        
        self.drivingAreaTitle = drivingAreatitle;
        
        drivingAreatitle.font = CarInfo_TitleFont;
        
        drivingAreatitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:drivingAreatitle];
        
        UITextField *drivingArea = [[UITextField alloc] init];
        
        self.drivingArea = drivingArea;
        
        drivingArea.placeholder = @"填写行驶里程";
        
        drivingArea.textAlignment = NSTextAlignmentRight;
        
        drivingArea.rightViewMode = UITextFieldViewModeWhileEditing;
        
        drivingArea.keyboardType = UIKeyboardTypeDecimalPad;
        
        [drivingArea addTarget:self action:@selector(areaChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self addSubview:drivingArea];
        
        UILabel *drivingArealine = [[UILabel alloc] init];
        
        self.drivingAreaLine = drivingArealine;
        
        drivingArealine.backgroundColor = CarInfo_LineColor;
        
        [self addSubview:drivingArealine];
        
        UILabel *drivingYearsTitle = [[UILabel alloc] init];
        
        self.drivingYearsTitle = drivingYearsTitle;
        
        drivingYearsTitle.font = CarInfo_TitleFont;
        
        drivingYearsTitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:drivingYearsTitle];
        
        UILabel *carYearsTitle = [[UILabel alloc] init];
        
        self.carYearsTitle = carYearsTitle;
        
        carYearsTitle.font = CarInfo_TitleFont;
        
        carYearsTitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:carYearsTitle];
        
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

-(void)setFrameModel:(RH_InsuranceInPutFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self hideKeyboard];
    
}

- (void)hideKeyboard {
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

- (void)setRect {

    self.carPriceTitle.frame = self.frameModel.carPriceTitleF;
    
    CGSize monetrightsize = [self sizeWithText:@"元" font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(0,self.frameModel.carPriceF.size.height)];
    
    UILabel *moneylab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, monetrightsize.width + 10, self.frameModel.carPriceF.size.height)];
    
    moneylab.text = @"元";
    
    moneylab.font = [UIFont systemFontOfSize:16];
    
    moneylab.textAlignment = NSTextAlignmentRight;
    
    self.carPrice.rightView = moneylab;
    
    self.carPrice.frame = self.frameModel.carPriceF;
    
    self.carPriceLine.frame = self.frameModel.carPriceLineF;
    
    self.insurancePersonTitle.frame = self.frameModel.insurancePersonTitleF;
    
    self.insurancePerson.frame = self.frameModel.insurancePersonF;
    
    self.insurancePersonLine.frame = self.frameModel.insurancePersonLineF;
    
    self.insurancePriceTitle.frame = self.frameModel.insurancePriceTitleF;
    
    self.insurancePrice.frame = self.frameModel.insurancePriceF;
    
    self.insurancePriceLine.frame = self.frameModel.insurancePriceLineF;
    
    self.insuranceTypeBtn.frame = self.frameModel.insurancePriceF;
    
    self.drivingAreaTitle.frame = self.frameModel.drivingAreaTitleF;
    
    self.drivingArea.frame = self.frameModel.drivingAreaF;
    
    CGSize mileagerightsize = [self sizeWithText:@"公里" font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(0,self.frameModel.drivingAreaF.size.height)];
    
    UILabel *mileagelab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, mileagerightsize.width + 10, self.frameModel.drivingAreaF.size.height)];
    
    mileagelab.text = @"公里";
    
    mileagelab.font = [UIFont systemFontOfSize:16];
    
    mileagelab.textAlignment = NSTextAlignmentRight;
    
    self.drivingArea.rightView = mileagelab;
    
    self.drivingAreaLine.frame = self.frameModel.drivingAreaLineF;
    
    self.drivingYearsTitle.frame = self.frameModel.drivingYearsTitleF;
    
    RH_RadioView *oneradio = [[RH_RadioView alloc] initWithFrame:self.frameModel.drivingYears_ONE_TitleF];
    
    self.OneRadio = oneradio;
    
    [self addSubview:oneradio];
    
    RH_RadioView *onetothreeradio = [[RH_RadioView alloc] initWithFrame:self.frameModel.drivingYears_ONEtoTHREE_TitleF];
    
    self.OnetoThreeRadio = onetothreeradio;
    
    [self addSubview:onetothreeradio];
    
    RH_RadioView *morethreeradio = [[RH_RadioView alloc] initWithFrame:self.frameModel.drivingYears_moreTHREE_TitleF];
    
    self.moreThreeRadio = morethreeradio;
    
    [self addSubview:morethreeradio];
    
    self.carYearsTitle.frame = self.frameModel.carYearsTitleF;
    
    RH_RadioView *c_oneradio = [[RH_RadioView alloc] initWithFrame:self.frameModel.carYears_ONE_TitleF];
    
    self.c_OneRadio = c_oneradio;
    
    [self addSubview:c_oneradio];
    
    RH_RadioView *c_onetotwo = [[RH_RadioView alloc] initWithFrame:self.frameModel.carYears_ONEtoTWO_TitleF];
    
    self.c_OnetoTwoRadio = c_onetotwo;
    
    [self addSubview:c_onetotwo];
    
    RH_RadioView *c_twotosix = [[RH_RadioView alloc] initWithFrame:self.frameModel.carYears_TWOtoSIX_TitleF];
    
    self.c_TwotoSixRadio = c_twotosix;
    
    [self addSubview:c_twotosix];
    
    RH_RadioView *moresix = [[RH_RadioView alloc] initWithFrame:self.frameModel.carYears_moreSIX_TitleF];
    
    self.c_moreSixRadio = moresix;
    
    [self addSubview:moresix];
    
    self.SureBtn.frame = self.frameModel.SureBtnF;
    
    self.SureBtnBGView.frame = self.frameModel.SureBtnBGViewF;
    
}

- (void)setContent {

    RH_InsuranceModel *model = self.frameModel.insuranceModel;
    
    self.carPriceTitle.text = @"车价";
    
    if ([self isNULLString:model.carPrice]) {
        
        self.carPrice.text = @"";
        
    }else {
        
        self.carPrice.text = model.carPrice;
        
    }
    
    self.insurancePersonTitle.text = @"被保险人";
    
    if ([self isNULLString:model.insurancePerson]) {
        
        self.insurancePerson.text = @"";
        
    }else {
        
        self.insurancePerson.text = model.insurancePerson;
        
    }
    
    self.insurancePriceTitle.text = @"保险种类";
    
    if ([self isNULLString:model.insuranceType]) {
        
        self.insurancePrice.text = @"";
        
    }else {
        
        self.insurancePrice.text = model.insuranceType;
        
    }
    
    self.drivingAreaTitle.text = @"行驶里程";
    
    if ([self isNULLString:model.drivingArea]) {
        
        self.drivingArea.text = @"";
        
    }else {
        
        self.drivingArea.text = model.drivingArea;
        
    }
    
    self.drivingYearsTitle.text = @"驾龄";
    
    self.OneRadio.title.text = @"1年以内";
    
    self.OnetoThreeRadio.title.text = @"1-3年";
    
    self.moreThreeRadio.title.text = @"3年以上";
    
    if ([model.drivingYears isEqualToString:@"1"]) {
        
        [self.OneRadio.btn setImage:[UIImage imageNamed:@"Administration_default.png"] forState:0];
        
        [self.OnetoThreeRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.moreThreeRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
    }else if ([model.drivingYears isEqualToString:@"2"]) {
    
        [self.OneRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.OnetoThreeRadio.btn setImage:[UIImage imageNamed:@"Administration_default.png"] forState:0];
        
        [self.moreThreeRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
    }else if ([model.drivingYears isEqualToString:@"3"]) {
    
        [self.OneRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.OnetoThreeRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.moreThreeRadio.btn setImage:[UIImage imageNamed:@"Administration_default.png"] forState:0];
        
    }
    
    [self.OneRadio.btn addTarget:self action:@selector(dri_oneClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.OnetoThreeRadio.btn addTarget:self action:@selector(dri_onetothreeClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.moreThreeRadio.btn addTarget:self action:@selector(dri_morethreeClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.carYearsTitle.text = @"车龄";

    self.c_OneRadio.title.text = @"1年以内";
    
    self.c_OnetoTwoRadio.title.text = @"1-2年";

    self.c_TwotoSixRadio.title.text = @"2-6年";

    self.c_moreSixRadio.title.text = @"6年以上";
    
    if ([model.carYears isEqualToString:@"1"]) {
        
        [self.c_OneRadio.btn setImage:[UIImage imageNamed:@"Administration_default.png"] forState:0];
        
        [self.c_OnetoTwoRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.c_TwotoSixRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.c_moreSixRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
    }else if ([model.carYears isEqualToString:@"2"]) {
    
        [self.c_OneRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.c_OnetoTwoRadio.btn setImage:[UIImage imageNamed:@"Administration_default.png"] forState:0];
        
        [self.c_TwotoSixRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.c_moreSixRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
    }else if ([model.carYears isEqualToString:@"3"]) {
        
        [self.c_OneRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.c_OnetoTwoRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.c_TwotoSixRadio.btn setImage:[UIImage imageNamed:@"Administration_default.png"] forState:0];
        
        [self.c_moreSixRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
    }else if ([model.carYears isEqualToString:@"4"]) {
        
        [self.c_OneRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.c_OnetoTwoRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.c_TwotoSixRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.c_moreSixRadio.btn setImage:[UIImage imageNamed:@"Administration_default.png"] forState:0];
        
    }
    
    [self.c_OneRadio.btn addTarget:self action:@selector(car_oneClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.c_OnetoTwoRadio.btn addTarget:self action:@selector(car_onetotwoClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.c_TwotoSixRadio.btn addTarget:self action:@selector(car_twotosixClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.c_moreSixRadio.btn addTarget:self action:@selector(car_moresixClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.SureBtn setTitle:@"提交" forState:0];
    
    [self.SureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)sureClick {

    if (self.sureBlock) {
        
        self.sureBlock();
        
    }
    
    [self hideKeyboard];
    
}

- (void)dri_oneClick {

    if (self.Driving_OneBlock) {
        
        self.Driving_OneBlock();
        
    }
    
    [self hideKeyboard];
    
}

- (void)dri_onetothreeClick {
    
    if (self.Driving_OneToThreeBlock) {
        
        self.Driving_OneToThreeBlock();
        
    }
    
    [self hideKeyboard];
    
}

- (void)dri_morethreeClick {
    
    if (self.Driving_MoreThreeBlock) {
        
        self.Driving_MoreThreeBlock();
        
    }
    
    [self hideKeyboard];
    
}

- (void)car_oneClick {
    
    if (self.Car_OneBlock) {
        
        self.Car_OneBlock();
        
    }
    
    [self hideKeyboard];
    
}

- (void)car_onetotwoClick {
    
    if (self.Car_OneToTwoBlock) {
        
        self.Car_OneToTwoBlock();
        
    }
    
    [self hideKeyboard];
    
}

- (void)car_twotosixClick {
    
    if (self.Car_TwoToSixBlock) {
        
        self.Car_TwoToSixBlock();
        
    }
    
    [self hideKeyboard];
    
}

- (void)car_moresixClick {
    
    if (self.Car_MoreSixBlock) {
        
        self.Car_MoreSixBlock();
        
    }
    
    [self hideKeyboard];
    
}

- (void)TypeClick {

    if (self.typeBlock) {
        
        self.typeBlock();
        
    }
    
    [self hideKeyboard];
    
}

//车价代理
- (void)priceChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(PriceFieldChange:)]) {
        
        [self.delegate PriceFieldChange:field];
        
    }
    
}

//保险人代理
- (void)personChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(InsurancePersonFieldChange:)]) {
        
        [self.delegate InsurancePersonFieldChange:field];
        
    }
    
}

//区域代理
- (void)areaChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(DrivingAreaFieldChange:)]) {
        
        [self.delegate DrivingAreaFieldChange:field];
        
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
