//
//  I_SuccessViewController.m
//  HuiHui
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "I_SuccessViewController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface I_SuccessViewController ()

@end

@implementation I_SuccessViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"邀请好友";
    
    [self setViewStyle];
    
    self.navigationItem.rightBarButtonItem = [self SetNavigationBarRightTitle:@"确定" andaction:@selector(sureBtnClick)];
    
}

- (void)setViewStyle {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 185)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake((view.frame.size.width - 70) * 0.5, 30, 70, 70)];
    
    imageview.image = [UIImage imageNamed:@"icon-zaixian-jy@2x.png"];
    
    [view addSubview:imageview];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageview.frame) + 10, WIDTH, 40)];
    
    label.text = @"邀请已发送成功";
    
    label.textColor = [UIColor colorWithRed:15/255. green:143/255. blue:234/255. alpha:1.];
    
    label.font = [UIFont systemFontOfSize:22];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:label];
    
}

- (void)sureBtnClick {

    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
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
