//
//  RH_TitleView.m
//  HuiHui
//
//  Created by mac on 2017/8/9.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_TitleView.h"
#import "RedHorseHeader.h"

@implementation RH_TitleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGSize size = self.bounds.size;
        
        CGSize titlesize = [self sizeWithText:@"养车宝" font:RH_NAVFont maxSize:CGSizeMake(0,0)];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake((size.width - 18 - 10 - titlesize.width) * 0.5, 0, titlesize.width, size.height)];
        
        titleLab.textAlignment = NSTextAlignmentRight;
        
        titleLab.font = RH_NAVFont;
        
        titleLab.textColor = RH_NAVTextColor;
        
        titleLab.text = @"养车宝";
        
        [self addSubview:titleLab];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLab.frame) + 10, 6, 18, 18)];
        
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [button setTitle:@"?" forState:0];
        
        [button setTitleColor:RH_NAVTextColor forState:0];
        
        button.layer.masksToBounds = YES;
        
        button.layer.cornerRadius = button.frame.size.width * 0.5;
        
        button.layer.borderColor = RH_NAVTextColor.CGColor;
        
        button.layer.borderWidth = 1;
        
        [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
    }
    
    return self;
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

- (void)btnClick {
    
    if (self.titleBlock) {
        
        self.titleBlock();
        
    }
    
}

@end
