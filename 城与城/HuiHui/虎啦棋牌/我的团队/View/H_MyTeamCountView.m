//
//  H_MyTeamCountView.m
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "H_MyTeamCountView.h"

@interface H_MyTeamCountView ()

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *contentLab;

@end

@implementation H_MyTeamCountView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat Width = frame.size.width * 0.8;
        
        CGFloat Height = 20;
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width * 0.1, (frame.size.height - 2 * Height - 10) * 0.5, Width, Height)];
        
        self.titleLab = titleLab;
        
        titleLab.textAlignment = NSTextAlignmentCenter;
        
        titleLab.textColor = [UIColor darkGrayColor];
        
        titleLab.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:titleLab];
        
        UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width * 0.1, CGRectGetMaxY(titleLab.frame) + 10, Width, Height)];
        
        self.contentLab = contentLab;
        
        contentLab.textAlignment = NSTextAlignmentCenter;
        
        contentLab.textColor = [UIColor orangeColor];
        
        contentLab.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:contentLab];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:frame];
        
        [self addSubview:btn];
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title {
    
    _title = title;
    
    self.titleLab.text = title;
    
}

-(void)setContent:(NSString *)content {
    
    _content = content;
    
    self.contentLab.text = content;
    
}

@end
