//
//  FanliListViewController.m
//  HuiHui
//
//  Created by mac on 15-3-31.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "FanliListViewController.h"

#import "HH_FanliViewController.h"

#import "FanliDetailViewController.h"

#import "FanliListCell.h"

@interface FanliListViewController ()

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UIButton *m_fanliBtn;

@property (weak, nonatomic) IBOutlet UITextField *m_orderField;

// 申请返利触发的事件
- (IBAction)shenqingFanliClicked:(id)sender;


@end

@implementation FanliListViewController

@synthesize m_flightList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_flightList = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"返利列表"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
//    [self setRightButtonWithTitle:@"申请返利" action:@selector(fanliClicked)];
    
    self.m_tableView.hidden = YES;
    
    self.m_emptyLabel.hidden = YES;
    
    // 隐藏tableView多余的分割线
    [self setExtraCellLineHidden:self.m_tableView];
    
    
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    //self.tableView.useLoadingMoreView= YES;
    
    // 设置按钮
    self.m_fanliBtn.layer.borderWidth = 1.0f;
    self.m_fanliBtn.layer.borderColor = RGBACKTAB.CGColor;
    self.m_fanliBtn.backgroundColor = [UIColor whiteColor];
    self.m_fanliBtn.titleLabel.textColor = RGBACKTAB;
    
    
    // 请求数据
    [self fanliListRequestSubmit];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSString *rebate = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"RebateKey"]];
    
    if ( [rebate isEqualToString:@"1"] ) {
        
        // 重新赋值
        [CommonUtil addValue:@"0" andKey:@"RebateKey"];
        
        // 请求数据
        [self fanliListRequestSubmit];

    }
    
    
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

- (void)fanliClicked{
    
    // 进入申请返利的页面
    HH_FanliViewController *VC = [[HH_FanliViewController alloc]initWithNibName:@"HH_FanliViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)fanliListRequestSubmit{
    
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
    
    [httpClient requestScenery:@"Flight/FlightRebateList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSLog(@"json = %@",json);
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
//            NSString *msg = [json valueForKey:@"msg"];
//            [SVProgressHUD showErrorWithStatus:msg];
            
            if ( self.m_flightList.count != 0 ) {
                
                [self.m_flightList removeAllObjects];
            }

            self.m_flightList = [json valueForKey:@"flightRebateList"];
            
            if ( self.m_flightList.count != 0 ) {
                
                self.m_tableView.hidden = NO;
                
                self.m_emptyLabel.hidden = YES;
                
                [self.m_tableView reloadData];
            
            }else{
                
                self.m_tableView.hidden = YES;
                
                self.m_emptyLabel.hidden = NO;
                
                self.m_emptyLabel.text = @"您暂时还没有返利记录";
                
            }
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        self.m_tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableView.pullTableIsRefreshing = NO;
        //self.m_tableView.pullTableIsLoadingMore = NO;
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        self.m_tableView.pullTableIsRefreshing = NO;

    }];

}

#pragma mark - UItableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_flightList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"FanliListCelIdentifier";
    
    FanliListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FanliListCell" owner:self options:nil];
        
        cell = (FanliListCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    // 赋值
    if ( self.m_flightList.count != 0 ) {
        
        NSDictionary *dic = [self.m_flightList objectAtIndex:indexPath.row];
        
        cell.m_orderId.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"OrderId"]];
       
        cell.m_time.text = [NSString stringWithFormat:@"申请时间：%@",[dic objectForKey:@"CreateDate"]];
        
        // Status：状态（1：处理中2：已退回3：成功）
        NSString *status = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Status"]];

        if ( [status isEqualToString:@"1"] ) {
            
             cell.m_status.text = @"处理中";
            
             cell.m_status.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
            
            cell.m_fanli.hidden = YES;

            
        }else if ( [status isEqualToString:@"2"] ){
            
            cell.m_status.text = @"已退回";
            
            cell.m_status.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
            
            cell.m_fanli.hidden = YES;

        }else if ( [status isEqualToString:@"3"] ){
            
            cell.m_status.text = @"成功";
            
            cell.m_status.textColor = RGBACKTAB;
            
            cell.m_fanli.hidden = NO;
            
            cell.m_fanli.text = [NSString stringWithFormat:@"返利:%@元",[dic objectForKey:@"Rebate"]];

        }else{
            
            cell.m_status.text = @"";

        }
        
        
    }
    
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if ( self.m_flightList.count != 0 ) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 15)];
        
        UIImageView *imagV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 15)];
        imagV.backgroundColor = [UIColor blackColor];
        imagV.alpha = 0.6;
        [view addSubview:imagV];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 15)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @" 您申请过的返利列表";
        
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textColor = [UIColor whiteColor];
        
        
        [view addSubview:label];
        
        return view;
        
        
    }else{
        
        return nil;

    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = [self.m_flightList objectAtIndex:indexPath.row];

    // 进入返利的详情页面
    FanliDetailViewController *VC = [[FanliDetailViewController alloc]initWithNibName:@"FanliDetailViewController" bundle:nil];
    VC.m_orderId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RecordId"]];
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    [self performSelector:@selector(fanliListRequestSubmit) withObject:nil];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    [self performSelector:@selector(fanliListRequestSubmit) withObject:nil];
}



- (IBAction)shenqingFanliClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    if ( self.m_orderField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请填写您申请返利的订单号"];
        
        return;
        
    }
    
    // 请求数据
    [self fanliRequestSubmit];
    
}

// 申请返利请求数据
- (void)fanliRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           [NSString stringWithFormat:@"%@",self.m_orderField.text],@"orderId",
                           
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestScenery:@"Flight/ApplyFlightRebate.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSLog(@"json = %@",json);
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            NSString *msg = [json valueForKey:@"msg"];
            //            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 记录值返回返利列表页面后进行刷新数据
            [CommonUtil addValue:@"1" andKey:@"RebateKey"];
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:msg
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles: nil];
            
            alertView.tag = 13234;
            [alertView show];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 13234 ) {
        
        if ( buttonIndex == 0 ) {
            // 返回上一级
//            [self goBack];
            // 刷新数据
            [self fanliListRequestSubmit];
        }
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self  hiddenNumPadDone:nil];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}



@end
