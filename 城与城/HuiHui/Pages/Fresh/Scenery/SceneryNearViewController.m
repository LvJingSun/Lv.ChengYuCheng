//
//  SceneryNearViewController.m
//  HuiHui
//
//  Created by mac on 15-1-19.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryNearViewController.h"

#import "SceneryDetailViewController.h"

#import "SceneryNearListCell.h"

#import "CommonUtil.h"

@interface SceneryNearViewController ()

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@end

@implementation SceneryNearViewController

@synthesize m_sceneryId;

@synthesize m_nearList;

@synthesize m_imageUrl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_nearList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_pageIndex = 1;
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"周边景区"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 设置代理
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView = YES;
    
    self.m_emptyLabel.hidden = YES;

    // 获取图片的地址
    self.m_imageUrl = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:SceneryImageUrl]];
    
    NSLog(@"imageUrl = %@",self.m_imageUrl);
    
    // 请求数据
    [self nearRequest];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
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

// 请求数据
- (void)nearRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    // sortType 1表示景区级别 2 同程推荐  3人气指数 4按距离升序 默认按同程推荐
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           [NSString stringWithFormat:@"%@",self.m_sceneryId],@"sceneryId",
                           [NSString stringWithFormat:@"%d",m_pageIndex],@"page",
                           @"20",@"pageSize",
                           
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    NSLog(@"parma = %@",param);
    
    [httpClient requestScenery:@"Scenery/GetNearbyScenery.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSLog(@"json =%@",json);
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            NSMutableArray *sceneryList = [json valueForKey:@"nearbySceneryList"];
            
            if (m_pageIndex == 1) {
                
                if (sceneryList == nil || sceneryList.count == 0) {
                    
                    [self.m_nearList removeAllObjects];
                    
                    [self.m_tableView reloadData];
                    
                    self.m_tableView.hidden = YES;
                    
                    self.m_emptyLabel.hidden = NO;
                    
                    // 数组为空的时候显示错误的提示信息
                    NSString *msg = [json valueForKey:@"msg"];
                    
                    self.m_emptyLabel.text = [NSString stringWithFormat:@"%@",msg];
                    
                    return;
                    
                } else {
                    
                    self.m_nearList = sceneryList;
                    
                    self.m_emptyLabel.hidden = YES;
                    
                    self.m_tableView.hidden = NO;
                    
                }
            } else {
                
                self.m_emptyLabel.hidden = YES;
                self.m_tableView.hidden = NO;
                
                if (sceneryList == nil || sceneryList.count == 0) {
                    
                    m_pageIndex--;
                    
                } else {
                    
                    [self.m_nearList addObjectsFromArray:sceneryList];
                }
            }
            
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_nearList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"SceneryNearListCellIdentifier";
    
    SceneryNearListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SceneryNearListCell" owner:self options:nil];
        
        cell = (SceneryNearListCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    // 赋值
    if ( self.m_nearList.count != 0 ) {
        
        NSDictionary *dic = [self.m_nearList objectAtIndex:indexPath.row];
        
        cell.m_title.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"sceneryName"]];
        cell.m_subTitle.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"sceneryAddress"]];
        
        cell.m_price.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"amountAdvice"]];
        
        cell.m_orignPrice.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"amount"]];
        
        // 图片赋值 图片由两个字符拼接起来
        NSString *imagePath = [NSString stringWithFormat:@"%@%@",self.m_imageUrl,[dic objectForKey:@"imgPath"]];
        
        // 赋值图片
        [cell setImageView:imagePath];
        
        cell.m_distance.text = [NSString stringWithFormat:@"%.2f米",[[dic objectForKey:@"distance"] floatValue]];
        
        // 返利赋值        
        cell.m_fanli.text = [NSString stringWithFormat:@"返￥%@",[dic objectForKey:@"rebate"]];
    }
    
    
    return cell;
    
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90.0f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *dic = [self.m_nearList objectAtIndex:indexPath.row];
        
    // 进入景点详情的页面
    SceneryDetailViewController *VC = [[SceneryDetailViewController alloc]initWithNibName:@"SceneryDetailViewController" bundle:nil];
    VC.m_dic = dic;
    [self.navigationController pushViewController:VC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    m_pageIndex = 1;
    [self performSelector:@selector(nearRequest) withObject:nil];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    m_pageIndex++;
    [self performSelector:@selector(nearRequest) withObject:nil];
}



@end
