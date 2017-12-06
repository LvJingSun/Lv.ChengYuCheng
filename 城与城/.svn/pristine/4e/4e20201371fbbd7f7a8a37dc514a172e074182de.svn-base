//
//  NewFriendsViewController.m
//  HuiHui
//
//  Created by mac on 13-12-11.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "NewFriendsViewController.h"

#import "FriendsCell.h"

#import "UserInformationViewController.h"

#import "InviteViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "Reachability.h"

@interface NewFriendsViewController ()

@property (weak, nonatomic) IBOutlet UITableView        *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel            *m_emptyLabel;

@end

@implementation NewFriendsViewController

@synthesize m_friendsArray;

@synthesize m_typeArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_friendsArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_typeArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        friendHelp = [[FriendHelper alloc]init];
        
    }
    return self;
}

+ (NewFriendsViewController *)shareController
{
    static NewFriendsViewController *sssviewcontroller = nil;
    if (sssviewcontroller == nil)
    {
        sssviewcontroller = [[NewFriendsViewController alloc]init];
        
        
        [sssviewcontroller GetABAddressBookRef];
    }
    return sssviewcontroller;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self setLeftButtonWithNormalImage:@"" action:@selector()];
    
    
    // 导航栏标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 6, 200, 30)];
    titleLabel.font = [UIFont systemFontOfSize:20.0f];//[UIFont fontWithName:@"Helvetica-Bold" size:20.0f];//fontWithName:@"Helvetica-Bold" size:22.0f];
    titleLabel.textColor = [UIColor whiteColor];
    [titleLabel setShadowOffset:CGSizeMake(0, 0)];
    [titleLabel setShadowColor:[UIColor colorWithRed:0x41/255.0f green:0x41/255.0f blue:0x41/255.0f alpha:1.0f]]; //[UIColor whiteColor]];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"新朋友";
    
    self.navigationItem.titleView = titleLabel;

    
    // 导航栏左按钮返回事件
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0, 0, 25, 25)];
    _button.backgroundColor = [UIColor clearColor];
    [_button setImage:[UIImage imageNamed:@"arrow_WL.png"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(leftClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
    [self.navigationItem setLeftBarButtonItem:_barButton];
    
    
    // 默认隐藏
    self.m_emptyLabel.hidden = YES;
    
    self.m_tableView.hidden = YES;
   
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear: animated];
   
   
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 添加通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetABAddressBookRef) name:@"RHAddressBookExternalChangeNotification" object:nil];

    
//    [self hideTabBar:YES];
    
    if ( ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized ) {
        
        // 将通讯录的个数和通讯录内容一一存放到plist文件里，用于区分每个用户登录时都请求刷新数据
        NSString *userId = [CommonUtil getValueByKey:MEMBER_ID];
        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_contactFriends.plist",userId]];
        
        // 读取plist里面的数据
        NSDictionary *l_dic =  [NSDictionary dictionaryWithContentsOfFile:dbPath];
        
        NSString *contatcString = [NSString stringWithFormat:@"%@",[l_dic objectForKey:[NSString stringWithFormat:@"%@_contactString",userId]]];
        
        
        if ( [friendHelp contactList].count != 0 ) {
            
            // 有值的话直接从数据库里面读取
            self.m_friendsArray = [friendHelp contactList];
            
            [self.m_tableView reloadData];
            
        }else{

            // 将通讯录的数据拼接城字符串传递给服务器，服务器返 回数据进行列表显示
            [self requestPeopleSubmit:contatcString];
            
        }
        
        
    }else{
        
        [SVProgressHUD dismiss];
        
        // 跳出提示
        [self alertWithMessage:@"请到设置->隐私->通讯录中开启授权!"];
        
        return;
    }

    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
//    [self hideTabBar:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_friendsArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"NewFriendsCellIdentifier";
    
    NewFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FriendsCell" owner:self options:nil];
        
        cell = (NewFriendsCell *)[nib objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.m_agreeLabel.hidden = YES;

    
    if ( self.m_friendsArray.count != 0 ) {
        
        cell.m_imageView.hidden = YES;
        
        NSMutableDictionary *dic = [self.m_friendsArray objectAtIndex:indexPath.row];
        
        cell.m_InviteBtn.hidden = NO;
        
        cell.m_addBtn.hidden = YES;
        
        cell.m_nameLabel.hidden = YES;
        cell.m_phoneLabel.hidden = YES;
        cell.m_inNameLabel.hidden = NO;
        cell.m_inPhoneLabel.hidden = NO;
        
        cell.m_resourceLabel.text = [NSString stringWithFormat:@"手机联系人：%@",[dic objectForKey:@"Name"]];
        
        cell.m_inNameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"NickName"]];
        
        NSString *string = [dic objectForKey:@"Phone"];
        
        if ( string.length != 0 ) {
            
            string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            
        }
        
        
        
        cell.m_inPhoneLabel.text = [NSString stringWithFormat:@"%@",string];
    }

    
    
    cell.m_addBtn.tag = indexPath.row;
    
    cell.m_InviteBtn.tag = indexPath.row;
    
//    [cell.m_addBtn addTarget:self action:@selector(addFriends:) forControlEvents:UIControlEventTouchUpInside];
    
//    [cell.m_InviteBtn addTarget:self action:@selector(InviteFriends:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.m_InviteBtn addTarget:self action:@selector(showMessageAlertView:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.m_backImgV.layer.borderWidth = 1.0;
    cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
    
    
    return cell;
    
}

#pragma - mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 102.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
   /* NSInteger count = [self countOfCellRow];
    
    switch ( count ) {
        case 0 :
        {
            
            
        }
            break;
        case 1 :
        {
            if ( indexPath.section == 0 ) {
  
                
            }else{
//                NSMutableDictionary *dic = [self.m_typeArray objectAtIndex:indexPath.row];
//                // 进入详细资料
//                UserInformationViewController *VC = [[UserInformationViewController alloc]initWithNibName:@"UserInformationViewController" bundle:nil];
//                VC.m_typeString = @"3";
//                VC.m_friendId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]];
//                [self.navigationController pushViewController:VC animated:YES];
                
            }
            
        }
            break;
        case 2 :
        {
            if ( indexPath.section == 0 ) {
                
                
            }
            
        }
            break;
        case 3 :
        {
            if ( indexPath.section == 0 ) {
                
//                NSMutableDictionary *dic = [self.m_typeArray objectAtIndex:indexPath.row];
//                // 进入详细资料
//                UserInformationViewController *VC = [[UserInformationViewController alloc]initWithNibName:@"UserInformationViewController" bundle:nil];
//                VC.m_typeString = @"3";
//                VC.m_friendId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]];
//                [self.navigationController pushViewController:VC animated:YES];
                
            }
            
        }
            break;
            
        default:
            break;
    }*/
        
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

#pragma mark - BtnClicked
/*- (void)addFriends:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_typeArray objectAtIndex:btn.tag];
    
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
                           [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]],@"otherId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"AttentionAdd.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 点击同意后请求添加我的接口进行刷新数据
            [self requestAddMeSubmit];
            
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}*/

// 同意别人的添加
- (void)InviteFriends:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_friendsArray objectAtIndex:btn.tag];
    
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
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"AttentionAdd.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 将通讯录的个数和通讯录内容一一存放到plist文件里，用于区分每个用户登录时都请求刷新数据
            NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID];
            
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

            NSString *documentDirectory = [paths objectAtIndex:0];
            NSString *dbPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_contactFriends.plist",userId]];
            
            // 读取plist里面的数据
            NSDictionary *l_dic =  [NSDictionary dictionaryWithContentsOfFile:dbPath];
            
            NSString *contatcString = [NSString stringWithFormat:@"%@",[l_dic objectForKey:[NSString stringWithFormat:@"%@_contactString",userId]]];
            
            // 请求数据，刷新列表
            [self requestPeopleSubmit:contatcString];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
 
}

#pragma mark - 通讯录上传服务器
- (void)requestPeopleSubmit:(NSString *)aString{
    
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
                           [NSString stringWithFormat:@"%@",aString],@"contacts",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"NewFriedsList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            //            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD dismiss];
            
            // 清空数组
            if ( self.m_friendsArray.count != 0 ) {
                [self.m_friendsArray removeAllObjects];
            }
            
            if ( self.m_typeArray.count != 0 ) {
                [self.m_typeArray removeAllObjects];
            }
            
            self.m_friendsArray = [json valueForKey:@"attentionInfo"];
            
            self.m_typeArray = [json valueForKey:@"memberInvite"];
            
            // 存储数据到库数据
            [friendHelp updateTongxunluList:[json valueForKey:@"attentionInfo"]];
            
            // 刷新数据后重新存储数据
            [friendHelp updateOtherConternedMe:[json valueForKey:@"memberInvite"]];
            
            Appdelegate.isMemberCountChange = NO;
            
            
            // 刷新数据
            [FriendHelper updateMemFan:[NSString stringWithFormat:@"%i",self.m_typeArray.count] withMemInvitingAcount:[NSString stringWithFormat:@"%i",self.m_friendsArray.count] withNewFriendCount:[NSString stringWithFormat:@"%i",self.m_typeArray.count + self.m_friendsArray.count]];
            
            
            if ( self.m_friendsArray.count == 0 && self.m_typeArray.count == 0 ) {
                
                self.m_emptyLabel.hidden = NO;
                
                self.m_tableView.hidden = YES;
                
            }else{
                
                self.m_emptyLabel.hidden = YES;
                
                self.m_tableView.hidden = NO;
                
                // 刷新列表
                [self.m_tableView reloadData];
                
            }
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
            self.m_emptyLabel.hidden = NO;
            
            self.m_tableView.hidden = YES;
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

- (void)viewDidUnload {
    [self setM_emptyLabel:nil];
    [super viewDidUnload];
}

#pragma mark 获取通讯录数据进行上传服务器进行比较
// 读取通讯录里面的信息
- (void)GetABAddressBookRef{
    //    6、通讯录列表获取差异
    ABAddressBookRef addressBook = nil;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    {
        addressBook=ABAddressBookCreateWithOptions(NULL, NULL);
        dispatch_semaphore_t sema=dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool greanted, CFErrorRef error){
            dispatch_semaphore_signal(sema);
        });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//        dispatch_release(sema);
        
    } else
    {
        addressBook = ABAddressBookCreate();
        
    }
    
    NSArray *tmpPeoples = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    NSString *string = [[NSString alloc]init];
    
    string = [string stringByAppendingString:@"["];
    
    NSString *phoneString = @"";
    
    int countIndex = 0;
    
    // 将通讯录的个数和通讯录内容一一存放到plist文件里，用于区分每个用户登录时都请求刷新数据
    NSString *userId = [CommonUtil getValueByKey:MEMBER_ID];
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_contactFriends.plist",userId]];
    
    for(id tmpPerson in tmpPeoples)
        
    {
        countIndex ++;
        
        NSMutableArray *l_phoneArray = [[NSMutableArray alloc]init];
        
        //获取的联系人单一属性:First name
        NSString* tmpFirstName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonFirstNameProperty);
        
        //获取的联系人单一属性:Last name
        
        NSString* tmpLastName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonLastNameProperty);
        
        NSString *nameString = @"";
        // 判断名称是否有值
        if ( tmpFirstName != nil && tmpLastName != nil ) {
            
            nameString = [NSString stringWithFormat:@"%@%@",tmpLastName,tmpFirstName];
            
        }else if ( tmpFirstName == nil && tmpLastName != nil ) {
            
            nameString = [NSString stringWithFormat:@"%@",tmpLastName];
            
        }else if ( tmpFirstName != nil && tmpLastName == nil ) {
            
            nameString = [NSString stringWithFormat:@"%@",tmpFirstName];
            
        }else{
            
            
        }
        
        phoneString = [phoneString stringByAppendingString:[NSString stringWithFormat:@"%@,",nameString]];
        
        
        //获取的联系人单一属性:Email(s)
        ABMultiValueRef tmpEmails = ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonEmailProperty);
        
        CFRelease(tmpEmails);
        
        ABMultiValueRef tmpPhones = ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonPhoneProperty);
        
        for(NSInteger j = 0; j < ABMultiValueGetCount(tmpPhones); j++)
            
        {
            
            NSString* tmpPhoneIndex = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmpPhones, j);
            
            // 添加到数组
            [l_phoneArray addObject:tmpPhoneIndex];
            
        }
        
        if ( tmpPeoples.count != 1 ) {
            
            if ( countIndex == tmpPeoples.count ) {
                
                if ( l_phoneArray.count != 0 ) {
                    
                    for (int i = 0; i < l_phoneArray.count; i ++) {
                        
                        NSString *string = [l_phoneArray objectAtIndex:i];
                        
                        if ( string.length != 0 ) {
                            
                            string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
                            string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
                            
                        }
                        
                        if ( string.length == 11 ) {
                            
                            phoneString = [phoneString stringByAppendingString:[NSString stringWithFormat:@"%@",string]];
                            
                            i = l_phoneArray.count;
                        }
                        
                    }
                    
                }
                
            }else{
                
                if ( l_phoneArray.count != 0 ) {
                    
                    for (int i = 0; i < l_phoneArray.count; i ++) {
                        
                        NSString *string = [l_phoneArray objectAtIndex:i];
                        
                        if ( string.length != 0 ) {
                            
                            string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
                            string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
                            
                        }
                        
                        if ( string.length == 11 ) {
                            
                            phoneString = [phoneString stringByAppendingString:[NSString stringWithFormat:@"%@|",string]];
                            
                            i = l_phoneArray.count;
                        }
                        
                    }
                    
                    
                }
                
            }
            
            
        }else{
            
            if ( l_phoneArray.count != 0 ) {
                
                for (int i = 0; i < l_phoneArray.count; i ++) {
                    
                    NSString *string = [l_phoneArray objectAtIndex:i];
                    
                    if ( string.length != 0 ) {
                        
                        string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
                        string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
                        
                    }
                    
                    if ( string.length == 11 ) {
                        
                        phoneString = [phoneString stringByAppendingString:[NSString stringWithFormat:@"%@",string]];
                        
                        i = l_phoneArray.count;
                    }
                    
                }
                
            }
            
        }
        
        
        CFRelease(tmpPhones);
        
    }
    
    NSString *m_phoneString = [NSString stringWithFormat:@"%@",phoneString];
    
    // 将数据写入plist里面
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",tmpPeoples.count],[NSString stringWithFormat:@"%@_contact",userId],phoneString,[NSString stringWithFormat:@"%@_contactString",userId], nil];
    
    [dic writeToFile:dbPath atomically:YES];
    
    // 将通讯录的数据拼接城字符串传递给服务器，服务器返回数据进行列表显示
    [self requestPeopleSubmit:m_phoneString];
    
    if (addressBook!=nil) {
        CFRelease(addressBook);
    }
    
}

- (void)showMessageAlertView:(id)sender{

    [self hiddenNumPadDone:nil];
    UIButton *btn = (UIButton *)sender;
    newindexpath = btn.tag;
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
        [self sendFriendApplyAtIndexPath:newindexpath
                                 message:messageStr];
    }
}

- (void)sendFriendApplyAtIndexPath:(NSInteger)indexPath
                           message:(NSString *)message
{
    NSDictionary *dic = [self.m_friendsArray objectAtIndex:indexPath];
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
            [self showHint:@"发送申请成功"];
            
        }
    }
}


@end
