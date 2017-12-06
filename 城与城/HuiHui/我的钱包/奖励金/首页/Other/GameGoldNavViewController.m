//
//  GameGoldNavViewController.m
//  HuiHui
//
//  Created by mac on 2017/8/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameGoldNavViewController.h"
#import "GameGoldHeader.h"

@interface GameGoldNavViewController ()

@end

@implementation GameGoldNavViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //设置导航栏背景色
    self.navigationBar.barTintColor = [UIColor whiteColor];
    
    //取消导航栏透明层
    [self.navigationBar setTranslucent:NO];
    
    //    //设置字体颜色
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:RH_NAVFont,NSForegroundColorAttributeName:RH_NAVTextColor}];
    
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
