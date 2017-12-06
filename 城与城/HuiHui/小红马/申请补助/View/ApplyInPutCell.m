//
//  ApplyInPutCell.m
//  HuiHui
//
//  Created by mac on 2017/6/10.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "ApplyInPutCell.h"
#import "ApplyInPutFrame.h"
#import "ApplySubsidyModel.h"
#import "RedHorseHeader.h"

#import "RH_RadioView.h"

@interface ApplyInPutCell ()

@property (nonatomic, weak) UILabel *typeTitle;

@property (nonatomic, weak) RH_RadioView *youfeiRadio;

//@property (nonatomic, weak) RH_RadioView *baoxianRadio;

@property (nonatomic, weak) RH_RadioView *baoyangRadio;

//@property (nonatomic, weak) RH_RadioView *luntaiRadio;

@property (nonatomic, weak) RH_RadioView *xiuliRadio;

@property (nonatomic, weak) UILabel *line1Lab;

@property (nonatomic, weak) UILabel *countTitle;

@property (nonatomic, weak) UITextField *countField;

@property (nonatomic, weak) UILabel *line2Lab;

@property (nonatomic, weak) UILabel *InvoiceTitleLab;

@property (nonatomic, weak) UIButton *AddInvoiceBtn;

@property (nonatomic, weak) UIView *bgview;

@property (nonatomic, weak) UIButton *SureBtn;

@property (nonatomic, weak) UIView *SureBtnBGView;

@end

@implementation ApplyInPutCell

+ (instancetype)ApplyInPutCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"ApplyInPutCell";
    
    ApplyInPutCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[ApplyInPutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *typetitle = [[UILabel alloc] init];
        
        self.typeTitle = typetitle;
        
        typetitle.font = CarInfo_TitleFont;
        
        typetitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:typetitle];
        
        UILabel *line1 = [[UILabel alloc] init];
        
        self.line1Lab = line1;
        
        line1.backgroundColor = RH_ViewBGColor;
        
        [self addSubview:line1];
        
        UILabel *counttitle = [[UILabel alloc] init];
        
        self.countTitle = counttitle;
        
        counttitle.font = CarInfo_TitleFont;
        
        counttitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:counttitle];
        
        UITextField *count = [[UITextField alloc] init];
        
        self.countField = count;
        
        count.placeholder = @"填写补助金额";
        
        count.textAlignment = NSTextAlignmentRight;
        
        count.keyboardType = UIKeyboardTypeDecimalPad;
        
        [count addTarget:self action:@selector(moneyChange:) forControlEvents:UIControlEventEditingChanged];
        
        count.rightViewMode = UITextFieldViewModeWhileEditing;
        
        [self addSubview:count];
        
        UILabel *line2 = [[UILabel alloc] init];
        
        self.line2Lab = line2;
        
        line2.backgroundColor = RH_ViewBGColor;
        
        [self addSubview:line2];
        
        UIView *viewbg = [[UIView alloc] init];
        
        self.SureBtnBGView = viewbg;
        
        viewbg.backgroundColor = RH_ViewBGColor;
        
        [self addSubview:viewbg];
        
        UIView *bg = [[UIView alloc] init];
        
        self.bgview = bg;
        
        bg.backgroundColor = [UIColor whiteColor];
        
        bg.layer.masksToBounds = YES;
        
        bg.layer.cornerRadius = 3;
        
        [self addSubview:bg];
        
        UILabel *Invoicetitle = [[UILabel alloc] init];
        
        self.InvoiceTitleLab = Invoicetitle;
        
        Invoicetitle.font = CarInfo_TitleFont;
        
        Invoicetitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:Invoicetitle];
        
        UIButton *addInvoiceBtn = [[UIButton alloc] init];
        
        self.AddInvoiceBtn = addInvoiceBtn;
        
        [addInvoiceBtn addTarget:self action:@selector(chooseimgclick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:addInvoiceBtn];
        
        UIButton *sureBtn = [[UIButton alloc] init];
        
        self.SureBtn = sureBtn;
        
        [sureBtn setBackgroundColor:RH_NAVTextColor];
        
        [sureBtn setTitleColor:[UIColor whiteColor] forState:0];
        
        sureBtn.layer.masksToBounds = YES;
        
        sureBtn.layer.cornerRadius = 5;
        
        [sureBtn addTarget:self action:@selector(sureclick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:sureBtn];
        
    }
    
    return self;
    
}

//补助金额代理
- (void)moneyChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(ApplyMoneyFieldChange:)]) {
        
        [self.delegate ApplyMoneyFieldChange:field];
        
    }
    
}

-(void)setFrameModel:(ApplyInPutFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.typeTitle.frame = self.frameModel.typeTitleF;
    
    RH_RadioView *youfeiradio = [[RH_RadioView alloc] initWithFrame:self.frameModel.youfeiF];
    
    self.youfeiRadio = youfeiradio;
    
    [self addSubview:youfeiradio];
    
//    RH_RadioView *baoxianradio = [[RH_RadioView alloc] initWithFrame:self.frameModel.baoxianF];
//    
//    self.baoxianRadio = baoxianradio;
//    
//    [self addSubview:baoxianradio];
    
    RH_RadioView *baoyangradio = [[RH_RadioView alloc] initWithFrame:self.frameModel.baoyangF];
    
    self.baoyangRadio = baoyangradio;
    
    [self addSubview:baoyangradio];
    
//    RH_RadioView *luntairadio = [[RH_RadioView alloc] initWithFrame:self.frameModel.luntaiF];
//    
//    self.luntaiRadio = luntairadio;
//    
//    [self addSubview:luntairadio];
    
    RH_RadioView *xiuliradio = [[RH_RadioView alloc] initWithFrame:self.frameModel.xiuliF];
    
    self.xiuliRadio = xiuliradio;
    
    [self addSubview:xiuliradio];
    
    self.line1Lab.frame = self.frameModel.line1F;
    
    CGSize monetrightsize = [self sizeWithText:@"元" font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(0,self.frameModel.countF.size.height)];
    
    UILabel *moneylab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, monetrightsize.width + 10, self.frameModel.countF.size.height)];
    
    moneylab.text = @"元";
    
    moneylab.font = [UIFont systemFontOfSize:16];
    
    moneylab.textAlignment = NSTextAlignmentRight;
    
    self.countField.rightView = moneylab;
    
    self.countTitle.frame = self.frameModel.countTitleF;
    
    self.countField.frame = self.frameModel.countF;
    
    self.line2Lab.frame = self.frameModel.line2F;
    
    self.InvoiceTitleLab.frame = self.frameModel.InvoiceTitleF;
    
    self.AddInvoiceBtn.frame = self.frameModel.AddInvoiceBtnF;
    
    self.bgview.frame = self.frameModel.InvoiceBGviewF;
    
    self.SureBtnBGView.frame = self.frameModel.SureBtnBGViewF;
    
    self.SureBtn.frame = self.frameModel.SureBtnF;
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

- (void)setContent {

    ApplySubsidyModel *model = self.frameModel.applymodel;
    
    self.typeTitle.text = @"请选择补助项目";
    
    self.youfeiRadio.title.text = @"油费";
    
//    self.baoxianRadio.title.text = @"保险";
    
    self.baoyangRadio.title.text = @"保养";
    
//    self.luntaiRadio.title.text = @"轮胎";
    
    self.xiuliRadio.title.text = @"修理";
    
    [self.youfeiRadio.btn addTarget:self action:@selector(youfeiClick) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.baoxianRadio.btn addTarget:self action:@selector(baoxianClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.baoyangRadio.btn addTarget:self action:@selector(baoyangClick) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.luntaiRadio.btn addTarget:self action:@selector(luntaiClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.xiuliRadio.btn addTarget:self action:@selector(xiuliClick) forControlEvents:UIControlEventTouchUpInside];
    
    if ([model.applyType isEqualToString:@"4"]) {
        
        //选择了油费补助
        
        [self.youfeiRadio.btn setImage:[UIImage imageNamed:@"Administration_default.png"] forState:0];
        
//        [self.baoxianRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.baoyangRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
//        [self.luntaiRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.xiuliRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
    }else if ([model.applyType isEqualToString:@"1"]) {
    
        //选择了保险补助
        
        [self.youfeiRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
//        [self.baoxianRadio.btn setImage:[UIImage imageNamed:@"Administration_default.png"] forState:0];
        
        [self.baoyangRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
//        [self.luntaiRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.xiuliRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
    }else if ([model.applyType isEqualToString:@"2"]) {
        
        //选择了保养补助
        
        [self.youfeiRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
//        [self.baoxianRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.baoyangRadio.btn setImage:[UIImage imageNamed:@"Administration_default.png"] forState:0];
        
//        [self.luntaiRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.xiuliRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
    }else if ([model.applyType isEqualToString:@"5"]) {
        
        //选择了轮胎补助
        
        [self.youfeiRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
//        [self.baoxianRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.baoyangRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
//        [self.luntaiRadio.btn setImage:[UIImage imageNamed:@"Administration_default.png"] forState:0];
        
        [self.xiuliRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
    }else if ([model.applyType isEqualToString:@"3"]) {
        
        //选择了修理补助
        
        [self.youfeiRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
//        [self.baoxianRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.baoyangRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
//        [self.luntaiRadio.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.xiuliRadio.btn setImage:[UIImage imageNamed:@"Administration_default.png"] forState:0];
        
    }
    
    self.countTitle.text = @"金额";
    
    if ([self isNULLString:model.count]) {
        
        self.countField.text = @"";
        
    }else {
        
        self.countField.text = model.count;
        
    }
    
    self.InvoiceTitleLab.text = @"请上传发票";
    
    if (model.InvoiceImg == nil) {
        
        [self.AddInvoiceBtn setImage:[UIImage imageNamed:@"Car_infoAdd.png"] forState:0];
        
    }else {
    
        [self.AddInvoiceBtn setImage:model.InvoiceImg forState:0];
        
    }
    
    [self.SureBtn setTitle:@"确认" forState:0];
    
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

//选择发票点击
- (void)chooseimgclick {

    if (self.ChooseImgBlock) {
        
        self.ChooseImgBlock();
        
    }
    
}

//确认点击
- (void)sureclick {
    
    if (self.SureBlock) {
        
        self.SureBlock();
        
    }
    
}

//油费点击
- (void)youfeiClick {

    if (self.youfeiBlock) {
        
        self.youfeiBlock();
        
    }
    
}

////保险点击
//- (void)baoxianClick {
//    
//    if (self.baoxianBlock) {
//        
//        self.baoxianBlock();
//        
//    }
//    
//}

//保养点击
- (void)baoyangClick {
    
    if (self.baoyangBlock) {
        
        self.baoyangBlock();
        
    }
    
}

////轮胎点击
//- (void)luntaiClick {
//    
//    if (self.luntaiBlock) {
//        
//        self.luntaiBlock();
//        
//    }
//    
//}

//修理点击
- (void)xiuliClick {
    
    if (self.xiuliBlock) {
        
        self.xiuliBlock();
        
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self hideKeyboard];
    
}

- (void)hideKeyboard {
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
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
