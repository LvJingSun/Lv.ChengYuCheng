//
//  DowncellViewController.m
//  Receive
//
//  Created by 冯海强 on 13-12-27.
//  Copyright (c) 2013年 冯海强. All rights reserved.


#import "DowncellViewController.h"
#import "DetailViewController.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "BusinesserlistViewController.h"

@interface DowncellViewController ()

@property (weak, nonatomic) IBOutlet UIButton *RemindBusBtn;
@property (weak, nonatomic) IBOutlet UILabel *RemindProLab;

@end

@implementation DowncellViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dbhelp = [[DBHelper alloc] init];

        self.chosearrayname=[[NSMutableArray alloc]initWithCapacity:0];
        self.chosearraycode=[[NSMutableArray alloc]initWithCapacity:0];
        self.chosearrayIsSpecial = [[NSMutableArray alloc]initWithCapacity:0];
        self.chosearrayLimitRebate = [[NSMutableArray alloc]initWithCapacity:0];
        self.chosearrayRebatesType = [[NSMutableArray alloc]initWithCapacity:0];

    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.RemindProLab.hidden=YES;
    self.RemindBusBtn.hidden=YES;
    self.Down_ListTable.hidden = NO;
    
    [self hideTabBar:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"请选择"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    
    [self.RemindBusBtn addTarget:self action:@selector(pushbusinessVC) forControlEvents:UIControlEventTouchUpInside];
    
    [self.Down_ListTable setDelegate:self];
    [self.Down_ListTable setDataSource:self];
    
    self.Down_ListTable.hidden = YES;

    if ([self.Itemstyle isEqualToString:@"B_one"])
    {
        [self loadCategoryView];

    }
    else if ([self.Itemstyle isEqualToString:@"B_two"])
    {
        [self categorySelect];

        
    }else if ([self.Itemstyle isEqualToString:@"B_city"])
    {
        [self loadCityView];

        
    }else if ([self.Itemstyle isEqualToString:@"ChoseBank"])
    {
        NSMutableArray*code = [[NSMutableArray alloc] initWithObjects:@"0100",@"0102",@"0103",@"0104",@"0105",@"0302",@"0303",@"0305",@"0306",@"0308",@"0309",nil];

        [self.chosearrayname addObject:@"邮储银行"];
        [self.chosearrayname addObject:@"中国工商银行"];
        [self.chosearrayname addObject:@"中国农业银行"];
        [self.chosearrayname addObject:@"中国银行"];
        [self.chosearrayname addObject:@"中国建设银行"];
        [self.chosearrayname addObject:@"中信银行"];
        [self.chosearrayname addObject:@"中国光大银行"];
        [self.chosearrayname addObject:@"中国民生银行"];
        [self.chosearrayname addObject:@"广东发展银行"];
        [self.chosearrayname addObject:@"招商银行"];
        [self.chosearrayname addObject:@"兴业银行"];
        
        [self.chosearraycode addObjectsFromArray:code];
        
    }else if ([self.Itemstyle isEqualToString:@"city"])
    {
        [self loadCityView];
        
    }else if ([self.Itemstyle isEqualToString:@"area"])
    {
        [self citySelectarea];
        
    }else if ([self.Itemstyle isEqualToString:@"busin"])
    {
        [self areaSelectmerchant];
        
    } else if ([self.Itemstyle isEqualToString:@"Business"])
    {
        [self GetDataFromServer];
    }
    


}


- (void)leftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushbusinessVC
{
    BusinesserlistViewController *viewController = [[BusinesserlistViewController alloc] initWithNibName:@"BusinesserlistViewController" bundle:nil];
        viewController.PorB=@"2";//商户
    [self.navigationController pushViewController:viewController animated:YES];
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chosearrayname.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text=[self.chosearrayname objectAtIndex:indexPath.row];
    

    return cell;
}


//选中CELL
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.Itemstyle isEqualToString:@"B_one"])
    {
        [self.Chosedelegate ChosesoneValue:[self.chosearrayname objectAtIndex:indexPath.row] code:[self.chosearraycode objectAtIndex:indexPath.row]];
        
    }
    else if ([self.Itemstyle isEqualToString:@"B_two"])
    {
        [self.Chosedelegate ChosestwoValue:[self.chosearrayname objectAtIndex:indexPath.row] code:[self.chosearraycode objectAtIndex:indexPath.row]];
        
    }else if ([self.Itemstyle isEqualToString:@"B_city"])
    {
        [self.Chosedelegate ChosescityValue:[self.chosearrayname objectAtIndex:indexPath.row] code:[self.chosearraycode objectAtIndex:indexPath.row]];
        
        
    }else if ([self.Itemstyle isEqualToString:@"ChoseBank"])
    {
        [self.Chosedelegate ChosesValue:[self.chosearrayname objectAtIndex:indexPath.row] Bankcode:[self.chosearraycode objectAtIndex:indexPath.row]];

    }else if ([self.Itemstyle isEqualToString:@"city"])
    {
        [self.Chosedelegate Chosescity:[self.chosearrayname objectAtIndex:indexPath.row] code:[self.chosearraycode objectAtIndex:indexPath.row]];
        
    }else if ([self.Itemstyle isEqualToString:@"area"])
    {
        [self.Chosedelegate Chosesarea:[self.chosearrayname objectAtIndex:indexPath.row] code:[self.chosearraycode objectAtIndex:indexPath.row]];
        
    }else if ([self.Itemstyle isEqualToString:@"busin"])
    {
        [self.Chosedelegate Chosesbusin:[self.chosearrayname objectAtIndex:indexPath.row] code:[self.chosearraycode objectAtIndex:indexPath.row]];
        
    }else if ([self.Itemstyle isEqualToString:@"Business"])
    {
        [self.Chosedelegate ChosesbusinessValue:[self.chosearrayname objectAtIndex:indexPath.row] code:[self.chosearraycode objectAtIndex:indexPath.row] Special:[self.chosearrayIsSpecial objectAtIndex:indexPath.row] LimitRebate:[self.chosearrayLimitRebate objectAtIndex:indexPath.row] RebatesType:[self.chosearrayRebatesType objectAtIndex:indexPath.row]];

        
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中状态。。

}

//加载类别一
-(void)loadCategoryView
{
    NSMutableArray *categorys = [dbhelp queryCategory];
    
    [self loadcelldata:categorys];
}
//二
- (void)categorySelect {
    
    NSMutableArray *areas = [dbhelp queryProject:[NSString stringWithFormat:@"%@",self.Needtwo]];
    
    [self loadcelldata:areas];
}
///////////////////////////////////////////////////////////////////////////////
-(void)loadcelldata:(NSArray*)datalist
{
    
    if (datalist == nil) {
        return;
    }
    for (NSDictionary *data in datalist)
    {
        [self.chosearrayname addObject:[data objectForKey:@"name"]];
        
        [self.chosearraycode addObject:[data objectForKey:@"code"]];
    }
    [self.Down_ListTable reloadData];
}


//城市
-(void)loadCityView
{
    NSArray *citys = [dbhelp queryCity];
    
    [self loadcelldata:citys];

}

-(void)citySelectarea
{
    NSMutableArray *areas = [dbhelp queryArea:self.Needtwo];

    [self loadcelldata:areas];
    
}
-(void)areaSelectmerchant
{
    NSMutableArray *areas = [dbhelp queryMerchant:self.Needthree];
    
    [self loadcelldata:areas];
}




-(void)GetDataFromServer
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MerchantDrp.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSLog(@"json = %@",json);
            
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"merchantDrpInfo"];
            if (metchantShop == nil || metchantShop.count == 0) {
                [self.chosearrayname removeAllObjects];
                [self.chosearrayname removeAllObjects];
                self.Down_ListTable.hidden = YES;
                self.RemindBusBtn.hidden=NO;
                self.RemindProLab.hidden=NO;
                
                return;
            } else {
                
                if (metchantShop == nil) {
                    return;
                }
                for (NSDictionary *data in metchantShop)
                {
                    [self.chosearrayname addObject:[data objectForKey:@"AllName"]];
                    
                    [self.chosearraycode addObject:[data objectForKey:@"MerchantID"]];
                    
                    [self.chosearrayIsSpecial addObject:[data objectForKey:@"IsSpecial"]];
// 、、、、还没有（诲诲）特殊商户
                    [self.chosearrayLimitRebate addObject:[data objectForKey:@"LimitRebate"]];
                    
                    NSLog(@"LimitRebate = %@",[data objectForKey:@"LimitRebate"]);
                    
                    [self.chosearrayRebatesType addObject:[data objectForKey:@"RebatesType"]];

                }
                [self.Down_ListTable reloadData];
                self.Down_ListTable.hidden = NO;
            }
            
        }
        else
        {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
  
    
}



@end
