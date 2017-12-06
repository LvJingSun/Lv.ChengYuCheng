//
//  AddSuccessViewController.m
//  HuiHui
//
//  Created by mac on 16/10/18.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "AddSuccessViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface AddSuccessViewController ()

@end

@implementation AddSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarStyle];
    
    self.title = @"添加银行卡";
    
    self.view.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:249/255. alpha:1.];
    
    [self setViewStyle];
    
}

- (void)setNavBarStyle {
    
    UIView *vs = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
    
    vs.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:vs];
    
    UIButton *right = [[UIButton alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
    
    [right setTitle:@"确定" forState:0];
    
    [right setTitleColor:[UIColor whiteColor] forState:0];
    
    [right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    UIColor *color = [UIColor whiteColor];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
}

- (void)rightClick {

    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    
}

- (void)setViewStyle {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 185)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake((view.frame.size.width - 70) * 0.5, 30, 70, 70)];
    
    imageview.image = [UIImage imageNamed:@"icon-zaixian-jy@2x.png"];
    
    [view addSubview:imageview];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageview.frame) + 10, WIDTH, 40)];
    
    label.text = @"添加成功";
    
    label.textColor = [UIColor colorWithRed:15/255. green:143/255. blue:234/255. alpha:1.];
    
    label.font = [UIFont systemFontOfSize:22];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:label];
    
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
