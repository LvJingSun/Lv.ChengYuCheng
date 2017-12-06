//
//  ChatDetailViewController.m
//  HuiHui
//
//  Created by mac on 14-10-9.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "ChatDetailViewController.h"

#import "XMPP_service.h"

#import "GroupChatObject.h"

#import "CommonUtil.h"

#import "GroupSettingCell.h"

#import "UserInformationViewController.h"

@interface ChatDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

// footerView
@property (strong, nonatomic) IBOutlet UIView *m_footerVire;


// 退出群
- (IBAction)exitGroup:(id)sender;

@end

@implementation ChatDetailViewController

@synthesize group;

@synthesize m_typeString;

@synthesize m_userName;

@synthesize m_groupMemberId;

@synthesize m_groupName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"群信息"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    // 添加通知
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(kickOutOther:) name:NOTIFY_KICK_OUT_OTHER object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(kickOutMe:) name:NOTIFY_KICK_OUT_ME object:nil];
   
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(modifyGroupName:) name:NOTIFY_MODIFY_GROUPNAME object:nil];
    
    // 对群主的名字进行赋值
    [self getGroupName];
    
    // 获取用户的名称
    NSString *nickName = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:NICK]];
    
    // 如果两值相等，则表示是群主，执行删除该群的功能；如果不是，则执行退出该群的功能
    if ( [self.m_userName isEqualToString:nickName] ) {
        
        // 设置tableView的footerView
        self.m_tableView.tableFooterView = self.m_footerVire;
        
    }else{
        
        
        // 设置tableView的footerView
        self.m_tableView.tableFooterView = nil;
    }
  
    
    // 赋值
    self.m_groupName = [NSString stringWithFormat:@"%@",[self.group getName]];
  

    
    
    NSLog(@"group.members = %@,group.data = %@",self.group.members,group.data);
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animate{
    
    [super viewWillDisappear:animate];
    
    [self hideTabBar:NO];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NOTIFY_KICK_OUT_OTHER object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NOTIFY_KICK_OUT_ME object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NOTIFY_MODIFY_GROUPNAME object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
    
}
// 获取群主的名字的方法
- (void)getGroupName{
    
    NSString *groupName = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:GroupNickName]];
  
    // 截取字符串-groupName是由群组的名字和memberId组成的，用“|”拼接的
    if ( [groupName rangeOfString:@"|"].location != NSNotFound ) {
        
        NSArray *l_arr = [groupName componentsSeparatedByString:@"|"];
        
        if ( l_arr.count != 0 ) {
            
            self.m_userName = [NSString stringWithFormat:@"%@",l_arr[0]];
            
            self.m_groupMemberId = [NSString stringWithFormat:@"%@",l_arr[1]];
            
        }
    }
    
}

- (IBAction)exitGroup:(id)sender {
    
    NSLog(@"self.group.data = %@",self.group.data);
    
//    [XMPP_service kickUserInGroup:self.group.data userId:197];

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确定退出群?"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
    alertView.tag = 11121;
    [alertView show];
 
}

- (void)modifyGroupName:(NSNotification *) notify{

    [SVProgressHUD showSuccessWithStatus:@"群名称修改成功!"];
    
    NSLog(@"m_groupName = %@",self.m_groupName);
    
    // 保存群的名称用于返回上一级时修改群的名称
    [CommonUtil addValue:self.m_groupName andKey:@"GroupName"];
    
    // 刷新列表
    [self.m_tableView reloadData];
    
}

- (void) kickOutOther:(NSNotification *) notify{
    
    NSLog(@"notifyOther = %@",notify);
    
    if(notify.object != self.group){
        return;
    }
//    [self.tableViewRef reloadData];
    
    NSLog(@"lickOutOther");
}

- (void) kickOutMe:(NSNotification *) notify{
    
    NSLog(@"notifyMe = %@",notify);

    if(notify.object != self.group){
        return;
    }
    
//    if(self.navigationController.visibleViewController == self){
//        
//        [self goBack];
//    
//    }else{
////        kickOuted = YES;
//        
//    }

    
    // 数组中删除数据
    [Appdelegate.m_groupList removeObjectAtIndex:Appdelegate.m_groupIndex];
   
    // 判断来自于哪个页面进行返回
    if ( [self.m_typeString isEqualToString:@"GroupChat"] ) {
        // 从添加群聊好友的页面过来进行退出群时直接返回最上级
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 4] animated:YES];
        
    }else{
        
        
        // 从消息页面过来进行退出群时直接返回最上级
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 3] animated:YES];
    }


    
    
    NSLog(@"lickOutMe");

    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"GroupSettingCellIdentifer";
    
    GroupSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"GroupSettingCell" owner:self options:nil];
        
        cell = (GroupSettingCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    
    if ( indexPath.row == 0 ) {
      
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        // 赋值
        cell.m_subName.text = @"群组名称";
        
        cell.m_name.text = [NSString stringWithFormat:@"%@",self.m_groupName];

    }else if ( indexPath.row == 1 ){
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        // 赋值
        cell.m_subName.text = @"群管理员";
        
        cell.m_name.text = [NSString stringWithFormat:@"%@",self.m_userName];
    }
    
    
    return cell;

    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if ( indexPath.row == 0 ) {
        
        // 将textField键盘上面的完成按钮隐藏
        [self hiddenNumPadDone:nil];
        
        // 获取用户的名称
        NSString *nickName = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:NICK]];
        
        // 如果两值相等，则表示是群主，执行删除该群的功能；如果不是，则执行退出该群的功能
        if ( [self.m_userName isEqualToString:nickName] ) {
            // 如果是群主的话则表示可以修改群组的名称
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"设置群名"
                                                                message:@""
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"确定", nil];
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            alertView.tag = 11109;
            [alertView show];
            
        }else{
            
            
        }
        
    }else if ( indexPath.row == 1 ){
        
        NSLog(@"self.m_id = %@",self.m_groupMemberId);
        
        // 知道群主的memberId查看群主的详细信息
        // 进入详细资料
        UserInformationViewController *VC = [[UserInformationViewController alloc]initWithNibName:@"UserInformationViewController" bundle:nil];
        VC.m_typeString = @"0";
        VC.m_chatString = @"1";
        ///// 好友Id================
        VC.m_friendId = [NSString stringWithFormat:@"%@",self.m_groupMemberId];
        [self.navigationController pushViewController:VC animated:YES];
    }

}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if( alertView.tag == 11109 ){
        if( buttonIndex == 1 ){
            
            NSString *text = [alertView textFieldAtIndex:0].text;
            
            // 赋值
            self.m_groupName = [NSString stringWithFormat:@"%@",text];
            
            [self.group changeName:text];
            
        }
    }else if ( alertView.tag == 11121 ){
        
        if ( buttonIndex == 1 ) {
           
            // 退出群
            NSString *nickName = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:NICK]];
            
            // 如果两值相等，则表示是群主，执行删除该群的功能；如果不是，则执行退出该群的功能
            if ( [self.m_userName isEqualToString:nickName] ) {
                
                [XMPP_service sendDismiss:self.group.data];
                
            }else{
                
                [XMPP_service sendLeave:self.group.data];
                
                
                // ======================
                // 删除数组中的值
                //        [Appdelegate.gChatGroups removeObject:group];
                // 数据库中删除数据
                if ( [GroupChatObject deleteMessageFromUserId:group.groupIdMain] ) {
                    if ( [GroupChatObject delereUserId:group.groupIdMain] ) {
                    }
                }
                
                
                // 数组中删除数据
                [Appdelegate.m_groupList removeObjectAtIndex:Appdelegate.m_groupIndex];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
                
            }
            
            NSLog(@"self.group.data = %@",self.group.data);
            
            NSLog(@"Appdelegate.m_groupUserId = %@",Appdelegate.m_groupUserId);
            
        }else{
            
            
            
        }
        
    }
    
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView{
   
    if( alertView.tag == 11109 ){
        
        return [alertView textFieldAtIndex:0].text.length != 0;
   
    }else{
        
        return YES;
    }
}


@end
