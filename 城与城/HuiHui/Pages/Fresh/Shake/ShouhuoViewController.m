//
//  ShouhuoViewController.m
//  HuiHuiApp
//
//  Created by mac on 13-10-16.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "ShouhuoViewController.h"

#import "ShouhuoCell.h"

#import <QuartzCore/QuartzCore.h>

@interface ShouhuoViewController ()

@end

@implementation ShouhuoViewController

@synthesize m_iconImg;

@synthesize m_selectString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.m_selectString = @"0";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"收获"];
    
    // 设置导航栏的左按钮
    [self setLeftButtonWithNormalImage:@"back.png" action:@selector(leftClicked)];
    
    // 设置导航栏的右按钮
    // 设置导航栏的左按钮
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 8, 58, 29)];
    imgV.image = [UIImage imageNamed:@"timg1.png"];
    
    imgV.backgroundColor = [UIColor clearColor];
    
//    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(60, 12, 20, 20)];
//    
//    icon.backgroundColor = [UIColor magentaColor];
    
    self.m_iconImg = imgV;
    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(26, 12, 30, 20)];
//    label.text = @"时间";
//    label.font = [UIFont systemFontOfSize:12.0f];
//    label.backgroundColor = [UIColor clearColor];
//    label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
//        
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, 80, 44);
//    btn.backgroundColor = [UIColor clearColor];
//    [btn addTarget:self action:@selector(rightCLicked) forControlEvents:UIControlEventTouchUpInside];
//    
//    [view addSubview:imgV];
//    
//    [view addSubview:label];
//        
//    [view addSubview:btn];
//    
//    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:view];
//    [self.navigationItem setRightBarButtonItem:_barButton];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
//    [self hideTabBar:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

//- (void)rightCLicked{
//    
//    // 判断选择的是升序还是降序
//    if ( [self.m_selectString isEqualToString:@"0"] ) {
//        // 升序
//        self.m_selectString = @"1";
//        
//        self.m_iconImg.image = [UIImage imageNamed:@"time2.png"];
//        
////        self.m_iconImg.backgroundColor = [UIColor blueColor];
//        
//    }else if ( [self.m_selectString isEqualToString:@"1"] ){
//        
//        // 降序
//        self.m_selectString = @"0";
//        
////        self.m_iconImg.backgroundColor = [UIColor greenColor];
//        
//        self.m_iconImg.image = [UIImage imageNamed:@"time3.png"];
//
//    }
//}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ShouhuoCellIdentifier";
    
    ShouhuoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ){
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShouhuoCell" owner:self options:nil];
        
        cell = (ShouhuoCell *)[nib objectAtIndex:0];
        
        
        // 设置cell的点击状态
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // 赋值
    
    
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90.0f;
}


@end
