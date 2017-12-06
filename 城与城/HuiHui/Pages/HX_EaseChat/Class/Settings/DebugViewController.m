//
//  DebugViewController.m
//  ChatDemo-UI2.0
//
//  Created by dhcdht on 14-8-19.
//  Copyright (c) 2014年 dhcdht. All rights reserved.
//
//easepushview hidetab

#import "DebugViewController.h"

@interface DebugViewController ()

@end

@implementation DebugViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"诊断"];
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    UITextAttributeTextColor: [UIColor whiteColor],
                                                                    UITextAttributeFont : [UIFont boldSystemFontOfSize:20]};
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [backButton setImage:[UIImage imageNamed:@"arrow_WL.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
//    footerView.backgroundColor = [UIColor clearColor];
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 0, footerView.frame.size.width - 10, 0.5)];
//        line.backgroundColor = [UIColor lightGrayColor];
//        [footerView addSubview:line];
//    }
    
//    UIButton *uploadLogButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 20, footerView.frame.size.width - 80, 40)];
//    [uploadLogButton setBackgroundColor:[UIColor colorWithRed:87 / 255.0 green:186 / 255.0 blue:205 / 255.0 alpha:1.0]];
//    [uploadLogButton setTitle:@"上传运行日志" forState:UIControlStateNormal];
//    [uploadLogButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [uploadLogButton addTarget:self action:@selector(uploadLogAction) forControlEvents:UIControlEventTouchUpInside];
//    [footerView addSubview:uploadLogButton];
//    self.tableView.tableFooterView = footerView;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hideTabBar:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self hideTabBar:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"SDK 版本";
        NSString *ver = [[EaseMob sharedInstance] sdkVersion];
        cell.detailTextLabel.text = ver;
    }
    
    return cell;
}

#pragma mark - action

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)uploadLogAction
//{
//    __weak typeof(self) weakSelf = self;
//    [self showHudInView:self.view hint:@"正在上传"];
//    [[EaseMob sharedInstance] asyncUploadLogToServerWithCompletion:^(EMError *error) {
//        [weakSelf hideHud];
//        if (error) {
//            [weakSelf showHint:error.description];
//        }
//        else{
//            [weakSelf showHint:@"上传成功"];
//        }
//    }];
//}

- (void) hideTabBar:(BOOL) hidden{
//    if ( isIOS7 ) {
//        [self.tabBarController.tabBar setHidden:hidden];
//        for(UIView *view in self.tabBarController.view.subviews)
//        {
//            CGSize m_size = self.tabBarController.view.frame.size;
//            if([view isKindOfClass:[UITabBar class]])
//            {
//                if (self.tabBarController.tabBar.hidden) {
//                    [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, view.frame.size.height)];
//                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width,m_size.height + 49);
//                } else {
//                    [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height-49, view.frame.size.width, view.frame.size.height)];
//                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width, m_size.height+ 49);
//                }
//            }
//            else
//            {
//                if (self.tabBarController.tabBar.hidden) {
//                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height)];
//                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width, m_size.height + 49);
//                } else {
//                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height-98)];
//                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width, m_size.height + 49);
//                }
//            }
//        }
//        
//    }else{
//        
//        if ( [self.tabBarController.view.subviews count] < 2 )
//        {
//            return;
//        }
//        UIView *contentView;
//        
//        if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ){
//            contentView = [self.tabBarController.view.subviews objectAtIndex:1];
//        }
//        else{
//            contentView = [self.tabBarController.view.subviews objectAtIndex:0];
//        }
//        if ( hidden ){
//            contentView.frame = self.tabBarController.view.bounds;
//        }
//        else
//        {
//            contentView.frame = CGRectMake(self.tabBarController.view.bounds.origin.x,
//                                           self.tabBarController.view.bounds.origin.y,
//                                           self.tabBarController.view.bounds.size.width,
//                                           self.tabBarController.view.bounds.size.height - self.tabBarController.tabBar.frame.size.height + 49);
//        }
//        self.tabBarController.tabBar.hidden = hidden;
//    }
}

@end
