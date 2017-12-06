//
//  hh_tianchengViewController.m
//  HuiHui
//
//  Created by mac on 15-1-21.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "hh_tianchengViewController.h"

@interface hh_tianchengViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *m_imageV;

@end

@implementation hh_tianchengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"天城"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    
    NSArray *Animation = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"loading_image_01.png"],[UIImage imageNamed:@"loading_image_02.png"],nil];
    self.m_imageV.animationImages = Animation;
    self.m_imageV.animationDuration = 0.2;
//    self.m_imageV.animationRepeatCount = 2;
    [self.m_imageV startAnimating];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.m_imageV stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    [self goBack];
}

@end
