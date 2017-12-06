//
//  TicketsViewController.m
//  HuiHui
//
//  Created by mac on 15-1-13.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "TicketsViewController.h"

#import "SceneryListViewController.h"

@interface TicketsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *m_textField;

// 搜索按钮触发的事件
- (IBAction)searchClicked:(id)sender;

@end

@implementation TicketsViewController

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
    
    [self setTitle:@"景点门票"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

- (IBAction)searchClicked:(id)sender {
    // 进入搜索后的景点列表
    SceneryListViewController *VC = [[SceneryListViewController alloc]initWithNibName:@"SceneryListViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
   
    [textField resignFirstResponder];
    
    [self searchClicked:nil];
    
    return YES;
}

@end
