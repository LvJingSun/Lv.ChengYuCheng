//
//  CPSHH_TakeOrderViewController.m
//  HuiHui
//
//  Created by fenghq on 15/9/22.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "CPSHH_TakeOrderViewController.h"
#import "CPSevaluationViewController.h"
#import "CPSmerchantsViewController.h"
#import "HH_TakeOrderViewController.h"

@interface CPSHH_TakeOrderViewController ()

@end

@implementation CPSHH_TakeOrderViewController

//重载init方法
- (instancetype)init
{
    if (self = [super initWithTagViewHeight:40])
    {
        self.m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"点单"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    //设置自定义属性
    self.tagItemSize = CGSizeMake(WindowSizeWidth/3, 40);
    //    self.selectedIndicatorSize = CGSizeMake(50, 10);
    self.selectedTitleColor = RGBACKTAB;
    self.selectedIndicatorColor = RGBACKTAB;
    self.selectedTitleFont = [UIFont systemFontOfSize:16];
    
    //    self.graceTime = 15;
    //    self.gapAnimated = YES;
    
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    NSArray *titleArray = @[
                            @"菜单",
                            @"评价",
                            @"商户",
                            ];
    
    NSArray *classNames = @[
                            [HH_TakeOrderViewController class],
                            [CPSevaluationViewController class],
                            [CPSmerchantsViewController class],
                            ];
    
    NSArray *params = @[
                        self.m_dic,
                        self.m_dic,
                        self.m_dic,
                        ];
    
    [self reloadDataWith:titleArray andSubViewdisplayClasses:classNames withParams:params];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
    
}

@end
