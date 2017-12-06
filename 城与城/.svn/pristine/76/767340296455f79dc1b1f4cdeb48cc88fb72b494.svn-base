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

#import "GroupListViewController.h"

#import "EMSearchBar.h"
#import "SRRefreshView.h"
#import "BaseTableViewCell.h"
#import "EMSearchDisplayController.h"
#import "ChatViewController.h"
#import "CreateGroupViewController.h"
#import "PublicGroupListViewController.h"
#import "RealtimeSearchUtil.h"
#import "UIViewController+HUD.h"
#import "CommonUtil.h"
#import "ProductDetailViewController.h"

@interface GroupListViewController ()<UISearchBarDelegate, UISearchDisplayDelegate, IChatManagerDelegate, SRRefreshDelegate>
{
    UIBarButtonItem *publicItem;
    UIBarButtonItem *createGroupItem;
}

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) SRRefreshView *slimeView;
@property (strong, nonatomic) EMSearchBar *searchBar;
@property (strong, nonatomic) EMSearchDisplayController *searchController;

@end

@implementation GroupListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    [self setTitle:@"我的群组"];

    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    UITextAttributeTextColor: [UIColor whiteColor],
                                                                    UITextAttributeFont : [UIFont boldSystemFontOfSize:20]};
#warning 把self注册为SDK的delegate
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    self.tableView.separatorColor = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
//    self.tableView.tableHeaderView = self.searchBar;
    [self.tableView addSubview:self.slimeView];
    [self searchController];
    
    UIButton *publicButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [publicButton setImage:[UIImage imageNamed:@"nav_createGroup"] forState:UIControlStateNormal];
    [publicButton addTarget:self action:@selector(showPublicGroupList) forControlEvents:UIControlEventTouchUpInside];
    publicItem = [[UIBarButtonItem alloc] initWithCustomView:publicButton];
    
    UIButton *createButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [createButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [createButton addTarget:self action:@selector(createGroup) forControlEvents:UIControlEventTouchUpInside];
    createGroupItem = [[UIBarButtonItem alloc] initWithCustomView:createButton];
    
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [backButton setImage:[UIImage imageNamed:@"arrow_WL.png"] forState:UIControlStateNormal];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    [self reloadDataSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    if (!self.didselectandpoptwo) {
        [self.navigationItem setRightBarButtonItems:@[createGroupItem, publicItem]];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    self.didselectandpoptwo = nil;

}
- (void)dealloc
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - getter

- (SRRefreshView *)slimeView
{
    if (_slimeView == nil) {
        _slimeView = [[SRRefreshView alloc] init];
        _slimeView.delegate = self;
        _slimeView.upInset = 0;
        _slimeView.slimeMissWhenGoingBack = YES;
        _slimeView.slime.bodyColor = [UIColor grayColor];
        _slimeView.slime.skinColor = [UIColor grayColor];
        _slimeView.slime.lineWith = 1;
        _slimeView.slime.shadowBlur = 4;
        _slimeView.slime.shadowColor = [UIColor grayColor];
    }
    
    return _slimeView;
}

- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[EMSearchBar alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索";
        _searchBar.backgroundColor = [UIColor colorWithRed:0.747 green:0.756 blue:0.751 alpha:1.000];
    }
    
    return _searchBar;
}

- (EMSearchDisplayController *)searchController
{
    if (_searchController == nil) {
        _searchController = [[EMSearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        _searchController.delegate = self;
        _searchController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        __weak GroupListViewController *weakSelf = self;
        [_searchController setCellForRowAtIndexPathCompletion:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            static NSString *CellIdentifier = @"ContactListCell";
            BaseTableViewCell *cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            // Configure the cell...
            if (cell == nil) {
                cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            EMGroup *group = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            NSString *imageName = group.isPublic ? @"groupPublicHeader" : @"groupPrivateHeader";
            cell.imageView.image = [UIImage imageNamed:imageName];
            cell.textLabel.text = group.groupSubject;
            
            return cell;
        }];
        
        [_searchController setHeightForRowAtIndexPathCompletion:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            return 50;
        }];
        
        [_searchController setDidSelectRowAtIndexPathCompletion:^(UITableView *tableView, NSIndexPath *indexPath) {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0) {
                UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"警告" message:@"由于您的手机操作系统版本太低，城与城 部分功能不能使用，若想完美使用城与城，请在设置中更新您手机的操作系统。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [view show];
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                return;
            }
            [weakSelf.searchController.searchBar endEditing:YES];
            
            EMGroup *group = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:group.groupId isGroup:YES];
            [weakSelf.navigationController pushViewController:chatVC animated:YES];
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];

        }];
    }
    
    return _searchController;
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
    static NSString *CellIdentifier = @"GroupCell";
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;

    EMGroup *group = [self.dataSource objectAtIndex:indexPath.row];
    NSString *imageName = group.isPublic ? @"groupPublicHeader" : @"groupPrivateHeader";
    cell.imageView.image = [UIImage imageNamed:imageName];
    if (group.groupSubject && group.groupSubject.length > 0) {
        cell.textLabel.text = group.groupSubject;
    }
    else {
        cell.textLabel.text = group.groupId;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0) {
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"警告" message:@"由于您的手机操作系统版本太低，城与城 部分功能不能使用，若想完美使用城与城，请在设置中更新您手机的操作系统。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [view show];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
    if (self.didselectandpoptwo) {
        chosepath = indexPath.row;
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                           message:@"确定发送消息?"
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:@"确定", nil];
        alertView.tag = 10010;
        [alertView show];
        
    }else
    {
    EMGroup *group = [self.dataSource objectAtIndex:indexPath.row];
    ChatViewController *chatController = [[ChatViewController alloc] initWithChatter:group.groupId isGroup:YES];
    chatController.title = group.groupSubject;
    [self.navigationController pushViewController:chatController animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [[RealtimeSearchUtil currentUtil] realtimeSearchWithSource:self.dataSource searchText:(NSString *)searchText collationStringSelector:@selector(groupSubject) resultBlock:^(NSArray *results) {
        if (results) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.searchController.resultsSource removeAllObjects];
                [self.searchController.resultsSource addObjectsFromArray:results];
                [self.searchController.searchResultsTableView reloadData];
            });
        }
    }];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{

    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [[RealtimeSearchUtil currentUtil] realtimeSearchStop];
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark - SRRefreshDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_slimeView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_slimeView scrollViewDidEndDraging];
}

- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsListWithCompletion:^(NSArray *groups, EMError *error) {
        if (!error) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:groups];
            [self.tableView reloadData];
        }
    } onQueue:nil];
    
//    [[EaseMob sharedInstance].chatManager asyncFetchAllPrivateGroupsWithCompletion:^(NSArray *groups, EMError *error) {
//        
//    } onQueue:nil];
    
    [_slimeView endRefresh];
}

#pragma mark - IChatManagerDelegate

- (void)groupDidUpdateInfo:(EMGroup *)group error:(EMError *)error
{
    if (!error) {
        [self reloadDataSource];
    }
}

- (void)didUpdateGroupList:(NSArray *)allGroups error:(EMError *)error
{
    [self reloadDataSource];
}

#pragma mark - data

- (void)reloadDataSource
{
//    [self.dataSource removeAllObjects];
//    
//    NSArray *rooms = [[EaseMob sharedInstance].chatManager groupList];
//    [self.dataSource addObjectsFromArray:rooms];
//    NSLog(@"%d",rooms.count);
//    
//    [self.tableView reloadData];
    
    [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsListWithCompletion:^(NSArray *groups, EMError *error) {
        if (!error) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:groups];
            [self.tableView reloadData];
        }
    } onQueue:nil];
}

#pragma mark - action

- (void)showPublicGroupList
{
    PublicGroupListViewController *publicController = [[PublicGroupListViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:publicController animated:YES];
}

- (void)createGroup
{
    CreateGroupViewController *createChatroom = [[CreateGroupViewController alloc] init];
    [self.navigationController pushViewController:createChatroom animated:YES];
}



#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 10010 ) {
        if ( buttonIndex == 1 ) {
            
            EMGroup *group = [self.dataSource objectAtIndex:chosepath];
            NSString *MemberID = group.groupId;
            
            if ([self.MessageType isEqualToString:@"PRO"]) {
                NSString *imagePath =[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"productImage"]];
                NSString *Title = @"";
                if ([self.m_FromDPId isEqualToString:@"1"]){
                    Title =  [NSString stringWithFormat:@"%@",[self.didselectandpoptwo objectForKey:@"description"]];
                }else{
                    Title =  [NSString stringWithFormat:@"%@",[self.didselectandpoptwo objectForKey:@"SvcSimpleName"]];
                }
                
                [self sendU_definedMessage:imagePath andtitle:Title andsubtitle:nil andtype:@"PRO" andtoid:MemberID andgroup:YES];
            }else if ([self.MessageType isEqualToString:@"WEB"]){
                NSString *imagePath = [self.didselectandpoptwo objectForKey:@"imageURL"];
                NSString *Title = [self.didselectandpoptwo objectForKey:@"title"];
                
                [self sendU_definedMessage:imagePath andtitle:Title andsubtitle:nil andtype:@"WEB" andtoid:MemberID andgroup:YES];
                
            }
 
        }
    }
    
}

#pragma mark 发送自定义消息（高级会话）一般是图片+正副标题（类型一般是产品，活动，网站等等）
-(void)sendU_definedMessage:(NSString *)Photo andtitle:(NSString *)title andsubtitle:(NSString *)subtitle andtype:(NSString *)type andtoid:(NSString *)username andgroup:(BOOL)Isgroup
{
    //@"自定义消息_HuiHui_012345"
    EMChatText *userObject = [[EMChatText alloc] initWithText:title];
    EMTextMessageBody *body = [[EMTextMessageBody alloc]
                               initWithChatObject:userObject];
    EMMessage *msg = [[EMMessage alloc] initWithReceiver:username
                                                  bodies:@[body]];
    //是否需要加密消息=NO
    msg.requireEncryption = NO;
    //是否是发送给群组
    msg.isGroup = Isgroup;
    NSMutableDictionary *vcardProperty = [NSMutableDictionary dictionary];
    //发送的图片地址
   	[vcardProperty setObject:Photo forKey:@"coverphoto"];
    //发送标题
    [vcardProperty setObject:title forKey:@"title"];
    //发送的类型（PRO是产品 else是活动）
   	[vcardProperty setObject:type forKey:@"type"];
    
    //如果类型 是产品
    if ([type isEqualToString:@"PRO"]) {
        //如果是DP的产品
        if ([self.m_FromDPId isEqualToString:@"1"]){
            [vcardProperty setObject:self.m_productId forKey:@"m_productId"];
            [vcardProperty setObject:@"0" forKey:@"m_merchantShopId"];
            [vcardProperty setObject:@"1" forKey:@"m_FromDPId"];
        }else{
            [vcardProperty setObject:self.m_productId forKey:@"m_productId"];
            [vcardProperty setObject:self.m_merchantShopId forKey:@"m_merchantShopId"];
            [vcardProperty setObject:@"2" forKey:@"m_FromDPId"];
        }}else if ([type isEqualToString:@"WEB"]){
            [vcardProperty setObject:[self.didselectandpoptwo objectForKey:@"shareString"] forKey:@"shareString"];
        }
    
    msg.ext = vcardProperty;
    [[EaseMob sharedInstance].chatManager asyncSendMessage:msg progress:nil prepare:^(EMMessage *message, EMError *error) {
        if (!error) {
            [self showHudInView:self.view hint:@"正在发送..."];
        }
    } onQueue:nil completion:^(EMMessage *message, EMError *error) {
        [self hideHud];
        if (!error) {
            [self showHint:@"发送成功"];
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(leftClickedtwo) userInfo:nil repeats:NO];
        }else{
            [self showHint:@"发送失败"];
        }
    } onQueue:nil];
    
}

-(void)leftClickedtwo
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ProductDetailViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }
    }
}

@end
