//
//  BblockslistViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-3-30.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BblockslistViewController.h"
#import "BlocksTableViewCell.h"

@interface BblockslistViewController ()

@property (nonatomic,strong) NSMutableArray *blocksarray;

@end

@implementation BblockslistViewController
@synthesize blocksarray;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.blocksarray = [[NSMutableArray alloc]initWithCapacity:0];
    self.title = @"已创建会员卡列表";
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    [self setRightButtonWithTitle:@"创建卡" action:@selector(releaseblock)];
    [m_tableView setDelegate:self];
    [m_tableView setDataSource:self];
    [m_tableView setPullDelegate:self];
    m_tableView.pullBackgroundColor = [UIColor whiteColor];
    m_tableView.useRefreshView = YES;
    m_tableView.useLoadingMoreView = YES;
    m_emptyLabel.hidden = YES;
    m_tableView.hidden = YES;
    
    // 隐藏tableView多余的分割线
    [self setExtraCellLineHidden:m_tableView];
    if ([m_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [m_tableView setSeparatorInset: UIEdgeInsetsZero];
    }
    if ([m_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [m_tableView setLayoutMargins: UIEdgeInsetsZero];
    }
    
    [self blockRequestSubmit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)leftClicked{
    
    [self goBack];
    
}

-(void)releaseblock
{
    BcreateblockViewController *VC = [[BcreateblockViewController alloc]initWithNibName:@"BcreateblockViewController" bundle:nil];
    VC.m_type = @"1";
    VC.Bcreatedelegate = self;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.blocksarray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"BlocksTableViewCellIdentifier";
    
    BlocksTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"BlocksTableViewCell" owner:self options:nil];
        
        cell = (BlocksTableViewCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        
    }
    
    NSDictionary *dic = [self.blocksarray objectAtIndex:indexPath.row];
    cell.blockname.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cardTitle"]];
    cell.blockshopnum.text = [NSString stringWithFormat:@"支持%@家门店",[dic objectForKey:@"merchentShopCount"]];
    cell.blockvipnum.text = [NSString stringWithFormat:@"共 %@ 名会员",[dic objectForKey:@"memberCount"]];
   
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableDictionary *dic = [self.blocksarray objectAtIndex:indexPath.row];
    
    // 进入编辑卡的页面
    BcreateblockViewController *VC = [[BcreateblockViewController alloc]initWithNibName:@"BcreateblockViewController" bundle:nil];
    VC.m_type = @"2";
    VC.m_dic = dic;
    VC.Bcreatedelegate = self;
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    [self performSelector:@selector(blockRequestSubmit) withObject:nil];
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    [self performSelector:@selector(blockRequestSubmit) withObject:nil];
    
}

-(void)blockRequestSubmit
{
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           merchantId,@"merchantId",
                           nil];
    [httpClient request:@"MyPubVIPCard.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            self.blocksarray = [json valueForKey:@"cardList"];
            
            if (self.blocksarray.count==0) {
                m_tableView.hidden = YES;
                m_emptyLabel.hidden = NO;
            }else{
                m_tableView.hidden = NO;
                m_emptyLabel.hidden = YES;
            }
            [m_tableView reloadData];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];

        }
        m_tableView.pullLastRefreshDate = [NSDate date];
        m_tableView.pullTableIsRefreshing = NO;
        m_tableView.pullTableIsLoadingMore = NO;
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"请求失败，请稍后再试"];
        m_tableView.pullLastRefreshDate = [NSDate date];
        m_tableView.pullTableIsRefreshing = NO;
        m_tableView.pullTableIsLoadingMore = NO;

    }];
    
}

-(void)BcretablockOver
{
    [self performSelector:@selector(blockRequestSubmit) withObject:nil];
}

@end
