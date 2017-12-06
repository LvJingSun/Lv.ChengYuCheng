//
//  IntegrationDetailViewController.m
//  baozhifu
//
//  Created by mac on 13-10-25.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "IntegrationDetailViewController.h"

#import "RTLabel.h"

#import "CommonUtil.h"

@interface IntegrationDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *txt_transactiondate;

@property (weak, nonatomic) IBOutlet UILabel *txt_tradingoperations;

@property (weak, nonatomic) IBOutlet UILabel *txt_status;

@property (weak, nonatomic) IBOutlet UILabel *txt_amount;

@property (weak, nonatomic) IBOutlet RTLabel *txt_description;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_conentView;

@end

@implementation IntegrationDetailViewController

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
    //self.txt_description.editable = YES;
    //[self.txt_description setDelegate:self];
    //[self.navigationController setNavigationBarHidden:NO];
   
    [self setTitle:@"积分详情"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
      
    // 时间
    self.txt_transactiondate.text = [NSString stringWithFormat:@"时间：%@", [self.item objectForKey:@"TransactionDate"]];
   // 操作
   self.txt_tradingoperations.text = [NSString stringWithFormat:@"操作：%@", [[CommonUtil operationsDict] objectForKey:[self.item objectForKey:@"TradingOperations"]]];
    // 类型
    if ([INTEGRATION_INCOME isEqualToString:[self.item objectForKey:@"TradingOperations"]]) {
                         
        self.txt_status.text = [NSString stringWithFormat:@"来源：%@",[self.item objectForKey:@"Source"]];
                  
     }else{
         
         NSString *string = [self.item objectForKey:@"Source"];
         
         if ( string.length == 0 ) {
             
             self.txt_status.text = @"类型：无";
             
         }else{
             
             self.txt_status.text = [NSString stringWithFormat:@"类型：%@",[self.item objectForKey:@"Source"]];
         }
         
         
     
     }
        // 积分金额
    self.txt_amount.text = [NSString stringWithFormat:@"%@", [self.item objectForKey:@"IntegralVal"]];
    // 说明
    self.txt_description.text = [self.item objectForKey:@"Description"];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
//    [super hideTabBar:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return NO;
}

@end
