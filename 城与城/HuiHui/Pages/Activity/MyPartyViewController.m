//
//  MyPartyViewController.m
//  baozhifu
//
//  Created by mac on 14-3-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MyPartyViewController.h"

#import "LaunchPartyViewController.h"

#import "CommonUtil.h"

#import "MyPartyCell.h"

#import "MemberListViewController.h"

#import "ActivityDetailViewController.h"

#import "AppHttpClient.h"

#include "SVProgressHUD.h"

#import "LaunchPartyViewController.h"

#import "AppDelegate.h"

@interface MyPartyViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (weak, nonatomic) IBOutlet UIButton *m_btn1;

@property (weak, nonatomic) IBOutlet UIButton *m_btn2;

@property (weak, nonatomic) IBOutlet UIButton *m_btn3;

@property (weak, nonatomic) IBOutlet UIButton *m_btn4;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

// 发起聚会
- (IBAction)partyClicked:(id)sender;

// 按钮选择触发的事件
- (IBAction)btnClicked:(id)sender;

@end

@implementation MyPartyViewController

@synthesize m_partyList;

@synthesize m_index;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_partyList = [[NSMutableArray alloc]initWithCapacity:0];
        
        pageIndex = 1;
        
        m_index = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"我的聚会"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"发起" action:@selector(rightClicked)];
    
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView= YES;
    
    self.m_tableView.hidden = YES;
    self.m_emptyLabel.hidden = YES;
    
    // 默认选中第一个
    [self setPlan:YES withAudit:NO withConduct:NO withEnd:NO];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
    [self hideTabBar:YES];

    
    Appdelegate.isModifyImage = NO;
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

- (void)rightClicked{
    // 发起聚会
    LaunchPartyViewController *VC = [[LaunchPartyViewController alloc]initWithNibName:@"LaunchPartyViewController" bundle:nil];
    VC.m_typeString = @"1";
    [self.navigationController pushViewController:VC animated:YES];

}

- (IBAction)btnClicked:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    switch (btn.tag) {
        case 11:
        {
            
            [self setPlan:YES withAudit:NO withConduct:NO withEnd:NO];
        }
            break;
        case 12:
        {
            
            [self setPlan:NO withAudit:YES withConduct:NO withEnd:NO];

        }
            break;
        case 13:
        {
            [self setPlan:NO withAudit:NO withConduct:YES withEnd:NO];

            
        }
            break;
        case 14:
        {
            
            [self setPlan:NO withAudit:NO withConduct:NO withEnd:YES];

        }
            break;
        default:
            break;
    }
    
    
}

- (void)setPlan:(BOOL)aPlan withAudit:(BOOL)aAudit withConduct:(BOOL)aConduct withEnd:(BOOL)aEnd{
    
    pageIndex = 1;
    
    self.m_btn1.selected = aPlan;
    self.m_btn2.selected = aAudit;
    self.m_btn3.selected = aConduct;
    self.m_btn4.selected = aEnd;
    
    // 按钮是否可点击
    self.m_btn1.userInteractionEnabled = !aPlan;
    self.m_btn2.userInteractionEnabled = !aAudit;
    self.m_btn3.userInteractionEnabled = !aConduct;
    self.m_btn4.userInteractionEnabled = !aEnd;
    
    // 活动状态：1：策划中；2：审核中；3：进行中；4：已结束
    
    if ( aPlan ) {
        
        self.m_statusType = STATUS_PLAN;
        
        self.m_statusString = @"1";
    }
    
    if ( aAudit ) {
        
        self.m_statusType = STATUS_AUDIT;
        
        self.m_statusString = @"2";

    }

    
    if ( aConduct ) {
        
        self.m_statusType = STATUS_CONDUCT;
        
        self.m_statusString = @"3";

    }

    
    if ( aEnd ) {
        
        self.m_statusType = STATUS_END;
        
        self.m_statusString = @"4";

    }

    // 请求数据
    [self partyRequestSubmit];

    
}

// 请求网络数据
- (void)partyRequestSubmit{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    // activityType0:商户活动；1:会员聚会
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  @"1",@"activityType",
                                  [NSString stringWithFormat:@"%@",self.m_statusString],@"status",
                                  [NSString stringWithFormat:@"%i",pageIndex],@"pageIndex",
                                  nil];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ActivityList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            NSMutableArray *resultList = [json valueForKey:@"ActivityList"];
          
            if (pageIndex == 1) {
                if (resultList == nil || resultList.count == 0) {
                    [self.m_partyList removeAllObjects];
                    self.m_tableView.hidden = YES;
                    
                    self.m_emptyLabel.hidden = NO;
                    
                    return;
                } else {
                    
                    self.m_partyList = resultList;
                    
                     self.m_emptyLabel.hidden = YES;
                    
                    self.m_tableView.hidden = NO;
                    
                }
            } else {
                
                self.m_tableView.hidden = NO;
                
                if (resultList == nil || resultList.count == 0) {
                    pageIndex--;
                } else {
                    [self.m_partyList addObjectsFromArray:resultList];
                }
            }
            [self.m_tableView reloadData];
        } else {
            if (pageIndex > 1) {
                pageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    } failure:^(NSError *error) {
        if (pageIndex > 1) {
            pageIndex--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    }];

}

- (void)deleteRequestSubmit:(NSString *)aPartyId withOperation:(NSString *)aOperation{
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    // operation1：删除；2：提交
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  [NSString stringWithFormat:@"%@",aOperation],@"operation",
                                  [NSString stringWithFormat:@"%@",aPartyId],@"actId",
                                  nil];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ActivityOptions.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            
//            [SVProgressHUD showSuccessWithStatus:msg];
            
            [SVProgressHUD dismiss];
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@""
                                                               message:msg
                                                              delegate:nil
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles: nil];
            [alertView show];
            
            
            // 请求接口刷新数据
            pageIndex = 1;
            
            [self partyRequestSubmit];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
       
    } failure:^(NSError *error) {
       
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_partyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"MyPartyCellIdentifier";
    
    MyPartyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
    
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MyPartyCell" owner:self options:nil];
        
        cell = (MyPartyCell *)[nib objectAtIndex:0];
        
       
    }
    
    if ( self.m_statusType == STATUS_AUDIT ){
        
        cell.accessoryType = UITableViewCellAccessoryNone;

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else{
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    

    // 赋值
    
    if ( self.m_partyList.count != 0 ) {
        
        NSMutableDictionary *dic = [self.m_partyList objectAtIndex:indexPath.row];
        
        // 设置cell上面的图片
        [cell setImageView:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Poster"]]];
        
        
        
        NSString *sexString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Sex"]];
        
        if ( [sexString isEqualToString:@"Female"] ) {
            
            sexString = @"女";
            
        }else if ( [sexString isEqualToString:@"Male"]  ){
            
            sexString = @"男";
            
        }else{
            
            sexString = @"不限男女";
            
        }
        cell.m_timeLabel.text = [NSString stringWithFormat:@"%@~%@ %@至%@",[dic objectForKey:@"ActStartDate"],[dic objectForKey:@"ActEndDate"],[dic objectForKey:@"ActStartTime"],[dic objectForKey:@"ActEndtTime"]];
        
        cell.m_ageLabel.text = [NSString stringWithFormat:@"最少%@人最多%@人/年龄%@-%@岁/性别:%@",[dic objectForKey:@"PeoperNumMin"],[dic objectForKey:@"PeoperNumMax"],[dic objectForKey:@"AgeMin"],[dic objectForKey:@"AgeMax"],sexString];
        
        
        cell.m_endTimeLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RegStopTime"]];
        
        cell.m_activityName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityName"]];
        
        cell.m_priceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Fee"]];
        
        
        // 更改为类型
        cell.m_categoryLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActCatgNames"]];
        
        
        cell.m_orignPriceLabel.hidden = YES;
        
        cell.m_lineLabel.hidden = YES;
   
    }
    
    cell.m_clickedBtn.hidden = YES;

    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 144.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    self.m_index = indexPath.row;
    
    if ( self.m_statusType == STATUS_PLAN ) {
        // 策划中
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                       message:nil
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"编辑",@"删除",@"提交", nil];
        alert.tag = 1101;
        [alert show];
        
    }else if ( self.m_statusType == STATUS_CONDUCT ) {
        // 进行中
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                       message:nil
                                                      delegate:self
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"查看成员",@"查看详情",@"取消", nil];
        alert.tag = 1102;
        [alert show];
        
    }else if ( self.m_statusType == STATUS_END ) {
        // 已结束
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                       message:nil
                                                      delegate:self
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"查看成员",@"查看详情",@"取消", nil];
        alert.tag = 1103;
        [alert show];
        
    }else{
        
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];


}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSDictionary *dic = [self.m_partyList objectAtIndex:self.m_index];
    
    if ( alertView.tag == 1101 ) {
        
        if ( buttonIndex == 1 ) {
            // 编辑
            // 进入发起聚会的页面-编辑状态
            LaunchPartyViewController *VC = [[LaunchPartyViewController alloc]initWithNibName:@"LaunchPartyViewController" bundle:nil];
            VC.m_typeString = @"2";
            [VC.m_items setObject:[dic objectForKey:@"ActivityID"] forKey:@"ActivityID"];
            [self.navigationController pushViewController:VC animated:YES];
             
        }else  if ( buttonIndex == 2 ) {
            // 删除
//            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
//                                                               message:@"确定删除该活动?"
//                                                              delegate:self
//                                                     cancelButtonTitle:@"取消"
//                                                     otherButtonTitles:@"确定", nil];
//            alertView.tag = 11112;
//            [alertView show];

            // 删除请求数据
            
            [self deleteRequestSubmit:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityID"]] withOperation:@"1"];
            
        }else if ( buttonIndex == 3 ){
            // 提交
            [self deleteRequestSubmit:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityID"]] withOperation:@"2"];

        }else{
            
            
        }
        
    }else if ( alertView.tag == 1102 ){
        if ( buttonIndex == 0 ) {
            // 查看成员
            MemberListViewController *VC = [[MemberListViewController alloc]initWithNibName:@"MemberListViewController" bundle:nil];
            VC.m_typeString = @"1";
            VC.m_activiceId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityID"]];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ( buttonIndex == 1 ){
            
            // 进入详情页面
            ActivityDetailViewController *VC = [[ActivityDetailViewController alloc]initWithNibName:@"ActivityDetailViewController" bundle:nil];
            VC.m_typeString = PARTY;
            VC.m_partyString = @"1";
            VC.m_serviceId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityID"]];
            [self.navigationController pushViewController:VC animated:YES];
            
            
        }else{
            
            
        }
        
        
    }else if ( alertView.tag == 1103 ){
        
        if ( buttonIndex == 0 ) {
            // 查看成员
            MemberListViewController *VC = [[MemberListViewController alloc]initWithNibName:@"MemberListViewController" bundle:nil];
            VC.m_typeString = @"1";
            VC.m_activiceId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityID"]];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ( buttonIndex == 1 ){
            
            // 进入详情页面
            ActivityDetailViewController *VC = [[ActivityDetailViewController alloc]initWithNibName:@"ActivityDetailViewController" bundle:nil];
            VC.m_typeString = PARTY;
            VC.m_partyString = @"1";
            VC.m_serviceId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityID"]];
            [self.navigationController pushViewController:VC animated:YES];
            
            
        }else {
            
            
        }
        
    }
    
}


#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    pageIndex = 1;
    [self partyRequestSubmit];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    pageIndex++;
    [self performSelector:@selector(partyRequestSubmit) withObject:nil];
}


@end
