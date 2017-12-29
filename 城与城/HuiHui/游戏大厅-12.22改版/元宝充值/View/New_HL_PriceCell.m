//
//  New_HL_PriceCell.m
//  HuiHui
//
//  Created by mac on 2017/12/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "New_HL_PriceCell.h"
#import "New_HL_PriceModel.h"
#import "New_HL_PriceFrame.h"
#import "LJConst.h"

@interface New_HL_PriceCell ()

@property (nonatomic, weak) UILabel *lineLab;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *priceLab;

@property (nonatomic, weak) UILabel *danweiLab;

@property (nonatomic, weak) UIButton *rechargeBtn;

@end

@implementation New_HL_PriceCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line];
        
        UILabel *title = [[UILabel alloc] init];
        
        self.titleLab = title;
        
        title.font = [UIFont systemFontOfSize:17];
        
        title.textColor = [UIColor darkTextColor];
        
        [self addSubview:title];
        
        UILabel *price = [[UILabel alloc] init];
        
        self.priceLab = price;
        
        price.font = [UIFont systemFontOfSize:18];
        
        price.textColor = [UIColor redColor];
        
        [self addSubview:price];
        
        UILabel *danwei = [[UILabel alloc] init];
        
        self.danweiLab = danwei;
        
        danwei.font = [UIFont systemFontOfSize:14];
        
        danwei.textColor = [UIColor darkGrayColor];
        
        [self addSubview:danwei];
        
        UIButton *sure = [[UIButton alloc] init];
        
        self.rechargeBtn = sure;
        
        sure.layer.masksToBounds = YES;
        
        sure.layer.cornerRadius = 5;
        
        [sure setBackgroundColor:FSB_StyleCOLOR];
        
        [sure setTitleColor:[UIColor whiteColor] forState:0];
        
        sure.titleLabel.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:sure];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(New_HL_PriceFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    [self.frameModel getCellSize];
    
    self.lineLab.frame = self.frameModel.lineF;
    
    self.titleLab.frame = self.frameModel.titleF;
    
    self.priceLab.frame = self.frameModel.priceF;
    
    self.danweiLab.frame = self.frameModel.danweiF;
    
    self.rechargeBtn.frame = self.frameModel.rechargeF;
    
}

- (void)setContent {
    
    New_HL_PriceModel *model = self.frameModel.model;
    
    self.titleLab.text = @"优惠价：";
    
    self.danweiLab.text = @"游戏币";
    
    if ([self isBlankString:model.price]) {
        
        self.priceLab.text = @"0";
        
    }else {
        
        self.priceLab.text = model.price;
        
    }
    
    [self.rechargeBtn setTitle:@"立即充值" forState:0];
    
    [self.rechargeBtn addTarget:self action:@selector(rechargeClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)rechargeClick {
    
    if (self.rechargeBlock) {
        
        self.rechargeBlock();
        
    }
    
    [self hideKeyboard];
    
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
