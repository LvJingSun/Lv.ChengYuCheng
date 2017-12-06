//
//  FSB_BasicViewController.m
//  HuiHui
//
//  Created by mac on 2017/5/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_BasicViewController.h"
#import "LJConst.h"

@interface FSB_BasicViewController ()

@end

@implementation FSB_BasicViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = FSB_ViewBGCOLOR;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    //    取消导航栏底部分割线
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:FSB_NAVFont,NSForegroundColorAttributeName:FSB_NAVTextColor}];

}

- (UIBarButtonItem *)SetNavigationBarRightImage:(NSString *)aImageName andaction:(SEL)Saction{
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [addButton setFrame:CGRectMake(0, 0, 20, 20)];
    
    addButton.backgroundColor = [UIColor clearColor];
    
    [addButton setImage:[UIImage imageNamed:aImageName] forState:UIControlStateNormal];
    
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    return _addFriendItem;
    
}

- (UIBarButtonItem *)SetNavigationBarRightTitle:(NSString *)title andaction:(SEL)Saction{
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [addButton setFrame:CGRectMake(0, 0, 40, 40)];
    
    addButton.backgroundColor = [UIColor clearColor];
    
    [addButton setTitle:title forState:UIControlStateNormal];
    
    [addButton setTitleColor:[UIColor whiteColor] forState:0];
    
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    return _addFriendItem;
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
