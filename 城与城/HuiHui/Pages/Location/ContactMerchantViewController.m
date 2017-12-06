//
//  ContactMerchantViewController.m
//  HuiHui
//
//  Created by mac on 14-7-7.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "ContactMerchantViewController.h"

#import "FriendsCell.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "ChatViewController.h"

@interface ContactMerchantViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@end

@implementation ContactMerchantViewController

@synthesize m_CustomerList;

@synthesize m_merchantId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_CustomerList = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"客服列表"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.m_tableView.hidden = YES;
    
    self.m_emptyLabel.hidden = YES;
    
    // 请求接口返回数据
    [self requestCustomerList];
    
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"FriendsCellIdentifier";
    
    FriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FriendsCell" owner:self options:nil];
        
        cell = (FriendsCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    
    cell.m_inviteNameLabel.hidden = YES;
    
    cell.m_statusLabel.hidden = YES;
    
    cell.m_nameLabel.hidden = NO;
    
    cell.m_imageView.hidden = NO;
    
    cell.m_imageBtn.hidden = YES;
    
    
    if ( self.m_CustomerList.count != 0 ) {
        
        NSDictionary *dic = [self.m_CustomerList objectAtIndex:indexPath.row];
        
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"NickName"]];
        
        [cell setImageViewWithPath:[NSString stringWithFormat:@"%@",[dic objectForKey:@"PhotoSmlUrl"]]];
        
        
    }
    

    return cell;

    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 53.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0) {
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"警告" message:@"由于您的手机操作系统版本太低，城与城 部分功能不能使用，若想完美使用城与城，请在设置中更新您手机的操作系统。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [view show];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
    NSDictionary *dic = [self.m_CustomerList objectAtIndex:indexPath.row];
    
//    // 保存聊天的对象的memberId
//    [CommonUtil addValue:[dic objectForKey:@"MemberId"] andKey:OTHERMEMBERID];
//    
//    [CommonUtil addValue:[dic objectForKey:@"NickName"] andKey:OTHERUSERNAME];
//    
//    [CommonUtil addValue:[dic objectForKey:@"PhotoMidUrl"] andKey:OTHERHEADERIMAGE];
//
//    // 进入聊天的页面
//    SendMessageViewController *VC = [[SendMessageViewController alloc]initWithNibName:@"SendMessageViewController" bundle:nil];
//    VC.m_chatPerson.userId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberId"]];
//    VC.m_chatPerson.userNickName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"NickName"]];
//    VC.m_chatPerson.userHead = [NSString stringWithFormat:@"%@",[dic objectForKey:@"PhotoMidUrl"]];
//    [self.navigationController pushViewController:VC animated:YES];
    FriendsCell *cell = (FriendsCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberId"]] isGroup:NO];
    chatVC.title = [NSString stringWithFormat:@"%@",[dic objectForKey:@"NickName"]];
    chatVC.Uimage = cell.m_imageView.image;
    [self.navigationController pushViewController:chatVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

#pragma mark - UINetWork
- (void)requestCustomerList{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  self.m_merchantId,@"merchantId",
                                  nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"CustomerServiceList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            self.m_CustomerList = [json valueForKey:@"CusServiceMemberList"];
            
            if ( self.m_CustomerList.count != 0 ) {
                
                self.m_tableView.hidden = NO;
                
                [self.m_tableView reloadData];
                
                self.m_emptyLabel.hidden = YES;

            }else{
                
                self.m_emptyLabel.hidden = NO;
                
                self.m_tableView.hidden = YES;
            }
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        
    }];
    
}


@end
