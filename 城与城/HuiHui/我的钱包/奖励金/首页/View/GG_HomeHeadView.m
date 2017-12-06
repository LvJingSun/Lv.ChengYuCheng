//
//  GG_HomeHeadView.m
//  HuiHui
//
//  Created by mac on 2017/8/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GG_HomeHeadView.h"
#import "GameGoldHeader.h"

@interface GG_HomeHeadView ()

@end

@implementation GG_HomeHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = home_tabBG;
        
        UILabel *zuori = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.1, 15, ScreenWidth * 0.8, 20)];
        
        zuori.text = @"昨日收益";
        
        zuori.textColor = [UIColor whiteColor];
        
        zuori.font = [UIFont systemFontOfSize:16];
        
        zuori.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:zuori];
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.1, CGRectGetMaxY(zuori.frame) + 15, ScreenWidth * 0.8, 40)];
        
        self.shouyiLab = count;
        
        count.textAlignment = NSTextAlignmentCenter;
        
        count.textColor = [UIColor whiteColor];
        
        count.font = [UIFont systemFontOfSize:40];
        
        count.text = @"0.00";
        
        [self addSubview:count];
        
//        UILabel *allcount = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.1, CGRectGetMaxY(count.frame) + 15, ScreenWidth * 0.8, 20)];
//        
//        self.AllshouyiLab = allcount;
//        
//        allcount.text = @"累计收益0.00元";
//        
//        allcount.textColor = [UIColor whiteColor];
//        
//        allcount.font = [UIFont systemFontOfSize:17];
//        
//        allcount.textAlignment = NSTextAlignmentCenter;
//        
//        [self addSubview:allcount];
        
        UILabel *zhiliangtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(count.frame) + 30, (ScreenWidth - 1) * 0.5, 20)];
        
        zhiliangtitle.textAlignment = NSTextAlignmentCenter;
        
        zhiliangtitle.textColor = [UIColor whiteColor];
        
        zhiliangtitle.font = [UIFont systemFontOfSize:17];
        
        zhiliangtitle.text = @"持有黄金(克)";
        
        [self addSubview:zhiliangtitle];
        
        UILabel *zhiliang = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(zhiliangtitle.frame) + 10, (ScreenWidth - 1) * 0.5, 20)];
        
        self.zhongliangLab = zhiliang;
        
        zhiliang.textColor = [UIColor whiteColor];
        
        zhiliang.textAlignment = NSTextAlignmentCenter;
        
        zhiliang.font = [UIFont systemFontOfSize:18];
        
        zhiliang.text = @"0.0000克";
        
        [self addSubview:zhiliang];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(zhiliangtitle.frame), CGRectGetMaxY(count.frame) + 30, 1, CGRectGetMaxY(zhiliang.frame) - CGRectGetMaxY(count.frame) - 30)];
        
        line.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:line];
        
        UILabel *jinetitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line.frame), CGRectGetMaxY(count.frame) + 30, (ScreenWidth - 1) * 0.5, 20)];
        
        jinetitle.textAlignment = NSTextAlignmentCenter;
        
        jinetitle.textColor = [UIColor whiteColor];
        
        jinetitle.font = [UIFont systemFontOfSize:17];
        
        jinetitle.text = @"总金额(元)";
        
        [self addSubview:jinetitle];
        
        UILabel *jine = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line.frame), CGRectGetMaxY(jinetitle.frame) + 10, (ScreenWidth - 1) * 0.5, 20)];
        
        self.jineLab = jine;
        
        jine.textColor = [UIColor whiteColor];
        
        jine.textAlignment = NSTextAlignmentCenter;
        
        jine.font = [UIFont systemFontOfSize:18];
        
        jine.text = @"0.00元";
        
        [self addSubview:jine];
        
        self.height = CGRectGetMaxY(jine.frame) + 15;
        
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(count.frame) + 13, ScreenWidth, self.height - CGRectGetMaxY(count.frame) - 13)];
        
        bg.backgroundColor = [UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:0.1];
        
        [self addSubview:bg];
        
    }
    
    return self;
    
}

@end
