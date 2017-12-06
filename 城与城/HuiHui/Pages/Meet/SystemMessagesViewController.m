//
//  SystemMessagesViewController.m
//  HuiHui
//
//  Created by mac on 13-12-11.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "SystemMessagesViewController.h"

#import "NewsCell.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

@interface SystemMessagesViewController ()

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@end

@implementation SystemMessagesViewController

@synthesize m_array;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_array = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"系统消息"];
    
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
    [self requestMessageList];
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
- (void)requestMessageList{
    
    
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
    [httpClient request:@"MessageList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *infoList = [json valueForKey:@"messageInfo"];
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
    
    SystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewsCell" owner:self options:nil];
        
        cell = (SystemMessageCell *)[nib objectAtIndex:2];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    if ( self.m_array.count != 0 ) {
        
        NSMutableDictionary *dic = [self.m_array objectAtIndex:indexPath.row];
        
        // 赋值
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MsgCot"]];
        
        CGSize size = [cell.m_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(237, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        cell.m_nameLabel.frame = CGRectMake(cell.m_nameLabel.frame.origin.x, cell.m_nameLabel.frame.origin.y, 237, size.height);
        
        cell.m_bgView.frame = CGRectMake(cell.m_bgView.frame.origin.x, cell.m_nameLabel.frame.origin.y + size.height + 7, cell.m_bgView.frame.size.width, cell.m_bgView.frame.size.height);
        
        cell.m_bgImgV.frame = CGRectMake(cell.m_bgImgV.frame.origin.x, cell.m_bgImgV.frame.origin.y, cell.m_bgImgV.frame.size.width, 6 + size.height + 7 + 30);
        
        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.m_bgImgV.frame.size.height + 10);
        
        cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CreateDate"]];
        
        cell.m_bgImgV.backgroundColor = [UIColor whiteColor];
        
        cell.m_bgImgV.layer.borderWidth = 1.0f;
        
        cell.m_bgImgV.layer.borderColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0].CGColor;
        
        
    }

    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *dic = [self.m_array objectAtIndex:indexPath.row];
    
    CGSize size = [[dic objectForKey:@"MsgCot"] sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(237, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    return 6 + size.height + 7 + 30 + 10;
}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    pageIndex = 1;
    [self performSelector:@selector(requestMessageList) withObject:nil];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    pageIndex++;
    [self performSelector:@selector(requestMessageList) withObject:nil];
}

@end
