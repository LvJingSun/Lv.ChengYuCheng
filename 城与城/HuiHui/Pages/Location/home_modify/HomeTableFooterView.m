//
//  HomeTableFooterView.m
//  HuiHui
//
//  Created by mac on 2017/9/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HomeTableFooterView.h"
#import "RedHorseHeader.h"

@implementation HomeTableFooterView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:245/255. alpha:1.];

        CGSize size = [self sizeWithText:@"我是有底线的" font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(0, 0)];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth - size.width) * 0.5, 20, size.width, size.height)];
        
        lab.text = @"我是有底线的";
        
        lab.textColor = [UIColor darkGrayColor];
        
        lab.textAlignment = NSTextAlignmentCenter;
        
        lab.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:lab];
        
        self.height = CGRectGetMaxY(lab.frame) + 20;
        
        UILabel *left = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.05, (self.height - 0.5) * 0.5, (ScreenWidth - size.width) * 0.5 - ScreenWidth * 0.1, 0.5)];
        
        left.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:left];
        
        UILabel *right = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame) + ScreenWidth * 0.05, (self.height - 0.5) * 0.5, (ScreenWidth - size.width) * 0.5 - ScreenWidth * 0.1, 0.5)];
        
        right.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:right];
        
    }
    
    return self;
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
