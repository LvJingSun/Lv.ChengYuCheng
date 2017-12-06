//
//  GameGoldBasicViewController.m
//  HuiHui
//
//  Created by mac on 2017/8/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameGoldBasicViewController.h"
#import "GameGoldHeader.h"

@interface GameGoldBasicViewController ()

@end

@implementation GameGoldBasicViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = RH_ViewBGColor;
    
    [self.navigationItem setHidesBackButton:YES];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

- (UIBarButtonItem *)SetNavigationBarRightTitle:(NSString *)title andaction:(SEL)Saction{
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [addButton setFrame:CGRectMake(0, 0, 60, 40)];
    
    addButton.backgroundColor = [UIColor clearColor];
    
    [addButton setTitle:title forState:UIControlStateNormal];
    
    [addButton setTitleColor:RH_NAVBtnTextColor forState:0];
    
    addButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    return _addFriendItem;
    
}

- (UIBarButtonItem *)SetNavigationBarImage:(NSString *)aImageName andaction:(SEL)Saction{
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [addButton setFrame:CGRectMake(0, 0, 22, 22)];
    
    addButton.backgroundColor = [UIColor clearColor];
    
    [addButton setImage:[UIImage imageNamed:aImageName] forState:UIControlStateNormal];
    
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    
    addButton.layer.masksToBounds = YES;
    
    addButton.layer.cornerRadius = addButton.frame.size.width * 0.5;
    
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    return _addFriendItem;
    
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
