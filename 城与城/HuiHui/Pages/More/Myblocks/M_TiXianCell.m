//
//  M_TiXianCell.m
//  HuiHui
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "M_TiXianCell.h"
#import "LJConst.h"
#import "M_TiXianModel.h"
#import "M_TiXianFrame.h"

@interface M_TiXianCell ()

@property (nonatomic, weak) UILabel *balanceLab;

@property (nonatomic, weak) UILabel *jifenLab;

@property (nonatomic, weak) UITextField *countField;

@property (nonatomic, weak) UILabel *noticeLab;

@property (nonatomic, weak) UIButton *sureBtn;

@end

@implementation M_TiXianCell

+ (instancetype)M_TiXianCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"M_TiXianCell";
    
    M_TiXianCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[M_TiXianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        
        UILabel *balance = [[UILabel alloc] init];
        
        self.balanceLab = balance;
        
        balance.textColor = [UIColor blackColor];
        
        balance.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:balance];
        
        UILabel *jifen = [[UILabel alloc] init];
        
        self.jifenLab = jifen;
        
        jifen.textColor = [UIColor redColor];
        
        jifen.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:jifen];
        
        UITextField *count = [[UITextField alloc] init];
        
        self.countField = count;
        
        count.backgroundColor = [UIColor whiteColor];
        
        count.font = [UIFont systemFontOfSize:16];
        
        count.keyboardType = UIKeyboardTypeDecimalPad;
        
        [count addTarget:self action:@selector(countChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self addSubview:count];
        
        UILabel *notice = [[UILabel alloc] init];
        
        self.noticeLab = notice;
        
        notice.textColor = [UIColor darkGrayColor];
        
        notice.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:notice];
        
        UILabel *need = [[UILabel alloc] init];
        
        self.needLab = need;
        
        need.textColor = [UIColor redColor];
        
        need.font = [UIFont systemFontOfSize:14];
        
        need.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:need];
        
        UIButton *sureBtn = [[UIButton alloc] init];
        
        self.sureBtn = sureBtn;
        
        sureBtn.layer.masksToBounds = YES;
        
        sureBtn.layer.cornerRadius = 3;
        
        [sureBtn setTitleColor:[UIColor whiteColor] forState:0];
        
        [sureBtn setBackgroundColor:FSB_StyleCOLOR];
        
        [sureBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:sureBtn];
        
    }
    
    return self;
    
}

- (void)btnClick {
    
    if (self.sureBlock) {
        
        self.sureBlock();
        
    }
    
    if ([self.countField isFirstResponder]) {
        
        [self.countField resignFirstResponder];
        
    }
    
}

-(void)setFrameModel:(M_TiXianFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.balanceLab.frame = self.frameModel.balanceF;
    
    self.jifenLab.frame = self.frameModel.jifenF;
    
    self.countField.frame = self.frameModel.countF;
    
    self.countField.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, self.frameModel.countF.size.height)];
    
    lab.text = @"金额";
    
    lab.textColor = [UIColor darkTextColor];
    
    lab.font = [UIFont systemFontOfSize:17];
    
    lab.textAlignment = NSTextAlignmentCenter;
    
    self.countField.leftView = lab;
    
    self.noticeLab.frame = self.frameModel.noticeF;
    
    self.needLab.frame = self.frameModel.needF;
    
    self.sureBtn.frame = self.frameModel.sureF;
    
}

- (void)setContent {
    
    M_TiXianModel *model = self.frameModel.tixianModel;
    
    if ([self isBlankString:model.balance]) {
        
        self.balanceLab.text = @"会员卡余额：0.00";
        
    }else {
        
        self.balanceLab.text = [NSString stringWithFormat:@"会员卡余额：%@",model.balance];
        
    }
    
    if ([self isBlankString:model.jifen]) {
        
        self.jifenLab.text = @"账户积分：0";
        
    }else {
        
        self.jifenLab.text = [NSString stringWithFormat:@"账户积分：%@",model.jifen];
        
    }
    
    if ([self isBlankString:model.count]) {
        
        self.countField.text = @"";
        
    }else {
        
        self.countField.text = [NSString stringWithFormat:@"%@",model.count];
        
    }
    
    self.countField.placeholder = [NSString stringWithFormat:@"本次最多转出%@",model.balance];
    
    if ([self isBlankString:model.notice]) {
        
        self.noticeLab.text = @"";
        
    }else {
        
        self.noticeLab.text = model.notice;
        
    }
    
    if ([self isBlankString:model.needJiFen]) {
        
        self.needLab.text = @"";
        
    }else {
        
        self.needLab.text = [NSString stringWithFormat:@"扣除%@积分",model.needJiFen];
        
    }
    
    [self.sureBtn setTitle:@"确认转账" forState:0];
    
}

- (void)countChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(CountFieldChange:)]) {
        
        [self.delegate CountFieldChange:field];
        
    }
    
}

- (BOOL)isBlankString:(NSString *)string {
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
    
    if ([self.countField isFirstResponder]) {
        
        [self.countField resignFirstResponder];
        
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
