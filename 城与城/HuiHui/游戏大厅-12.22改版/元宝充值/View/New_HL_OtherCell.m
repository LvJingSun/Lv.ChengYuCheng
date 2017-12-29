//
//  New_HL_OtherCell.m
//  HuiHui
//
//  Created by mac on 2017/12/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "New_HL_OtherCell.h"
#import "New_HL_OtherModel.h"
#import "New_HL_OtherFrame.h"
#import "LJConst.h"

@interface New_HL_OtherCell ()

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UITextField *countField;

@end

@implementation New_HL_OtherCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *title = [[UILabel alloc] init];
        
        self.titleLab = title;
        
        title.textColor = [UIColor lightGrayColor];
        
        title.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:title];
        
        UITextField *count = [[UITextField alloc] init];
        
        self.countField = count;
        
        count.layer.masksToBounds = YES;
        
        count.layer.borderWidth = 1;
        
        count.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        count.layer.cornerRadius = 5;
        
        count.keyboardType = UIKeyboardTypeDecimalPad;
        
        count.font = [UIFont systemFontOfSize:20];
        
        count.textColor = [UIColor darkTextColor];
        
        count.placeholder = @"输入充值数量";
        
        count.textAlignment = NSTextAlignmentCenter;
        
        [count addTarget:self action:@selector(countChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self addSubview:count];
        
    }
    
    return self;
    
}

- (void)countChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(OtherPriceFieldChange:)]) {
        
        [self.delegate OtherPriceFieldChange:field];
        
    }
    
}

-(void)setFrameModel:(New_HL_OtherFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.titleLab.frame = self.frameModel.titleF;
    
    self.countField.frame = self.frameModel.countF;
    
}

- (void)setContent {
    
    New_HL_OtherModel *model = self.frameModel.model;
    
    self.titleLab.text = @"输入数量";
    
    if (![self isBlankString:model.count]) {
        
        self.countField.text = model.count;
        
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

- (void)hideKeyboard {
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self hideKeyboard];
    
}

@end
