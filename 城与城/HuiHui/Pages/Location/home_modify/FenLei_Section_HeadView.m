//
//  FenLei_Section_HeadView.m
//  HuiHui
//
//  Created by mac on 2017/9/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FenLei_Section_HeadView.h"
#import "RedHorseHeader.h"

@implementation FenLei_Section_HeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.032, 10, 4, 15)];
        
        line.backgroundColor = [UIColor colorWithRed:0/255. green:128/255. blue:222/255. alpha:1.];
        
        [self addSubview:line];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line.frame) + 5, 10, ScreenWidth * 0.5, 15)];
        
        self.title = title;
        
        title.textColor = [UIColor grayColor];
        
        title.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:title];
        
        self.size = CGSizeMake(ScreenWidth, CGRectGetMaxY(title.frame) + 10);
        
    }
    
    return self;
    
}

@end
