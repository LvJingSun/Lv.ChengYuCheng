//
//  ResultViewController.m
//  HuiHui
//
//  Created by mac on 14-1-6.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "ResultViewController.h"

#import "ResultCell.h"

#import "UserInformationViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"


@interface ResultViewController ()<UIAlertViewDelegate>
{
    NSInteger Addfriendindex ;
}

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@end

@implementation ResultViewController

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
    
    [self setTitle:@"搜索结果"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    self.m_tableView.hidden = YES;
    
    self.m_emptyLabel.hidden = YES;
    
    
    // 请求数据
    [self requestFriendsSubmit];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];

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
    
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        [self goBack];
        
    }else{
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.m_array.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ResultCellIdentifier";
    
    ResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ResultCell" owner:self options:nil];
        
        cell = (ResultCell *)[nib objectAtIndex:0];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    if ( self.m_array.count != 0 ) {
        
    NSDictionary *dic = [self.m_array objectAtIndex:indexPath.row];
        
    cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"NickName"]];
      
    cell.m_addBtn.tag = indexPath.row;
        
    [cell.m_addBtn addTarget:self action:@selector(showMessageAlertView:) forControlEvents:UIControlEventTouchUpInside];
        
        // type 1表示未关注 2表示已关注
        if ( [[dic objectForKey:@"Type"] isEqualToString:@"1"] ) {
            
            cell.m_addBtn.hidden = NO;
            
        }else if ( [[dic objectForKey:@"Type"] isEqualToString:@"2"] ){
            
            cell.m_addBtn.hidden = YES;
            
        }else{
            
            
        }
        
    }
   
    return cell;
 
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSDictionary *dic = [self.m_array objectAtIndex:indexPath.row];
    if ( [[dic objectForKey:@"Type"] isEqualToString:@"1"] ) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    // 进入好友详情的页面
    UserInformationViewController *VC = [[UserInformationViewController alloc]initWithNibName:@"UserInformationViewController" bundle:nil];
    VC.m_typeString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Type"]];
    VC.m_friendId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"OtmemId"]];
    VC.m_RName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RealName"] ];

    [self.navigationController pushViewController:VC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (void)showMessageAlertView:(id)sender{
    [self hiddenNumPadDone:nil];
    UIButton *btn = (UIButton *)sender;
    Addfriendindex = btn.tag;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"输入请求消息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView cancelButtonIndex] != buttonIndex) {
        UITextField *messageTextField = [alertView textFieldAtIndex:0];
        
        NSString *messageStr = @"";
        if (messageTextField.text.length > 0) {
            messageStr = [NSString stringWithFormat:@"%@", messageTextField.text];
        }
        else{
            messageStr = [NSString stringWithFormat:@"邀请你为好友"];

        }
        [self sendFriendApplyAtIndexPath:Addfriendindex
                                 message:messageStr];
    }
}

- (void)sendFriendApplyAtIndexPath:(NSInteger)indexPath
                           message:(NSString *)message
{
    NSDictionary *dic = [self.m_array objectAtIndex:indexPath];
    NSString *buddyName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"OtmemId"]];
    if (buddyName && buddyName.length > 0) {
        [self showHudInView:self.view hint:@"正在发送申请..."];
        EMError *error;
        [[EaseMob sharedInstance].chatManager addBuddy:buddyName message:message error:&error];
        [self hideHud];
        if (error) {
            [self showHint:@"发送申请失败，请重新操作"];
        }
        else{
//            [self addFriend:indexPath];
            [self showHint:@"发送申请成功"];

        }
    }
}

//发出请求
// 关注好友请求数据
- (void)addFriend:(NSInteger)index{

    NSDictionary *dic = [self.m_array objectAtIndex:index];
    
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
                           [NSString stringWithFormat:@"%@",[dic objectForKey:@"OtmemId"]],@"otherId",
                           nil];
//    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"AttentionAdd.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [self showHint:@"发送申请成功"];

            [self requestFriendsSubmit];
                       
        } else {

            [self showHint:@"发送申请失败，请重新操作"];
        }
    } failure:^(NSError *error) {

        [self showHint:@"发送申请失败"];

    }];

}

- (void)requestFriendsSubmit{
    
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
                           self.m_searchString,@"content",
                           nil];
    [httpClient request:@"PhoneSearch.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            [self.m_array removeAllObjects];
            self.m_array = [json valueForKey:@"attentionInfo"];
            
            if ( self.m_array.count != 0 ) {
                self.m_tableView.hidden = NO;
                self.m_emptyLabel.hidden = YES;
                // 刷新列表
                [self.m_tableView reloadData];
           
            }else{
                self.m_tableView.hidden = YES;
                self.m_emptyLabel.hidden = NO;
            }
            
        } else {
        }
    } failure:^(NSError *error) {

    }];
}

- (void)viewDidUnload {
    [self setM_emptyLabel:nil];
    [super viewDidUnload];
}
@end
