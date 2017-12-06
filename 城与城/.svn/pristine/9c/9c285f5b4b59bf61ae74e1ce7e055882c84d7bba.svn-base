//
//  IntegralViewController.m
//  HuiHuiApp
//
//  Created by mac on 13-10-15.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "IntegralViewController.h"

@interface IntegralViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *m_backImageV;


@end

@implementation IntegralViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"积分"];
    
    [self setLeftButtonWithNormalImage:@"back.png" action:@selector(LeftClicked)];
    
    // 设置view的圆角
    self.m_backImageV.layer.cornerRadius = 10.0f;
    self.m_backImageV.layer.borderWidth = 1.0f;
    
    self.m_backImageV.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
   
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
  
    // 隐藏tabBar
    [self hideTabBar:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
//    [self hideTabBar:NO];

}


- (void)LeftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BtnClicked
- (IBAction)putInTree:(id)sender {
    
    [self alertWithMessage:@"放回树上"];
    
}

- (IBAction)putInBox:(id)sender {
    
    [self alertWithMessage:@"放入百宝箱"];

}

@end
