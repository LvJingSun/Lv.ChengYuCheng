//
//  GameRechargeCell.m
//  HuiHui
//
//  Created by mac on 2017/10/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameRechargeCell.h"
#import "RedHorseHeader.h"
#import "LJConst.h"
#import "GameRechargeModel.h"
#import "GameRechargeFrame.h"
#import "RH_RadioView.h"

@interface GameRechargeCell ()

@property (nonatomic, weak) UILabel *nickLab;

@property (nonatomic, weak) UIButton *qipaiNoticeBtn;

@property (nonatomic, weak) RH_RadioView *YB_View;

@property (nonatomic, weak) RH_RadioView *FK_View;

@property (nonatomic, weak) UITextField *countField;

@property (nonatomic, weak) UIButton *sureBtn;

@property (nonatomic, weak) UILabel *noticeLab;

@end

@implementation GameRechargeCell

+ (instancetype)GameRechargeCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"GameRechargeCell";
    
    GameRechargeCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[GameRechargeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = RH_ViewBGColor;
        
        UITextField *qipaiID = [[UITextField alloc] init];
        
        self.qipaiIDField = qipaiID;
        
        qipaiID.backgroundColor = [UIColor whiteColor];
        
        qipaiID.font = [UIFont systemFontOfSize:20];
        
        qipaiID.keyboardType = UIKeyboardTypeDecimalPad;
        
        [qipaiID addTarget:self action:@selector(IDChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self addSubview:qipaiID];
        
        UILabel *nick = [[UILabel alloc] init];
        
        self.nickLab = nick;
        
        nick.textColor = FSB_StyleCOLOR;
        
        nick.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:nick];
        
        UIButton *IDbtn = [[UIButton alloc] init];
        
        self.qipaiNoticeBtn = IDbtn;
        
        [IDbtn setTitle:@"虎啦棋牌ID获取???" forState:0];
        
        [IDbtn addTarget:self action:@selector(noticeClick) forControlEvents:UIControlEventTouchUpInside];
        
        [IDbtn setTitleColor:FSB_StyleCOLOR forState:0];
        
        IDbtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:IDbtn];
        
        UITextField *field = [[UITextField alloc] init];
        
        self.countField = field;
        
        field.backgroundColor = [UIColor whiteColor];
        
        field.font = [UIFont systemFontOfSize:20];
        
        field.keyboardType = UIKeyboardTypeDecimalPad;
        
        [field addTarget:self action:@selector(countChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self addSubview:field];
        
        UIButton *sure = [[UIButton alloc] init];
        
        self.sureBtn = sure;
        
        sure.layer.masksToBounds = YES;
        
        sure.layer.cornerRadius = 3;
        
        [sure addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:sure];
        
        UILabel *notice = [[UILabel alloc] init];
        
        self.noticeLab = notice;
        
        notice.textColor = [UIColor colorWithRed:150/255. green:150/255. blue:150/255. alpha:1.];
        
        notice.font = [UIFont systemFontOfSize:13];
        
        notice.numberOfLines = 0;
        
        [self addSubview:notice];
        
    }
    
    return self;
    
}

- (void)noticeClick {
    
    if (self.noticeBlock) {
        
        self.noticeBlock();
        
    }
    
}

-(void)setFrameModel:(GameRechargeFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.qipaiIDField.frame = self.frameModel.qipaiIDF;
    
    UILabel *IDtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth * 0.35, self.frameModel.qipaiIDF.size.height)];
    
    IDtitle.text = @"输入棋牌ID";
    
    IDtitle.textAlignment = NSTextAlignmentCenter;
    
    IDtitle.font = [UIFont systemFontOfSize:18];
    
    IDtitle.textColor = [UIColor darkTextColor];
    
    self.qipaiIDField.leftViewMode = UITextFieldViewModeAlways;
    
    self.qipaiIDField.leftView = IDtitle;
    
    self.nickLab.frame = self.frameModel.qipaiNickF;
    
    self.qipaiNoticeBtn.frame = self.frameModel.qipaiNoticeF;
    
    RH_RadioView *ybview = [[RH_RadioView alloc] initWithFrame:self.frameModel.YBF];
    
    self.YB_View = ybview;
    
    [self addSubview:ybview];
    
    RH_RadioView *fkview = [[RH_RadioView alloc] initWithFrame:self.frameModel.FKF];
    
    self.FK_View = fkview;
    
    [self addSubview:fkview];
    
    self.countField.frame = self.frameModel.countF;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth * 0.35, self.frameModel.countF.size.height)];
    
    if ([self.frameModel.tranmodel.viewType isEqualToString:@"3"]) {
        
        if ([self.frameModel.tranmodel.rechargeType isEqualToString:@"1"]) {
            
            title.text = @"赠送元宝:";
            
        }else if ([self.frameModel.tranmodel.rechargeType isEqualToString:@"2"]) {
            
            title.text = @"赠送房卡:";
            
        }
        
    }else {
        
        if ([self.frameModel.tranmodel.rechargeType isEqualToString:@"1"]) {
            
            title.text = @"充值元宝:";
            
        }else if ([self.frameModel.tranmodel.rechargeType isEqualToString:@"2"]) {
            
            title.text = @"充值房卡:";
            
        }
        
    }
    
    title.textAlignment = NSTextAlignmentCenter;
    
    title.font = [UIFont systemFontOfSize:18];
    
    title.textColor = [UIColor darkTextColor];
    
    self.countField.leftViewMode = UITextFieldViewModeAlways;
    
    self.countField.leftView = title;
    
    self.sureBtn.frame = self.frameModel.sureF;
    
    self.noticeLab.frame = self.frameModel.noticeF;
    
}

- (void)setContent {
    
    GameRechargeModel *model = self.frameModel.tranmodel;
    
    if ([self isNULLString:model.qipaiID]) {
        
        self.qipaiIDField.text = @"";
        
    }else {
        
        self.qipaiIDField.text = model.qipaiID;
        
    }
    
    if ([model.viewType isEqualToString:@"1"]) {
        
        self.qipaiIDField.userInteractionEnabled = NO;
        
    }else {
        
        self.qipaiIDField.userInteractionEnabled = YES;
        
    }
    
    if (![self isNULLString:model.qipaiNick]) {
        
        self.nickLab.text = model.qipaiNick;
        
    }
    
    self.YB_View.title.text = @"元宝";
    
    self.FK_View.title.text = @"房卡";
    
    if ([model.rechargeType isEqualToString:@"1"]) {
        
        [self.YB_View.btn setImage:[UIImage imageNamed:@"checkblueyes.png"] forState:0];
        
        [self.FK_View.btn setImage:[UIImage imageNamed:@"checkblueno.png"] forState:0];
        
    }else if ([model.rechargeType isEqualToString:@"2"]) {
        
        [self.YB_View.btn setImage:[UIImage imageNamed:@"checkblueno.png"] forState:0];
        
        [self.FK_View.btn setImage:[UIImage imageNamed:@"checkblueyes.png"] forState:0];
        
    }
    
    [self.YB_View.btn addTarget:self action:@selector(ybClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.FK_View.btn addTarget:self action:@selector(fkClick) forControlEvents:UIControlEventTouchUpInside];
    
    if (![self isNULLString:model.xiane]) {
        
        self.countField.placeholder = [NSString stringWithFormat:@"本次最多可充值%.2f元",[model.xiane floatValue]];
        
    }
    
    if ([self isNULLString:model.count]) {
        
        self.countField.text = @"";
        
    }else {
        
        self.countField.text = model.count;
        
    }
    
    self.noticeLab.text = model.notice;
    
    [self.sureBtn setBackgroundColor:FSB_StyleCOLOR];
    
    if ([model.viewType isEqualToString:@"3"]) {
        
        [self.sureBtn setTitle:@"确认赠送" forState:0];
        
    }else {
        
        [self.sureBtn setTitle:@"确认充值" forState:0];
        
    }
    
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:0];
    
}

- (void)ybClick {
    
    if (self.ybBlock) {
        
        self.ybBlock();
        
    }
    
}

- (void)fkClick {
    
    if (self.fkBlock) {
        
        self.fkBlock();
        
    }
    
}

- (void)sureClick {
    
    if (self.sureBlock) {
        
        self.sureBlock();
        
    }
    
    [self hideKeyboard];
    
}

- (void)IDChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(IDFieldChange:)]) {
        
        [self.delegate IDFieldChange:field];
        
    }
    
}

- (void)countChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(CountFieldChange:)]) {
        
        [self.delegate CountFieldChange:field];
        
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self hideKeyboard];
    
}

- (void)hideKeyboard {
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
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
