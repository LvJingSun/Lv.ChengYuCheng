//
//  ShopListViewController.m
//  HuiHui
//
//  Created by mac on 13-11-25.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "ShopListViewController.h"

#import "ShopListCell.h"

#import "MapViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

@interface ShopListViewController ()

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@end

@implementation ShopListViewController

@synthesize m_shopList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_shopList = [[NSMutableArray alloc]initWithCapacity:0];
        
        pageIndex = 1;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"店铺信息"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
//    self.m_shopList = [NSMutableArray arrayWithObjects:@"11",@"22",@"33", nil];
    
    // 设置tableView的代理
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView= YES;
    self.m_tableView.hidden = YES;
    
    
    if ([self.m_FromDPId isEqualToString:@"1"]) {
        
        //表示点评
        [self.m_tableView setPullDelegate:nil];
        self.m_tableView.useRefreshView = NO;
        self.m_tableView.useLoadingMoreView= NO;
        self.m_emptyLabel.hidden = YES;
        
        self.m_tableView.hidden = NO;
        [self.m_tableView reloadData];
        
        
    }else{
    
    // 请求网络
    [self requestMerchantShopList];
        
    }
  
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
                                  [NSString stringWithFormat:@"%@",self.m_merchantId],   @"merchantId",
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
                    [self.m_shopList removeAllObjects];
                    self.m_tableView.hidden = YES;
                    
                    self.m_emptyLabel.hidden = NO;
                    
                    return;
                } else {
                    self.m_shopList = metchantShop;
                    
                    self.m_emptyLabel.hidden = YES;
                    
                }
            } else {
                if (metchantShop == nil || metchantShop.count == 0) {
                    pageIndex--;
                } else {
                    [self.m_shopList addObjectsFromArray:metchantShop];
                }
            }
            [self.m_tableView reloadData];
            self.m_tableView.hidden = NO;
        } else {
            if (pageIndex > 1) {
                pageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.m_tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    } failure:^(NSError *error) {
        if (pageIndex > 1) {
            pageIndex--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    }];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.m_shopList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    static NSString *cellIdentifer = @"ShopListCellIdentifier";
    
    ShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopListCell" owner:self options:nil];
        
        cell = (ShopListCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if ( self.m_shopList.count != 0 ) {
        
        NSMutableDictionary *dic = [self.m_shopList objectAtIndex:indexPath.row];
        
        
        if ([self.m_FromDPId isEqualToString:@"1"]) {
            
            // 赋值
            cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            cell.m_timeLable.text = [NSString stringWithFormat:@"营业时间：=-=-=--=-=-="];
            cell.m_timeLable.text = [NSString stringWithFormat:@"营业时间："];
            cell.m_phoneLabel.text = [NSString stringWithFormat:@"咨询电话：%@",[dic objectForKey:@"telephone"]];
            
            cell.m_addressLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"address"]];
            
        }else{
        // 赋值
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ShopName"]];
        cell.m_timeLable.text = [NSString stringWithFormat:@"营业时间：%@",[dic objectForKey:@"OpeningHours"]];
        cell.m_phoneLabel.text = [NSString stringWithFormat:@"咨询电话：%@",[dic objectForKey:@"Phone"]];
        
        cell.m_addressLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Address"]];
        
        }
        cell.m_phoneBtn.tag = indexPath.row;
        
        cell.m_addressBtn.tag = indexPath.row;
        
        [cell.m_phoneBtn addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
        [cell.m_addressBtn addTarget:self action:@selector(mapClicked:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return cell;

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 108.0f;
}

#pragma mark - BtnClicked
- (void)callPhone:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_shopList objectAtIndex:btn.tag];
    
    // 判断设备是否支持
    if([[[UIDevice currentDevice] model] rangeOfString:@"iPhone Simulator"].location != NSNotFound) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"该设备暂不支持电话功能"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
        
    }else{
        
        self.m_webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        if ([self.m_FromDPId isEqualToString:@"1"]) {
            
            [self.m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [dic objectForKey:@"telephone"]]]]];
            
        }else{
            [self.m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [dic objectForKey:@"Phone"]]]]];
            
        }
    }
    
}

- (void)mapClicked:(id)sender{
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_shopList objectAtIndex:btn.tag];

    // 进入地图展示的页面
    MapViewController *VC = [[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];
    VC.item = dic;
    VC.m_shopString = @"1";
    
    
    if ([self.m_FromDPId isEqualToString:@"1"]) {
        VC.m_FromDPId = @"1";
    }else{
        VC.m_FromDPId = @"2";
    }
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    pageIndex = 1;
    [self performSelector:@selector(requestMerchantShopList) withObject:nil];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    pageIndex++;
    [self performSelector:@selector(requestMerchantShopList) withObject:nil];
}


@end
