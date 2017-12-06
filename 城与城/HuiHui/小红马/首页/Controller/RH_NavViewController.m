//
//  RH_NavViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_NavViewController.h"
#import "RedHorseHeader.h"

@interface RH_NavViewController ()

@end

@implementation RH_NavViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //设置导航栏背景色
    self.navigationBar.barTintColor = [UIColor whiteColor];
    
    //取消导航栏透明层
    [self.navigationBar setTranslucent:NO];

    //    //设置字体颜色
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:RH_NAVFont,NSForegroundColorAttributeName:RH_NAVTextColor}];
    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
//    
//    self.navigationBar.tintColor = RH_NAVTextColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
