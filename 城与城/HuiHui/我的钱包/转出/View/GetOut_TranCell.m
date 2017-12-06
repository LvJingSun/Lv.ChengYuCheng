//
//  GetOut_TranCell.m
//  HuiHui
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GetOut_TranCell.h"
#import "RedHorseHeader.h"
#import "GetOut_TranModel.h"
#import "GetOut_TranFrame.h"
#import "LJConst.h"

@interface GetOut_TranCell ()

@property (nonatomic, weak) UITextField *countField;

@property (nonatomic, weak) UILabel *noticeLab;

@end

@implementation GetOut_TranCell

+ (instancetype)GetOut_TranCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"GetOut_TranCell";
    
    GetOut_TranCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[GetOut_TranCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = RH_ViewBGColor;
        
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

-(void)setFrameModel:(GetOut_TranFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.countField.frame = self.frameModel.countF;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth * 0.2, self.frameModel.countF.size.height)];
    
    title.text = @"金额";
    
    title.textAlignment = NSTextAlignmentCenter;
    
    title.font = [UIFont systemFontOfSize:18];
    
    title.textColor = [UIColor darkTextColor];
    
    self.countField.leftViewMode = UITextFieldViewModeAlways;
    
    self.countField.leftView = title;
    
    self.sureBtn.frame = self.frameModel.sureF;
    
    self.noticeLab.frame = self.frameModel.noticeF;
    
}

- (void)setContent {
    
    GetOut_TranModel *model = self.frameModel.tranmodel;
    
    if (![self isNULLString:model.xiane]) {
        
        self.countField.placeholder = [NSString stringWithFormat:@"本次最多可转出%.2f元",[model.xiane floatValue]];
        
    }
    
    if ([self isNULLString:model.count]) {
                                                
        self.countField.text = @"";
        
    }else {
    
        self.countField.text = model.count;
        
    }
    
    self.noticeLab.text = model.notice;
    
    [self.sureBtn setBackgroundColor:FSB_StyleCOLOR];
    
    [self.sureBtn setTitle:@"确认转出" forState:0];
    
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:0];

}

- (void)sureClick {

    if (self.sureBlock) {
        
        self.sureBlock();
        
    }
    
    [self hideKeyboard];
    
}

//行驶里程代理
- (void)countChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(CountFieldChange:)]) {
        
        [self.delegate CountFieldChange:field];
        
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
