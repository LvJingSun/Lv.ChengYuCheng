//
//  MR_NavTitleView.m
//  HuiHui
//
//  Created by mac on 2017/10/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "MR_NavTitleView.h"
#import "LJConst.h"

@implementation MR_NavTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = FSB_StyleCOLOR;
        
        CGSize size = self.bounds.size;
        
        CGSize titlesize = [self sizeWithText:@"商户红包" font:FSB_NAVFont maxSize:CGSizeMake(0,0)];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake((size.width - 18 - 10 - titlesize.width) * 0.5, 0, titlesize.width, size.height)];
        
        titleLab.textAlignment = NSTextAlignmentRight;
        
        titleLab.font = FSB_NAVFont;
        
        titleLab.textColor = FSB_NAVTextColor;
        
        titleLab.text = @"商户红包";
        
        [self addSubview:titleLab];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLab.frame) + 10, 6, 18, 18)];
        
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [button setTitle:@"?" forState:0];
        
        [button setTitleColor:[UIColor whiteColor] forState:0];
        
        button.layer.masksToBounds = YES;
        
        button.layer.cornerRadius = button.frame.size.width * 0.5;
        
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        
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
