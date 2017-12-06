//
//  Gold_OutCell.m
//  HuiHui
//
//  Created by mac on 2017/9/19.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Gold_OutCell.h"
#import "Gold_OutModel.h"
#import "Gold_OutFrame.h"
#import "GameGoldHeader.h"

@interface Gold_OutCell ()

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *qualityLab;

@property (nonatomic, weak) UIButton *lookBtn;

@property (nonatomic, weak) UITextField *countField;

@property (nonatomic, weak) UIButton *sureBtn;

@end

@implementation Gold_OutCell

+ (instancetype)Gold_OutCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"Gold_OutCell";
    
    Gold_OutCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[Gold_OutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = RH_ViewBGColor;
        
        UILabel *title = [[UILabel alloc] init];
        
        self.titleLab = title;
        
        title.font = [UIFont systemFontOfSize:19];
        
        title.textColor = [UIColor colorWithRed:20/255. green:20/255. blue:20/255. alpha:1.];
        
        title.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:title];
        
        UILabel *quality = [[UILabel alloc] init];
        
        self.qualityLab = quality;
        
        quality.textAlignment = NSTextAlignmentCenter;
        
        quality.font = [UIFont systemFontOfSize:45];
        
        quality.textColor = RH_NAVBtnTextColor;
        
        [self addSubview:quality];
        
        UIButton *look = [[UIButton alloc] init];
        
        self.lookBtn = look;
        
        look.layer.masksToBounds = YES;
        
        [look setTitleColor:RH_NAVBtnTextColor forState:0];
        
        look.layer.borderColor = RH_NAVBtnTextColor.CGColor;
        
        look.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [look addTarget:self action:@selector(lookClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:look];
        
        UITextField *field = [[UITextField alloc] init];
        
        self.countField = field;
        
        field.backgroundColor = [UIColor whiteColor];
        
        field.font = [UIFont systemFontOfSize:19];
        
        field.keyboardType = UIKeyboardTypeDecimalPad;
        
        [field addTarget:self action:@selector(countChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self addSubview:field];
        
        UILabel *money = [[UILabel alloc] init];
        
        self.moneyLab = money;
        
        money.font = [UIFont systemFontOfSize:16];
        
        money.textAlignment = NSTextAlignmentRight;
        
        money.textColor = RH_NAVBtnTextColor;
        
        [self addSubview:money];
        
        UIButton *sure = [[UIButton alloc] init];
        
        self.sureBtn = sure;
        
        [sure setTitleColor:[UIColor whiteColor] forState:0];
        
        [sure setBackgroundColor:RH_NAVBtnTextColor];
        
        sure.layer.masksToBounds = YES;
        
        sure.layer.cornerRadius = 4;
        
        [sure addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:sure];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(Gold_OutFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.titleLab.frame = self.frameModel.titleF;
    
    self.qualityLab.frame = self.frameModel.qualityF;
    
    self.lookBtn.frame = self.frameModel.lookF;
    
    self.lookBtn.layer.cornerRadius = self.frameModel.lookF.size.height * 0.5;
    
    self.lookBtn.layer.borderWidth = 1;
    
    self.countField.frame = self.frameModel.countF;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth * 0.3, self.frameModel.countF.size.height)];
    
    title.text = @"黄金克数";
    
    title.textAlignment = NSTextAlignmentCenter;
    
    title.font = [UIFont systemFontOfSize:18];
    
    title.textColor = [UIColor darkTextColor];
    
    self.countField.leftViewMode = UITextFieldViewModeAlways;
    
    self.countField.leftView = title;
    
    self.moneyLab.frame = self.frameModel.moneyF;
    
    self.sureBtn.frame = self.frameModel.sureF;
    
}

- (void)setContent {

    Gold_OutModel *model = self.frameModel.outModel;
    
    self.titleLab.text = @"账户黄金";
    
    self.qualityLab.text = [NSString stringWithFormat:@"%@毫克",model.allQuality];
    
    [self.lookBtn setTitle:@"查看当前金价" forState:0];
    
    self.countField.placeholder = [NSString stringWithFormat:@"本次最多可卖出%@毫克",model.allQuality];
    
    if ([self isNULLString:model.outQuality]) {
        
        self.countField.text = @"";
        
    }else {
        
        self.countField.text = model.outQuality;
        
    }
    
    self.moneyLab.text = [NSString stringWithFormat:@"折合共%.2f元",[model.outQuality floatValue] * 0.001 * [model.goldPrice floatValue]];
    
    [self.sureBtn setTitle:@"确认卖出" forState:0];
    
}

//行驶里程代理
- (void)countChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(CountFieldChange:)]) {
        
        [self.delegate CountFieldChange:field];
        
    }
    
}

- (void)lookClick {

    if (self.lookBlock) {
        
        self.lookBlock();
        
    }
    
}

- (void)sureClick {
    
    if (self.sureBlock) {
        
        self.sureBlock();
        
    }
    
    [self hideKeyboard];
    
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
