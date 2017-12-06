//
//  ChoseShopViewController.m
//  baozhifu
//
//  Created by 冯海强 on 14-1-12.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ChoseShopViewController.h"

#import "CommonUtil.h"
#import "SVProgressHUD.h"
#import "AppHttpClient.h"

@interface ChoseShopViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table_key_list;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UIView *m_iseView;

@property(nonatomic,weak)IBOutlet UIButton *ChoseallBtn;


@property(nonatomic,weak)IBOutlet UIButton *ChoseremindBtn;
@property(nonatomic,weak)IBOutlet UILabel *ChoseremindLab;


@end

@implementation ChoseShopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.chosearray  =  [[NSMutableArray alloc]initWithCapacity:0];
        self.chosearrayID=[[NSMutableArray alloc]initWithCapacity:0];

        self.shoparrayIDName =  [[NSMutableArray alloc]initWithCapacity:0];
        
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.ChoseremindLab.hidden=YES;
    self.ChoseremindBtn.hidden=YES;
    self.table_key_list.hidden = YES;
    [self hideTabBar:YES];
        
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    

    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"IDarray"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Namearray"];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.table_key_list setDelegate:self];
    [self.table_key_list setDataSource:self];
    //[self.table_key_list setSeparatorColor:[UIColor clearColor]];
    //[self.m_tempView setBackgroundColor:[UIColor clearColor]];
    [self setTitle:@"选择店铺"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    [self getShopDataFromServer];

}

- (void)leftClicked{
    
    [self goBack];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chosearray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
     ChoseShopCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"ChoseShopCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
        cell.chosedic=[[NSMutableArray alloc]initWithCapacity:0];
        cell.choseallnameCe=[[NSMutableArray alloc]initWithCapacity:0];
        cell.chosedicname=[[NSMutableArray alloc]initWithCapacity:0];
        cell.Chosedelegate = self;
        }
    if ([isall isEqualToString:@"1"])
    {
        [cell.Choseshop setImage:[UIImage imageNamed:@"comm_check_box_selected.png"] forState:UIControlStateNormal];
    }else if ([isall isEqualToString:@"0"])
    {
        [cell.Choseshop setImage:[UIImage imageNamed:@"comm_check_box_def.png"] forState:UIControlStateNormal];
    }
    NSString* tag=[NSString stringWithFormat:@"%@",[self.chosearrayID objectAtIndex:indexPath.row]];
    cell.Choseshop.tag=[tag intValue];
    cell.shopname.text=[self.chosearray objectAtIndex:indexPath.row];
    
    cell.choseallnameCe =self.shoparrayIDName;
    
    

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中状态。。

}

- (void)CellChosesshopValue:(NSString *)value code:(NSString *)shopcode
{
    shopName = value;
    shopID  = shopcode;
    
}


//是否全选
-(IBAction)choseallshop:(id)sender
{
    if (self.ChoseallBtn.selected)
    {
        isall=@"0";
        self.ChoseallBtn.selected=NO;
        [self.ChoseallBtn setImage:[UIImage imageNamed:@"comm_check_box_def.png"] forState:UIControlStateSelected];
    shopID=@"";
    shopName = @"";

    }
    else
    {
        isall=@"1";
        self.ChoseallBtn.selected=YES;
        [self.ChoseallBtn setImage:[UIImage imageNamed:@"comm_check_box_selected.png"] forState:UIControlStateSelected];
        
        NSString *strID;
        if (self.chosearrayID.count>1)
        {
            strID =[NSString stringWithFormat:@"%@",[self.chosearrayID objectAtIndex:0]];
        for (int i=0; i<self.chosearrayID.count; i++)
        {
            strID =[NSString stringWithFormat:@"%@,%@",strID,[self.chosearrayID objectAtIndex:i]];
        }
        }
        else
        {
            strID=[NSString stringWithFormat:@"%@",[self.chosearrayID objectAtIndex:0]];
        }
        
        NSString *strName;
    

        if (self.chosearrayID.count>1)
        {
            strName =[NSString stringWithFormat:@"%@",[self.chosearray objectAtIndex:0]];

            for (int i=0; i<self.chosearray.count; i++)
            {
                strName =[NSString stringWithFormat:@"%@,%@",strName,[self.chosearray objectAtIndex:i]];

            }
        }
        else
        {
            strName=[NSString stringWithFormat:@"%@",[self.chosearray objectAtIndex:0]];
        }


        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",strID] forKey:@"choseshopID"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",strName] forKey:@"choseshopName"];
        
        shopName =[[NSUserDefaults standardUserDefaults] objectForKey:@"choseshopName"];
        shopID =[[NSUserDefaults standardUserDefaults] objectForKey:@"choseshopID"];

    }
    [self.table_key_list reloadData];
}



-(void)getShopDataFromServer
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
                           self.chosemerchantId,@"merchantId",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MerchantShopDrp.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"merchantShopDrpInfo"];
            if (metchantShop == nil || metchantShop.count == 0) {
                [self.chosearray removeAllObjects];
                [self.chosearrayID removeAllObjects];
                self.table_key_list.hidden = YES;
                self.ChoseremindBtn.hidden=NO;
                self.ChoseremindLab.hidden=NO;
                
                return;
            } else {
                self.table_key_list.hidden = NO;

                self.shoparrayIDName=metchantShop;
                
                for (NSDictionary *data in metchantShop)
                {
                    [self.chosearray addObject:[data objectForKey:@"ShopName"]];
                    
                    [self.chosearrayID addObject:[data objectForKey:@"MerchantShopID"]];
                }
                [self.table_key_list reloadData];
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



-(IBAction)choseOver:(id)sender
{
    
    [self.Choseshopdelegate ChosesshopValue:shopName code:shopID];
    
    [self.navigationController popViewControllerAnimated:YES];


}



@end
