//
//  RH_AddBtnView.m
//  HuiHui
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_AddBtnView.h"
#import "RedHorseHeader.h"

@implementation RH_AddBtnView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = RH_ViewBGColor;
        
        UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width * 0.1, 10, frame.size.width * 0.8, 45)];
        
        [addBtn setTitle:@"添加车辆" forState:0];
        
        [addBtn addTarget:self action:@selector(AddClick) forControlEvents:UIControlEventTouchUpInside];
        
        [addBtn setTitleColor:[UIColor whiteColor] forState:0];
        
        addBtn.backgroundColor = RH_NAVTextColor;
        
        addBtn.layer.masksToBounds = YES;
        
        addBtn.layer.cornerRadius = 5;
        
        [self addSubview:addBtn];
        
    }
    
    return self;
    
}

- (void)AddClick {

    if (self.AddBlock) {
        
        self.AddBlock();
        
    }
    
}

@end
