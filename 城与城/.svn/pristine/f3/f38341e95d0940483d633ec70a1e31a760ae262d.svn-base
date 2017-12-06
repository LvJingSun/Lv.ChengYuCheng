//
//  f_activityViewController.m
//  HuiHui
//
//  Created by mac on 14-7-22.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "f_activityViewController.h"

#import "MyActivityViewController.h"

#import "ActivityDetailViewController.h"

#import "BusinessCell.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

@interface f_activityViewController ()

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;


- (IBAction)cehuaActivity:(id)sender;

@end

@implementation f_activityViewController

@synthesize m_activityArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_activityArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        pageIndex = 1;
        
        m_pageIndex = 1;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"商户活动"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView = YES;
    
    self.m_emptyLabel.hidden = YES;
    
    
    // 请求数据
    [self activityRequestSubmit];

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

- (IBAction)cehuaActivity:(id)sender {
    
    // 商户发起活动
    MyActivityViewController *VC = [[MyActivityViewController alloc]initWithNibName:@"MyActivityViewController" bundle:nil];
    
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_activityArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 商户活动
    static NSString *cellIdentifier = @"PartyCellIdentifier";
    
    PartyCell *cell = (PartyCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
      
        NSArray *arr = [[NSBundle mainBundle]loadNibNamed:@"BusinessCell" owner:self options:nil];
        
        cell = (PartyCell *)[arr objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    if ( self.m_activityArray.count != 0 ) {
        
        NSMutableDictionary *dic = [self.m_activityArray objectAtIndex:indexPath.row];
        
        // 设置cell上面的图片
        [cell setImageView:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Poster"]]];
        
        NSString *sexString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Sex"]];
        
        if ( [sexString isEqualToString:@"Female"] ) {
            
            sexString = @"女";
            
        }else if ( [sexString isEqualToString:@"Male"]  ){
            
            sexString = @"男";
            
        }else{
            
            sexString = @"不限";
            
        }
        
        cell.m_validateTimeLabel.text = [NSString stringWithFormat:@"%@~%@ %@至%@",[dic objectForKey:@"ActStartDate"],[dic objectForKey:@"ActEndDate"],[dic objectForKey:@"ActStartTime"],[dic objectForKey:@"ActEndtTime"]];
        
        cell.m_ageLabel.text = [NSString stringWithFormat:@"最少%@人最多%@人/年龄%@-%@岁/性别:%@",[dic objectForKey:@"PeoperNumMin"],[dic objectForKey:@"PeoperNumMax"],[dic objectForKey:@"AgeMin"],[dic objectForKey:@"AgeMax"],sexString];
        
        cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RegStopTime"]];
        
        cell.m_productName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityName"]];
        
        cell.m_priceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Price"]];
        
        cell.m_orignLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"OriginalPrice"]];
        
        // 更改为类型
        cell.m_sexLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActCatgNames"]];
        
        // 计算label的大小坐标
        CGSize size = [cell.m_priceLabel.text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
        
        CGSize size1 = [cell.m_orignLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
        
        cell.m_orignLabel.hidden = NO;
        
        cell.m_lineLabel.hidden = NO;
        
        cell.m_priceLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x, cell.m_priceLabel.frame.origin.y, size.width, 21);
        
        cell.m_orignLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width + 5, cell.m_orignLabel.frame.origin.y, size1.width + 2, 21);
        
        cell.m_lineLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width + 3, 68, size1.width + 5, 1);
        
    }
    
    return cell;
    
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 143.0f;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // 活动详情
    NSMutableDictionary *dic = [self.m_activityArray objectAtIndex:indexPath.row];
    
    // 保存活动的图标
    [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Poster"]] andKey:@"productImage"];
    
    // 活动
    ActivityDetailViewController *VC = [[ActivityDetailViewController alloc]initWithNibName:@"ActivityDetailViewController" bundle:nil];
    VC.m_partyString = @"0";
    VC.m_typeString = MERCHANTACTIVITY;
    VC.m_serviceId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityID"]];
    [self.navigationController pushViewController:VC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];


}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    pageIndex = 1;
    [self performSelector:@selector(activityRequestSubmit) withObject:nil];
    
}
- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    if ( [self.m_isLastPage isEqualToString:@"1"] ) {
        
        m_pageIndex++;
        [self performSelector:@selector(activityRequestSubmit1) withObject:nil];
        
    }else{
        
        pageIndex++;
        [self performSelector:@selector(activityRequestSubmit) withObject:nil];
    }
    
}
#pragma mark - UINetWork
- (void)activityRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
 
        return;
    }
    
    // activityType 0：商户活动；1：会员聚会
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  [NSString stringWithFormat:@"%d", pageIndex], @"pageIndex",
                                  @"0", @"activityType",
                                  nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ActivityAllListTop.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"ActivityList"];
            
            if (pageIndex == 1) {
                if (metchantShop == nil || metchantShop.count == 0) {
                    [self.m_activityArray removeAllObjects];
                   
                    self.m_tableView.hidden = YES;
                    
                    self.m_emptyLabel.hidden = NO;
                    
                    self.m_emptyLabel.text = @"暂无商户活动!";

                    
                } else {
                    self.m_activityArray = metchantShop;
                    
                    self.m_emptyLabel.hidden = YES;
                    
                }
            } else {
                if (metchantShop == nil || metchantShop.count == 0) {
                    pageIndex--;
                } else {
                    [self.m_activityArray addObjectsFromArray:metchantShop];
                }
            }
            
            self.m_isLastPage = [NSString stringWithFormat:@"%@",[json valueForKey:@"IsLastPage"]];
            
            NSLog(@"m_isLastPage = %@",self.m_isLastPage);
            
            if ( [self.m_isLastPage isEqualToString:@"1"] ) {
                
                m_pageIndex = 1;
                //如果是1则表示是最后一页，请求数据
                [self activityRequestSubmit1];
                
            }
            
            self.m_tableView.hidden = NO;
            
            [self.m_tableView reloadData];
            
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

- (void)activityRequestSubmit1{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
     
        return;
    }
    
    // activityType 0：商户活动；1：会员聚会
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  [NSString stringWithFormat:@"%d", m_pageIndex], @"pageIndex",
                                  @"0", @"activityType",
                                  nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ActivityAllList_1_0.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"ActivityList"];
            
            if (m_pageIndex == 1) {
                if (metchantShop == nil || metchantShop.count == 0) {
                    //                    [self.m_activityArray removeAllObjects];
                    
                    if ( self.m_activityArray.count != 0 ) {
                        
                        self.m_tableView.hidden = NO;
                        
                        self.m_emptyLabel.hidden = YES;
                        
                    }else{
                        
                        self.m_tableView.hidden = YES;
                        
                        self.m_emptyLabel.hidden = NO;
                        
                        self.m_emptyLabel.text = @"暂无商户活动!";

                        return;
                    }
                    
                } else {
                    
                    [self.m_activityArray addObjectsFromArray: metchantShop];
                    
                    self.m_emptyLabel.hidden = YES;
                    
                    self.m_tableView.hidden = NO;
                    
                }
            } else {
                if (metchantShop == nil || metchantShop.count == 0) {
                    m_pageIndex--;
                } else {
                    [self.m_activityArray addObjectsFromArray:metchantShop];
                }
            }
            
            self.m_tableView.hidden = NO;
            
            [self.m_tableView reloadData];
            
        } else {
            if (m_pageIndex > 1) {
                m_pageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.m_tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
        
    } failure:^(NSError *error) {
        if (m_pageIndex > 1) {
            m_pageIndex--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    }];
}


@end
