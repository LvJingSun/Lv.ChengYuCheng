//
//  MyquanquanViewController.m
//  HuiHui
//
//  Created by mac on 15-3-18.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "MyquanquanViewController.h"

#import "HHQuanDetailViewController.h"

#import "HHCouponCell.h"


@interface MyquanquanViewController ()

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (weak, nonatomic) IBOutlet UIButton *m_usedBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_favoriteBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

- (IBAction)btnClicked:(id)sender;

@end

@implementation MyquanquanViewController

@synthesize m_type;

@synthesize m_voucherList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_voucherList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_pageIndex = 1;
        
        m_indexRow = 0;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"我的券券"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 默认选中第一个
    [self setUserd:NO withFavorite:YES];
    
    // 去掉tableView多余的分割线
    [self setExtraCellLineHidden:self.m_tableView];
    
    
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView = YES;
    
    self.m_emptyLabel.hidden = YES;
    
    self.m_tableView.hidden = NO;

    
    
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

#pragma mark - 请求数据
- (void)vourcherRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
   
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    NSLog(@"self.m_type = %@",self.m_type);
    
    // option 1表示我收藏的   2已经使用的
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  [NSString stringWithFormat:@"%i",m_pageIndex],@"pageIndex",
                                  [NSString stringWithFormat:@"%@",self.m_type],@"option",
                                  
                                  nil];
    
    NSLog(@"params = %@",param);
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"VocherFavList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSLog(@"json = %@",json);
            
            [SVProgressHUD dismiss];
            
            NSMutableArray *voucherList = [json valueForKey:@"VoucherFavList"];
            
            if (m_pageIndex == 1) {
                
                if ( self.m_voucherList.count != 0 ) {
                    
                    [self.m_voucherList removeAllObjects];
                    
                }
                
                if (voucherList == nil || voucherList.count == 0) {
                    
                    self.m_tableView.hidden = YES;
                    
                    self.m_emptyLabel.hidden = NO;
                    
                    if ( [self.m_type isEqualToString:@"1"] ) {
                        
                         self.m_emptyLabel.text = @"暂无我收藏的券券数据";
                    
                    }else{
                        
                        self.m_emptyLabel.text = @"暂无已使用的券券数据";

                    }
                    
                } else {
                    
                    self.m_emptyLabel.hidden = YES;
                    
                    self.m_tableView.hidden = NO;
                    
                    [self.m_voucherList addObjectsFromArray: voucherList];
                    
                    
                    self.m_tableView.hidden = NO;
                    
                    [self.m_tableView reloadData];
                    
                    
                }
            } else {
                
                if (voucherList == nil || voucherList.count == 0) {
                    
                    m_pageIndex--;
                    
                } else {
                    
                    [self.m_voucherList addObjectsFromArray:voucherList];
                
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_voucherList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"HHQuanquanListCellIdentifier";
    
    HHQuanquanListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HHCouponCell" owner:self options:nil];
        
        cell = (HHQuanquanListCell *)[nib objectAtIndex:2];
        
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.m_view.layer.cornerRadius = 5.0f;
        cell.m_view.layer.masksToBounds = YES;
        
        cell.m_view.layer.borderWidth = 0.5f;
        cell.m_view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        
        cell.m_imagV.layer.cornerRadius = 30.0f;
        cell.m_imagV.layer.masksToBounds = YES;
        
        cell.m_view.frame = CGRectMake(cell.m_view.frame.origin.x, cell.m_view.frame.origin.y, WindowSizeWidth - 10, cell.m_view.frame.size.height);

        
    }
    
    // 赋值
    if ( self.m_voucherList.count != 0 ) {
        
        NSDictionary *dic = [self.m_voucherList objectAtIndex:indexPath.row];
        
        cell.m_title.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Title"]];
        cell.m_time.text = [NSString stringWithFormat:@"截止日期:%@",[dic objectForKey:@"MaxDateTime"]];
        cell.m_mctName.text = [NSString stringWithFormat:@"可用份数:%@",[dic objectForKey:@"AllowGetAmount"]];
        
        [cell setImagePath:[NSString stringWithFormat:@"%@",[dic objectForKey:@"LogoMidUrl"]]];
        
         // 已收藏
        if ( [self.m_type isEqualToString:@"1"] ) {
            // 我收藏的状态下

//            cell.m_btn.hidden = NO;
//            cell.m_btn.tag = indexPath.row;
//            
//            // 判断是否收藏  IsFav  0 表示未收藏 1表示已收藏
//            NSString *isFav = [NSString stringWithFormat:@"%@",[dic objectForKey:@"IsFav"]];
//
//            if ( [isFav isEqualToString:@"1"] ) {
//                
//                // 已收藏
//                [cell.m_btn setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
//                
//                [cell.m_btn removeTarget:self action:@selector(favoriteClicked:) forControlEvents:UIControlEventTouchUpInside];
//                
//                [cell.m_btn addTarget:self action:@selector(cancelFavClicked:) forControlEvents:UIControlEventTouchUpInside];
//                
//                
//            }else{
//                
//                // 未收藏
//                [cell.m_btn setImage:[UIImage imageNamed:@"favorite_no.png"] forState:UIControlStateNormal];
//                
//                [cell.m_btn removeTarget:self action:@selector(cancelFavClicked:) forControlEvents:UIControlEventTouchUpInside];
//                
//                [cell.m_btn addTarget:self action:@selector(favoriteClicked:) forControlEvents:UIControlEventTouchUpInside];
//                
//                
//                
//            }

            
            cell.m_btn.hidden = YES;
            cell.m_btn.tag = indexPath.row;
            
//            [cell.m_btn setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            
//            [cell.m_btn setTitle:@"已领取" forState:UIControlStateNormal];
            
//            [cell.m_btn addTarget:self action:@selector(cancelFavClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }else{
            
            // 已使用的状态下
            cell.m_btn.hidden = YES;
            
        }
                
    }

    
    return cell;
    
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110.0f;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = [self.m_voucherList objectAtIndex:indexPath.row];
    
    // 进入券券详情的页面
    HHQuanDetailViewController *VC = [[HHQuanDetailViewController alloc]initWithNibName:@"HHQuanDetailViewController" bundle:nil];
    VC.m_counponId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"VouchersID"]];
    VC.m_typeString = @"2";
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)cancelFavClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    m_indexRow = btn.tag;
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"您确定取消收藏？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 10236;
    
    [alertView show];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 10236 ) {
        
        if ( buttonIndex == 1 ) {
            
            // 获取voucherId
            NSDictionary *dic = [self.m_voucherList objectAtIndex:m_indexRow];
            
            NSString *voucherId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"VouchersID"]];
            
            // 确定取消收藏请求网络
            [self CancelFavoriteRequest:voucherId];
            
        }
    }
    
}

- (void)CancelFavoriteRequest:(NSString *)aVoucherId{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    // type 1表示添加收藏  2表示取消收藏
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           aVoucherId,@"voucherId",
                           @"2",@"option",
                           
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"VoucherFav.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        NSLog(@"json = %@",json);
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            // 收藏成功后提示
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            
            // 取消收藏成功后保存值用于返回我的券券列表进行请求数据刷新列表
            [CommonUtil addValue:@"1" andKey:@"IsFavorite"];
            
            // 请求数据重新刷新
            [self vourcherRequest];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}


#pragma mark - BtnClicked
- (IBAction)btnClicked:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 10 ) {
        // 已使用的
        [self setUserd:YES withFavorite:NO];
        
    }else if ( btn.tag == 11 ){
        // 我收藏的
        [self setUserd:NO withFavorite:YES];

    }
    
}

- (void)setUserd:(BOOL)aUsered withFavorite:(BOOL)aFavorite{
    
    m_pageIndex = 1;
    
    self.m_usedBtn.selected = aUsered;
    self.m_favoriteBtn.selected = aFavorite;
    
    if ( aUsered ) {

        self.m_usedBtn.userInteractionEnabled = NO;
        self.m_favoriteBtn.userInteractionEnabled = YES;
        
        self.m_type = @"2";
        
    }else{

        self.m_usedBtn.userInteractionEnabled = YES;
        self.m_favoriteBtn.userInteractionEnabled = NO;
      
        self.m_type = @"1";

    }
    
    // 请求数据
    [self vourcherRequest];

}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    m_pageIndex = 1;
    
    [self performSelector:@selector(vourcherRequest) withObject:nil];
    
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    m_pageIndex++;
    [self performSelector:@selector(vourcherRequest) withObject:nil];
    
}



@end
