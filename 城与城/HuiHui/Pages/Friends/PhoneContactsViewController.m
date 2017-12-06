//
//  PhoneContactsViewController.m
//  HuiHui
//
//  Created by mac on 13-12-3.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "PhoneContactsViewController.h"

#import "ContactCell.h"

#import "UserInformationViewController.h"

#import <CoreFoundation/CoreFoundation.h>

#import <AddressBook/AddressBook.h>

#import "InviteViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"



@interface PhoneContactsViewController ()
{
    NSInteger Addfriendindex ;
}

//@property (weak, nonatomic) IBOutlet UISearchBar *m_searchBar;
@property (nonatomic, strong) NSMutableArray       *AllpersonsArray;//全部联系人及属性


@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (nonatomic, strong) NSString                  *m_phoneString;

@property (nonatomic, assign) ABAddressBookRef addressBookRef;

@end

@implementation PhoneContactsViewController

@synthesize m_friendsList;

@synthesize m_index;

@synthesize AllpersonsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_friendsList = [[NSMutableArray alloc]initWithCapacity:0];
        
        AllpersonsArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_contactHelp = [[ContactHelper alloc]init];
        
        m_index = 0;
        
        CFErrorRef error;
        _addressBookRef = ABAddressBookCreateWithOptions(NULL, &error);
    }
    return self;
}

+ (PhoneContactsViewController *)shareController
{
    static PhoneContactsViewController*sssviewcontroller=nil;
    if (sssviewcontroller==nil)
    {
        sssviewcontroller=[[PhoneContactsViewController alloc]init];

        ABAddressBookRequestAccessWithCompletion(sssviewcontroller.addressBookRef, ^(bool granted, CFErrorRef error) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [sssviewcontroller GetABAddressBookRef];
                });
            } else {
                // TODO: Show alert
            }
        });
        
    }
    return sssviewcontroller;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"通讯录朋友"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.m_tableView.frame = CGRectMake(0, 0, self.PhoneContactsView.frame.size.width, self.PhoneContactsView.frame.size.height);

    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
   
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
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
        
        if ( [m_contactHelp contactList].count != 0 ) {
            
            // 有值的话直接从数据库里面读取
            self.m_friendsList = [m_contactHelp contactList];
            
            [self.m_tableView reloadData];
            
        }else{
            // 将通讯录的数据拼接城字符串传递给服务器，服务器返 回数据进行列表显示
            [self requestPeopleSubmit:contatcString];
            
        }
        
        
    }else{
        
        [SVProgressHUD dismiss];
        
        [self alertWithMessage:@"请到设置->隐私->通讯录中开启授权!"];
        
        return;
    }

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetABAddressBookRef) name:@"RHAddressBookExternalChangeNotification" object:nil];

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
    
    return self.m_friendsList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ContactCellIdentifier";
    
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ContactCell" owner:self options:nil];
        
        cell = (ContactCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if ( self.m_friendsList.count != 0 ) {
        
        NSDictionary *dic = [self.m_friendsList objectAtIndex:indexPath.row];
        
        NSString *string = [dic objectForKey:@"Phone"];
        
        if ( string.length != 0 ) {
            
            string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            
        }
        
        
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@(%@)",[dic objectForKey:@"NickName"],string];
        
        cell.m_inviteBtn.tag = indexPath.row;
        
        cell.m_addBtn.tag = indexPath.row;
        
        // 1:未关注、2已关注、3待邀请 4、已邀请
        if ( [[dic objectForKey:@"Type"]isEqualToString:@"1"] ) {
            
            cell.m_inviteBtn.hidden = YES;
            cell.m_addBtn.hidden = NO;
            cell.m_inviteLabel.hidden = YES;
            
        }else if ( [[dic objectForKey:@"Type"]isEqualToString:@"2"] ) {
            
            cell.m_inviteBtn.hidden = YES;
            cell.m_addBtn.hidden = YES;
            cell.m_inviteLabel.hidden = YES;

            
        }else if ( [[dic objectForKey:@"Type"]isEqualToString:@"3"] ) {
            
            cell.m_inviteBtn.hidden = NO;
            cell.m_addBtn.hidden = YES;
            cell.m_inviteLabel.hidden = YES;

            
        }else if ( [[dic objectForKey:@"Type"]isEqualToString:@"4"] ){
            
            cell.m_inviteBtn.hidden = YES;
            cell.m_addBtn.hidden = YES;
            cell.m_inviteLabel.hidden = NO;
            
        }else{
            
            
        }
        
        // 添加按钮响应的事件
        [cell.m_inviteBtn addTarget:self action:@selector(invidate:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.m_addBtn addTarget:self action:@selector(showMessageAlertView:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSDictionary *dic = [self.m_friendsList objectAtIndex:indexPath.row];
    
    // 1:未关注、2已关注、3待邀请
    if ( [[dic objectForKey:@"Type"]isEqualToString:@"1"] ) {
        
        // 进入详细资料
        UserInformationViewController *VC = [[UserInformationViewController alloc]initWithNibName:@"UserInformationViewController" bundle:nil];
        VC.m_typeString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Type"]];
        VC.m_friendId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"OtmemId"]];
//        [self.navigationController pushViewController:VC animated:YES];
        [self.PhoneContactsNav pushViewController:VC animated:YES];

        
    }else if ( [[dic objectForKey:@"Type"]isEqualToString:@"2"] ) {
        
        // 进入详细资料
        UserInformationViewController *VC = [[UserInformationViewController alloc]initWithNibName:@"UserInformationViewController" bundle:nil];
        VC.m_typeString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Type"]];
        VC.m_friendId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"OtmemId"]];
//        [self.navigationController pushViewController:VC animated:YES];
        [self.PhoneContactsNav pushViewController:VC animated:YES];
        
    }else if ( [[dic objectForKey:@"Type"]isEqualToString:@"3"] ){
        
//进入电话本详细资料
        ABRecordID personId = (ABRecordID)[[NSString stringWithFormat:@"%@",[dic objectForKey:@"PersonId"]]integerValue];
        
        ABPersonViewController *view = [[ABPersonViewController alloc] init];
        view.addressBook = self.addressBookRef;
        view.allowsActions = YES;
        view.allowsEditing = YES;
        view.personViewDelegate = self;
        view.displayedPerson = ABAddressBookGetPersonWithRecordID(self.addressBookRef, personId);
        
        [self.PhoneContactsNav pushViewController:view animated:YES];


    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

-(void)ChangeRightLeftAdress:(UINavigationController *)navi
{
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0, 0, 25, 25)];
    _button.backgroundColor = [UIColor clearColor];
    [_button setImage:[UIImage imageNamed:@"arrow_WL.png"] forState:UIControlStateNormal];
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
    [navi.navigationItem setLeftBarButtonItem:_barButton];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0f;
}

- (void)invidate:(id)sender{
    
    Appdelegate.isTongxunlu = YES;
    
    UIButton *btn = (UIButton *)sender;
    
    NSDictionary *dic = [self.m_friendsList objectAtIndex:btn.tag];
    
    // 邀请好友
    InviteViewController *VC = [[InviteViewController alloc]initWithNibName:@"InviteViewController" bundle:nil];
    VC.m_dic = dic;
    VC.stringType = @"2";
//    [self.navigationController pushViewController:VC animated:YES];
    [self.PhoneContactsNav pushViewController:VC animated:YES];
    
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
    NSDictionary *dic = [self.m_friendsList objectAtIndex:indexPath];
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
//            [self addFriends:indexPath];
            [self showHint:@"发送申请成功"];

        }
    }
}

- (void)addFriends:(NSInteger)index{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    NSDictionary *dic = [self.m_friendsList objectAtIndex:index];

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
        [SVProgressHUD dismiss];
        if (success) {
            
            // 添加成功后请求数据刷新下列表
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refresh) userInfo:nil repeats:NO];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"添加失败"];
        //NSLog(@"failed:%@", error);
    }];
    
}

- (void)refresh{
    
    // 将通讯录的个数和通讯录内容一一存放到plist文件里，用于区分每个用户登录时都请求刷新数据
    NSString *userId = [CommonUtil getValueByKey:MEMBER_ID];
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_contactFriends.plist",userId]];
    
    // 读取plist里面的数据
    NSDictionary *l_dic =  [NSDictionary dictionaryWithContentsOfFile:dbPath];
    
    NSString *contatcString = [NSString stringWithFormat:@"%@",[l_dic objectForKey:[NSString stringWithFormat:@"%@_contactString",userId]]];
    
    
    // 刷新数据
    [self requestPeopleSubmit:contatcString];
    
}


#pragma mark -
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
    [self showHudInView:self.view hint:@"数据加载中"];
    [httpClient request:@"ContactsList_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        [self hideHud];
        [SVProgressHUD dismiss];
        if (success) {
            
            self.m_friendsList = [json valueForKey:@"attentionInfo"];
            
            [self.m_tableView reloadData];
            
            // 将数据保存到数据库里面
            [m_contactHelp updateData:[json valueForKey:@"attentionInfo"]];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        [self hideHud];
        [SVProgressHUD dismiss];
    }];
    
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
        
        ABRecordRef contactPerson = (__bridge ABRecordRef)tmpPeoples[countIndex];
        NSInteger PersonId =  ABRecordGetRecordID(contactPerson);
        
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
                            
                            string = [string stringByAppendingString:[NSString stringWithFormat:@",%ld",(long)PersonId]];

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
                            
                            string = [string stringByAppendingString:[NSString stringWithFormat:@",%ld",(long)PersonId]];
//
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
                        
                        phoneString = [phoneString stringByAppendingString:[NSString stringWithFormat:@",%ld",(long)PersonId]];
                        
                        i = l_phoneArray.count;
                    }
                    
                }
                
            }
            
        }
        
        
        CFRelease(tmpPhones);
        
    }
    
    NSString *m_phoneString = [NSString stringWithFormat:@"%@",phoneString];
    
    // 将数据写入plist里面
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lu",(unsigned long)tmpPeoples.count],[NSString stringWithFormat:@"%@_contact",userId],phoneString,[NSString stringWithFormat:@"%@_contactString",userId], nil];
    
    [dic writeToFile:dbPath atomically:YES];
    
    // 将通讯录的数据拼接城字符串传递给服务器，服务器返回数据进行列表显示
    [self requestPeopleSubmit:m_phoneString];
    
    if (addressBook!=nil) {
        CFRelease(addressBook);
    }
    
}

-(NSDictionary *)GetALLpersonsattribute
{    
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
    
    NSArray *results = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);

    NSMutableArray *ABAddressARR = [[NSMutableArray alloc]initWithCapacity:0];
    
    for(int i = 0; i < results.count; i++)
    {
        NSMutableDictionary *ABAdic = [[NSMutableDictionary alloc]initWithCapacity:0];

        ABRecordRef person = (__bridge ABRecordRef)results[i];
        
        NSInteger PersonId =  ABRecordGetRecordID(person);
        
        NSString *pstr = [NSString stringWithFormat:@"%li",(long)PersonId];
        
        [ABAdic setObject:pstr forKey:@"PersonId"];

        //读取firstname
        NSString *personName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        if(personName == nil){
            personName = @"";
        }
        [ABAdic setObject:personName forKey:@"PerFirstName"];

        //读取lastname
        NSString *lastname = (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
        if(lastname == nil){
            lastname = @"";
        }
        [ABAdic setObject:lastname forKey:@"PerLastName"];
        
        
//        //读取middlename
//        NSString *middlename = (__bridge NSString*)ABRecordCopyValue(person, kABPersonMiddleNameProperty);
//        if(middlename != nil)
//            textView.text = [textView.text stringByAppendingFormat:@"%@\n",middlename];
//        //读取prefix前缀
//        NSString *prefix = (__bridge NSString*)ABRecordCopyValue(person, kABPersonPrefixProperty);
//        if(prefix != nil)
//            textView.text = [textView.text stringByAppendingFormat:@"%@\n",prefix];
//        //读取suffix后缀
//        NSString *suffix = (__bridge NSString*)ABRecordCopyValue(person, kABPersonSuffixProperty);
//        if(suffix != nil)
//            textView.text = [textView.text stringByAppendingFormat:@"%@\n",suffix];
//        //读取nickname呢称
//        NSString *nickname = (__bridge NSString*)ABRecordCopyValue(person, kABPersonNicknameProperty);
//        if(nickname != nil)
//            textView.text = [textView.text stringByAppendingFormat:@"%@\n",nickname];
//        //读取firstname拼音音标
//        NSString *firstnamePhonetic = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty);
//        if(firstnamePhonetic != nil)
//            textView.text = [textView.text stringByAppendingFormat:@"%@\n",firstnamePhonetic];
//        //读取lastname拼音音标
//        NSString *lastnamePhonetic = (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty);
//        if(lastnamePhonetic != nil)
//            textView.text = [textView.text stringByAppendingFormat:@"%@\n",lastnamePhonetic];
//        //读取middlename拼音音标
//        NSString *middlenamePhonetic = (__bridge NSString*)ABRecordCopyValue(person, kABPersonMiddleNamePhoneticProperty);
//        if(middlenamePhonetic != nil)
//            textView.text = [textView.text stringByAppendingFormat:@"%@\n",middlenamePhonetic];
  
        
        //读取organization公司
        NSString *Perorganization = (__bridge NSString*)ABRecordCopyValue(person, kABPersonOrganizationProperty);
        if (Perorganization ==nil) {
            Perorganization = @"";
        }

        [ABAdic setObject:Perorganization forKey:@"Perorganization"];


//        //第一次添加该条记录的时间
//        NSString *firstknow = (__bridge NSString*)ABRecordCopyValue(person, kABPersonCreationDateProperty);
//        NSLog(@"第一次添加该条记录的时间%@\n",firstknow);
        //最后一次修改該条记录的时间
        NSString *lastknow = (__bridge NSString*)ABRecordCopyValue(person, kABPersonModificationDateProperty);
        if (lastknow == nil) {
            lastknow = @"";
        }
        
//        NSLog(@"最后一次修改該条记录的时间%@\n",lastknow);
        [ABAdic setObject:[NSString stringWithFormat:@"%@",lastknow] forKey:@"Perlastknow"];

        
//        //读取jobtitle工作
//        NSString *jobtitle = (__bridge NSString*)ABRecordCopyValue(person, kABPersonJobTitleProperty);
//        if(jobtitle != nil)
//            textView.text = [textView.text stringByAppendingFormat:@"%@\n",jobtitle];
//        //读取department部门
//        NSString *department = (__bridge NSString*)ABRecordCopyValue(person, kABPersonDepartmentProperty);
//        if(department != nil)
//            textView.text = [textView.text stringByAppendingFormat:@"%@\n",department];
//        //读取birthday生日
//        NSDate *birthday = (__bridge NSDate*)ABRecordCopyValue(person, kABPersonBirthdayProperty);
//        if(birthday != nil)
//            textView.text = [textView.text stringByAppendingFormat:@"%@\n",birthday];
//        //读取note备忘录
//        NSString *note = (__bridge NSString*)ABRecordCopyValue(person, kABPersonNoteProperty);
//        if(note != nil)
//            textView.text = [textView.text stringByAppendingFormat:@"%@\n",note];
//        //第一次添加该条记录的时间
//        NSString *firstknow = (__bridge NSString*)ABRecordCopyValue(person, kABPersonCreationDateProperty);
//        NSLog(@"第一次添加该条记录的时间%@\n",firstknow);
        //最后一次修改該条记录的时间
//        NSString *lastknow = (__bridge NSString*)ABRecordCopyValue(person, kABPersonModificationDateProperty);
//        NSLog(@"最后一次修改該条记录的时间%@\n",lastknow);
//        
//        //获取email多值
//        ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
//        int emailcount = ABMultiValueGetCount(email);
//        for (int x = 0; x < emailcount; x++)
//        {
//            //获取email Label
//            NSString* emailLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(email, x));
//            //获取email值
//            NSString* emailContent = (__bridge NSString*)ABMultiValueCopyValueAtIndex(email, x);
//            textView.text = [textView.text stringByAppendingFormat:@"%@:%@\n",emailLabel,emailContent];
//        }
//        //读取地址多值
//        ABMultiValueRef address = ABRecordCopyValue(person, kABPersonAddressProperty);
//        int count = ABMultiValueGetCount(address);
//        
//        for(int j = 0; j < count; j++)
//        {
//            //获取地址Label
//            NSString* addressLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(address, j);
//            textView.text = [textView.text stringByAppendingFormat:@"%@\n",addressLabel];
//            //获取該label下的地址6属性
//            NSDictionary* personaddress =(__bridge NSDictionary*) ABMultiValueCopyValueAtIndex(address, j);
//            NSString* country = [personaddress valueForKey:(NSString *)kABPersonAddressCountryKey];
//            if(country != nil)
//                textView.text = [textView.text stringByAppendingFormat:@"国家：%@\n",country];
//            NSString* city = [personaddress valueForKey:(NSString *)kABPersonAddressCityKey];
//            if(city != nil)
//                textView.text = [textView.text stringByAppendingFormat:@"城市：%@\n",city];
//            NSString* state = [personaddress valueForKey:(NSString *)kABPersonAddressStateKey];
//            if(state != nil)
//                textView.text = [textView.text stringByAppendingFormat:@"省：%@\n",state];
//            NSString* street = [personaddress valueForKey:(NSString *)kABPersonAddressStreetKey];
//            if(street != nil)
//                textView.text = [textView.text stringByAppendingFormat:@"街道：%@\n",street];
//            NSString* zip = [personaddress valueForKey:(NSString *)kABPersonAddressZIPKey];
//            if(zip != nil)
//                textView.text = [textView.text stringByAppendingFormat:@"邮编：%@\n",zip];
//            NSString* coutntrycode = [personaddress valueForKey:(NSString *)kABPersonAddressCountryCodeKey];
//            if(coutntrycode != nil)
//                textView.text = [textView.text stringByAppendingFormat:@"国家编号：%@\n",coutntrycode];
//        }
//        
//        //获取dates多值
//        ABMultiValueRef dates = ABRecordCopyValue(person, kABPersonDateProperty);
//        int datescount = ABMultiValueGetCount(dates);
//        for (int y = 0; y < datescount; y++)
//        {
//            //获取dates Label
//            NSString* datesLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(dates, y));
//            //获取dates值
//            NSString* datesContent = (__bridge NSString*)ABMultiValueCopyValueAtIndex(dates, y);
//            textView.text = [textView.text stringByAppendingFormat:@"%@:%@\n",datesLabel,datesContent];
//        }
//        //获取kind值
//        CFNumberRef recordType = ABRecordCopyValue(person, kABPersonKindProperty);
//        if (recordType == kABPersonKindOrganization) {
//            // it's a company
//            NSLog(@"it's a company\n");
//        } else {
//            // it's a person, resource, or room
//            NSLog(@"it's a person, resource, or room\n");
//        }
//        
//        
//        //获取IM多值
//        ABMultiValueRef instantMessage = ABRecordCopyValue(person, kABPersonInstantMessageProperty);
//        for (int l = 1; l < ABMultiValueGetCount(instantMessage); l++)
//        {
//            //获取IM Label
//            NSString* instantMessageLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(instantMessage, l);
//            textView.text = [textView.text stringByAppendingFormat:@"%@\n",instantMessageLabel];
//            //获取該label下的2属性
//            NSDictionary* instantMessageContent =(__bridge NSDictionary*) ABMultiValueCopyValueAtIndex(instantMessage, l);
//            NSString* username = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageUsernameKey];
//            if(username != nil)
//                textView.text = [textView.text stringByAppendingFormat:@"username：%@\n",username];
//            
//            NSString* service = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageServiceKey];
//            if(service != nil)
//                textView.text = [textView.text stringByAppendingFormat:@"service：%@\n",service];
//        }
        
        //读取电话多值
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        NSMutableArray *ABMultiValueGet = [[NSMutableArray alloc]initWithCapacity:0];
        for (int k = 0; k<ABMultiValueGetCount(phone); k++)
        {
            //获取电话Label
            NSString * personPhoneLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k));
            //获取該Label下的电话值
            NSString * personPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phone, k);
            
            NSMutableDictionary *PERDIC = [[NSMutableDictionary alloc]initWithCapacity:0];
            
            [PERDIC setObject:personPhoneLabel forKey:@"PhoneLabel"];
            [PERDIC setObject:personPhone forKey:@"Phone"];

            [ABMultiValueGet addObject:PERDIC];
//            textView.text = [textView.text stringByAppendingFormat:@"%@:%@\n",personPhoneLabel,personPhone];
        }
        
        [ABAdic setObject:[ABMultiValueGet mutableCopy] forKey:@"ABGetPhones"];

        //获取URL多值
//        ABMultiValueRef url = ABRecordCopyValue(person, kABPersonURLProperty);
//        for (int m = 0; m < ABMultiValueGetCount(url); m++)
//        {
//            //获取电话Label
//            NSString * urlLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(url, m));
//            //获取該Label下的电话值
//            NSString * urlContent = (__bridge NSString*)ABMultiValueCopyValueAtIndex(url,m);
//            
//            textView.text = [textView.text stringByAppendingFormat:@"%@:%@\n",urlLabel,urlContent];
//        }
//        
//        //读取照片
//        NSData *image = (__bridge NSData*)ABPersonCopyImageData(person);
//        if (image == nil) {
//        [ABAdic setObject:@"" forKey:@"image"];
//        }else{
//        [ABAdic setObject:image forKey:@"image"];
//        }
//
//        UIImageView *myImage = [[UIImageView alloc] initWithFrame:CGRectMake(200, 0, 50, 50)];
//        [myImage setImage:[UIImage imageWithData:image]];
//        myImage.opaque = YES;
//        [textView addSubview:myImage];
        
        [ABAddressARR addObject:ABAdic];
    }
    
    NSDictionary *ABAddressDIC = [NSDictionary dictionaryWithObjectsAndKeys:
                                   ABAddressARR,     @"ABAddressARR",nil];

    
    CFRelease(addressBook);
    
    return ABAddressDIC;
    
}


@end
