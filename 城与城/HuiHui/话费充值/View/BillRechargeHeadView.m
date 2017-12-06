//
//  BillRechargeHeadView.m
//  HuiHui
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "BillRechargeHeadView.h"
#import "LJConst.h"

@implementation BillRechargeHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(_WindowViewWidth * 0.05, 10, _WindowViewWidth * 0.9, 40)];
        
        self.phoneFiled = field;
        
        field.placeholder = @"请输入手机号码";
        
        field.font = RechargePhoneFont;
        
        field.textColor = RechargePhoneCOLOR;
        
        field.keyboardType = UIKeyboardTypePhonePad;
        
        [self addSubview:field];
        
        UILabel *location = [[UILabel alloc] initWithFrame:CGRectMake(_WindowViewWidth * 0.05, CGRectGetMaxY(field.frame) + 5, _WindowViewWidth * 0.9, 10)];
        
        self.locationLab = location;
        
        location.textColor = [UIColor lightGrayColor];
        
        location.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:location];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(location.frame) + 5, _WindowViewWidth, 1)];
        
        line.backgroundColor = FSB_LineCOLOR;
        
        [self addSubview:line];
        
        UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(_WindowViewWidth * 0.05, CGRectGetMaxY(line.frame) + 15, _WindowViewWidth * 0.9, 20)];
        
        desc.text = @"充话费";
        
        desc.textColor = [UIColor darkTextColor];
        
        desc.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:desc];
        
        CGFloat margin = 10;
        
        CGFloat btnW = (_WindowViewWidth * 0.9 - 2 * margin) * 0.33333;
        
        CGFloat btnH = 60;
        
        UIButton *btn50 = [[UIButton alloc] initWithFrame:CGRectMake(_WindowViewWidth * 0.05, CGRectGetMaxY(desc.frame) + 15, btnW, btnH)];
        
        self.btn50 = btn50;
        
        btn50.layer.masksToBounds = YES;
        
        btn50.layer.borderWidth = 1;
        
        btn50.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        btn50.layer.cornerRadius = 3;
        
        btn50.userInteractionEnabled = NO;
        
        [btn50 setTitle:@"50元" forState:0];
        
        [btn50 setTitleColor:[UIColor darkGrayColor] forState:0];
        
        [self addSubview:btn50];
        
        self.height = CGRectGetMaxY(btn50.frame) + 15;
        
        UIButton *btn100 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn50.frame) + margin, CGRectGetMaxY(desc.frame) + 15, btnW, btnH)];
        
        self.btn100 = btn100;
        
        btn100.layer.masksToBounds = YES;
        
        btn100.layer.borderWidth = 1;
        
        btn100.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        btn100.layer.cornerRadius = 3;
        
        btn100.userInteractionEnabled = NO;
        
        [btn100 setTitle:@"100元" forState:0];
        
        [btn100 setTitleColor:[UIColor darkGrayColor] forState:0];
        
        [self addSubview:btn100];
        
        UIButton *btn300 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn100.frame) + margin, CGRectGetMaxY(desc.frame) + 15, btnW, btnH)];
        
        self.btn300 = btn300;
        
        btn300.layer.masksToBounds = YES;
        
        btn300.layer.borderWidth = 1;
        
        btn300.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        btn300.layer.cornerRadius = 3;
        
        btn300.userInteractionEnabled = NO;
        
        [btn300 setTitle:@"300元" forState:0];
        
        [btn300 setTitleColor:[UIColor darkGrayColor] forState:0];
        
        [self addSubview:btn300];
        
    }
    
    return self;
    
}

@end
