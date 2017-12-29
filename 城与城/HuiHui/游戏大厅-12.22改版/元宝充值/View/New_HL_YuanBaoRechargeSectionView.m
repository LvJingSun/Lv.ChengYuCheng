//
//  New_HL_YuanBaoRechargeSectionView.m
//  HuiHui
//
//  Created by mac on 2017/12/28.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "New_HL_YuanBaoRechargeSectionView.h"
#import "LJConst.h"

@implementation New_HL_YuanBaoRechargeSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat titleX = _WindowViewWidth * 0.05;
        
        CGFloat titleY = 20;
        
        CGFloat titleW = _WindowViewWidth * 0.9;
        
        CGFloat titleH = 20;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        
        self.titleLab = title;
        
        title.textColor = [UIColor lightGrayColor];
        
        title.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:title];
        
        self.size = CGSizeMake(_WindowViewWidth, CGRectGetMaxY(title.frame));
        
    }
    
    return self;
    
}

@end
