//
//  New_HL_CountCell.m
//  HuiHui
//
//  Created by mac on 2017/12/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "New_HL_CountCell.h"
#import "New_HL_CountModel.h"
#import "NEW_HL_CountFrame.h"
#import "LJConst.h"

@interface New_HL_CountCell ()

@property (nonatomic, weak) UIButton *countBtn;

@end

@implementation New_HL_CountCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIButton *count = [[UIButton alloc] init];
        
        self.countBtn = count;
        
        [count setBackgroundColor:[UIColor whiteColor]];
        
        [count setTitleColor:[UIColor darkTextColor] forState:0];
        
        count.titleLabel.font = [UIFont systemFontOfSize:16];
        
        count.layer.masksToBounds = YES;
        
        count.layer.cornerRadius = 5;
        
        count.layer.borderWidth = 1;
        
        count.layer.borderColor = [UIColor darkGrayColor].CGColor;
        
        [self addSubview:count];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(NEW_HL_CountFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.countBtn.frame = self.frameModel.countF;
    
}

- (void)setContent {
    
    New_HL_CountModel *model = self.frameModel.model;
    
    [self.countBtn setTitle:model.title forState:0];
    
    if (model.isChoose) {
        
        [self.countBtn setTitleColor:FSB_StyleCOLOR forState:0];
        
        self.countBtn.layer.borderColor = FSB_StyleCOLOR.CGColor;
        
    }else {
        
        [self.countBtn setTitleColor:[UIColor darkTextColor] forState:0];
        
        self.countBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
        
    }
    
    [self.countBtn addTarget:self action:@selector(countClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)countClick {
    
    if (self.countBlock) {
        
        self.countBlock();
        
    }
    
}

- (void)hideKeyboard {
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self hideKeyboard];
    
}

@end
