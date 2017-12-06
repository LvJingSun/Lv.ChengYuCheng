//
//  Home_FenLeiCell.m
//  HuiHui
//
//  Created by mac on 2017/9/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Home_FenLeiCell.h"
#import "Home_FenLeiModel.h"
#import "Home_FenLeiFrame.h"
#import "RedHorseHeader.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface Home_FenLeiCell ()

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *titleLab;

@end

@implementation Home_FenLeiCell

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImg = icon;
        
        [self addSubview:icon];
        
        UILabel *lab = [[UILabel alloc] init];
        
        self.titleLab = lab;
        
        lab.textColor = [UIColor darkTextColor];
        
        lab.textAlignment = NSTextAlignmentCenter;
        
        lab.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:lab];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(Home_FenLeiFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.iconImg.frame = self.frameModel.iconF;
    
    self.titleLab.frame = self.frameModel.titleF;
    
}

- (void)setContent {
    
    Home_FenLeiModel *model = self.frameModel.fenleiModel;

    [self.iconImg setImageWithURL:[NSURL URLWithString:model.PhotoUrl] placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
    
    self.titleLab.text = model.Title;
    
}

@end
