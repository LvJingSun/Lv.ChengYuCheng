//
//  MactQuanquanViewController.m
//  HuiHui
//
//  Created by mac on 15-3-24.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "MactQuanquanViewController.h"

#import "HH_RelseaeQuanViewController.h"

#import "hh_shopListCell.h"

#import "Quan_detailViewController.h"


@interface MactQuanquanViewController ()

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@end

@implementation MactQuanquanViewController

@synthesize m_vocherList;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        m_vocherList = [[NSMutableArray alloc]initWithCapacity:0];
     
        m_pageIndex = 1;
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"我的券券列表"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    [self setRightButtonWithTitle:@"新增券券" action:@selector(releaseCoupon)];
    
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView = YES;
    self.m_emptyLabel.hidden = YES;
    
    // 隐藏tableView多余的分割线
    [self setExtraCellLineHidden:self.m_tableView];
    
   
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    // 请求数据
    [self quanquanRequestSubmit];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
    
}

- (void)releaseCoupon{
    
    // 进入发布券券的页面
    HH_RelseaeQuanViewController *VC = [[HH_RelseaeQuanViewController alloc]initWithNibName:@"HH_RelseaeQuanViewController" bundle:nil];
    VC.m_type = @"1";
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - 请求网络数据
- (void)quanquanRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  [NSString stringWithFormat:@"%d", m_pageIndex], @"pageIndex",
                                 
                                  nil];
    
    NSLog(@"params = %@",param);
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"VocherMctList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSLog(@"json = %@",json);
            
            [SVProgressHUD dismiss];
            
            NSMutableArray *vocherList = [json valueForKey:@"VoucherMctList"];
            
            
            if (m_pageIndex == 1) {
                
                if ( self.m_vocherList.count != 0 ) {
                    
                    [self.m_vocherList removeAllObjects];
                    
                }
                
                if (vocherList == nil || vocherList.count == 0) {
                    
                    self.m_tableView.hidden = YES;
                    
                    self.m_emptyLabel.hidden = NO;
                    
                    self.m_emptyLabel.text = @"暂无券券数据";
                    
                } else {
                    
                    self.m_emptyLabel.hidden = YES;
                    
                    self.m_tableView.hidden = NO;
                    
                    [self.m_vocherList addObjectsFromArray: vocherList];
                    
                    
                    self.m_tableView.hidden = NO;
                    
                    [self.m_tableView reloadData];
                    
                    
                }
            } else {
                
                if (vocherList == nil || vocherList.count == 0) {
                    m_pageIndex--;
                    
                } else {
                    
                    [self.m_vocherList addObjectsFromArray:vocherList];
                    
                }
                
                self.m_tableView.hidden = NO;
                
                [self.m_tableView reloadData];
            }
            
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


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_vocherList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"MactQuanquanCellIdentifier";
    
    MactQuanquanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"hh_shopListCell" owner:self options:nil];
        
        cell = (MactQuanquanCell *)[nib objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        
    }
    
    // 赋值
    
    if ( self.m_vocherList.count != 0 ) {
        
        NSDictionary *dic = [self.m_vocherList objectAtIndex:indexPath.row];
        
        cell.m_title.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Title"]];
        
        cell.m_time.text = [NSString stringWithFormat:@"有效期:%@-%@",[dic objectForKey:@"MinDateTime"],[dic objectForKey:@"MaxDateTime"]];

        
        // Status状态：0（未开始）、1（进行中）、2（已结束）
        NSString *status = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Status"]];
        
        if ( [status isEqualToString:@"0"] ) {
            
            cell.m_status.text = @"未开始";
            cell.m_status.textColor = RGBACKTAB;

        }else if ( [status isEqualToString:@"1"] ){
            
            cell.m_status.text = @"进行中";
            cell.m_status.textColor = [UIColor redColor];
            
        }else{
            
            cell.m_status.text = @"已结束";
            cell.m_status.textColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:209/255.0 alpha:1.0f];
            
        }
    
    }
    
  
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableDictionary *dic = [self.m_vocherList objectAtIndex:indexPath.row];

    
    // 进入编辑券券的页面
//    HH_RelseaeQuanViewController *VC = [[HH_RelseaeQuanViewController alloc]initWithNibName:@"HH_RelseaeQuanViewController" bundle:nil];
//    VC.m_type = @"2";
//    VC.m_dic = dic;
//    [self.navigationController pushViewController:VC animated:YES];
    // 进入券券详情的页面
    Quan_detailViewController *VC = [[Quan_detailViewController alloc]initWithNibName:@"Quan_detailViewController" bundle:nil];
    VC.m_quanquanDic = dic;
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    m_pageIndex = 1;
    
    [self performSelector:@selector(quanquanRequestSubmit) withObject:nil];
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    m_pageIndex++;
    [self performSelector:@selector(quanquanRequestSubmit) withObject:nil];
    
}


@end
