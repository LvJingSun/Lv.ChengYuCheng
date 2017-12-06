//
//  TiXingView.m
//  HuiHui
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "TiXingView.h"
//屏幕宽度
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

//屏幕高度
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@implementation TiXingView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.8];
        
        UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.1, SCREENHEIGHT * 0.2, SCREENWIDTH * 0.8, SCREENHEIGHT * 0.7)];
        
        bgview.backgroundColor = [UIColor whiteColor];
        
        bgview.layer.cornerRadius = 5;
        
        [self addSubview:bgview];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake((bgview.frame.size.width - 40) * 0.5, 20, 40, 40)];
        
        self.iconImg = imageview;
        
        [bgview addSubview:imageview];
        
        UIButton *noBtn = [[UIButton alloc] initWithFrame:CGRectMake(bgview.frame.size.width - 30, 10, 20, 20)];
        
        [noBtn setImage:[UIImage imageNamed:@"closea.png"] forState:0];
        
        self.backBtn = noBtn;
        
        noBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        
        [noBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        noBtn.layer.cornerRadius = 10;
        
        noBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        noBtn.layer.borderWidth = 0.8;
        
        [noBtn addTarget:self action:@selector(noBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [bgview addSubview:noBtn];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(bgview.frame.size.width * 0.1, bgview.frame.size.height - 51, bgview.frame.size.width * 0.8, 1)];
        
        line.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:245/255. alpha:1.];
        
        [bgview addSubview:line];
        
        UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(imageview.frame) + 10, bgview.frame.size.width - 10, line.frame.origin.y - CGRectGetMaxY(imageview.frame) - 10)];
        
        self.textview = textview;
        
        [bgview addSubview:textview];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(line.frame.origin.x, CGRectGetMaxY(line.frame), line.frame.size.width, 50)];
        
        [btn setTitle:@"我确认同意" forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor colorWithRed:255/255. green:98/255. blue:16/255. alpha:1.] forState:UIControlStateNormal];
        
        self.sureBtn = btn;
        
        [btn addTarget:self action:@selector(dismissClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [bgview addSubview:btn];
        
    }
    
    return self;
    
}

- (void)noBtnClick {

    [self removeFromSuperview];
    
}

- (void)dismissClicked {

    [self removeFromSuperview];
    
}

@end
