//
//  InvitationFriendsViewController.m
//  HuiHui
//
//  Created by mac on 14-5-4.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "InvitationFriendsViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "FriendsCell.h"

#import "InviteViewController.h"

#import "InviteResultViewController.h"

@interface InvitationFriendsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@end

@implementation InvitationFriendsViewController

@synthesize m_InviteArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_InviteArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        inviteFriendHelp = [[FriendHelper alloc]init];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"邀请中的好友"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.m_tableView.hidden = YES;
    
    self.m_emptyLabel.hidden = YES;
    
   
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    
    NSString *inviteFriendCount = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kMemInvitingAcount]];
    
    // 判断：如果个数相同的话则从数据库中读取；不同的话则请求服务器获取
    if ( [inviteFriendCount intValue] == [[inviteFriendHelp inviteFriendsList] count] ) {
        
        if ( self.m_InviteArray.count != 0 ) {
            
            [self.m_InviteArray removeAllObjects];
        }
        
        // 赋值
        self.m_InviteArray = [inviteFriendHelp inviteFriendsList];
        
        if ( self.m_InviteArray.count != 0 ) {
            
            self.m_emptyLabel.hidden = YES;
            
            self.m_tableView.hidden = NO;
            
            [self.m_tableView reloadData];
            
        }else{
            
            self.m_emptyLabel.hidden = NO;
            
            self.m_emptyLabel.text = @"您暂时没有邀请中的好友";
            self.m_tableView.hidden = YES;
            
        }
        
    }else{
        
        // 设置恢复默认的值
//        [CommonUtil addValue:@"0" andKey:kInviteFriendsKey];
        
        // 请求我关注的商户列表信息
        [self friendsRequest];
        
    }
    
    
//    NSString *string = [CommonUtil getValueByKey:kInviteFriendsKey];

//    // 如果是1的话则表示商户列表有变化，否则的话则表示没有变化，不用请求数据来刷新
//    if ( [string isEqualToString:@"1"] ) {
//        
//        // 设置恢复默认的值
//        [CommonUtil addValue:@"0" andKey:kInviteFriendsKey];
//        
//        // 请求我关注的商户列表信息
//        [self friendsRequest];
//        
//        
//    }else{
//        
//        if ( self.m_InviteArray.count != 0 ) {
//            
//            [self.m_InviteArray removeAllObjects];
//        }
//        
//        // 赋值
//        self.m_InviteArray = [inviteFriendHelp inviteFriendsList];
//        
//        if ( self.m_InviteArray.count != 0 ) {
//            
//            self.m_emptyLabel.hidden = YES;
//            
//            self.m_tableView.hidden = NO;
//            
//            [self.m_tableView reloadData];
//            
//        }else{
//            
//            self.m_emptyLabel.hidden = NO;
//            
//            self.m_emptyLabel.text = @"您暂时没有邀请过其他的好友";
//            self.m_tableView.hidden = YES;
//            
//        }
//        
//    }

    
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

- (void)friendsRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MemberInviteList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            [self.m_InviteArray removeAllObjects];
            
            self.m_InviteArray = [json valueForKey:@"memberInvitationInvite"];
            
            if ( self.m_InviteArray.count != 0 ) {
                
                self.m_emptyLabel.hidden = YES;
                
                self.m_tableView.hidden = NO;
                
                [self.m_tableView reloadData];
                
            }else{
                
                self.m_emptyLabel.hidden = NO;
                
                self.m_emptyLabel.text = @"您暂时没有邀请过其他的好友";
                
                self.m_tableView.hidden = YES;
                
            }
            
            // 保存数据到数据库中
            [inviteFriendHelp updateData:[json valueForKey:@"memberJoinedInvite"]];
            
            [inviteFriendHelp updateMerchantData:[json valueForKey:@"memberRelationsInfo"]];
            
            [inviteFriendHelp updateInviteFriends:[json valueForKey:@"memberInvitationInvite"]];
            
            
            // 设置标志商户那边的默认值为0            
            [CommonUtil addValue:@"0" andKey:kMerchantKey];
            
            [CommonUtil addValue:@"0" andKey:kInviteFriendsKey];
            
            
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
    
    return self.m_InviteArray.count;
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
    
    cell.m_nameLabel.hidden = NO;
    
    cell.m_imageView.hidden = NO;
    
    cell.m_statusLabel.hidden = YES;
    
    cell.m_imageBtn.hidden = YES;

    
    if ( self.m_InviteArray.count != 0 ) {
        
        cell.m_inviteNameLabel.hidden = NO;
        
        cell.m_nameLabel.hidden = YES;
        
        cell.m_imageView.hidden = YES;
        
        cell.m_statusLabel.hidden = NO;
        
        NSDictionary *dic = [self.m_InviteArray objectAtIndex:indexPath.row];
        
        cell.m_inviteNameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"InviteName"]];
        
        // 判断邀请中好友是否已过期的标志 Joined 表示已过期  Invitation 邀请中
        if ( [[dic objectForKey:@"InviteStatus"] isEqualToString:@"Joined"] ) {
            
            cell.m_statusLabel.text = @"已过期";
            
        }else if ( [[dic objectForKey:@"InviteStatus"] isEqualToString:@"Invitation"] ) {
            
            cell.m_statusLabel.text = @"邀请中";
            
        }else{
            
            cell.m_statusLabel.text = @"";
        }
        

    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 53.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSMutableDictionary *dic = [self.m_InviteArray objectAtIndex:indexPath.row];
    
    // 邀请中好友的页面
    if ( [[dic objectForKey:@"InviteStatus"] isEqualToString:@"Joined"] ) {
        // 重新邀请-已过期的状态
        InviteViewController *VC = [[InviteViewController alloc]initWithNibName:@"InviteViewController" bundle:nil];
        VC.m_dic = dic;
        VC.stringType = @"1";
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        
        // 查看-未过期的状态
        InviteResultViewController *VC = [[InviteResultViewController alloc]initWithNibName:@"InviteResultViewController" bundle:nil];
        VC.message = [NSString stringWithFormat:@"%@",[dic objectForKey:@"InviteCodeView"]];
        VC.phone = [NSString stringWithFormat:@"%@",[dic objectForKey:@"InvitePhone"]];
        VC.m_type = @"2";
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
