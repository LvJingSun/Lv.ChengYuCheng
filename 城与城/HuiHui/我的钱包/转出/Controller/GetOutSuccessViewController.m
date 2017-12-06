//
//  GetOutSuccessViewController.m
//  HuiHui
//
//  Created by mac on 2017/9/13.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GetOutSuccessViewController.h"
#import "RedHorseHeader.h"
#import "LJConst.h"

@interface GetOutSuccessViewController ()

@end

@implementation GetOutSuccessViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = FSB_StyleCOLOR;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:FSB_NAVFont,NSForegroundColorAttributeName:FSB_NAVTextColor}];
    
    self.title = @"转出结果";
    
    UIView *vs = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
    
    vs.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:vs];
    
    [self setRightButtonWithTitle:@"确定" action:@selector(sureClick)];
    
    [self setViewStyle];
    
}

- (void)setRightButtonWithTitle:(NSString *)aTitle action:(SEL)action{
    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0, 0, 60, 29)];
    _button.backgroundColor = [UIColor clearColor];
    _button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_button setTitle:aTitle forState:UIControlStateNormal];
    [_button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
    [self.navigationItem setRightBarButtonItem:_barButton];
}

- (void)sureClick {

    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    
}

- (void)setViewStyle {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 185)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake((view.frame.size.width - 70) * 0.5, 30, 70, 70)];
    
    imageview.image = [UIImage imageNamed:@"icon-zaixian-jy@2x.png"];
    
    [view addSubview:imageview];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageview.frame) + 10, ScreenWidth, 40)];
    
    label.text = @"提交成功";
    
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
