//
//  Ctrip_chosehotelViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-9-22.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "Ctrip_chosehotelViewController.h"

#import "LeftCell.h"

#import "Ctrip_ChoseRightCell.h"


@interface Ctrip_chosehotelViewController ()

@property(nonatomic,strong) NSMutableArray * Ctrip_LeftArray;

@property(nonatomic,strong) NSMutableArray * Ctrip_RightArray;

@end

@implementation Ctrip_chosehotelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.Ctrip_LeftArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.Ctrip_RightArray = [[NSMutableArray alloc]initWithCapacity:0];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"关键字"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.Ctrip_LeftArray = [NSMutableArray arrayWithObjects:@"特色",@"品牌",@"商业区",@"机场车站",@"行政区",@"地铁线",@"热门地标", nil];
    
    self.Ctrip_RightArray = [NSMutableArray arrayWithObjects:@"客栈",@"青年施舍",@"精品酒店",@"青子出游",@"购物便捷",@"休闲度假",@"游乐园周边", nil];
    

    [self DataToLefttableview];
    [self DataToRighttableview];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)leftClicked{
    
    [self goBack];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self SetLeftTablefram];
    [self SetRightTablefram];
    
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.Ctrip_LeftTableview selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    self.Ctrip_LeftTableview.hidden = YES;
    self.Ctrip_RightTableview.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
    
    self.Ctrip_LeftTableview.hidden = YES;
    self.Ctrip_RightTableview.hidden = YES;
}

-(void)SetLeftTablefram
{
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.Ctrip_LeftTableview.hidden = NO;
        
        CGRect frame=self.Ctrip_LeftTableview.frame;
        
        int fr = self.Ctrip_LeftArray.count*44;
        
        if (fr>WindowSize.size.height) {
            fr = WindowSize.size.height;
        }
        
        frame.size.height = fr;
        [self.Ctrip_LeftTableview setFrame:frame];
        
        
    } completion:^(BOOL finished){
        
    }];
    
}

-(void)SetRightTablefram
{
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.Ctrip_RightTableview.hidden = NO;
        
        CGRect frame=self.Ctrip_RightTableview.frame;
        
        int fr = self.Ctrip_RightArray.count*44;
        if (fr>WindowSize.size.height) {
            fr = WindowSize.size.height;
        }
        frame.size.height = fr;
        [self.Ctrip_RightTableview setFrame:frame];
        
        
    } completion:^(BOOL finished){
        
    }];
    
}

#pragma mark - 产品
//分类一赋值tableview
-(void) DataToLefttableview
{
    
    [self.Ctrip_LeftTableview initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count=self.Ctrip_LeftArray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         LeftCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LeftCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"LeftCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];

            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
         }
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.Ctrip_LeftArray objectAtIndex:indexPath.row]]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         [self.Ctrip_RightTableview reloadData];
         
     }];
    
    [self.Ctrip_LeftTableview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.Ctrip_LeftTableview.layer setBorderWidth:0];
    
}


//分类二赋值tableview
-(void) DataToRighttableview
{
    
    [self.Ctrip_RightTableview initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count=self.Ctrip_RightArray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         Ctrip_ChoseRightCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Ctrip_ChoseRightCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"Ctrip_ChoseRightCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
             
         }
         
         cell.CtripRight.text = [self.Ctrip_RightArray objectAtIndex:indexPath.row];
         
         return cell;
         
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         
         
     }];
    
    [self.Ctrip_RightTableview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.Ctrip_RightTableview.layer setBorderWidth:0];
    
}


@end
