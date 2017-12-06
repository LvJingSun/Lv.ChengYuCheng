//
//  T_BtnView.m
//  HuiHui
//
//  Created by mac on 2017/3/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_BtnView.h"

#define TEXTCOLOR [UIColor colorWithRed:102/255.f green:102/255.f blue:102/255.f alpha:1.0]
#define WIDTH ([UIScreen mainScreen].bounds.size.width) * 0.333333333333
@implementation T_BtnView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, WIDTH, 20)];
        
        self.countLab = count;
        
        count.textColor = TEXTCOLOR;
        
        count.textAlignment = NSTextAlignmentCenter;
        
        count.font = [UIFont systemFontOfSize:25];
        
        [self addSubview:count];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(count.frame) + 15, WIDTH, 15)];
        
        self.titleLab = title;
        
        title.textColor = TEXTCOLOR;
        
        title.textAlignment = NSTextAlignmentCenter;
        
        title.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:title];
        
        self.height = CGRectGetMaxY(title.frame) + 10;
        
        UIButton *click = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH * 0.2, self.height * 0.2, WIDTH * 0.6, self.height * 0.6)];
        
        self.clickBtn = click;
        
        [self addSubview:click];
        
    }
    
    return self;
    
}

@end
