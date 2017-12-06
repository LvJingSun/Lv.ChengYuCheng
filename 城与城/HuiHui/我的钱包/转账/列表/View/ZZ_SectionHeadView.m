//
//  ZZ_SectionHeadView.m
//  HuiHui
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "ZZ_SectionHeadView.h"
#import "RedHorseHeader.h"

@interface ZZ_SectionHeadView ()

@property (nonatomic, weak) UILabel *titleLab;

@end

@implementation ZZ_SectionHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:249/255. alpha:1];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.05, 5, ScreenWidth * 0.9, 20)];
        
        self.titleLab = lab;
        
        lab.font = [UIFont systemFontOfSize:15];
        
        lab.textColor = [UIColor colorWithRed:112/255. green:109/255. blue:110/255. alpha:1];
        
        [self addSubview:lab];
        
        self.height = CGRectGetMaxY(lab.frame) + 5;
        
    }
    
    return self;
    
}

-(void)setTitleName:(NSString *)titleName {

    _titleName = titleName;
    
    self.titleLab.text = titleName;
    
}

@end
