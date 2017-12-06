//
//  BshoplistsViewController.m
//  baozhifu
//
//  Created by 冯海强 on 14-1-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BshoplistsViewController.h"
#import "BshoplistsCell.h"
#import "ShopdetailViewController.h"
#import "CommonUtil.h"
#import "SVProgressHUD.h"
#import "AppHttpClient.h"
@interface BshoplistsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *remindlabel;
@property (weak, nonatomic) IBOutlet UIButton *remindBtn;


@end

@implementation BshoplistsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        pageIndex = 1;

        self.shoparray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.remindlabel.hidden=YES;
    self.remindBtn.hidden=YES;
    self.S_ListTable.hidden = YES;

    
    [self.shoparray removeAllObjects];
    pageIndex = 1;
    [self requestMerchantShopList];
    [self hideTabBar:YES];

    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.S_ListTable setDelegate:self];
    [self.S_ListTable setDataSource:self];
    [self.S_ListTable setPullDelegate:self];
    self.S_ListTable.pullBackgroundColor = [UIColor whiteColor];
    self.S_ListTable.useRefreshView = YES;
    self.S_ListTable.useLoadingMoreView= YES;
    
    [self.remindBtn addTarget:self action:@selector(Addshop) forControlEvents:UIControlEventTouchUpInside];
    
    [self setTitle:@"店铺"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithNormalImage:@"add.png" action:@selector(Addshop)];
    
    // 隐藏多余的分割线
    [self setExtraCellLineHidden:self.S_ListTable];

    
    // Do any additional setup after loading the view from its nib.
}


- (void)leftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.shoparray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BshoplistsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"BshoplistsCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    if ( self.shoparray.count != 0 ) {
        
        NSMutableDictionary *dic = [self.shoparray objectAtIndex:indexPath.row];
        
        // 赋值
        cell.SL_Name.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ShopName"]];
        cell.SL_phone.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Phone"]];
        cell.SL_time.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"OpeningHours"]];
        cell.SL_Data.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Address"]];
        
        
        NSLog(@"%@,%@,%@,%@",cell.SL_Name.text,cell.SL_phone.text,cell.SL_time.text,cell.SL_Data.text);

    }
    
    
    return cell;
}


//选中CELL
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    ShopdetailViewController*DetailVC=[[ShopdetailViewController alloc]initWithNibName:@"ShopdetailViewController" bundle:nil];
    

    DetailVC.shopdetaildic = [self.shoparray objectAtIndex:indexPath.row];

    [self .navigationController pushViewController:DetailVC animated:YES];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中状态。。

}

-(void)Addshop
{
    
    ShopdetailViewController*DetailVC=[[ShopdetailViewController alloc]initWithNibName:@"ShopdetailViewController" bundle:nil];
    DetailVC.addorchange=@"1";
    
    [self .navigationController pushViewController:DetailVC animated:YES];
    
}


// 请求数据
- (void)requestMerchantShopList{
    
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  [NSString stringWithFormat:@"%@",self.merchantId],@"merchantId",
                                  [NSString stringWithFormat:@"%d",pageIndex],@"pageIndex",
                                  nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MerchantShopList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"merchantShop"];
            
            if (pageIndex == 1) {
                if (metchantShop == nil || metchantShop.count == 0) {
                    [self.shoparray removeAllObjects];
                    self.S_ListTable.hidden = YES;
                    
                    self.remindBtn.hidden=NO;
                    self.remindlabel.hidden=NO;
                    return;
                } else {
                    self.shoparray = metchantShop;

                    
                }
            } else {
                if (metchantShop == nil || metchantShop.count == 0) {
                    pageIndex--;
                } else {
                    [self.shoparray addObjectsFromArray:metchantShop];
                }
            }
            [self.S_ListTable reloadData];
            self.S_ListTable.hidden = NO;
        } else {
            if (pageIndex > 1) {
                pageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.S_ListTable.pullLastRefreshDate = [NSDate date];
        self.S_ListTable.pullTableIsRefreshing = NO;
        self.S_ListTable.pullTableIsLoadingMore = NO;
    } failure:^(NSError *error) {
        if (pageIndex > 1) {
            pageIndex--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        self.S_ListTable.pullTableIsRefreshing = NO;
        self.S_ListTable.pullTableIsLoadingMore = NO;
    }];
    
}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    pageIndex=1;
    [self performSelector:@selector(requestMerchantShopList) withObject:nil];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    pageIndex++;
    [self performSelector:@selector(requestMerchantShopList) withObject:nil];
}



@end