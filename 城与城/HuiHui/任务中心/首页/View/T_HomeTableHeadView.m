//
//  T_HomeTableHeadView.m
//  HuiHui
//
//  Created by mac on 2017/3/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_HomeTableHeadView.h"
#import "T_BtnView.h"

#define T_HeadBGCOLOR [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0]
#define TEXTBGCOLOR [UIColor colorWithRed:255/255. green:200/255. blue:32/255. alpha:1.]
#define T_HANGCOLOR [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.]

// 屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// 屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define WIDTH ([UIScreen mainScreen].bounds.size.width)

@implementation T_HomeTableHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = T_HeadBGCOLOR;
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * 0.05, WIDTH * 0.05, 70, 70)];
        
        self.iconImageview = icon;
        
        icon.layer.masksToBounds = YES;
        
        icon.layer.cornerRadius = 35;
        
        icon.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:icon];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + 10, icon.center.y - 15, WIDTH * 0.65 - CGRectGetMaxX(icon.frame) - 10, 30)];
        
        self.nameLab = name;
        
        name.textColor = [UIColor whiteColor];
        
        name.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:name];
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH * 0.65, name.frame.origin.y, WIDTH * 0.4, name.frame.size.height)];
        
        self.countLab = count;
        
        count.textColor = [UIColor whiteColor];
        
        count.font = [UIFont systemFontOfSize:15];
        
        count.backgroundColor = TEXTBGCOLOR;
        
        count.layer.masksToBounds = YES;
        
        count.layer.cornerRadius = 15;
        
        [self addSubview:count];
        
        T_BtnView *dfb = [[T_BtnView alloc] init];
        
        self.DFB_Btn = dfb;
        
        dfb.countLab.text = @"0";
        
        dfb.titleLab.text = @"待发布金额";
        
        dfb.frame = CGRectMake(0, CGRectGetMaxY(icon.frame) + WIDTH * 0.05, WIDTH * 0.333333333, dfb.height);
        
        [self addSubview:dfb];
        
        T_BtnView *my = [[T_BtnView alloc] init];
        
        self.MY_Btn = my;
        
        my.countLab.text = @"0";
        
        my.titleLab.text = @"我的任务";
        
        my.frame = CGRectMake(CGRectGetMaxX(dfb.frame), CGRectGetMaxY(icon.frame) + WIDTH * 0.05, WIDTH * 0.333333333, dfb.height);
        
        [self addSubview:my];
        
        T_BtnView *friend = [[T_BtnView alloc] init];
        
        self.FRIEND_Btn = friend;
        
        friend.countLab.text = @"0";
        
        friend.titleLab.text = @"好友任务";
        
        friend.frame = CGRectMake(CGRectGetMaxX(my.frame), CGRectGetMaxY(icon.frame) + WIDTH * 0.05, WIDTH * 0.333333333, dfb.height);
        
        [self addSubview:friend];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(friend.frame), WIDTH, 10)];
        
        line.backgroundColor = T_HANGCOLOR;
        
        [self addSubview:line];
        
        self.height = CGRectGetMaxY(line.frame);
        
    }
    
    return self;
    
}

@end
