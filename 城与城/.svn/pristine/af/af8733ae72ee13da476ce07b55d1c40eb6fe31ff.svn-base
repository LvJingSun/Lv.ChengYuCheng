//
//  ZhiPaiShopViewController.m
//  HuiHui
//
//  Created by mac on 15-8-21.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "ZhiPaiShopViewController.h"

#import "hh_shopListCell.h"

@interface ZhiPaiShopViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@end

@implementation ZhiPaiShopViewController

@synthesize m_shopList;

@synthesize m_orderId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        m_shopList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_selectedIndex = -1;
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"指派店铺"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"指派" action:@selector(zhipaiClicked)];
    
    // 隐藏掉多余的分割线
    [self setExtraCellLineHidden:self.m_tableView];
    
    // 请求数据
    [self shopListRequest];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)zhipaiClicked{
    
    if ( m_selectedIndex == -1 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择要指派的店铺"];
        
        return;
        
    }
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSDictionary *dic = [self.m_shopList objectAtIndex:m_selectedIndex];

    NSString *shopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopID"]];
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
//    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"MemberID",
                           key,@"Key",
                           shopId,@"MerchantShopID",
                           [NSString stringWithFormat:@"%@",self.m_orderId],@"CloudMenuOrderID",
                           
                           nil];
    
    [SVProgressHUD showWithStatus:@"指派中"];
    
    [httpClient request:@"AllotWaiMaiOrder.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [self goBack];
            
       
            
        } else {
            
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

    
    
    
    
}

// 店铺数据请求数据
- (void)shopListRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           merchantId,@"merchantId",
                           
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"VoucherMerchantShops.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            self.m_shopList = [json valueForKey:@"ShopModelList"];
            
            NSLog(@"json = %@",json);
       
            // 刷新列表数据
            [self.m_tableView reloadData];
            
        } else {
            
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_shopList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"hh_shopListCellIdentifier";
    
    hh_shopListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"hh_shopListCell" owner:self options:nil];
        
        cell = (hh_shopListCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    // 赋值
    if ( self.m_shopList.count != 0 ) {
        
        NSDictionary *dic = [self.m_shopList objectAtIndex:indexPath.row];
        
        cell.m_shopName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopName"]];
    }
    
    
//    cell.m_btn.hidden = YES;
    
    
//    cell.m_btn.tag = indexPath.row;
//    [cell.m_btn addTarget:self action:@selector(addShopName:) forControlEvents:UIControlEventTouchUpInside];
    
    // 状态为0时表示未选择  1表示已经选择
//    NSString *status = [NSString stringWithFormat:@"%@",[self.m_selectedDic objectForKey:[NSString stringWithFormat:@"%li",(long)indexPath.row]]];
    
    if ( m_selectedIndex == indexPath.row ) {
        
        [cell.m_btn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
        
    }else{
        
        [cell.m_btn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
        
    }
    
    
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{

    m_selectedIndex = indexPath.row;
    
    [self.m_tableView reloadData];
    
}


@end
