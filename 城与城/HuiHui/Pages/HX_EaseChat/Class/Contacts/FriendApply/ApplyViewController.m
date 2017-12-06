/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */
//easepushview hidetab

#import "ApplyViewController.h"

#import "ApplyFriendCell.h"
//#import "ApplyEntity.h"
#import "InvitationManager.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"

#import "IDInfoCache.h"

static ApplyViewController *controller = nil;

@interface ApplyViewController ()<ApplyFriendCellDelegate>

@property (strong, nonatomic) NSMutableArray *NewfriendSource;

@property (strong, nonatomic) IDInfoCache *InfoCache;


@end

@implementation ApplyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _dataSource = [[NSMutableArray alloc] init];
        _NewfriendSource = [[NSMutableArray alloc]init];
        _dataSourceInfo =[[NSMutableArray alloc]init];
        self.InfoCache  = [[IDInfoCache alloc]init];

    }
    return self;
}

+ (instancetype)shareController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[self alloc] initWithStyle:UITableViewStylePlain];
    });
    return controller;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.title = @"申请与通知";
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [backButton setImage:[UIImage imageNamed:@"arrow_WL.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    [self loadDataSourceFromLocalDB];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self hideTabBar:YES];
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    UITextAttributeTextColor: [UIColor whiteColor],
                                                                    UITextAttributeFont : [UIFont boldSystemFontOfSize:20]};

    if (ISrequest) {
        
        NSMutableArray *applicantUsername = [[NSMutableArray alloc]init];
        for (int iii =0 ; iii<self.dataSource.count; iii++) {
            ApplyEntity *entity = [self.dataSource objectAtIndex:iii];
            NSString *username = entity.applicantUsername;
            [applicantUsername addObject:username];
        }
        
        [self requestSubmitFromIDS:[NSString stringWithFormat:@"%@",[applicantUsername componentsJoinedByString:@","]]];
        
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideTabBar:NO];
}

#pragma mark - getter

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (NSString *)loginUsername
{
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    return [loginInfo objectForKey:kSDKUsername];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataSource count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ApplyFriendCell";
    ApplyFriendCell *cell = (ApplyFriendCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[ApplyFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.delegate = self;

    }
    if (ISrequest) {
        return cell;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    if(self.dataSource.count > indexPath.row)
    {
        ApplyEntity *entity = [self.dataSource objectAtIndex:indexPath.row];
        if (entity) {
            cell.indexPath = indexPath;
            ApplyStyle applyStyle = [entity.style integerValue];
            if (applyStyle == ApplyStyleGroupInvitation) {
                    cell.titleLabel.text = @"群组通知";
                    cell.headerImageView.image = [UIImage imageNamed:@"groupPrivateHeader"];
            }
            else if (applyStyle == ApplyStyleJoinGroup)
            {
                    cell.titleLabel.text = @"群组通知";
                    cell.headerImageView.image = [UIImage imageNamed:@"groupPrivateHeader"];
                    NSString*string =entity.reason;
                    NSRange range = [string rangeOfString:@"申请加入群组"];//匹配得到的下标
                    string = [string substringToIndex:range.location];
                    NSString *endstring = [entity.reason substringFromIndex:range.location];
                
                    if ([self ISnullInfo:entity.applicantUsername]) {
                        cell.contentLabel.text = [NSString stringWithFormat:@"%@%@",[[self.InfoCache getInfo:entity.applicantUsername] objectForKey:@"NickName"],endstring];
                    }
                    else{
                        ISrequest = YES;
                        [self.dataSourceInfo addObject:[NSString stringWithFormat:@"%@",entity.applicantUsername]];
                    }
                
            }
            else if(applyStyle == ApplyStyleFriend){
                    cell.headerImageView.image = [UIImage imageNamed:@"chatListCellHead"];
                
                    if ([self ISnullInfo:entity.applicantUsername]) {
                        
                        cell.titleLabel.text = [NSString stringWithFormat:@"%@",[[self.InfoCache getInfo:entity.applicantUsername] objectForKey:@"NickName"]];
                        [cell setAPPlyImageViewWithPath:[[self.InfoCache getInfo:entity.applicantUsername] objectForKey:@"PhotoMidUrl"]];
                        cell.contentLabel.text = entity.reason;
                    }
                    else{
                        
                        ISrequest = YES;
                        [self.dataSourceInfo addObject:[NSString stringWithFormat:@"%@",entity.applicantUsername]];

                    }

            }
        }
    }
    
    if (indexPath.row == self.dataSource.count) {
        if (ISrequest && self.dataSourceInfo.count!=0 ) {
        [self requestSubmitFromIDS:[NSString stringWithFormat:@"%@",[self.dataSourceInfo componentsJoinedByString:@","]]];
            [self.dataSourceInfo removeAllObjects];
        }
    }
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ApplyEntity *entity = [self.dataSource objectAtIndex:indexPath.row];
    return [ApplyFriendCell heightWithContent:entity.reason];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - ApplyFriendCellDelegate

- (void)applyCellAddFriendAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.dataSource count]) {
        [self showHudInView:self.view hint:@"正在发送申请"];
        ApplyEntity *entity = [self.dataSource objectAtIndex:indexPath.row];
//        ApplyStyle applyStyle = [entity.style integerValue];
        ApplyStyle applyStyle = [entity.style intValue];
        EMError *error;
        
        if (applyStyle == ApplyStyleGroupInvitation) {
            [[EaseMob sharedInstance].chatManager acceptInvitationFromGroup:entity.groupId error:&error];
        }
        else if (applyStyle == ApplyStyleJoinGroup)
        {
            [[EaseMob sharedInstance].chatManager acceptApplyJoinGroup:entity.groupId groupname:entity.groupSubject applicant:entity.applicantUsername error:&error];
        }
        else if(applyStyle == ApplyStyleFriend){
            
            [self InviteFriends:entity.applicantUsername SI:entity andindex:indexPath];
            return;

        }
        [self hideHud];
        if (!error &&applyStyle !=ApplyStyleFriend) {
                [self.dataSource removeObject:entity];
//                [entity deleteEntity];
            NSString *loginUsername = [[[EaseMob sharedInstance].chatManager loginInfo] objectForKey:kSDKUsername];
            [[InvitationManager sharedInstance] removeInvitation:entity loginUser:loginUsername];
                [self.tableView reloadData];
//                [self save];
                [self showHint:@"接收成功"];
        }
        else{
            [self showHint:@"接受失败"];
        }
    }
}

- (void)applyCellRefuseFriendAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.dataSource count]) {
        [self showHudInView:self.view hint:@"正在发送申请"];
        ApplyEntity *entity = [self.dataSource objectAtIndex:indexPath.row];
        ApplyStyle applyStyle = [entity.style integerValue];
        EMError *error;
        
        if (applyStyle == ApplyStyleGroupInvitation) {
            [[EaseMob sharedInstance].chatManager rejectInvitationForGroup:entity.groupId toInviter:entity.applicantUsername reason:@""];
        }
        else if (applyStyle == ApplyStyleJoinGroup)
        {
            NSString *reason = [NSString stringWithFormat:@"被拒绝加入群组\'%@\'", entity.groupSubject];
            [[EaseMob sharedInstance].chatManager rejectApplyJoinGroup:entity.groupId groupname:entity.groupSubject toApplicant:entity.applicantUsername reason:reason];
        }
        else if(applyStyle == ApplyStyleFriend){
            
            [self rejectFriends:entity.applicantUsername SI:entity andindex:indexPath];
            return;
        }
        
        [self hideHud];
        if (!error && applyStyle !=ApplyStyleFriend) {
            [self.dataSource removeObject:entity];
            NSString *loginUsername = [[[EaseMob sharedInstance].chatManager loginInfo] objectForKey:kSDKUsername];
            [[InvitationManager sharedInstance] removeInvitation:entity loginUser:loginUsername];
            [self.tableView reloadData];
            [self showHint:@"拒绝成功"];
        }
        else{
            [self showHint:@"拒绝失败"];
        }
    }
}

#pragma mark - public

- (void)addNewApply:(NSDictionary *)dictionary
{
    if (dictionary && [dictionary count] > 0) {
        NSString *applyUsername = [dictionary objectForKey:@"username"];
        ApplyStyle style = [[dictionary objectForKey:@"applyStyle"] intValue];
        
        if (applyUsername && applyUsername.length > 0) {
            for (int i = ((int)[_dataSource count] - 1); i >= 0; i--) {
                ApplyEntity *oldEntity = [_dataSource objectAtIndex:i];
                ApplyStyle oldStyle = [oldEntity.style intValue];
                if (oldStyle == style && [applyUsername isEqualToString:oldEntity.applicantUsername]) {
                    if(style != ApplyStyleFriend)
                    {
                        NSString *newGroupid = [dictionary objectForKey:@"groupname"];
                        if (newGroupid || [newGroupid length] > 0 || [newGroupid isEqualToString:oldEntity.groupId]) {
                            break;
                        }
                    }
                    
                    oldEntity.reason = [dictionary objectForKey:@"applyMessage"];
                    [_dataSource removeObject:oldEntity];
                    [_dataSource insertObject:oldEntity atIndex:0];
                    [self.tableView reloadData];
//                    [self save];
                    
                    return;
                }
            }
            
            //new apply
//            ApplyEntity *newEntity = [ApplyEntity createEntity];
            ApplyEntity * newEntity= [[ApplyEntity alloc] init];
            newEntity.applicantUsername = [dictionary objectForKey:@"username"];
            newEntity.style = [dictionary objectForKey:@"applyStyle"];
            newEntity.reason = [dictionary objectForKey:@"applyMessage"];
            
            NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
            NSString *loginName = [loginInfo objectForKey:kSDKUsername];
            newEntity.receiverUsername = loginName;
            
            NSString *groupId = [dictionary objectForKey:@"groupId"];
            newEntity.groupId = (groupId && groupId.length > 0) ? groupId : @"";
            
            NSString *groupSubject = [dictionary objectForKey:@"groupname"];
            newEntity.groupSubject = (groupSubject && groupSubject.length > 0) ? groupSubject : @"";
            
            [_dataSource insertObject:newEntity atIndex:0];
            [self.tableView reloadData];
            
//            if (style != ApplyStyleFriend) {
//                [self save];
//            }
        }
    }
}

//- (void)loadDataSourceFromLocalDB
//{
////    [_dataSource removeAllObjects];
//    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
//    NSString *loginName = [loginInfo objectForKey:kSDKUsername];
//    if(loginName && [loginName length] > 0)
//    {
//        NSPredicate *deletePredicate = [NSPredicate predicateWithFormat:@"receiverUsername = %@ and style = %i", loginName, ApplyStyleFriend];
//        [ApplyEntity deleteAllMatchingPredicate:deletePredicate];
//        
//        NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"receiverUsername = %@", loginName];
//        NSFetchRequest *request = [ApplyEntity requestAllWithPredicate:searchPredicate];
//        NSArray *applyArray = [ApplyEntity executeFetchRequest:request];
////        self.dataSource  = [applyArray mutableCopy];
//        _dataSource = [applyArray mutableCopy];
//        
//        [self.tableView reloadData];
//    }
//}

- (void)loadDataSourceFromLocalDB
{
    [_dataSource removeAllObjects];
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    NSString *loginName = [loginInfo objectForKey:kSDKUsername];
    if(loginName && [loginName length] > 0)
    {
        
        NSArray * applyArray = [[InvitationManager sharedInstance] applyEmtitiesWithloginUser:loginName];
        [self.dataSource addObjectsFromArray:applyArray];
        
        [self.tableView reloadData];
    }
}



- (void)back
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUntreatedApplyCount" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)save
//{
//    [[NSManagedObjectContext defaultContext] saveToPersistentStoreAndWait];
//}

- (void)clear
{
    [_dataSource removeAllObjects];
//    [_dataSourceInfo removeAllObjects];
    [self.tableView reloadData];
}

- (void) hideTabBar:(BOOL) hidden{
//    if ( isIOS7 ) {
//        [self.tabBarController.tabBar setHidden:hidden];
//        for(UIView *view in self.tabBarController.view.subviews)
//        {
//            CGSize m_size = self.tabBarController.view.frame.size;
//            if([view isKindOfClass:[UITabBar class]])
//            {
//                if (self.tabBarController.tabBar.hidden) {
//                    [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, view.frame.size.height)];
//                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width,m_size.height + 49);
//                } else {
//                    [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height-49, view.frame.size.width, view.frame.size.height)];
//                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width, m_size.height+ 49);
//                }
//            }
//            else
//            {
//                if (self.tabBarController.tabBar.hidden) {
//                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height)];
//                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width, m_size.height + 49);
//                } else {
//                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height-98)];
//                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width, m_size.height + 49);
//                }
//            }
//        }
//        
//    }else{
//        
//        if ( [self.tabBarController.view.subviews count] < 2 )
//        {
//            return;
//        }
//        UIView *contentView;
//        
//        if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ){
//            contentView = [self.tabBarController.view.subviews objectAtIndex:1];
//        }
//        else{
//            contentView = [self.tabBarController.view.subviews objectAtIndex:0];
//        }
//        if ( hidden ){
//            contentView.frame = self.tabBarController.view.bounds;
//        }
//        else
//        {
//            contentView.frame = CGRectMake(self.tabBarController.view.bounds.origin.x,
//                                           self.tabBarController.view.bounds.origin.y,
//                                           self.tabBarController.view.bounds.size.width,
//                                           self.tabBarController.view.bounds.size.height - self.tabBarController.tabBar.frame.size.height + 49);
//        }
//        self.tabBarController.tabBar.hidden = hidden;
//    }
}

//是否要请求数据
- (void)ISrequest:(NSString *)ID{
    if ([self ISnullInfo:ID]) {
        ISrequest = NO;
    }else{
        ISrequest = YES;
    }
}

// 多个ID（群成员）好友详细信息请求数据
- (void)requestSubmitFromIDS:(NSString *)IDS{
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           IDS,@"otherIds",
                           nil];
    [self showHudInView:self.view hint:@"加载数据"];
    [httpClient request:@"GetMemberDetail.ashx" parameters:param success:^(NSJSONSerialization* json){
        BOOL success = [[json valueForKey:@"status"] boolValue];
        [self hideHud];
        if (success) {
            ISrequest = NO;
            NSMutableArray *dataSourceInfo = [json valueForKey:@"friendsInfos"];
            for (int ii=0; ii<dataSourceInfo.count; ii++) {
                NSMutableDictionary *dic = [dataSourceInfo objectAtIndex:ii];
                [self.InfoCache addInfo:dic andID:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberId"]]];
            }
            
            [self.tableView reloadData];
        }else
        {
            ISrequest = YES;

        }
    } failure:^(NSError *error) {
        [self hideHud];
        ISrequest = YES;
    }];
    
}



// 同意别人的添加
- (void)InviteFriends:(NSString *)ID SI:(ApplyEntity*)entity andindex:(NSIndexPath *)indexPath{
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           ID,@"otherId",
                           nil];
    [httpClient request:@"AttentionAdd_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        [self hideHud];
        EMError * error;
        if (success) {
            [[EaseMob sharedInstance].chatManager acceptBuddyRequest:entity.applicantUsername error:&error];
            if (!error) {
                [self.dataSource removeObject:entity];
//                [entity deleteEntity];
                NSString *loginUsername = [[[EaseMob sharedInstance].chatManager loginInfo] objectForKey:kSDKUsername];
                [[InvitationManager sharedInstance] removeInvitation:entity loginUser:loginUsername];
                [self.tableView reloadData];
//                [self save];
                [self showHint:@"接收成功"];

            }else
            {
                [self showHint:@"接收失败"]; 
            }


        }else
        {
            [self showHint:@"接收失败"];
        }
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"接收失败"];
    }];
    
}
 // 拒绝别人的添加（A&B双方没有关注关系）跟删除好友同一接口
- (void)rejectFriends:(NSString *)ID SI:(ApplyEntity*)entity andindex:(NSIndexPath *)indexPath{
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           ID,@"otherId",
                           nil];
    [httpClient request:@"AttentionDelete.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        [self hideHud];
        EMError *error;
        if (success) {
            [[EaseMob sharedInstance].chatManager rejectBuddyRequest:entity.applicantUsername reason:@"" error:&error];
            if (!error) {
                [self.dataSource removeObject:entity];
                NSString *loginUsername = [[[EaseMob sharedInstance].chatManager loginInfo] objectForKey:kSDKUsername];
                [[InvitationManager sharedInstance] removeInvitation:entity loginUser:loginUsername];
                [self.tableView reloadData];
//                [self save];
                [self showHint:@"拒绝成功"];
            }else
            {
                [self showHint:@"拒绝失败"];

            }

        }else
        {
            [self showHint:@"拒绝失败"];
        }
        
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"拒绝失败"];
    }];
    
}


//判断根据ID的个人信息是否为空
-(BOOL)ISnullInfo:(NSString *)ID{
    NSMutableDictionary *reSizeInfo = [self.InfoCache getInfo:ID];
    if (reSizeInfo != nil) {
        return YES;
    }return NO;
}


@end
