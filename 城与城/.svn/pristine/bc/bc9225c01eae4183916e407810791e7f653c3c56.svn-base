//
//  IncomeoneViewController.m
//  Receive
//
//  Created by 冯海强 on 13-12-31.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "IncomeoneViewController.h"
#import "BasicViewController.h"
#import "SVProgressHUD.h"

@interface IncomeoneViewController ()

@property (nonatomic,weak) IBOutlet UITextView *Textview;//

@property (nonatomic,weak) IBOutlet UIButton *AgreeBtn;
@property (nonatomic,weak) IBOutlet UIButton *NextBtn;


@end

@implementation IncomeoneViewController

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
 
    self.Textview.editable=NO;
    self.NextBtn.enabled=NO;
    self.AgreeBtn.selected=NO;
    
    self.m_incomeView.backgroundColor=[UIColor clearColor];
    
    [self setTitle:@"商户入驻"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self.AgreeBtn addTarget:self action:@selector(SelectAgreeBtn:) forControlEvents:UIControlEventTouchUpInside];

    [self.NextBtn addTarget:self action:@selector(OneNextToTwo:) forControlEvents:UIControlEventTouchUpInside];

        
        if ( !iPhone5 ) {
            
            [self.Textview setFrame:CGRectMake(0,0, WindowSizeWidth,[[UIScreen mainScreen]bounds].size.height-48-80)];
            [self.AgreeBtn setFrame:CGRectMake(20,[[UIScreen mainScreen]bounds].size.height-115, 70, 39)];
            [self.NextBtn setFrame:CGRectMake(WindowSizeWidth - 202,[[UIScreen mainScreen]bounds].size.height-115,105, 39)];
            
        }



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideTabBar:YES];
}

-(IBAction)OneNextToTwo:(id)sender
{
    BasicViewController *BasicVC=[[BasicViewController alloc]initWithNibName:@"BasicViewController" bundle:nil];
    [self.navigationController pushViewController:BasicVC animated:YES];
    
}




-(IBAction)SelectAgreeBtn:(id)sender{
    
    if (self.AgreeBtn.selected)
    {
        self.AgreeBtn.selected=NO;
        self.NextBtn.enabled=NO;
        [self.AgreeBtn setImage:[UIImage imageNamed:@"comm_check_box_def.png"] forState:UIControlStateSelected];
    }
    else{
        self.AgreeBtn.selected=YES;
        self.NextBtn.enabled=YES;
        [self.AgreeBtn setImage:[UIImage imageNamed:@"comm_check_box_selected.png"] forState:UIControlStateSelected];
    }

}

@end
