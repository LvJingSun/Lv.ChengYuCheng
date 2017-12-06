//
//  OilHeadView.m
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "OilHeadView.h"
#import "RedHorseHeader.h"

@implementation OilHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        
        line.backgroundColor = RH_ViewBGColor;
        
        [self addSubview:line];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.05, CGRectGetMaxY(line.frame) + 10, 50, 50)];
        
        self.iconImg = icon;
        
        [self addSubview:icon];
        
        UILabel *bottom = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(icon.frame) + 10, ScreenWidth, 10)];
        
        bottom.backgroundColor = RH_ViewBGColor;
        
        [self addSubview:bottom];
        
        self.height = CGRectGetMaxY(bottom.frame);
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + 15, CGRectGetMaxY(line.frame) + 10 + (icon.frame.size.height - 30) * 0.5, ScreenWidth * 0.95 - 30 - CGRectGetMaxX(icon.frame) - 15, 30)];
        
        self.carModel = title;
        
        title.font = [UIFont systemFontOfSize:18];
        
        title.textColor = [UIColor colorWithRed:20/255. green:20/255. blue:20/255. alpha:1.];
        
        [self addSubview:title];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(title.frame), CGRectGetMaxY(line.frame) + 10 + (icon.frame.size.height - 30) * 0.5, 30, 30)];
        
        self.switchBtn = btn;
        
        [btn setImage:[UIImage imageNamed:@"Oil_refresh.png"] forState:0];
        
        [btn addTarget:self action:@selector(switchClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
    }
    
    return self;
    
}

- (void)switchClick {

    if (self.switchBlock) {
        
        self.switchBlock();
        
    }
    
}

- (void)hideKeyboard {
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self hideKeyboard];
    
}

@end
