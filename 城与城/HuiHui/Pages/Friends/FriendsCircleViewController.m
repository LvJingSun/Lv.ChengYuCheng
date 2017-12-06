//
//  FriendsCircleViewController.m
//  HuiHui
//
//  Created by mac on 14-5-4.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "FriendsCircleViewController.h"

#import "AddFriendViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "FriendsCell.h"

#import "NewFriendsViewController.h"

#import "JPinYinUtil.h"

#import "UserInformationViewController.h"

#import "MySiteViewController.h"

#import "InvitationFriendsViewController.h"


@interface FriendsCircleViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (strong, nonatomic) IBOutlet UIView *m_footerView;

@property (weak, nonatomic) IBOutlet UILabel *m_countLabel;



@end

@implementation FriendsCircleViewController

@synthesize m_friendsArray;

@synthesize m_allKeys;

@synthesize m_FriendsListDic;

@synthesize isEnterSecondPage;

@synthesize m_friendsCount;

@synthesize m_friendCount;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_friendsArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_allKeys = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_FriendsListDic = [[NSMutableDictionary alloc]initWithCapacity:0];

        friendHelp = [[FriendHelper alloc]init];
        
        m_friendCount = [[NSMutableArray alloc]init];

        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(FriendsContact) name:@"RHAddressBookExternalChangeNotification" object:nil];


    }
    return self;
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

- (void)FriendsContact{
    
    // 通讯录有变化的话去刷新下数据
    [self ReadAllPeoples];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"圈子"];
    
    [self setRightButtonWithNormalImage:@"add.png" action:@selector(rightClicked)];
    
//    [self setRightButtonWithNormalImage:@"xxqd.png" withTitle:@"加好友" action:@selector(rightClicked)];
    
    [self setRightButtonWithTitle:@"添加好友" action:@selector(rightClicked)];
    
//    self.m_tableView.hidden = YES;
    
    // 设置默认的值
    self.m_totalCount = @"0";
    
    self.m_newFriendsCount = @"0";
    
    self.m_showCount = @"0";

    if ( isIOS7 ) {
        
        // section索引的背景色-右边排序的ABCD所在的视图
        self.m_tableView.sectionIndexBackgroundColor = [UIColor clearColor];

    }
    
    // 设置默认的值为0
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"newFriendCount",@"0",@"memFanCount",@"0",@"contactCount",@"0",@"isRead", nil];
    
    [self.m_friendCount addObject:dic];
    
    [friendHelp upDateNewFriendCont:self.m_friendCount];


}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear: animated];
//    
    // 先请求好友的数据用于和数据库中的数据进行比较，如果不同的话则先去请求接口刷新数据，如果相同的话则直接从数据库中进行读取数据

    {dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self friendsCount];
        
        [self performSelector:@selector(ReadAllPeoples) withObject:nil afterDelay:1.0];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
        });
        
    });}

}

// 通讯录有变化时候的判断
- (void)judgetongxunluCount{
    
    NSMutableArray *arr = [friendHelp newFriendsCount];
    
    NSMutableArray *l_arr = [friendHelp contactList];
    
    // 如果没有值的话则先给数据库加入数据
    if ( arr.count != 0 ) {
        
        NSDictionary *countDic = [arr objectAtIndex:0];
        
        NSString *countString = [countDic objectForKey:@"newFriendCount"];
        
        NSString *memFanCount = [countDic objectForKey:@"memFanCount"];
        
        NSString *isread = [countDic objectForKey:@"isRead"];

        
        // 通讯录变化时候的个数
        NSString *newContactCount = [NSString stringWithFormat:@"%i",l_arr.count];
        
        if ( [self.m_memberInviteCount intValue] == [memFanCount intValue] ) {
            
            // 判断新朋友是否有变化
            Appdelegate.isMemberCountChange = NO;
           
            // 如果相等的话则表示没有增加新朋友
            if ( [isread intValue] == [countString intValue] ) {
                // 相同的话表示未读，显示这个个数
               self.m_showCount = [NSString stringWithFormat:@"%i",[self.m_memberInviteCount intValue] + [newContactCount intValue]];
                
            }else{
                
                // 表示已读，表示未读的为
                if ( ([self.m_memberInviteCount intValue] + [newContactCount intValue]) > [countString intValue] ) {
                    
                    self.m_showCount = [NSString stringWithFormat:@"%i",[self.m_memberInviteCount intValue] + [newContactCount intValue] - [countString intValue]];
                    
                    
                }else{
                    
                    self.m_showCount = @"0";
                    
                }
              
            }
            
        }else{
            
            // 判断新朋友是否有变化
            Appdelegate.isMemberCountChange = YES;

            // 表示已读，表示未读的为
            if ( [self.m_memberInviteCount intValue] + [newContactCount intValue] > [countString intValue] ) {
                
                self.m_showCount = [NSString stringWithFormat:@"%i",[self.m_memberInviteCount intValue] + [newContactCount intValue] - [countString intValue]];
                
                
            }else{
                
                self.m_showCount = @"0";
                
            }
        
        }
        
        self.m_totalCount = [NSString stringWithFormat:@"%i",[self.m_memberInviteCount intValue] + [newContactCount intValue]];
        
        self.m_newFriendsCount = [NSString stringWithFormat:@"%@",newContactCount];

        
        // 刷新某一行
        [self.m_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
    }else{
        
        // 判断新朋友是否有变化
        Appdelegate.isMemberCountChange = NO;
        
        NSString *string = [NSString stringWithFormat:@"%i",[self.m_memberInviteCount intValue] + [l_arr count]];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:string,@"newFriendCount",self.m_memberInviteCount,@"memFanCount",[NSString stringWithFormat:@"%i",[l_arr count]],@"contactCount",string,@"isRead", nil];
        
        [self.m_friendCount addObject:dic];
        
        [friendHelp upDateNewFriendCont:self.m_friendCount];
        
        // 第一次无数据的时候显示个数
        self.m_showCount = string;
        
        self.m_totalCount = [NSString stringWithFormat:@"%@",string];
        
        self.m_newFriendsCount = [NSString stringWithFormat:@"%i",[l_arr count]];
        
        // 刷新某一行
        [self.m_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];

    }
    
}

// 别人添加我的时候数据有变化时候的判断
- (void) judgeNewFriendsCount{
    
    NSMutableArray *arr = [friendHelp newFriendsCount];
    
    if ( arr.count != 0 ) {
        
        NSDictionary *countDic = [arr objectAtIndex:0];
        
        NSString *countString = [countDic objectForKey:@"newFriendCount"];

        NSString *contactCount = [countDic objectForKey:@"contactCount"];

        NSString *memFanCount = [countDic objectForKey:@"memFanCount"];

        NSString *isread = [countDic objectForKey:@"isRead"];
        

        if ( [self.m_memberInviteCount intValue] == [memFanCount intValue] ) {
            
            // 判断新朋友是否有变化
            Appdelegate.isMemberCountChange = NO;
            
            // 如果相等的话则表示没有增加新朋友
            if ( [isread intValue] == [countString  intValue] ) {
                // 相同的话表示未读，显示这个个数
                self.m_showCount = countString;
                
            }else{
                
                // 表示已读，表示未读的为0
                self.m_showCount = @"0";
            }
            
            
            self.m_totalCount = [NSString stringWithFormat:@"%@",countString];
            
            self.m_newFriendsCount = [NSString stringWithFormat:@"%@",contactCount];

            
        }else{
            
            
            // 判断新朋友是否有变化
            Appdelegate.isMemberCountChange = YES;

            NSString *newFriendCount = [NSString stringWithFormat:@"%i",[self.m_memberInviteCount intValue] + [contactCount intValue] - [countString intValue]];
            
            if ( ([self.m_memberInviteCount intValue] + [contactCount intValue]) > [countString intValue] ) {
                
                // 如果相等的话则表示没有增加新朋友
                if ( [isread intValue] == [countString  intValue] ) {
                    // 相同的话表示未读，显示这个个数
                   self.m_showCount = [NSString stringWithFormat:@"%i",[countString intValue] + [newFriendCount intValue]];
                    
                }else{
                    
                    // 表示已读，表示未读的为0
                    self.m_showCount = [NSString stringWithFormat:@"%i",[newFriendCount intValue]];
                    
                }

            }else{
                
                
                
            }
            
            self.m_totalCount = [NSString stringWithFormat:@"%i",[self.m_memberInviteCount intValue] + [contactCount intValue]];
            
            self.m_newFriendsCount = [NSString stringWithFormat:@"%@",contactCount];

          
        }
      
        // 刷新某一行
        [self.m_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
       
    }
}


// 读取通讯录里面的信息
- (void)ReadAllPeoples{
    
    //    6、通讯录列表获取差异
    //    自iOS6.0后获取通讯录列表需要询问用户，经过用户同意后才可以获取通讯录用户列表。而且ABAddressBookRef的初始化工作也由ABAddressBookCreate函数转变为ABAddressBookCreateWithOptions函数。下面代码是兼容之前版本的获取通讯录用户列表方法。
    ABAddressBookRef addressBook = nil;
    //    CFErrorRef *error;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    {
        
        // 判断是否第一次启动项目
        if ( ![[NSUserDefaults standardUserDefaults]boolForKey:@"firstLaunch"] ) {
            
            //            if ( ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized ) {
            
            addressBook =  ABAddressBookCreateWithOptions(NULL, NULL);
            
            //获取通讯录权限
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            
        }else
        {
            addressBook =  ABAddressBookCreateWithOptions(NULL, NULL);
            //获取通讯录权限
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            
            //            dispatch_release(sema);
            
        }
        
        if ( ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized ) {
            
            
        }else{
            
            [self alertWithMessage:@"请到设置->隐私->通讯录中开启授权!"];
            
            return;
        }
        
        
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
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID];
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_contactFriends.plist",userId]];
    
    
   // 读取plist里面的数据
    NSDictionary *l_dic =  [NSDictionary dictionaryWithContentsOfFile:dbPath];
    
    NSString *count = [NSString stringWithFormat:@"%@",[l_dic objectForKey:[NSString stringWithFormat:@"%@_contact",userId]]];

    
    // 判断如果通讯录值不变的话则跳出下面的操作
    if ( tmpPeoples.count == [count intValue] ) {
        
        // 将我的通讯录好友存储起来
        
        [CommonUtil addValue:@"0" andKey:kMyContact];
        
        // 判断新朋友的个数
        [self judgeNewFriendsCount];
        
        return;
    }
    
    for(id tmpPerson in tmpPeoples)
        
    {
        countIndex ++;
        
        NSMutableArray *l_phoneArray = [[NSMutableArray alloc]init];
        //        NSMutableArray *l_emailArray = [[NSMutableArray alloc]init];
        
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
        
        //        string = [string stringByAppendingString:@"],"];
        
        CFRelease(tmpEmails);
        
        //获取的联系人单一属性:Generic phone number
        
        //        string = [string stringByAppendingString:@"\"phone\":["];
        
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
    
    self.m_phoneString = [NSString stringWithFormat:@"%@",phoneString];
    
    
    // 将我的通讯录好友存储起来
    [CommonUtil addValue:@"2" andKey:kMyContact];
    
    
    // 将数据写入plist里面
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",tmpPeoples.count],[NSString stringWithFormat:@"%@_contact",userId],self.m_phoneString,[NSString stringWithFormat:@"%@_contactString",userId], nil];
    
    [dic writeToFile:dbPath atomically:YES];
    
    if (addressBook!=nil) {
        CFRelease(addressBook);
    }
    
    
    // 获取通讯录后去请求数据返回
    [self requestPeopleSubmit:self.m_phoneString];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.isEnterSecondPage = NO;
  
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    if ( self.isEnterSecondPage ) {
        
        self.m_tableView.frame = CGRectMake(0, 0, WindowSizeWidth, self.view.frame.size.height - 49);
    }else{
        
        self.m_tableView.frame = CGRectMake(0, 0, WindowSizeWidth, self.view.frame.size.height);
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightClicked{
    
    // 添加好友
    AddFriendViewController *VC = [[AddFriendViewController alloc]initWithNibName:@"AddFriendViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
}

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
//    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"NewFriedsList.ashx" parameters:param success:^(NSJSONSerialization* json) {
       
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            // 存储数据到库数据
            [friendHelp updateTongxunluList:[json valueForKey:@"attentionInfo"]];
            // 别人加我的数据
            [friendHelp updateOtherConternedMe:[json valueForKey:@"memberInvite"]];
            
            // 判断我的通讯录有变化的情况
            [self judgetongxunluCount];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

- (void)friendsCount{
    
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
//    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MemberInviteCount.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSDictionary *dic = [json valueForKey:@"MemInviteAcc"];
            
            self.m_friendsCount = [dic objectForKey:@"MemberInviteAcount"];
            
            self.m_memberInviteCount = [dic objectForKey:@"MemFansAcount"];
            
            // 保存商户个数和邀请中好友个数
            [CommonUtil addValue:[dic objectForKey:@"MctFansAcount"] andKey:kMctFansAcount];
            [CommonUtil addValue:[dic objectForKey:@"MemInvitingAcount"] andKey:kMemInvitingAcount];

            
//            // 将新朋友的个数存储起来，用于进入页面的时候判断是否需要重新请求接口来刷新数据
//            [CommonUtil addValue:[dic objectForKey:@"MemFansAcount"] andKey:@"MemFansAcount"];
            
            // 设置标志商户那边的默认值为0
            [CommonUtil addValue:@"0" andKey:kMerchantKey];
            
            // 设置我邀请的好友默认值为0
            [CommonUtil addValue:@"0" andKey:kInviteFriendsKey];
            // 将我的通讯录好友存储起来
            [CommonUtil addValue:@"0" andKey:kMyContact];
            
            // 进行判断，如果请求下来的好友个数与数据库中的数据个数相等的话，则读取数据库中的数据，否则直接请求服务器去刷新
            if ( [self.m_friendsCount intValue] == [[friendHelp friendsList] count] ) {
                
                // 判断数据库中是否有数据，如果有则从数据库中直接读取，如果没有则请求服务器
                if ( [friendHelp friendsList].count != 0 ) {
                    
                    // 清空数据
                    if ( self.m_friendsArray.count != 0 ) {
                        
                        [self.m_friendsArray removeAllObjects];
                        
                    }
                    // 清空字典里面的数据
                    if ( self.m_FriendsListDic.count != 0 ) {
                        
                        [self.m_FriendsListDic removeAllObjects];
                        
                    }
                    
                    if ( self.m_allKeys.count != 0 ) {
                        
                        [self.m_allKeys removeAllObjects];
                        
                    }
                    
                    self.m_friendsArray = [friendHelp friendsList];
                    
                    // 将数据进行排序后显示
                    [self sortFriends];
                    
                    [self friendsRequest];

                    
                }

            }else{
                
                // 请求数据
                [self friendsRequest];
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
//    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MemberInviteList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            [self.m_friendsArray removeAllObjects];
            
            // 清空字典里面的数据
            [self.m_FriendsListDic removeAllObjects];
            
            [self.m_allKeys removeAllObjects];
            
            self.m_friendsArray = [json valueForKey:@"memberJoinedInvite"];
            
            // 将数据保存到数据库里面
            [friendHelp updateData:[json valueForKey:@"memberJoinedInvite"]];
            
            [friendHelp updateMerchantData:[json valueForKey:@"memberRelationsInfo"]];

            [friendHelp updateInviteFriends:[json valueForKey:@"memberInvitationInvite"]];
            
            // 将数据进行排序后显示
            [self sortFriends];
            
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
    
    return self.m_allKeys.count + 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    if ( section == 0 ) {
        
        return 3;
    
    }else{
        
        NSString *str = [self.m_allKeys objectAtIndex:section - 1];
        
        NSArray *friendsArr = [self.m_FriendsListDic objectForKey:str];
        
        return friendsArr.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    
    if ( indexPath.section == 0 ) {
        
        cell = [self CommontableView:tableView cellForRowAtIndexPath:indexPath];
    
    }else{
        
        cell = [self FriendstableView:tableView cellForRowAtIndexPath:indexPath];
        
    }

    return cell;
}

- (UITableViewCell *)CommontableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"NewFriendAndMeCellIdentifier";
    
    NewFriendAndMeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FriendsCell" owner:self options:nil];
        
        cell = (NewFriendAndMeCell *)[nib objectAtIndex:2];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    
    if ( indexPath.row == 0 ) {

        cell.m_imageView.image = [UIImage imageNamed:@"new_friend.png"];

        cell.m_nameLabel.text = @"新的朋友";
        
        // 判断新朋友的数据
        if ( [self.m_showCount isEqualToString:@"0"] ) {
            
            cell.m_numberImgV.hidden = YES;
            
            cell.m_numberLabel.hidden = YES;
       
        }else{
            
            cell.m_numberImgV.hidden = NO;
            
            cell.m_numberLabel.hidden = NO;
            
            cell.m_numberLabel.text = [NSString stringWithFormat:@"%@",self.m_showCount];
            
        }
        
    }else if ( indexPath.row == 1 ){
        
        cell.m_imageView.image = [UIImage imageNamed:@"Mysite.png"];

        cell.m_nameLabel.text = @"我的地盘";
        
        cell.m_numberImgV.hidden = YES;
        
        cell.m_numberLabel.hidden = YES;
        
    }else{
        
        cell.m_imageView.image = [UIImage imageNamed:@"inviteFriend.png"];

        cell.m_nameLabel.text = @"邀请中的好友";
        
        cell.m_numberImgV.hidden = YES;
        
        cell.m_numberLabel.hidden = YES;
        
    }
    
    return cell;

}

- (UITableViewCell *)FriendstableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

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
        NSString *key = [self.m_allKeys objectAtIndex:indexPath.section - 1];
        
        NSArray *array = [self.m_FriendsListDic objectForKey:key];
        
        NSDictionary *dic = [array objectAtIndex:indexPath.row];
        
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RealName"]];
        
        [cell setImageViewWithPath:[NSString stringWithFormat:@"%@",[dic objectForKey:@"PhotoUrl"]]];
        
    }
    
    return cell;

}

#pragma mark - UITableViewDelegate
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    return self.m_allKeys;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ( section != 0 ) {
        
        UIView* l_View = [[UIView alloc] init];
        l_View.backgroundColor = [UIColor clearColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, WindowSizeWidth, 22)];
        titleLabel.textColor=[UIColor grayColor];
        titleLabel.textAlignment = UITextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleLabel.backgroundColor = [UIColor clearColor];
        
        NSString *str = [self.m_allKeys objectAtIndex:section - 1];
        titleLabel.text = str;
        
        
        [l_View addSubview:titleLabel];
        
        return l_View;
        
    }else{
        
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    if ( section == 0 ) {
        
        return 0.0f;

    }else{
        
        return 30.0f;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 53.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.isEnterSecondPage = YES;
    
    
    if ( indexPath.section == 0 ) {
        
        if ( indexPath.row == 0 ) {
            
            // 点击后将cell上面的数字隐藏
            self.m_showCount = @"0";
            // 刷新某一行
            [self.m_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            
            // 点击进入新朋友列表后将未读的数据改为已读的数据写入数据库
            [FriendHelper updateIsreadNewFriendsCount];
            
            // 点击查看新朋友后就刷新下数据库中的数据
            [FriendHelper updateMemFan:self.m_memberInviteCount withMemInvitingAcount: self.m_newFriendsCount withNewFriendCount:self.m_totalCount];
         
            
            // 新朋友的列表
            NewFriendsViewController *VC = [[NewFriendsViewController alloc]initWithNibName:@"NewFriendsViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];

        }else if ( indexPath.row == 1 ){
            // 我关注的商户列表
            MySiteViewController *VC = [[MySiteViewController alloc]initWithNibName:@"MySiteViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else{
            // 邀请中的好友
            InvitationFriendsViewController *VC = [[InvitationFriendsViewController alloc]initWithNibName:@"InvitationFriendsViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
        }
    }else{
        
        // 赋值
        NSString *key = [self.m_allKeys objectAtIndex:indexPath.section - 1];
        
        NSArray *array = [self.m_FriendsListDic objectForKey:key];
        
        NSDictionary *dic = [array objectAtIndex:indexPath.row];
        
        // 进入详细资料
        UserInformationViewController *VC = [[UserInformationViewController alloc]initWithNibName:@"UserInformationViewController" bundle:nil];
        VC.m_typeString = @"2";
        ///// 好友Id================
        VC.m_friendId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

// 好友列表进行字母分类
- (void)sortFriends{
    
    if ( self.m_friendsArray.count != 0 ) {
        
        // 赋值
        self.m_tableView.tableFooterView = self.m_footerView;
        
        self.m_countLabel.text = [NSString stringWithFormat:@"共有%i位好友",self.m_friendsArray.count];
      
        // 进行排序循环
        for (int i = 0; i< self.m_friendsArray.count; i++) {
            NSDictionary *dic = [self.m_friendsArray objectAtIndex:i];
            
            NSString *pinyin = [self firstLetterForCompositeName:[dic objectForKey:@"RealName"]];
            
            NSArray *array = [self sortBypinyin:pinyin];
            
            [self.m_FriendsListDic setObject:array forKey:pinyin];
            
        }
        
        NSArray *allkeys  = [[self.m_FriendsListDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
        
        [self.m_allKeys addObjectsFromArray:allkeys];
        
    }else{
        
        
        self.m_tableView.tableFooterView = nil;
    }
    
    
    
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
    
    for (int i = 0; i< self.m_friendsArray.count; i++) {
        
        NSDictionary *dic = [self.m_friendsArray objectAtIndex:i];
        NSString *data_pinyin = [self firstLetterForCompositeName:[dic objectForKey:@"RealName"]];
        
        if ([data_pinyin isEqualToString:pinyin]) {
            [array addObject:dic];
        }
    }
    
    return array;
}


@end
