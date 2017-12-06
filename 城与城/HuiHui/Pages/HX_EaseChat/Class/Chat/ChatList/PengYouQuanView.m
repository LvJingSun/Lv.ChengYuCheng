//
//  PengYouQuanView.m
//  HuiHui
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "PengYouQuanView.h"

// 屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// 屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation PengYouQuanView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 15, 40, 40)];
        
        imageview.image = [UIImage imageNamed:@"f1.png"];
        
        [self addSubview:imageview];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageview.frame) + 15, 15, SCREEN_WIDTH * 0.9 - 55, 40)];
        
        lab.text = @"朋友圈";
        
        lab.font = [UIFont systemFontOfSize:18];
        
        [self addSubview:lab];
        
        self.height = CGRectGetMaxY(imageview.frame) + 15;
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height - 0.5, SCREEN_WIDTH, 0.5)];
        
        line.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:line];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height)];
        
        self.button = button;
        
        [self addSubview:button];
        
    }
    
    return self;
    
}

@end
