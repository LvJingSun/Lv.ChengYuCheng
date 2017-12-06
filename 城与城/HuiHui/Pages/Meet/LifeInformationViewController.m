//
//  LifeInformationViewController.m
//  HuiHui
//
//  Created by mac on 13-12-11.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "LifeInformationViewController.h"

#import "NewsCell.h"

#import "MessageViewController.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

#import "AppHttpClient.h"

@interface LifeInformationViewController ()

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@end

@implementation LifeInformationViewController

@synthesize m_array;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_array = [[NSMutableArray alloc]initWithCapacity:0];
        
        pageIndex = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"生活资讯"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
        
    // 设置tableView的代理
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView= YES;
    self.m_tableView.hidden = YES;
    
    // 隐藏控件
    self.m_tableView.hidden = NO;
    
    self.m_emptyLabel.hidden = YES;
    
    // 请求数据
    [self requestInfoList];
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
- (void)requestInfoList{
    
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
//    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
//    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 
                                  [NSString stringWithFormat:@"%d",pageIndex],@"pageIndex",
                                  nil];    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"InfoList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *infoList = [json valueForKey:@"info"];
            if (pageIndex == 1) {
                if (infoList == nil || infoList.count == 0) {
                    [self.m_array removeAllObjects];
                    self.m_tableView.hidden = YES;
                    
                    self.m_emptyLabel.hidden = NO;
                    
                    return;
                } else {
                    self.m_array = infoList;
                    
                    self.m_emptyLabel.hidden = YES;
                    
                }
            } else {
                if (infoList == nil || infoList.count == 0) {
                    pageIndex--;
                } else {
                    [self.m_array addObjectsFromArray:infoList];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.m_array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LifeInfoCellIdentifier";
    
    LifeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewsCell" owner:self options:nil];
        
        cell = (LifeInfoCell *)[nib objectAtIndex:1];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    if ( self.m_array.count != 0 ) {
        
        NSMutableDictionary *dic = [self.m_array objectAtIndex:indexPath.row];
        
        // 赋值
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Title"]];
        
        cell.m_detailIntro.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CoreIntro"]];
        
        cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ModifyDate"]];
        
        CGSize size = [cell.m_detailIntro.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        cell.m_detailIntro.frame = CGRectMake(10, 32, 290, size.height);
        
        cell.m_imageView.frame = CGRectMake(0, cell.m_detailIntro.frame.origin.y + size.height + 5 , 320, 1);
        
        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, 32 + cell.m_imageView.frame.origin.y + 1);
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    NSMutableDictionary *dic = [self.m_array objectAtIndex:indexPath.row];
    
    CGSize size = [[dic objectForKey:@"CoreIntro"] sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    return 32 + size.height + 6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableDictionary *dic = [self.m_array objectAtIndex:indexPath.row];

    // 进入资讯详情
    MessageViewController *VC = [[MessageViewController alloc]initWithNibName:@"MessageViewController" bundle:nil];
    VC.m_DetailDic = dic;
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    pageIndex = 1;
    [self performSelector:@selector(requestInfoList) withObject:nil];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    pageIndex++;
    [self performSelector:@selector(requestInfoList) withObject:nil];
}


@end
