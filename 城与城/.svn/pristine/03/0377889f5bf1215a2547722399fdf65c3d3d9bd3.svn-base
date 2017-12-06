//
//  MeetViewController.m
//  HuiHui
//
//  Created by mac on 13-11-19.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "MeetViewController.h"

#import "NewsCell.h"

#import "MessageViewController.h"

#import "LifeInformationViewController.h"

#import "SystemMessagesViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "SendMessageViewController.h"

#import "XMPPManager.h"

#import "MessageObject.h"

#import "MessageAndUserObject.h"

#import "FriendsListViewController.h"

#import "RightCell.h"

#import "InviteViewController.h"

#import "Send_merchantViewController.h"

#import "Configuration.h"

#import "GroupChatViewController.h"

#import "XMPP_service.h"

#import "ChatGroup.h"


#import "GroupChatObject.h"

#import "GroupObject.h"


@interface MeetViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet TableViewWithBlock *m_popTableView;

@property (weak, nonatomic) IBOutlet UIControl *m_backView;

// view点击事件
- (IBAction)alphaviewtap:(id)sender;


@end

@implementation MeetViewController

@synthesize m_InfoArray;
@synthesize m_messageArray;
@synthesize m_chatList;
@synthesize m_count;
@synthesize m_popArray;
@synthesize isEnterChat;
@synthesize m_infoDic;

@synthesize m_list;

+(MeetViewController*)shareobject;
{
    static MeetViewController*viewcontroller=nil;
    if (viewcontroller==nil)
    {
        viewcontroller=[[MeetViewController alloc]init];
    }
    return viewcontroller;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_InfoArray = [[NSMutableArray alloc]initWithCapacity:0];

        m_messageArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_chatList = [[NSMutableArray alloc]initWithCapacity:0];

        m_popArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_infoDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_list = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_count = 0;
        
        arrayCount = 0;
        
        unReadMessageCount = 0;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMsgCome:) name:kXMPPNewMsgNotifaction object:nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"消息"];
         
    isFirst = YES;
    
//    [self setRightButtonWithNormalImage:@"add.png" action:@selector(rightClicked)];
    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0, 0, 60, 29)];
    _button.backgroundColor = [UIColor clearColor];
    _button.titleLabel.font = [UIFont boldSystemFontOfSize:30.0f];
    [_button setTitle:@"+" forState:UIControlStateNormal];
    //    _button.layer.borderWidth = 1.0;
    //    _button.layer.borderColor = [UIColor whiteColor].CGColor;
    [_button addTarget:self action:@selector(rightClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
    [self.navigationItem setRightBarButtonItem:_barButton];
    
    // 隐藏tableView
    self.m_tableView.hidden = YES;
    
    tableViewOpened = NO;
    
    self.m_popTableView.hidden = YES;
    
    self.m_popTableView.frame = CGRectMake(170, 0, 150, 0);
    
    self.m_popArray = [NSMutableArray arrayWithObjects:@"发起聊天",@"邀请好友", nil];
    
    // 加载pop tableView上面的数据
    [self loadTableView];

    // 进入后将数据库中的数据清空重新赋值===========
    NSMutableArray *array = [GroupChatObject fetchGroupByPage:1];
    
    if ( array.count != 0 ) {
        
        for (int i = 0; i < array.count; i++) {
            
            // 清空
            if ( [GroupChatObject deleteFromAllMessage] ) {
                
                [GroupChatObject deleteGroupMessage];
                
            }
            
        }
       
    }
    // =================
   
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 当数组值为空的时候进行请求数据
    if ( self.m_InfoArray.count == 0 ) {
        
        // 请求数据
        [self requestInfoSubmit];
    }
   
    // 刷新数组
    [self refresh];
    
    self.isEnterChat = NO;
    

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMsgCome:) name:kXMPPNewMsgNotifaction object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatGroup:) name:@"groups_change" object:nil];
    
    // 获取群聊的列表
    [XMPP_service getGroups];
    
  
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    
    // 第一次进入时获取到的群聊消息不产生声音,之后收到消息后将产生声音
    Appdelegate.isFirstGroup = NO;

    if ( self.isEnterChat ) {
        
        self.m_tableView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height - 49);

    }else{
        
        self.m_tableView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    }
    
//    if ( !self.m_popTableView.hidden ) {
//        
//        [self rightClicked];
//        
////        self.m_popTableView.hidden = YES;
////        
////        self.m_backView.alpha = 0.0f;
////        
////        tableViewOpened = NO;
//
//    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMsgCome:) name:kXMPPNewMsgNotifaction object:nil];
    
//       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatGroup:) name:@"groups_change" object:nil];
}

// 有人邀请加入群聊
- (void)chatGroup:(NSNotification *)notification{
    
    NSLog(@"chatGroup");
    
//    [SVProgressHUD showErrorWithStatus:@"有人邀请你加入群聊"];
    
    
//    NSLog(@"Appdelegate.gChatGroups = %@,count = %i",Appdelegate.gChatGroups,Appdelegate.gChatGroups.count);
//    
//
//    for (int i = 0; i < Appdelegate.gChatGroups.count; i ++) {
//        
//        ChatGroup *group = [Appdelegate.gChatGroups objectAtIndex:i];
//        
//        NSLog(@"group getName = %@",[group getName]);
//
//        
//        NSLog(@"isself = %i,name = %@,groupId = %@",[group isSelfOwner],[group getName],group.groupId);
//        
//        NSLog(@"group.data = %@",group.data);
//
//    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightClicked{
    
    NSLog(@"tableViewOpened = %i",tableViewOpened);
    
    if ( tableViewOpened ) {
        
        self.m_popTableView.hidden = YES;
 
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_popTableView.frame;
            
            frame.size.height = 0;
            
            [self.m_popTableView setFrame:frame];
          
            self.m_backView.alpha = 0.0f;
            
            
        } completion:^(BOOL finished){
            
            tableViewOpened = NO;
        }];
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.m_popTableView.hidden = NO;
            
            self.m_backView.alpha = 0.3f;

            CGRect frame = self.m_popTableView.frame;
            
            
            int fr = self.m_popArray.count * 44;
            
            
            if (fr > 300) {
              
                frame.size.height = 300;
          
            }else {
               
                frame.size.height = fr;
                
            }
            
            
            [self.m_popTableView setFrame:frame];
            
            
        } completion:^(BOOL finished){
            
            tableViewOpened = YES;
            
        }];
        
    }

}

// 加载popTableView上面的内容
- (void)loadTableView{
    
    self.m_backView.alpha = 0.0f;

    
    [self.m_popTableView initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count = self.m_popArray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightCell"];
         
         if (!cell)
         {
             cell = [[[NSBundle mainBundle]loadNibNamed:@"RightCell" owner:self options:nil]objectAtIndex:0];
             
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
             
             cell.selectionStyle = UITableViewCellAccessoryDisclosureIndicator;
         }
         
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.m_popArray objectAtIndex:indexPath.row]]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {

         if (indexPath.row == 0) {
             
             // 进入好友列表的页面
//             FriendsListViewController *VC = [[FriendsListViewController alloc]initWithNibName:@"FriendsListViewController" bundle:nil];
//             VC.m_typeString = @"1";
//             [self.navigationController pushViewController:VC animated:YES];
             
             
             // 进入群聊的页面
             GroupChatViewController *VC = [[GroupChatViewController alloc]initWithNibName:@"GroupChatViewController" bundle:nil];
             [self.navigationController pushViewController:VC animated:YES];
             
             
         }else if (indexPath.row ==1)
         {
          
             // 进入邀请好友的页面
             InviteViewController *VC = [[InviteViewController alloc]initWithNibName:@"InviteViewController" bundle:nil];
             VC.stringType = @"3";
             VC.m_phoneString = @"";

             [self.navigationController pushViewController:VC animated:YES];
             
         }
         
          [self alphaviewtap:nil];
         
     }];
    
    [self.m_popTableView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.m_popTableView.layer setBorderWidth:0];


}


- (IBAction)alphaviewtap:(id)sender {
    
    [self rightClicked];
    
}

#pragma mark  接受新消息广播
-(void)newMsgCome:(NSNotification *)notifacation
{
    
    [self.tabBarController.tabBarItem setBadgeValue:@"1"];
    
    //[WCMessageObject save:notifacation.object];
    
    [self refresh];
    
}

- (void)refresh
{
    
    NSLog(@"appde = %@",Appdelegate.m_groupList);
    
    if ( Appdelegate.isAddToBase ) {
        
        Appdelegate.isAddToBase = NO;
        
        [Appdelegate.m_groupList addObjectsFromArray:[GroupChatObject fetchGroupByPage:1]];
    }
    
    self.m_chatList = [MessageObject fetchRecentChatByPage:1];
    
    unReadMessageCount = 0;
    
    // 判断有多少未读的消息
    for (int i = 0; i < self.m_chatList.count; i++) {
        
        MessageAndUserObject *object = [self.m_chatList objectAtIndex:i];
        
        NSInteger unReadCount = [MessageObject fetchCountWithUser:object.user.userId byPage:1];
        
        unReadMessageCount = unReadMessageCount + unReadCount;
    
    }
    
    //=========
    NSMutableArray *arr = [GroupChatObject fetchAllGroup];
    
    NSLog(@"arr = %@",arr);
    
    NSMutableArray *l_arr = [[NSMutableArray alloc]initWithCapacity:0];
    
    if ( Appdelegate.m_groupList.count == arr.count ) {
        
        [l_arr addObjectsFromArray:Appdelegate.m_groupList];
        
        
        [Appdelegate.m_groupList removeAllObjects];
        
        // 判断有多少未读的消息
        for (int i = 0; i < l_arr.count; i++) {
            
            MessageAndUserObject *object = [l_arr objectAtIndex:i];

            GroupObject *object1 = [arr objectAtIndex:i];
            
            object.object = object1;
            
            [Appdelegate.m_groupList addObject:object];
            
        }
        
    }
    //=========
    
    
//    // 判断有多少未读的消息
    for (int i = 0; i < Appdelegate.m_groupList.count; i++) {
        
        MessageAndUserObject *object = [Appdelegate.m_groupList objectAtIndex:i];
        
        NSInteger unReadCount = [GroupChatObject fetchCountWithUser:object.object.userId byPage:1];
        
        unReadMessageCount = unReadMessageCount + unReadCount;
        
        
    }
    
    // 设置tabBar上面的数字显示
    if ( unReadMessageCount != 0 ) {
        
        // 大于99的时候显示99+
        if ( unReadMessageCount > 99 ) {
        
            self.navigationController.tabBarItem.badgeValue = @"99+";
            
        }else{
            
            [self.navigationController.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%i",unReadMessageCount]];

        }
        
    }else{
        
        self.navigationController.tabBarItem.badgeValue = nil;
    }
    
    
    [self.m_tableView reloadData];
    
}

// 请求数据
- (void)requestInfoSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"1",     @"pageIndex",
                           memberId,@"memberId",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"InfoList_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
//            [SVProgressHUD dismiss];
            
            [self.m_InfoArray removeAllObjects];
            
            self.m_InfoArray = [json valueForKey:@"info"];
            
            self.m_infoDic = [json valueForKey:@"TeamInfo"];
                        
            NSString *messageContent = [NSString stringWithFormat:@"%@",[self.m_infoDic objectForKey:@"Message"]];
            
            // 默认将数据存储到数据库里面，相当于是第一个提示用户
            
            if ( messageContent.length != 0 ) {
                
                // 将这条消息保存到数据库里
                // =========
                
                //创建message对象
                MessageObject *msg = [[MessageObject alloc]init];
                [msg setMessageDate:[NSDate date]];
                [msg setMessageFrom:[self.m_infoDic objectForKey:@"MemberId"]];
                [msg setMessageContent:messageContent];
                [msg setMessageTo:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID]];
                [msg setMessageType:[NSNumber numberWithInt:0]];
                [msg setIsRead:@"1"];
                
                if ( ![Userobject haveSaveUserById:[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID] withFriendId:[self.m_infoDic objectForKey:@"MemberId"]]) {
                    
                    // 保存
                    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID],kUSER_FRIENDID,[self.m_infoDic objectForKey:@"MemberId"],kUSER_ID,[self.m_infoDic objectForKey:@"NickName"],kUSER_NICKNAME,messageContent,kUSER_DESCRIPTION,[self.m_infoDic objectForKey:@"PhotoUrl"],kUSER_USERHEAD,[NSNumber numberWithInt:1],kUSER_FRIEND_FLAG, nil];
                    
                    Userobject *user = [Userobject userFromDictionary:dic];
                    [Userobject saveNewUser:user];
                    
                    
                }
                
                // 保存聊天发送的时间
                [MessageObject save:msg];
                
                
                // 刷新数组
                [self refresh];
                
            }
            
            // 请求消息的接口
            [self requestmessageSubmit];
            
        } else {
           
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

// 请求数据
- (void)requestmessageSubmit{
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"1",     @"pageIndex",nil];
    
//    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MessageList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            [self.m_messageArray removeAllObjects];

            self.m_messageArray = [json valueForKey:@"messageInfo"];
            
            // 显示刷新tableView
            self.m_tableView.hidden = NO;
            
            [self.m_tableView reloadData];
            
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return 2 + self.m_chatList.count;
    
    if ( section == 0 ) {
        
        return 2;
        
    }else if ( section == 1 ){
        
        return self.m_chatList.count;

    }else{
        
        return Appdelegate.m_groupList.count;

    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"NewsCellIdentifier";
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewsCell" owner:self options:nil];
        
        cell = (NewsCell *)[nib objectAtIndex:0];
        
        
        // cell的选中状态
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    // 赋值
    if ( indexPath.section == 0 ) {
        
        if ( indexPath.row == 0 ) {
            
            if ( self.m_InfoArray.count != 0 ) {
                
                cell.m_nameLabel.text = @"生活资讯";
                
                NSMutableDictionary *dic = [self.m_InfoArray objectAtIndex:0];
                
                cell.m_detailIntro.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Title"]];
                
                cell.m_imageView.backgroundColor = [UIColor clearColor];
                
                cell.m_imageView.image = [UIImage imageNamed:@"zixun.png"];
                
                cell.m_timeLabel.hidden = YES;
                
                cell.m_backImgV.hidden = YES;
                
                cell.m_countLabel.hidden = YES;
                
            }
            
        }else if ( indexPath.row == 1 ){
            
            if ( self.m_messageArray.count != 0 ) {
                
                cell.m_nameLabel.text = @"系统消息";
                
                NSMutableDictionary *dic = [self.m_messageArray objectAtIndex:0];
                
                cell.m_detailIntro.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MsgTitle"]];
                
                cell.m_imageView.backgroundColor = [UIColor clearColor];
                
                cell.m_imageView.image = [UIImage imageNamed:@"xiaoxi.png"];
                
                cell.m_timeLabel.hidden = YES;
                
                cell.m_backImgV.hidden = YES;
                
                cell.m_countLabel.hidden = YES;
            }
            
        }
    }else if ( indexPath.section == 1 ){
        
        // 个人聊天进行赋值
        if ( self.m_chatList.count != 0 ) {
            
            cell.hidden = NO;
            
            MessageAndUserObject *object = [self.m_chatList objectAtIndex:indexPath.row];
            
            cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",object.user.userNickName];
            cell.m_nameLabel.font = [UIFont systemFontOfSize:16.0f];

            // 判断发来的是图片还是文本
            if ( [object.message.messageType intValue] == kWCMessageTypeImage ) {
                
                cell.m_detailIntro.text = @"[一张图片]";

            }else if ( [object.message.messageType intValue] == kWCMessageTypePlain ){
                
                
                // ==表情时候做的判断
                NSString *result = object.message.messageContent;
                
                while (true) {
                    
                    NSRange range = [result rangeOfString:@"/:HH"];
                    
                    if (range.location == NSNotFound ) {
                        
                        break;
                    }
                 
                    // 判断字符的长度用于删除字符时做的处理
                    if ( result.length < range.location + 8 ) {
                        
                        break;
                    }
                    //====
                    
                    NSString *endString = [result substringWithRange:NSMakeRange(range.location+7, 1)];
                    
                    if(nil == endString || NO == [@":" isEqualToString:endString]){
                        
                        break;
                    }
                    
                    NSString *rawTag = [result substringWithRange:NSMakeRange(range.location,8)];

                    NSString *coreText = @"[表情]";

                    result = [result stringByReplacingOccurrencesOfString:rawTag withString:coreText];
                }
                
                
                cell.m_detailIntro.text = [NSString stringWithFormat:@"%@",result];
                
//                cell.m_detailIntro.text = [NSString stringWithFormat:@"%@",object.message.messageContent];

            }else if ( [object.message.messageType intValue] == kWCMessageTypeVoice ){
                
                cell.m_detailIntro.text = @"[一段语音]";
                
            }else{
                
                
            }
            
            cell.m_imageView.backgroundColor = [UIColor clearColor];
            
            
            //        cell.m_imageView.image = [UIImage imageNamed:@"invite_reg_no_photo.png"];
            
            [cell setImageViewWithPath:object.user.userHead];
            
            cell.m_timeLabel.hidden = NO;
            
            // 判断未读消息的条数
            NSInteger unReadCount = [MessageObject fetchCountWithUser:object.user.userId byPage:1];

            if ( unReadCount != 0 ) {
                
                cell.m_backImgV.hidden = NO;
                
                cell.m_countLabel.hidden = NO;
                
                if ( unReadCount > 99 ) {
                  
                    cell.m_countLabel.text = @"99+";
                    
                }else{
                    
                    cell.m_countLabel.text = [NSString stringWithFormat:@"%i",unReadCount];
                    
                }

            }else{
                
                cell.m_backImgV.hidden = YES;
                
                cell.m_countLabel.hidden = YES;
                
            }
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//            [formatter setAMSymbol:@"上午"];
//            [formatter setPMSymbol:@"下午"];
//            [formatter setDateFormat:@"a HH:mm"];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            
            [cell.m_timeLabel setText:[formatter stringFromDate:object.message.messageDate]];
            
          
            
        }else{
            
            cell.hidden = YES;
        }
        
    }else{
        
        // 群聊赋值
        if ( Appdelegate.m_groupList.count != 0 ) {
            
            cell.hidden = NO;
            
            // 赋值
            MessageAndUserObject *object = [Appdelegate.m_groupList objectAtIndex:indexPath.row];
            
            ChatGroup *group = (ChatGroup *)[self getGroupById:object.groupObject.messageTo];
            
            //            cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",object.object.userNickName];
            
            NSLog(@"name = %@",[group getName]);
            
            NSString *string = [NSString stringWithFormat:@"%@",[group getName]];
            
            if ( ![string isEqualToString:@"(null)"] ) {
                
                cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",string];
                
            }
            
            cell.m_nameLabel.font = [UIFont systemFontOfSize:12.0f];
            
            // 判断发来的是图片还是文本
            if ( [object.groupObject.messageType intValue] == kWCMessageTypeImage ) {
                
                cell.m_detailIntro.text = [NSString stringWithFormat:@"%@",object.object.userDescription];
                
            }else if ( [object.groupObject.messageType intValue] == kWCMessageTypePlain ){
                
                // ==表情时候做的判断
                NSString *result = object.object.userDescription;
                
                while (true) {
                    
                    NSRange range = [result rangeOfString:@"/:HH"];
                    
                    if (range.location == NSNotFound ) {
                        
                        break;
                    }
                    
                    // 判断字符的长度用于删除字符时做的处理
                    if ( result.length < range.location + 8 ) {
                        
                        break;
                    }
                    //====
                    
                    NSString *endString = [result substringWithRange:NSMakeRange(range.location+7, 1)];
                    
                    if(nil == endString || NO == [@":" isEqualToString:endString]){
                        
                        break;
                    }
                    
                    NSString *rawTag = [result substringWithRange:NSMakeRange(range.location,8)];
                    
                    NSString *coreText = @"[表情]";
                    
                    result = [result stringByReplacingOccurrencesOfString:rawTag withString:coreText];
                }
                
                
                cell.m_detailIntro.text = [NSString stringWithFormat:@"%@",result];
                
                //                cell.m_detailIntro.text = [NSString stringWithFormat:@"%@",object.message.messageContent];
                
            }else if ( [object.groupObject.messageType intValue] == kWCMessageTypeVoice ){
                
                cell.m_detailIntro.text = [NSString stringWithFormat:@"%@",object.object.userDescription];
                
            }else{
                
                
            }
            
            cell.m_imageView.backgroundColor = [UIColor clearColor];
            
            cell.m_imageView.image = [UIImage imageNamed:@"group_Chat.png"];
            
            //            [cell setImageViewWithPath:object.user.userHead];
            
            cell.m_timeLabel.hidden = NO;
            
            // 判断未读消息的条数
            NSInteger unReadCount = [GroupChatObject fetchCountWithUser:object.object.userId byPage:1];
            
            if ( unReadCount != 0 ) {
                
                cell.m_backImgV.hidden = NO;
                
                cell.m_countLabel.hidden = NO;
                
                if ( unReadCount > 99 ) {
                    
                    cell.m_countLabel.text = @"99+";
                    
                }else{
                    
                    cell.m_countLabel.text = [NSString stringWithFormat:@"%i",unReadCount];
                    
                }
                
            }else{
                
                cell.m_backImgV.hidden = YES;
                
                cell.m_countLabel.hidden = YES;
                
            }
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//                          [formatter setAMSymbol:@"上午"];
//                          [formatter setPMSymbol:@"下午"];
//                          [formatter setDateFormat:@"a HH:mm"];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            
            // 将时间赋值为聊天的最新时间
            NSMutableArray *array = [GroupChatObject fetchGroupList:group.groupIdMain byPage:1];

            if ( array.count != 0 ) {
                
                GroupChatObject *obj = (GroupChatObject *)[array objectAtIndex:array.count - 1];

                [cell.m_timeLabel setText:[formatter stringFromDate:obj.messageDate]];

            }else{
                
                [cell.m_timeLabel setText:[formatter stringFromDate:object.groupObject.messageDate]];
                
            }
            
            // 如果值为空则赋值为当前的时间
            if ( [cell.m_timeLabel.text isEqualToString:@"null"] ) {
                
                [cell.m_timeLabel setText:[formatter stringFromDate:[NSDate date]]];

            }
    
            
        }else{
            
            
            cell.hidden = YES;
            
        }
        
    }
    
    return cell;
}

- (ChatGroup *) getGroupById:(NSString *) key{
    
    for (ChatGroup *each in Appdelegate.gChatGroups) {
        
        if ([each.groupIdMain rangeOfString:key].location != NSNotFound) {
            return each;
        }
    }
    return nil;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 0 ) {
        
        return 60.0f;
        
    }else if ( indexPath.section == 1 ){
        
        if ( self.m_chatList.count != 0 ) {
            
            return 60.0f;
            
        }else{
            
            return 0.0f;
            
        }

    }else{
        
        if ( Appdelegate.m_groupList.count != 0 ) {
            
            return 60.0f;
            
        }else{
            
            return 0.0f;
        }
        
        
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.isEnterChat = YES;
    
    if ( indexPath.section == 0 ) {

        if ( indexPath.row == 0 ) {
            
            // 进入生活资讯
            LifeInformationViewController *VC = [[LifeInformationViewController alloc]initWithNibName:@"LifeInformationViewController" bundle:nil];
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ( indexPath.row == 1 ) {
            
            // 系统消息
            SystemMessagesViewController *VC = [[SystemMessagesViewController alloc]initWithNibName:@"SystemMessagesViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
        }
    }else if ( indexPath.section == 1 ){
        
        // 个人聊天
        MessageAndUserObject *unionObj = [self.m_chatList objectAtIndex:indexPath.row];
        
        NSString *friendFlag = [NSString stringWithFormat:@"%@",unionObj.user.friendFlag];
        
        if ( [friendFlag isEqualToString:@"1"] ) {
            
            // 进入聊天的页面
            SendMessageViewController *VC = [[SendMessageViewController alloc]initWithNibName:@"SendMessageViewController" bundle:nil];
            VC.m_chatPerson = unionObj.user;
            //        VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            
        }else{
            
            // 进入商户的聊天页面
            Send_merchantViewController *VC = [[Send_merchantViewController alloc]initWithNibName:@"Send_merchantViewController" bundle:nil];
            VC.m_MemberRelationsId = friendFlag;
            VC.m_typeString = @"1";
            VC.m_xiaoxiString = @"1";
            [self.navigationController pushViewController:VC animated:YES];
            
            
        }

    } else{
        
        // 群聊
        MessageAndUserObject *unionObj = [Appdelegate.m_groupList objectAtIndex:indexPath.row];
        
        ChatGroup *group = (ChatGroup *)[self getGroupById:unionObj.groupObject.messageTo];
        
        
        NSLog(@"mesgId = %@",unionObj.object.userId);
        
        Appdelegate.m_groupIndex = indexPath.row;
        
        Appdelegate.m_groupUserId = [NSString stringWithFormat:@"%@",unionObj.object.userId];
        
        NSLog(@"unionObj.object.userNickName = %@",unionObj.object.userNickName);
        
        // 保存userNickName，此值是记录群主的名称的值，保存起来用于判断群的详情里面是删除该群还是退出该群
        [CommonUtil addValue:unionObj.object.userNickName andKey:GroupNickName];
        
        
        // =============test===========
        if ( group ) {
            
            // 进入聊天的页面
            SendMessageViewController *VC = [[SendMessageViewController alloc]initWithNibName:@"SendMessageViewController" bundle:nil];
            //                VC.m_chatPerson = unionObj.user;
            VC.group = group;
            
            [XMPP_service presenceGroupWithGroup:group.data];
            
            NSLog(@"group.members = %@",group.members);
            
            if (nil == group.members) {
                [XMPP_service getGroupUsers:group.data];
            }
            
            //        VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            
        }
        
    }

}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        
        return YES;
    
    } else {
        
        return NO;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) { // product
        return UITableViewCellEditingStyleDelete;
    }
    else {
        
        return UITableViewCellEditingStyleNone;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        
//        if ( indexPath.section == 1 ) {
//            
//            m_index = indexPath.row;
//            
//            UIAlertView *deleAlert = [[UIAlertView alloc] initWithTitle:nil
//                                                                message:@"确定要删除此条聊天记录?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            deleAlert.tag = 1001;
//            [deleAlert show];
//            
//        }else
        
            if ( indexPath.section == 1 ){
            
            m_index = indexPath.row;
            
            UIAlertView *deleAlert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"确定要删除此条聊天记录?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            deleAlert.tag = 1000;
            [deleAlert show];
        }
     }
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"to delete:%d", indexPath.row);
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 1000 ) {
        
        if ( buttonIndex == 1 ) {
            
            MessageAndUserObject *object = [self.m_chatList objectAtIndex:m_index];
            
            if ( [MessageObject delereUserId:object.user.mesgId] ) {
                
                // 刷新数据
                [self refresh];
            }

            
        }else{
            
            
        }
    }else if ( alertView.tag == 1001 ){
        
        if ( buttonIndex == 1 ) {
            
            MessageAndUserObject *object = [Appdelegate.m_groupList objectAtIndex:m_index];
            
            if ( [GroupChatObject delereUserId:object.object.mesgId] ) {
                
                // 刷新数据
                [self refresh];
            }
            
            
        }else{
            
            
        }

    }
    
}



@end
