//
//  FriendsListViewController.m
//  HuiHui
//
//  Created by mac on 14-5-4.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "FriendsListViewController.h"

#import "FriendsCell.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "JPinYinUtil.h"

#import "UserInformationViewController.h"

#import "NSObject+SBJson.h"

#import "XMPPManager.h"

#import "NSData+Base64.h"

#import "NSDate+BBExtensions.h"

#import "GTMBase64.h"

#import "MessageObject.h"

#import "SendMessageViewController.h"

@interface FriendsListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@end

@implementation FriendsListViewController

@synthesize m_friendsList;

@synthesize m_allKeys;

@synthesize m_FriendsListDic;

@synthesize m_typeString;

@synthesize m_section;

@synthesize m_index;

@synthesize m_userId;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_friendsList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_allKeys = [[NSArray alloc]init];
        
        m_FriendsListDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_section = 0;
        
        m_index = 0;
        
        friendHelp = [[FriendHelper alloc]init];
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"我的好友"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.m_tableView.hidden = YES;

    self.m_emptyLabel.hidden = YES;

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    
    // 我的好友数据库中如果有数据，则直接从数据库中读取，否则请求接口返回数据
    if ( [[friendHelp friendsList] count] != 0 ) {
        
        self.m_friendsList = [friendHelp friendsList];

        if ( self.m_friendsList.count != 0 ) {
            
            self.m_emptyLabel.hidden = YES;
            
            // 好友进行字母排序
            [self sortFriends];
            
            
        }else{
            
            self.m_emptyLabel.hidden = NO;
            
            self.m_tableView.hidden = YES;
            
        }

    }else{
        
        // 我的好友请求数据
        [self friendsRequest];
        
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
            
            // 如果数组里有数据则先清空数据再进行赋值
            if ( self.m_friendsList.count != 0 ) {
                
                [self.m_friendsList removeAllObjects];

            }
            
            self.m_friendsList = [json valueForKey:@"memberJoinedInvite"];
            
            // 将数据保存到数据库里面
            [friendHelp updateData:[json valueForKey:@"memberJoinedInvite"]];
            
            [friendHelp updateMerchantData:[json valueForKey:@"memberRelationsInfo"]];
            
            [friendHelp updateInviteFriends:[json valueForKey:@"memberInvitationInvite"]];
            
        
            if ( self.m_friendsList.count != 0 ) {
                
                self.m_emptyLabel.hidden = YES;

                // 好友进行字母排序
                [self sortFriends];
                
                
            }else{
                
                self.m_emptyLabel.hidden = NO;
                
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
    
    return self.m_allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString *str = [self.m_allKeys objectAtIndex:section];
  
    NSArray *friendsArr = [self.m_FriendsListDic objectForKey:str];
  
    return friendsArr.count;
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
    
    if ( self.m_allKeys.count != 0 ) {
        
        // 赋值
        NSString *key = [self.m_allKeys objectAtIndex:indexPath.section];
        
        NSArray *array = [self.m_FriendsListDic objectForKey:key];
        
        NSDictionary *dic = [array objectAtIndex:indexPath.row];
        
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RealName"]];
        
        [cell setImageViewWithPath:[NSString stringWithFormat:@"%@",[dic objectForKey:@"PhotoUrl"]]];

    }
    
    return cell;

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 53.0f;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    return self.m_allKeys;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* l_View = [[UIView alloc] init];
    l_View.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 320, 22)];
    titleLabel.textColor=[UIColor grayColor];
    titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    
    NSString *str = [self.m_allKeys objectAtIndex:section];
    titleLabel.text = str;
    
    
    [l_View addSubview:titleLabel];
    
    return l_View;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        // 赋值
        NSString *key = [self.m_allKeys objectAtIndex:indexPath.section];
        
        NSArray *array = [self.m_FriendsListDic objectForKey:key];
        
        NSDictionary *dic = [array objectAtIndex:indexPath.row];
        
        // 进入详细资料
        UserInformationViewController *VC = [[UserInformationViewController alloc]initWithNibName:@"UserInformationViewController" bundle:nil];
        VC.m_typeString = @"2";
        
        ///// 好友Id================
        VC.m_friendId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]];
        [self.navigationController pushViewController:VC animated:YES];
   
    }else{
        
        self.m_section = indexPath.section;
        
        self.m_index = indexPath.row;
        
        
        // 转发消息
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"确定转发？"
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:@"确定", nil];
        alertView.tag = 11100;
        [alertView show];
        
    }
    
}

// 好友列表进行字母分类
- (void)sortFriends{
   
    for (int i = 0; i< self.m_friendsList.count; i++) {
        NSDictionary *dic = [self.m_friendsList objectAtIndex:i];
      
        NSString *pinyin = [self firstLetterForCompositeName:[dic objectForKey:@"RealName"]];
     
        NSArray *array = [self sortBypinyin:pinyin];
       
        [self.m_FriendsListDic setObject:array forKey:pinyin];
        
    }
   
    NSArray *allkeys  = [[self.m_FriendsListDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    self.m_allKeys = allkeys;
    
    self.m_tableView.hidden = NO;

    // 刷新列表
    [self.m_tableView reloadData];
    
}

- (NSString *)firstLetterForCompositeName:(NSString *)cityString {
    if (![cityString length]) {
        return @"";
    }
    unichar charString = [cityString characterAtIndex:0];
    NSArray *array = pinYinWithoutToneOnlyLetter(charString);
    if ([array count]) {
        return [[[array objectAtIndex:0] substringToIndex:1] uppercaseString];
    }
    return @"";
}

- (NSMutableArray *)sortBypinyin:(NSString *)pinyin{
	
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
   
    for (int i = 0; i< self.m_friendsList.count; i++) {
       
        NSDictionary *dic = [self.m_friendsList objectAtIndex:i];
        NSString *data_pinyin = [self firstLetterForCompositeName:[dic objectForKey:@"RealName"]];
        
        if ([data_pinyin isEqualToString:pinyin]) {
            [array addObject:dic];
        }
    }
    
    return array;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 11100 ) {
        
        if ( buttonIndex == 1 ) {
            // 转发
            NSString *key = [self.m_allKeys objectAtIndex:self.m_section];
            
            NSArray *array = [self.m_FriendsListDic objectForKey:key];
            
            NSDictionary *dic = [array objectAtIndex:self.m_index];
            
            NSLog(@"dic = %@",dic);
            
            NSString *memberId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]];
            
            if ( [memberId isEqualToString:self.m_userId] ) {
                // 如果userId一样的话，则返回上一级聊天的页面,否则进去新的聊天页面
                Appdelegate.isForward = YES;
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                
                Appdelegate.isForward = YES;
                
                
                // 进入聊天的页面
                SendMessageViewController *VC = [[SendMessageViewController alloc]initWithNibName:@"SendMessageViewController" bundle:nil];
                VC.m_chatPerson.userId = memberId;
                VC.m_chatPerson.userNickName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"NickName"]];
                VC.m_chatPerson.userHead = [NSString stringWithFormat:@"%@",[dic objectForKey:@"PhotoUrl"]];
                [self.navigationController pushViewController:VC animated:YES];
                
            }
            
        }else{
            
            
        }
    }
    
    
}


@end
