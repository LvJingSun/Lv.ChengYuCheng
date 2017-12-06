//
//  MySiteViewController.m
//  HuiHui
//
//  Created by mac on 14-5-4.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "MySiteViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "MerchantDetailViewController.h"

#import "FriendsCell.h"

#import "Chat_MerViewController.h"

@interface MySiteViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@end

@implementation MySiteViewController

@synthesize m_MerchantArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_MerchantArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        merchantHelp = [[FriendHelper alloc]init];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"我关注的商户"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.m_tableView.hidden = YES;
    
    self.m_emptyLabel.hidden = YES;

}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
   
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    NSString *string = [CommonUtil getValueByKey:kMerchantKey];
    
    // 如果是1的话则表示商户列表有变化，否则的话则表示没有变化，不用请求数据来刷新
    if ( [string isEqualToString:@"1"] ) {
        
        // 设置恢复默认的值
        [CommonUtil addValue:@"0" andKey:kMerchantKey];
        
        // 请求我关注的商户列表信息
        [self friendsRequest];
        
    }else{
        // 判断个数是否否相同，不同的话则去服务器请求数据，相同的话则直接读取数据库中的数据
        NSString *mctCount = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kMctFansAcount]];
        
        if ( [mctCount intValue] == [[merchantHelp merchantList] count] ) {
            
            
            if ( self.m_MerchantArray.count != 0 ) {
                
                [self.m_MerchantArray removeAllObjects];
            }
            
            self.m_MerchantArray = [merchantHelp merchantList];
            
            if ( self.m_MerchantArray.count != 0 ) {
                
                self.m_emptyLabel.hidden = YES;
                
                self.m_tableView.hidden = NO;
                
                [self.m_tableView reloadData];
                
            }else{
                
                self.m_emptyLabel.hidden = NO;
                
                self.m_emptyLabel.text = @"您暂时没有关注过其他的商户";
                self.m_tableView.hidden = YES;
                
            }

        }else{
            
            // 请求我关注的商户列表信息
            [self friendsRequest];
            
        }
        
        
        
    }

   
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
            //            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD dismiss];
            
            [self.m_MerchantArray removeAllObjects];
            
            self.m_MerchantArray = [json valueForKey:@"memberRelationsInfo"];
            
            // 保存数据到数据库
            [merchantHelp updateData:[json valueForKey:@"memberJoinedInvite"]];
            
            [merchantHelp updateMerchantData:[json valueForKey:@"memberRelationsInfo"]];
            
            [merchantHelp updateInviteFriends:[json valueForKey:@"memberInvitationInvite"]];
            
            
            // 设置标志商户那边的默认值为0
            
            [CommonUtil addValue:@"0" andKey:kMerchantKey];
            [CommonUtil addValue:@"0" andKey:kInviteFriendsKey];
            
            
            
            if ( self.m_MerchantArray.count != 0 ) {
                
                self.m_emptyLabel.hidden = YES;
                
                self.m_tableView.hidden = NO;
                
                [self.m_tableView reloadData];

            }else{
                
                self.m_emptyLabel.hidden = NO;
                
                self.m_emptyLabel.text = @"您暂时没有关注过其他的商户";
                self.m_tableView.hidden = YES;
                
            }
            
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
    
    return self.m_MerchantArray.count;
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

    
    if ( self.m_MerchantArray.count != 0 ) {
        
        NSDictionary *dic = [self.m_MerchantArray objectAtIndex:indexPath.row];
        
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctName"]];
        
        [cell setImageViewWithPath:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantPic"]]];
        
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 53.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    NSMutableDictionary *dic = [self.m_MerchantArray objectAtIndex:indexPath.row];
    
    // 进入关注的商户详情
//    MerchantDetailViewController *VC = [[MerchantDetailViewController alloc]initWithNibName:@"MerchantDetailViewController" bundle:nil];
//    VC.m_typeString = @"2";
//    VC.m_items = dic;
//    [self.navigationController pushViewController:VC animated:YES];
    
//    Send_merchantViewController *VC = [[Send_merchantViewController alloc]initWithNibName:@"Send_merchantViewController" bundle:nil];
//    VC.m_items = dic;
//    VC.m_typeString = @"2";
//    VC.m_xiaoxiString = @"2";
//    [self.navigationController pushViewController:VC animated:YES];
    
    Chat_MerViewController *chatVC = [[Chat_MerViewController alloc]initWithChatter:nil isGroup:NO];
    chatVC.m_items = dic;
    [self.navigationController pushViewController:chatVC animated:YES];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


@end
