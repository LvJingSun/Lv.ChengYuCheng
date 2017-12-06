//
//  NewYearADView.m
//  HuiHui
//
//  Created by mac on 2017/1/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "NewYearADView.h"

//屏幕宽度
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

//屏幕高度
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@implementation NewYearADView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.8];
        
        UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.1, (SCREENHEIGHT - SCREENWIDTH * 0.8) * 0.5, SCREENWIDTH * 0.8, SCREENWIDTH * 0.8 + 100)];
        
        bgview.backgroundColor = [UIColor whiteColor];
        
        bgview.layer.cornerRadius = 5;
        
        [self addSubview:bgview];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, bgview.frame.size.width - 2, bgview.frame.size.height - 102)];
        
        self.adimageview = imageview;
        
        imageview.layer.masksToBounds = YES;
        
        imageview.layer.cornerRadius = 5;
        
        [bgview addSubview:imageview];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:imageview.frame];
        
        self.clickBtn = btn;
        
        [bgview addSubview:btn];
        
        UILabel *noticeLab = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(imageview.frame) + 5, bgview.frame.size.width - 30, 90)];
        
        noticeLab.numberOfLines = 0;
        
        noticeLab.textColor = [UIColor blackColor];
        
        noticeLab.font = [UIFont systemFontOfSize:17];
        
        self.noticeLab = noticeLab;
        
        [bgview addSubview:noticeLab];
        
        UIButton *noBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.9 - 40, bgview.frame.origin.y - 50, 30, 30)];
        
        self.noButton = noBtn;
        
        [noBtn setImage:[UIImage imageNamed:@"closea.png"] forState:0];
        
        [noBtn addTarget:self action:@selector(noBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:noBtn];
        
    }
    
    return self;
    
}

- (void)noBtnClick {
    
    [self removeFromSuperview];
    
}


@end
