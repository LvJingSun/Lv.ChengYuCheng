//
//  SceneryListViewController.m
//  HuiHui
//
//  Created by mac on 15-1-13.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryListViewController.h"

#import "CommonUtil.h"

#import "SceneryListCell.h"

#import "SceneryDetailViewController.h"

#import "SceneryMapViewController.h"


@interface SceneryListViewController ()

@property (weak, nonatomic) IBOutlet UIButton *m_morenBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_saleBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_goodBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_filterBtn;

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

// 按钮的选择类别
- (IBAction)btnClicked:(id)sender;

@end

@implementation SceneryListViewController

@synthesize m_sceneryList;

@synthesize m_type;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_sceneryList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_pageIndex = 1;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"景点列表"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"地图" action:@selector(mapClicked)];

    
    // 设置代理
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView = YES;
    
    // 请求数据
//    [self requestSubmit];
    
    // 设置选中的为默认的类型
    [self setmore:YES withSale:NO withGood:NO];
    
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

- (void)mapClicked{
   
    // 进入地图显示的页面
//    SceneryMapViewController *VC = [[SceneryMapViewController alloc]initWithNibName:@"SceneryMapViewController" bundle:nil];
//    [self.navigationController pushViewController:VC animated:YES];
    
}

- (IBAction)btnClicked:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 10) {
        
        // 默认的类型
        [self setmore:YES withSale:NO withGood:NO];
        
    }else if ( btn.tag == 11 ){
        
        // 销量的类型
        [self setmore:NO withSale:YES withGood:NO];
        
    }else if ( btn.tag == 12 ){
        
        // 好评的类型
        [self setmore:NO withSale:NO withGood:YES];
        
    }else{
        
        // 筛选的类型 - 进入筛选的页面进行选择
        SceneryFilterViewController *VC = [SceneryFilterViewController shareobject];
        VC.delegate = self;
        [self.navigationController pushViewController:VC animated:YES];

    }

}

- (void)setmore:(BOOL)aMoren withSale:(BOOL)aSale withGood:(BOOL)aGood{
    
    self.m_morenBtn.selected = aMoren;
    self.m_saleBtn.selected = aSale;
    self.m_goodBtn.selected = aGood;
    
    if ( aMoren ) {
        
        self.m_morenBtn.userInteractionEnabled = NO;
        self.m_saleBtn.userInteractionEnabled = YES;
        self.m_goodBtn.userInteractionEnabled = YES;
        self.m_filterBtn.userInteractionEnabled = YES;
        
        self.m_type = SceneryMoreType;
        
    }
    
    if ( aSale ) {
        
        self.m_morenBtn.userInteractionEnabled = YES;
        self.m_saleBtn.userInteractionEnabled = NO;
        self.m_goodBtn.userInteractionEnabled = YES;
        self.m_filterBtn.userInteractionEnabled = YES;
        
        self.m_type = ScenerySaleType;
        
    }
    
    if ( aGood ) {
        
        self.m_morenBtn.userInteractionEnabled = YES;
        self.m_saleBtn.userInteractionEnabled = YES;
        self.m_goodBtn.userInteractionEnabled = NO;
        self.m_filterBtn.userInteractionEnabled = YES;
        
        self.m_type = SceneryGoodType;
        
    }
    
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

//    return self.m_sceneryList.count;
    
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"SceneryListCellIdentifier";
    
    SceneryListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SceneryListCell" owner:self options:nil];
        
        cell = (SceneryListCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    // 赋值
    
    
    return cell;

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 95.0f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 进入景点详情的页面
    SceneryDetailViewController *VC = [[SceneryDetailViewController alloc]initWithNibName:@"SceneryDetailViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark - UINetWorking 请求数据
- (void)requestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestScenery:@"GetSceneryList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSLog(@"json =%@",json);
        
        if ( success ) {

            [SVProgressHUD dismiss];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
          
            
        }
    } failure:^(NSError *error) {
        NSLog(@"failed:%@", error);
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    m_pageIndex = 1;
    
//    [self performSelector:@selector(loadData) withObject:nil];
    
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    m_pageIndex++;
//    [self performSelector:@selector(loadData1) withObject:nil];

}

#pragma mark - SceneryFilterDelegate
- (void)filterChoose:(NSMutableDictionary *)aDic{
    
    
    
}

@end
