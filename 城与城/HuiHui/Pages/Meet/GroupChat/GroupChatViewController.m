//
//  GroupChatViewController.m
//  HuiHui
//
//  Created by mac on 14-8-21.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "GroupChatViewController.h"

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

#import "groupChatCell.h"

#import "UIImageView+AFNetworking.h"

#import "XMPP_service.h"

#import "ChatGroup.h"

#import "XMPPRoomCoreDataStorage.h"



#import "MultiUserChatViewCtl.h"



@interface GroupChatViewController ()
{
    XMPPRoom *_xmppRoom;
}

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UILabel *m_tipLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@end

@implementation GroupChatViewController

@synthesize m_friendsList;

@synthesize m_allKeys;

@synthesize m_FriendsListDic;

@synthesize m_section;

@synthesize m_index;

@synthesize m_userId;

@synthesize m_userArray;

@synthesize m_selectedDic;

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
        
        m_userArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_selectedDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        // test
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goGroupChat) name:@"CreateGroupChatting" object:nil];

    }
    return self;
}

- (void)goGroupChat{
    
    
    ChatGroup *group = Appdelegate.HHcreateGroupResult;
    
    NSArray *arr = [group.groupId componentsSeparatedByString:@"@conference"];
    
    NSLog(@"arr[0]= %@",[arr objectAtIndex:0]);
    
    // 保存群消息的数据
    /*
    //创建message对象
    MessageObject *msg = [[MessageObject alloc]init];
//    [msg setMessageDate:[NSDate date]];
//    [msg setMessageFrom:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID]];
//    
//    [msg setMessageTo:strs[0]];
//    //判断多媒体消息
//    NSDictionary *messageDic = [body JSONValue];
//    
//    [msg setMessageType:[NSNumber numberWithInt:[[messageDic objectForKey:@"messageType"] intValue]]];
//    [msg setMessageContent:saveVoiceFilePath];
    [msg setIsRead:@"0"];
    [MessageObject save:msg];

    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID],kUSER_FRIENDID,[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]],kUSER_ID,[group getName],kUSER_NICKNAME,@"",kUSER_DESCRIPTION,[CommonUtil getValueByKey:OTHERHEADERIMAGE],kUSER_USERHEAD,[NSNumber numberWithInt:1],kUSER_FRIEND_FLAG, nil];
    
    Userobject *user = [Userobject userFromDictionary:dic];
    [Userobject saveNewUser:user];
    
    
    */
    
    
    Appdelegate.isHello = YES;
    
    // 进入聊天的页面
    SendMessageViewController *VC = [[SendMessageViewController alloc]initWithNibName:@"SendMessageViewController" bundle:nil];
    
    VC.m_chatPerson.userId = [NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    VC.m_chatPerson.userNickName = [NSString stringWithFormat:@"%@",Appdelegate.HHcreateRoomName];
    VC.m_chatPerson.userHead = @"";
    VC.group = group;
    VC.m_typeFrom = @"GroupChat";
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"发起群聊"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    if ( isIOS7 ) {
        
        // section索引的背景色-右边排序的ABCD所在的视图
        self.m_tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        // section索引的背景色-右边排序的ABCD字体颜色
        //    self.m_tableView.sectionIndexColor = [UIColor grayColor];
    }
    
    self.m_tipLabel.hidden = NO;
    
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
    
    static NSString *cellIdentifier = @"groupChatCellIdentifier";
    
    groupChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"groupChatCell" owner:self options:nil];
        
        cell = (groupChatCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if ( self.m_allKeys.count != 0 ) {
        
        // 赋值
        NSString *key = [self.m_allKeys objectAtIndex:indexPath.section];
        
        NSArray *array = [self.m_FriendsListDic objectForKey:key];
        
        NSDictionary *dic = [array objectAtIndex:indexPath.row];
        
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RealName"]];
        
        [cell setImageViewWithPath:[NSString stringWithFormat:@"%@",[dic objectForKey:@"PhotoUrl"]]];
        
        cell.m_btn.userInteractionEnabled = NO;

        // MemberID 是NSNumber类型的，不是NSString类型的
        NSString *memberId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]];
      
        NSString *memIdString = [self.m_selectedDic objectForKey:memberId];
        
        if ( [memIdString isEqualToString:@"1"] ) {
            
            [cell.m_btn setImage:[UIImage imageNamed:@"group_chat_selected.png"] forState:UIControlStateNormal];

        }else{
            
            [cell.m_btn setImage:[UIImage imageNamed:@"group_chat_normal.png"] forState:UIControlStateNormal];

        }

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
    l_View.backgroundColor = [UIColor colorWithRed:236.0/255 green:230.0/255 blue:240.0/255 alpha:1.0];
    
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
    
    // 赋值
    NSString *key = [self.m_allKeys objectAtIndex:indexPath.section];
    
    NSArray *array = [self.m_FriendsListDic objectForKey:key];
    
    NSDictionary *dic = [array objectAtIndex:indexPath.row];
   
    
    NSString *memberId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]];
    
    NSString *memIdKey = [self.m_selectedDic objectForKey:memberId];
    
    if ( [memIdKey isEqualToString:@"1"] ) {
        
        [self.m_selectedDic setValue:@"0" forKey:memberId];
        
        [self.m_userArray removeObject:dic];
        
    }else{
       
        [self.m_selectedDic setValue:@"1" forKey:memberId];
        
        [self.m_userArray addObject:dic];

    }
    
    
    // 刷新某一行
    NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section], nil];
    
    [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
    
    
    // 初始化上面的view，显示选择的用户所在的view
    [self initwithUserView];

  
}

- (void)initwithUserView{
    
    for (UIButton *btn in self.m_scrollerView.subviews) {
        
        [btn removeFromSuperview];
        
    }
    
    float sum = 0.0;
    
    
    if ( self.m_userArray.count != 0 ) {
        
        // 设置右上角的确定按钮
        [self setRightButtonWithTitle:@"确定" action:@selector(sureToGroupChat)];
        
        self.m_tipLabel.hidden = YES;
        
        for (int i = 0; i < self.m_userArray.count; i++) {
            
            NSDictionary *dic = [self.m_userArray objectAtIndex:i];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(10 + 40 * i, 15, 30, 30);
            btn.backgroundColor = [UIColor redColor];
            
            NSString *userHeadImage = [dic objectForKey:@"PhotoUrl"];
            
            UIImageView *imagV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
            
            [imagV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:userHeadImage]]
                                          placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                       
                                                       imagV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                                       imagV.contentMode = UIViewContentModeScaleAspectFit;
                                                       
                                                       // btn赋值背景图片
                                                       [btn setImage:imagV.image forState:UIControlStateNormal];
                                                       
                                                   }
                                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                       
                                                   }];
            
            
            [self.m_scrollerView addSubview:btn];
            
            sum = 40 * (i + 1);
            
            
            if ( sum >= 320.0) {
                
                [self.m_scrollerView setContentSize:CGSizeMake(sum + 40, 60)];
                
                [self.m_scrollerView setContentOffset:CGPointMake(40 * (i - 6), 0)];
                
            }else{
                
                [self.m_scrollerView setContentSize:CGSizeMake(0, 60)];
                
                [self.m_scrollerView setContentOffset:CGPointMake(0, 0)];

                
            }
            
        }
        

    }else{
        
        self.m_tipLabel.hidden = NO;
        
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    
}

- (void)sureToGroupChat{
    
    if ( Appdelegate.gChatGroups.count != 0 ) {
        
        [Appdelegate.gChatGroups removeAllObjects];
    }
    
    NSLog(@"m_userArray = %@,m_userArray.count = %i",self.m_userArray,self.m_userArray.count);
    
    if ( self.m_userArray.count == 1 ) {
        // 数组里只有一个数据时，则表示和某个人聊天-进入聊天的页面
        
        NSDictionary *dic = [self.m_userArray objectAtIndex:0];
        
        
        // 保存聊天的对象的memberId
        [CommonUtil addValue:[dic objectForKey:@"MemberID"] andKey:OTHERMEMBERID];
        
        [CommonUtil addValue:[dic objectForKey:@"NickName"] andKey:OTHERUSERNAME];
        
        [CommonUtil addValue:[dic objectForKey:@"PhotoUrl"] andKey:OTHERHEADERIMAGE];
        
        // 进入聊天的页面
        SendMessageViewController *VC = [[SendMessageViewController alloc]initWithNibName:@"SendMessageViewController" bundle:nil];
        VC.m_chatPerson.userId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]];
        VC.m_chatPerson.userNickName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"NickName"]];
        VC.m_chatPerson.userHead = [NSString stringWithFormat:@"%@",[dic objectForKey:@"PhotoUrl"]];
        [self.navigationController pushViewController:VC animated:YES];
        
        
    }else{
        
        // 表示多人聊天
        NSString *nameString = @"";

//        NSString *nameString1 = @"";

        if ( Appdelegate.HHinitRoomUsers.count != 0 ) {
            
            [Appdelegate.HHinitRoomUsers removeAllObjects];
        }
        
        // 发起群聊的人
//        [self.m_userArray addObject:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:NICK]]];
        
        NSDictionary *l_dic = [NSDictionary dictionaryWithObjectsAndKeys:[CommonUtil getValueByKey:MEMBER_ID],@"MemberID",[CommonUtil getValueByKey:NICK],@"NickName",[CommonUtil getValueByKey:USER_PHOTO],@"PhotoUrl",[CommonUtil getValueByKey:USER_NAME],@"RealName",nil];
        
        [self.m_userArray addObject:l_dic];
        
        
        NSLog(@"groupMembers = %@",Appdelegate.GroupMembers);
        
        
        for (int i = 0; i < self.m_userArray.count; i++) {
            
            NSMutableDictionary *dic = [self.m_userArray objectAtIndex:i];
            
            NSString *string = [NSString stringWithFormat:@"%@",[dic objectForKey:@"NickName"]];

//            NSString *string1 = [NSString stringWithFormat:@"%@|%@|%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"MemberID"],[dic objectForKey:@"PhotoUrl"]];

            if ( i == self.m_userArray.count - 1 ) {
                
                nameString = [nameString stringByAppendingString:[NSString stringWithFormat:@"%@",string]];
                
//                nameString1 = [nameString1 stringByAppendingString:[NSString stringWithFormat:@"%@",string1]];
                
            }else{
                
                nameString = [nameString stringByAppendingString:[NSString stringWithFormat:@"%@,",string]];
                
//                nameString1 = [nameString1 stringByAppendingString:[NSString stringWithFormat:@"%@,",string1]];


            }
            
            [Appdelegate.HHinitRoomUsers addObject:[dic objectForKey:@"MemberID"]];

        }
        
        
        NSLog(@"nameString = %@",nameString);
        Appdelegate.HHcreateRoomName = [NSString stringWithFormat:@"%@",nameString];
        
//        Appdelegate.GroupMembers = [NSString stringWithFormat:@"%@",nameString1];
        
        // 将群里所有人的信息拼接成字符存储起来
        NSString *string1 = [NSString stringWithFormat:@"%@|%@|%@",[CommonUtil getValueByKey:NICK],[CommonUtil getValueByKey:MEMBER_ID],[CommonUtil getValueByKey:USER_PHOTO]];
        
        Appdelegate.AllMessageOfGroup = [NSString stringWithFormat:@"%@",string1];
        
//        // 创建房间
        [self createGroup];
        
        
//        MultiUserChatViewCtl *multiChatCtl = [[MultiUserChatViewCtl alloc] init];
//        
//        [self.navigationController pushViewController:multiChatCtl animated:YES];
        
        
    }
    
    
}


- (void) createGroup{
    
    [XMPP_service presenceGroup];
    
//    [self performSelector:@selector(goGroupChat) withObject:self afterDelay:5.0f];
 
    
//    float waitTime = 0;
//    
//    while (YES) {
//        
//        if (waitTime > 15 || Appdelegate.HHcreateGroupResult) {
//            
//            NSLog(@"Appdelegate.HHcreateGroupResult = %@",Appdelegate.HHcreateGroupResult);
//           
//            break;
//        }
//        
//        [NSThread sleepForTimeInterval:0.1];
//        waitTime += 0.1f;
//        
//    }
//    
//    NSLog(@"time = %f",waitTime);
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        NSLog(@"Appdelegate.HHcreateGroupResult = %@",Appdelegate.HHcreateGroupResult);
//       
//        if ( Appdelegate.HHcreateGroupResult ) {
////            
////            ChatT *chatT = [[ChatT alloc] initWithNibName:@"ChatT"
////                                                   bundle:nil];
////            chatT.group = createGroupResult;
////            chatT.intent = @{@"fresh":@YES};
////            [self.navigationController pushViewController:chatT
////                                                 animated:YES];
//            
//            NSLog(@"创建");
//            
//
//        }else{
////            [self tk:@"操作超时,创建聊天室失败"];
//            
//            [SVProgressHUD showErrorWithStatus:@"操作超时,创建聊天室失败"];
//        }
//    });
}


// 好友列表进行字母分类
- (void)sortFriends{
    
    // 先清空字典里的数据
    if ( self.m_selectedDic.count != 0 ) {
        
        [self.m_selectedDic removeAllObjects];
        
    }
    
    for (int i = 0; i< self.m_friendsList.count; i++) {
        NSDictionary *dic = [self.m_friendsList objectAtIndex:i];
        
        NSString *pinyin = [self firstLetterForCompositeName:[dic objectForKey:@"RealName"]];
        
        NSArray *array = [self sortBypinyin:pinyin];
        
        [self.m_FriendsListDic setObject:array forKey:pinyin];
        
        // 首次默认是否选择某个用户为0
        [self.m_selectedDic setValue:@"0" forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]]];
        
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
