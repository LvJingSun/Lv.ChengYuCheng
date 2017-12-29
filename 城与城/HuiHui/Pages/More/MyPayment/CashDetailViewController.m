//
//  CashDetailViewController.m
//  baozhifu
//
//  Created by mac on 14-3-31.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CashDetailViewController.h"

#import "RTLabel.h"

@interface CashDetailViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UILabel *m_typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_bankNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_statusLable;

@property (weak, nonatomic) IBOutlet UILabel *m_countLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_failLabel;

@end

@implementation CashDetailViewController

@synthesize m_items;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_items = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"提现记录详情"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
   

    
//    // 赋值
    self.m_countLabel.text = [NSString stringWithFormat:@"%.2f",[[self.m_items objectForKey:@"Amount"] floatValue]];
//
    self.m_timeLabel.text = [NSString stringWithFormat:@"提现时间：%@",[self.m_items objectForKey:@"CreateDate"]];
//
    self.m_typeLabel.text = [NSString stringWithFormat:@"银行卡类型：%@",[self.m_items objectForKey:@"BankName"]];
//
    self.m_bankNumLabel.text = [NSString stringWithFormat:@"银行卡卡号：%@",[self.m_items objectForKey:@"AccountNo"]];
//
//    // 提现失败原因
     self.m_failLabel.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Descript"]];
//
//
    // 根据状态来判断如何显示
    if ( [[self.m_items objectForKey:@"Status"] isEqualToString:@"HasCompleted"] ) {

        self.m_statusLable.text = [NSString stringWithFormat:@"已完成"];

        self.m_statusLable.textColor = [UIColor colorWithRed:51/255.0 green:152/255.0 blue:24/255.0 alpha:1.0];

    }else if ( [[self.m_items objectForKey:@"Status"] isEqualToString:@"Pending"] ){

        self.m_statusLable.text = [NSString stringWithFormat:@"处理中"];

        self.m_statusLable.textColor = [UIColor colorWithRed:252/255.0 green:14/255.0 blue:44/255.0 alpha:1.0];

    }else if ( [[self.m_items objectForKey:@"Status"] isEqualToString:@"HasRefused"] ){

        self.m_statusLable.text = [NSString stringWithFormat:@"失败"];

        self.m_statusLable.textColor = [UIColor colorWithRed:252/255.0 green:14/255.0 blue:44/255.0 alpha:1.0];

    }else{

        self.m_statusLable.text = [NSString stringWithFormat:@"处理中"];

        self.m_statusLable.textColor = [UIColor colorWithRed:252/255.0 green:14/255.0 blue:44/255.0 alpha:1.0];
    }

    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
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

@end
