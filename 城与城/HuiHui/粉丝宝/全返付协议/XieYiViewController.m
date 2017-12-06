//
//  XieYiViewController.m
//  BusinessCenter
//
//  Created by mac on 2016/12/7.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "XieYiViewController.h"

// 屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
// 屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface XieYiViewController ()

@end

@implementation XieYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"协议";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 10, SCREEN_WIDTH * 0.9, SCREEN_HEIGHT - 84)];
    
    textview.text = self.xieyiString;
    
    [self.view addSubview:textview];

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
