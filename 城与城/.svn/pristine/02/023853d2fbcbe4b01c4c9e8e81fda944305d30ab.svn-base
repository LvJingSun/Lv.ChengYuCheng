//
//  HistoryserviceViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-1-27.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HistoryserviceViewController.h"
#import "HistoryserviceUTableViewCell.h"

@interface HistoryserviceViewController ()
{

    NSMutableArray *historysArray;
    
    int page;  // 用于分页请求的参数

}
@property (weak, nonatomic) IBOutlet PullTableView      *HS_tableview;

@end

@implementation HistoryserviceViewController
@synthesize HS_tableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    historysArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    [HS_tableview setPullDelegate:self];
    HS_tableview.pullBackgroundColor = [UIColor whiteColor];
    HS_tableview.useRefreshView = YES;
    HS_tableview.useLoadingMoreView= YES;
    
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"服务历史"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    if (![self.IsChatting isEqualToString:@"1"]) {
        [self setRightButtonWithTitle:@"发起" action:@selector(rightClicked)];
    }
    page = 1;
    [self Servicers_loadData];

}

-(void)leftClicked
{
    [self goBack];
}

-(void)rightClicked
{
    SubdescribeViewController *VC = [[SubdescribeViewController alloc]initWithNibName:@"SubdescribeViewController" bundle:nil];
    VC.delegate = self;
    VC.toMemberId = self.toMemberId;
    [self.navigationController pushViewController:VC animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return historysArray.count*2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [historysArray objectAtIndex:indexPath.row/2];

    if (indexPath.row%2==0) {
        
        NSString *string = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceDesc"]];
        
        CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(175, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        return size.height > 55 ? (size.height +30): 90;
    }
    
    NSString *string = [NSString stringWithFormat:@"%@",[dic objectForKey:@"FeedbackDesc"]];
    
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(175, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height > 44 ? size.height: 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    HistoryserviceUTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HistoryserviceUTableViewCell" owner:self options:nil];
        cell = (HistoryserviceUTableViewCell *)[nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    
    if (indexPath.row%2==0) {
        
    NSDictionary *dic = [historysArray objectAtIndex:indexPath.row/2];

        
    NSString *string = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceDesc"]];
    
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(175, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    if (size.height >55) {
        
        cell.Linedown.frame = CGRectMake(cell.Linedown.frame.origin.x, cell.Linedown.frame.origin.y, cell.Linedown.frame.size.width, cell.Linedown.frame.size.height + size.height -55);
        
        cell.DescribeLabel.frame = CGRectMake(cell.DescribeLabel.frame.origin.x, cell.DescribeLabel.frame.origin.y, cell.DescribeLabel.frame.size.width, size.height);

    }
    
    NSString*Timestring =[NSString stringWithFormat:@"%@",[dic objectForKey:@"CreateDate"]];
    NSArray *array = [Timestring componentsSeparatedByString:@" "];
    cell.YearLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
    cell.TimeLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
    
    cell.DescribeLabel.text = string;
        
    }else
    {
        
        
      return  [self tableView1:tableView cellForRowAtIndexPath:indexPath];

    }
    
    return cell;

}

- (UITableViewCell *)tableView1:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    HistoryserviceUTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HistoryserviceUTableViewCell" owner:self options:nil];
        cell = (HistoryserviceUTableViewCell1 *)[nib objectAtIndex:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    NSDictionary *dic = [historysArray objectAtIndex:indexPath.row/2];

    NSString *string = [NSString stringWithFormat:@"%@",[dic objectForKey:@"FeedbackDesc"]];
    
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(175, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    if (size.height >44) {
        
        cell.Linedown.frame = CGRectMake(cell.Linedown.frame.origin.x, 0, cell.Linedown.frame.size.width, size.height);
        cell.FeedbackDescLabel.frame = CGRectMake(cell.FeedbackDescLabel.frame.origin.x, cell.FeedbackDescLabel.frame.origin.y, cell.FeedbackDescLabel.frame.size.width, size.height);
        
    }
    
    cell.FeedbackDescLabel.text = string;
    
    return cell;
}


//我服务的历史
- (void)Servicers_loadData {
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    if ((![self.IsSender isEqualToString:@"1"])&&([self.IsChatting isEqualToString:@"1"])) {
        NSString *middle = @"";
        middle = self.toMemberId;
        self.toMemberId = memberId;
        memberId = middle;
    }
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"fromMemberId",
                           self.toMemberId,   @"toMemberId",
                           [NSString stringWithFormat:@"%d",page],@"pageIndex",
                           nil];
    if (historysArray.count ==0) {
        [SVProgressHUD showWithStatus:@"数据加载中"];
    }
    [httpClient request:@"ServiceHistory.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            NSMutableArray *metchantShop = [json valueForKey:@"historys"];

            if (page == 1) {
                if (metchantShop == nil || metchantShop.count == 0) {
                    [SVProgressHUD showErrorWithStatus:@"暂无服务历史"];
                    HS_tableview.hidden = YES;
                } else {
                    historysArray = metchantShop;
                    HS_tableview.hidden = NO;
                }
            } else {
                if (metchantShop == nil || metchantShop.count == 0) {
                    page--;
                } else {
                    [historysArray addObjectsFromArray:metchantShop];
                }
            }
            
            [HS_tableview reloadData];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        HS_tableview.pullLastRefreshDate = [NSDate date];
        HS_tableview.pullTableIsRefreshing = NO;
        HS_tableview.pullTableIsLoadingMore = NO;
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        HS_tableview.pullTableIsRefreshing = NO;
        HS_tableview.pullTableIsLoadingMore = NO;
    }];
}

-(void)Submitsuccess;
{
    [self Servicers_loadData];
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    page = 1;
    [self Servicers_loadData];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    page ++;
    [self Servicers_loadData];
}


@end
