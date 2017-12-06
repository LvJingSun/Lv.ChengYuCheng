//
//  PaymentDetailViewController.m
//  baozhifu
//
//  Created by mac on 13-6-15.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "PaymentDetailViewController.h"
#import "RootViewController.h"
#import "RTLabel.h"
#import "CommonUtil.h"

@interface PaymentDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *txt_transactionnumber;

@property (weak, nonatomic) IBOutlet UILabel *txt_transactiondate;

@property (weak, nonatomic) IBOutlet UILabel *txt_tradingoperations;

@property (weak, nonatomic) IBOutlet UILabel *txt_transactiontype;

@property (weak, nonatomic) IBOutlet UILabel *txt_status;

@property (weak, nonatomic) IBOutlet UILabel *txt_amount;

@property (weak, nonatomic) IBOutlet RTLabel *txt_description;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_conentView;

@end

@implementation PaymentDetailViewController

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
    
    [self setTitle:@"交易详情"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.txt_transactionnumber.text = [NSString stringWithFormat:@"编号：%@", [self.item objectForKey:@"transactionNumber"]];
    self.txt_transactiondate.text = [NSString stringWithFormat:@"时间：%@", [self.item objectForKey:@"transactionDate"]];
    self.txt_tradingoperations.text = [NSString stringWithFormat:@"操作：%@", [[CommonUtil operationsDict] objectForKey:[self.item objectForKey:@"tradingOperations"]]];

    NSString *type = [self.item objectForKey:@"transactionType"];

    if ( type.length == 0 ) {

        self.txt_transactiontype.text = @"类型：无";

    }else{

        self.txt_transactiontype.text = [NSString stringWithFormat:@"类型：%@", [self.item objectForKey:@"transactionType"]];
    }

    if ( [[self.item objectForKey:@"status"] isEqualToString:@"HasCompleted"] ) {

        self.txt_status.text = @"状态：已完成";

    }else if ( [[self.item objectForKey:@"status"] isEqualToString:@"Pending"] ){

        self.txt_status.text = @"状态：处理中";

    }else{

        self.txt_status.text = @"状态：失败";
    }

    self.txt_amount.text = [NSString stringWithFormat:@"%.4f", [[self.item objectForKey:@"amount"] floatValue]];

    self.txt_description.text = [NSString stringWithFormat:@"%@",[self.item objectForKey:@"description"]];

}

- (void)viewWillAppear:(BOOL)animated{
  
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];

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
