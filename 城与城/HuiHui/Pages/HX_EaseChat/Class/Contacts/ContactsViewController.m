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

#import "ContactsViewController.h"
#import "ContactsDelegateViewController.h"
#import "BaseTableViewCell.h"
#import "RealtimeSearchUtil.h"
#import "ChineseToPinyin.h"
#import "EMSearchBar.h"
#import "SRRefreshView.h"
#import "EMSearchDisplayController.h"
#import "AddFriendViewController.h"
#import "ApplyViewController.h"
#import "GroupListViewController.h"
#import "ChatViewController.h"

#import "CommonUtil.h"
#import "FriendsCell.h"
#import "UserInformationViewController.h"
#import "Reachability.h"
#import "MySiteViewController.h"
#import "InvitationFriendsViewController.h"

#import "RightCell.h"
#import "NewFriendsViewController.h"
#import "SynchronousadressViewController.h"
#import "YunDongYSViewController.h"
#import "InterestShopViewController.h"

@interface ContactsViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UIActionSheetDelegate, SRRefreshDelegate,FriendsCellDelegate>
{
    NSIndexPath *_currentLongPressIndex;

}

@property (strong, nonatomic) NSMutableArray *contactsSource;//存储每区域

@property (strong, nonatomic) NSMutableArray *dataSource;//存储所有区域

@property (strong, nonatomic) NSMutableArray *sectionTitles;//存储每区域标题

@property (strong, nonatomic) UILabel *unapplyCountLabel;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) EMSearchBar *searchBar;
@property (strong, nonatomic) SRRefreshView *slimeView;
@property (strong, nonatomic) GroupListViewController *groupController;

@property (strong, nonatomic) EMSearchDisplayController *searchController;

@property (strong, nonatomic) UIControl *m_backView;
@property (strong, nonatomic) TableViewWithBlock *m_popTableView;

@property (nonatomic, strong) NSMutableArray        *m_popArray;

@property (nonatomic, strong) NSMutableArray        *sectionIndex;//用于存储索引栏，对应section下标

@end


@implementation ContactsViewController

@synthesize isEnterSecondPage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataSource = [NSMutableArray array];
        _contactsSource = [NSMutableArray array];
        _sectionTitles = [NSMutableArray array];
        friendHelp = [[FriendHelper alloc]init];
        _m_popArray = [[NSMutableArray alloc]init];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.title = @"圈子";

    //显示三个@“好友",@"电话本"
    [self didSegment];

    [self searchController];
    self.searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    self.tableView.tableHeaderView = self.searchBar;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    if ( isIOS7 ) {
        // section索引的背景色-右边排序的ABCD所在的视图
        self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    }
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.slimeView];
    [self.slimeView setLoadingWithExpansion];

}


-(UIBarButtonItem *)SETnavigationBarBtn:(NSString *)title
{
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    [addButton setTitle:title forState:UIControlStateNormal];
    [addButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [addButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    if ([title isEqualToString:@"添加"]) {
        
    [addButton addTarget:self action:@selector(addFriendAction) forControlEvents:UIControlEventTouchUpInside];

    }else if ([title isEqualToString:@"备份"])
    {
        [addButton addTarget:self action:@selector(DownloadAdress) forControlEvents:UIControlEventTouchUpInside];
 
    }
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    return _addFriendItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self friendsRequest];
    
    [self slimeRefreshStartRefresh:self.slimeView];
    
    isEnterSecondPage = NO;
    
    [self reloadApplyView];
    
    [self hideTabBar:NO];
    

//    // 这值1的时候表示通讯录有变化
//    NSString *string = [CommonUtil getValueByKey:@"NewFriendsKey"];
//    // 有变化的时候刷新tableView显示红点
//    if ( [string isEqualToString:@"1"] ) {
//        NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:2 inSection:0]];
//        [_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
//    }
    
    [[UINavigationBar appearance] setTintColor:[UIColor blueColor]];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

// 加载popTableView上面的内容
- (void)loadTableView{
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
             
             [self addFriendAction];
             
         }else if (indexPath.row ==1)
         {
             isEnterSecondPage = YES;
             // 进入手机联系人的界面
             PhoneContactsViewController *VC = [PhoneContactsViewController shareController];
             [self.navigationController pushViewController:VC animated:YES];
         }
         [self alphaviewtap];
     }];
    
    [self.m_popTableView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.m_popTableView.layer setBorderWidth:0];
    
}

- (void)alphaviewtap {
    [self rightClicked];
}

- (void)rightClicked{
    if ( tableViewOpened ) {
        self.m_popTableView.hidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.m_popTableView.frame;
            frame.size.height = 0;
            [self.m_popTableView setFrame:frame];
            self.m_backView.alpha = 0.0f;
            self.m_backView.hidden = YES;
        } completion:^(BOOL finished){
            tableViewOpened = NO;
        }];
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            self.m_popTableView.hidden = NO;
            self.m_backView.alpha = 0.3f;
            self.m_backView.hidden = NO;
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

#pragma mark - getter

- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[EMSearchBar alloc] init];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索";
        _searchBar.backgroundColor = [UIColor colorWithRed:0.747 green:0.756 blue:0.751 alpha:1.000];
    }
    
    return _searchBar;
}

- (UILabel *)unapplyCountLabel
{
    if (_unapplyCountLabel == nil) {
        _unapplyCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 5, 20, 20)];
        _unapplyCountLabel.textAlignment = NSTextAlignmentCenter;
        _unapplyCountLabel.font = [UIFont systemFontOfSize:11];
        _unapplyCountLabel.backgroundColor = [UIColor redColor];
        _unapplyCountLabel.textColor = [UIColor whiteColor];
        _unapplyCountLabel.layer.cornerRadius = _unapplyCountLabel.frame.size.height / 2;
        _unapplyCountLabel.hidden = YES;
        _unapplyCountLabel.clipsToBounds = YES;
    }
    
    return _unapplyCountLabel;
}

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

- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    
    return _tableView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.dataSource count] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 4;
    }
    
    return [[self.dataSource objectAtIndex:(section - 1)] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell *cell;
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
        if (cell == nil) {
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FriendCell"];
        }
        
        cell.imageView.image = [UIImage imageNamed:@"newFriends"];
        cell.textLabel.text = @"申请与通知";
        [cell addSubview:self.unapplyCountLabel];
    }
    else if(indexPath.section == 0 && indexPath.row == 1){
        static NSString *CellIdentifier = @"ContactListCell";
        cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//            cell.delegate = self;
        }
        
        cell.indexPath = indexPath;
        cell.imageView.image = [UIImage imageNamed:@"groupPrivateHeader"];
        cell.textLabel.text = @"我的群组";
    }
//    else if (indexPath.section == 0 && indexPath.row == 2)
//    {
//        static NSString *CellIdentifier = @"ContactListCell";
//        cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil) {
//            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
//        
//        cell.indexPath = indexPath;
//        cell.imageView.image = [UIImage imageNamed:@"Mysite.png"];
//        cell.textLabel.text = @"我的地盘";
//        
//    }else if (indexPath.section == 0 && indexPath.row == 3)
//    {
//        static NSString *CellIdentifier = @"ContactListCell";
//        cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil) {
//            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
//        
//        cell.indexPath = indexPath;
//        cell.imageView.image = [UIImage imageNamed:@"inviteFriend.png"];
//        cell.textLabel.text = @"邀请中的好友";
//        
//    }
    else if(indexPath.section == 0 && indexPath.row == 2){
        static NSString *CellIdentifier = @"ContactListCell";
        cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            //            cell.delegate = self;
        }
        
        cell.indexPath = indexPath;
        cell.imageView.image = [UIImage imageNamed:@"inviteFriend"];
        cell.textLabel.text = @"运动养生";
    }
    
    else if(indexPath.section == 0 && indexPath.row == 3){
        static NSString *CellIdentifier = @"ContactListCell";
        cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            //            cell.delegate = self;
        }
        
        cell.indexPath = indexPath;
        cell.imageView.image = [UIImage imageNamed:@"inviteFriend"];
        cell.textLabel.text = @"感兴趣的商户";
    }
    
//    else if (indexPath.section == 0 && indexPath.row == 2)
//    {
//        static NSString *CellIdentifier = @"ContactListCell";
//        cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil) {
//            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//            
//            // 添加红点的label
//            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(120, 22, 10, 10)];
//            label.backgroundColor = [UIColor redColor];
//            label.tag = 100001;
//            label.layer.cornerRadius = 5;
//            label.clipsToBounds = YES;
//            
//            [cell addSubview:label];
//            
//        }
//        
//        cell.indexPath = indexPath;
//        cell.imageView.image = [UIImage imageNamed:@"new_friend.png"];
//        cell.textLabel.text = @"新朋友";
//        
//        // 这值1的时候表示通讯录有变化
//        NSString *string = [CommonUtil getValueByKey:@"NewFriendsKey"];
//        
//        UILabel *label = (UILabel *)[cell viewWithTag:100001];
//        // 如果是1的话表示通讯录有变化
//        if ( [string isEqualToString:@"1"] ) {
//            
//            label.hidden = NO;
//            
//        }else{
//            
//            label.hidden = YES;
//        }
//        
//    }
    else{
        
        return  [self FriendstableView:tableView cellForRowAtIndexPath:indexPath];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}


- (UITableViewCell *)FriendstableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"FriendsCellIdentifier";
    FriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FriendsCell" owner:self options:nil];
        cell = (FriendsCell *)[nib objectAtIndex:0];
        [cell Addpress];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.delegate = self;
    }
    cell.m_inviteNameLabel.hidden = YES;
    cell.m_statusLabel.hidden = YES;
    cell.m_nameLabel.hidden = NO;
    cell.m_imageView.hidden = NO;
    cell.m_imageBtn.hidden = YES;
    
    
    cell.indexPath = indexPath;
        // 赋值
    NSDictionary * dic = [[self.dataSource objectAtIndex:(indexPath.section - 1)] objectAtIndex:indexPath.row];
    cell.m_imageView.image = [UIImage imageNamed:@"chatListCellHead.png"];
    cell.m_imageView.layer.masksToBounds = YES;
    cell.m_imageView.layer.cornerRadius = 4.0;
    cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RealName"]];
    [cell setImageViewWithPath:[NSString stringWithFormat:@"%@",[dic objectForKey:@"PhotoUrl"]]];
    
    return cell;
    
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
//    NSLog(@"%d",indexPath.section);
    if (indexPath.section == 0) {
        return NO;
        [self isViewLoaded];
    }
//    return YES;
    return NO;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
        NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
        
//        EMBuddy *buddy = [[self.dataSource objectAtIndex:(indexPath.section - 1)] objectAtIndex:indexPath.row];
        NSDictionary *buddy = [[self.dataSource objectAtIndex:(indexPath.section - 1)] objectAtIndex:indexPath.row];

        if ([[NSString stringWithFormat:@"%@",[buddy objectForKey:@"MemberID" ]] isEqualToString:loginUsername]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不能删除自己" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
            return;
        }
        
        [tableView beginUpdates];
        [[self.dataSource objectAtIndex:(indexPath.section - 1)] removeObjectAtIndex:indexPath.row];
        [self.contactsSource removeObject:buddy];
        [tableView  deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView  endUpdates];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            EMError *error;
            [[EaseMob sharedInstance].chatManager removeBuddy:[NSString stringWithFormat:@"%@",[buddy objectForKey:@"MemberID" ]] removeFromRemote:YES error:&error];
            if (!error) {
                //删除取消关注好友
                [self DeleteFriends:[NSString stringWithFormat:@"%@",[buddy objectForKey:@"MemberID" ]]];
            }
        });
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 53.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || [[self.dataSource objectAtIndex:(section - 1)] count] == 0)
    {
        return 0;
    }
    else{
        return 22;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0 || [[self.dataSource objectAtIndex:(section - 1)] count] == 0)
    {
        return nil;
    }
    
    UIView *contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 22)];
    label.backgroundColor = [UIColor clearColor];
    [label setText:[self.sectionTitles objectAtIndex:(section - 1)]];
    [contentView addSubview:label];

    return contentView;
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    _sectionIndex = [[NSMutableArray alloc]init];
    NSMutableArray * existTitles = [NSMutableArray array];
    //section数组为空的title过滤掉，不显示
    for (int i = 0; i < [self.sectionTitles count]; i++) {

        if ([[self.dataSource objectAtIndex:i] count] > 0) {
            [existTitles addObject:[self.sectionTitles objectAtIndex:i]];
            
            [_sectionIndex addObject:[NSString stringWithFormat:@"%d",i]];
        }
//        else{
//            [existTitles addObject:@""];
//        }
    }
    return existTitles;
}

// 点击目录
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{

        NSInteger section = [[_sectionIndex objectAtIndex:index] integerValue] +1;

        // 获取所点目录对应的indexPath值
        NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        // 让table滚动到对应的indexPath位置
        [tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    
        return section;

}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    isEnterSecondPage = YES;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[ApplyViewController shareController] animated:YES];
        }
        else if (indexPath.row == 1)
        {
            if (_groupController == nil) {
                _groupController = [[GroupListViewController alloc] initWithStyle:UITableViewStylePlain];
            }
            else{
                [_groupController reloadDataSource];
            }
            [self.navigationController pushViewController:_groupController animated:YES];
        }else if (indexPath.row == 2)
        {
            YunDongYSViewController *VC = [[YunDongYSViewController alloc]initWithNibName:@"YunDongYSViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.row == 3)
        {
            
            InterestShopViewController *vc = [[InterestShopViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    
//        else if (indexPath.row == 2)
//        {
//            // 点击进入之后将值设置为0
//            [CommonUtil addValue:@"0" andKey:@"NewFriendsKey"];
//            
//            // 进入新朋友的页面
//            NewFriendsViewController *VC = [NewFriendsViewController shareController];
//            
//            [self.navigationController pushViewController:VC animated:YES];
//            
//        }
//        else if (indexPath.row == 2)
//        {
//            // 我关注的商户列表
//            MySiteViewController *VC = [[MySiteViewController alloc]initWithNibName:@"MySiteViewController" bundle:nil];
//            [self.navigationController pushViewController:VC animated:YES];
//        }else if (indexPath.row ==3)
//        {
//            // 邀请中的好友
//            InvitationFriendsViewController *VC = [[InvitationFriendsViewController alloc]initWithNibName:@"InvitationFriendsViewController" bundle:nil];
//            [self.navigationController pushViewController:VC animated:YES];
//        }
    }
    else{
//        EMBuddy *buddy = [[self.dataSource objectAtIndex:(indexPath.section - 1)] objectAtIndex:indexPath.row];
        NSDictionary * dic  = [[self.dataSource objectAtIndex:(indexPath.section - 1)] objectAtIndex:indexPath.row];
        
        // 进入详细资料
        UserInformationViewController *VC = [[UserInformationViewController alloc]initWithNibName:@"UserInformationViewController" bundle:nil];
        VC.m_typeString = @"2";
        VC.m_friendId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]];
        VC.m_RName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RealName"] ];
        [self.navigationController pushViewController:VC animated:YES];

    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex != actionSheet.cancelButtonIndex && _currentLongPressIndex) {

        NSDictionary *buddy = [[self.dataSource objectAtIndex:(_currentLongPressIndex.section - 1)] objectAtIndex:_currentLongPressIndex.row];

        [self.tableView beginUpdates];
        [[self.dataSource objectAtIndex:(_currentLongPressIndex.section - 1)] removeObjectAtIndex:_currentLongPressIndex.row];
        [self.contactsSource removeObject:buddy];
        [self.tableView  deleteRowsAtIndexPaths:[NSArray arrayWithObject:_currentLongPressIndex] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView  endUpdates];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            EMError *error;
            [[EaseMob sharedInstance].chatManager removeBuddy:[NSString stringWithFormat:@"%@",[buddy objectForKey:@"MemberID" ]] removeFromRemote:YES error:&error];
            if (!error) {
                //删除取消关注好友
                [self DeleteFriends:[NSString stringWithFormat:@"%@",[buddy objectForKey:@"MemberID" ]]];
            }
        });
    }
    
    _currentLongPressIndex = nil;
}

#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_slimeView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_slimeView scrollViewDidEndDraging];
}

#pragma mark - slimeRefresh delegate
//刷新列表
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    __weak ContactsViewController *weakSelf = self;
    [weakSelf reloadDataSource:nil];

}

#pragma mark - BaseTableCellDelegate

- (void)cellImageViewLongPressAtIndexPathHMD:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return;
    }
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
    NSDictionary *buddy = [[self.dataSource objectAtIndex:(indexPath.section - 1)] objectAtIndex:indexPath.row];

    if ([[NSString stringWithFormat:@"%@",[buddy objectForKey:@"MemberID"] ] isEqualToString:loginUsername]){
        return;
    }
    
    _currentLongPressIndex = indexPath;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除好友" otherButtonTitles:nil, nil];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

#pragma mark - private

- (NSMutableArray *)sortDataArray:(NSArray *)dataArray
{
    //建立索引的核心
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    
    self.sectionTitles = [[indexCollation sectionTitles] mutableCopy];
    
    //返回27，是a－z和＃
    NSInteger highSection = [self.sectionTitles count];
    //tableView 会被分成27个section
    NSMutableArray *sortedArray = [NSMutableArray arrayWithCapacity:highSection];
    for (int i = 0; i <= highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sortedArray addObject:sectionArray];
    }
    
    for (NSDictionary * dic in dataArray) {
        //getUserName是实现中文拼音检索的核心，见NameIndex类
        NSString *firstLetter = [ChineseToPinyin pinyinFromChineseString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"RealName"]]];
        
        if ( firstLetter.length != 0 ) {
        
            NSInteger section = [indexCollation sectionForObject:[firstLetter substringToIndex:1] collationStringSelector:@selector(uppercaseString)];
            
            NSMutableArray *array = [sortedArray objectAtIndex:section];
            [array addObject:dic];
            
        }
        
    }

    for (int i = 0; i < [sortedArray count]; i++) {
        NSArray *array = [[sortedArray objectAtIndex:i] sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
            NSString *str1 = [NSString stringWithFormat:@"%@",[obj1 objectForKey:@"RealName"] ];
            NSString *str2 = [NSString stringWithFormat:@"%@",[obj2 objectForKey:@"RealName"] ];

            NSString *firstLetter1 = [ChineseToPinyin pinyinFromChineseString:str1];
            firstLetter1 = [[firstLetter1 substringToIndex:1] uppercaseString];
            
            NSString *firstLetter2 = [ChineseToPinyin pinyinFromChineseString:str2];
            firstLetter2 = [[firstLetter2 substringToIndex:1] uppercaseString];
            
            return [firstLetter1 caseInsensitiveCompare:firstLetter2];
        }];
        
        [sortedArray replaceObjectAtIndex:i withObject:[NSMutableArray arrayWithArray:array]];
    }
    
    return sortedArray;
}

#pragma mark - dataSource

- (void)reloadDataSource:(NSString *)DB
{
    if ([DB isEqualToString:@"YES"]) {
        //数据库提取
        self.contactsSource = [friendHelp friendsList];
        self.dataSource  = [self sortDataArray:self.contactsSource];
        [_tableView reloadData];
        [self.slimeView endRefresh];
        return;
    }
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    BOOL  isExistenceNetWork = YES;
    switch ( [reach currentReachabilityStatus] ) {
        case NotReachable:
            isExistenceNetWork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetWork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetWork = YES;
            break;
        default:
            break;
    }
    if ( !isExistenceNetWork ) {
        //数据库提取
        self.contactsSource = [friendHelp friendsList];
        self.dataSource  = [self sortDataArray:self.contactsSource];
        [_tableView reloadData];
        [self.slimeView endRefresh];
        
    }else{
        //更新数据库信息
        [self friendsRequest];
    }
}

#pragma mark - action

- (void)reloadApplyView
{
    NSInteger count = [[[ApplyViewController shareController] dataSource] count];
    
    if (count == 0) {
        self.unapplyCountLabel.hidden = YES;
    }
    else
    {
        NSString *tmpStr = [NSString stringWithFormat:@"%li", (long)count];
        CGSize size = [tmpStr sizeWithFont:self.unapplyCountLabel.font constrainedToSize:CGSizeMake(50, 20) lineBreakMode:NSLineBreakByWordWrapping];
        CGRect rect = self.unapplyCountLabel.frame;
        rect.size.width = size.width > 20 ? size.width : 20;
        self.unapplyCountLabel.text = tmpStr;
        self.unapplyCountLabel.frame = rect;
        self.unapplyCountLabel.hidden = NO;
    }
}

- (void)reloadGroupView
{
    [self reloadApplyView];
    
    if (_groupController) {
        [_groupController reloadDataSource];
    }
}

- (void)addFriendAction
{
    isEnterSecondPage = YES;
    // 进入按号码搜索的界面
    SearchNumberViewController *VC = [[SearchNumberViewController alloc]initWithNibName:@"SearchNumberViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
}


/*!
 诲诲增加处理信息
 */
/////////////
//好友信息列表
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
    [httpClient request:@"MemberInviteList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            self.contactsSource = [json valueForKey:@"memberJoinedInvite"];
            self.dataSource  = [self sortDataArray:self.contactsSource];
            [_tableView reloadData];
            [self.slimeView endRefresh];

            // 将数据保存到数据库里面
            [friendHelp updateData:self.contactsSource];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败，稍后再试"];

    }];
}


// 删除好友的请求数据
- (void)DeleteFriends:(NSString *)ID{
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
        if (success) {
            [[EaseMob sharedInstance].chatManager removeConversationByChatter:ID deleteMessages:YES append2Chat:NO];
            
        }
    } failure:^(NSError *error) {

    }];
    
}

- (EMSearchDisplayController *)searchController
{
    if (_searchController == nil) {
        _searchController = [[EMSearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        _searchController.delegate = self;
        _searchController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        __weak ContactsViewController *weakSelf = self;
        [_searchController setCellForRowAtIndexPathCompletion:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            static NSString *CellIdentifier = @"ContactListCell";
            BaseTableViewCell *cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            // Configure the cell...
            if (cell == nil) {
                cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            NSDictionary *buddy = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[buddy objectForKey:@"RealName"]];
            cell.imageView.image = [UIImage imageNamed:@"chatListCellHead.png"];
            [cell setImageViewWithPath:[NSString stringWithFormat:@"%@",[buddy objectForKey:@"PhotoUrl"]]];
            
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
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            NSDictionary *buddy = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
            NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
            if (loginUsername && loginUsername.length > 0) {
                if ([loginUsername isEqualToString:[buddy objectForKey:@"RealName"]]) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不能跟自己聊天" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    
                    return;
                }
            }
            
            [weakSelf.searchController.searchBar endEditing:YES];
            ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:[NSString stringWithFormat:@"%@",[buddy objectForKey:@"MemberID" ]] isGroup:NO];
            chatVC.title = [buddy objectForKey:@"RealName"];
            [weakSelf.navigationController pushViewController:chatVC animated:YES];
        }];
    }
    
    return _searchController;
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self hiddenNumPadDone:nil];
    [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
     [[RealtimeSearchUtil currentUtil] realtimeSearchWithSource:self.contactsSource searchText:(NSString *)searchText collationStringSelector:nil resultBlock:^(NSArray *results) {
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


//UISegmentedControl选择器
-(void)didSegment
{
    // 设置导航栏上的搜索框
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowSize.size.width, 44)];
//    view.backgroundColor = [UIColor redColor];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 9, 150, 24)];
    
    imgV.backgroundColor = [UIColor clearColor];
    imgV.layer.borderWidth = 1.0;
    imgV.layer.cornerRadius = 12.0f;
    imgV.layer.masksToBounds = YES;
    imgV.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [view addSubview:imgV];
    
    
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"好友",@"电话本",nil];
    //初始化UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
//    segmentedControl.frame = CGRectMake(WindowSizeWidth/2-100, 3, 200, 34);
    segmentedControl.frame = CGRectMake(0, 9, 150, 24);
    segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    segmentedControl.tintColor =[UIColor whiteColor];
    segmentedControl.layer.cornerRadius = 12.0f;
    segmentedControl.layer.masksToBounds = YES;
    
    segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;//设置样式
    
    [segmentedControl addTarget:self action:@selector(SelectChangebutton:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:segmentedControl];
    self.navigationItem.titleView = view;
    
    
    self.navigationItem.rightBarButtonItems = @[[self SETnavigationBarBtn:@"添加"],[self SETnavigationBarBtn:@"备份"]];
    
    [self setLeftButtonWithTitle:@"协议" action:@selector(delegateClick)];

}

- (void)delegateClick {
    
    ContactsDelegateViewController *vc = [[ContactsDelegateViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)SelectChangebutton:(UISegmentedControl *)Seg{
    
    [self hiddenNumPadDone:nil];
    [self.view endEditing:YES];
    NSInteger Index = Seg.selectedSegmentIndex;
    
    switch (Index) {
            
        case 0:
            
            [self.view bringSubviewToFront:self.tableView];//

            break;
            
        case 1:
            
            if (!PhoneContactsVC) {
                PhoneContactsVC = [PhoneContactsViewController shareController];
                PhoneContactsVC.PhoneContactsNav = self.navigationController;
                PhoneContactsVC.PhoneContactsView = self.view;
                [self.view addSubview:PhoneContactsVC.view];

            }else{
                [self.view bringSubviewToFront:PhoneContactsVC.view];//

            }
            
            break; 
            
        default:
            
            break;
            
    }
    
}





//同步
-(void)DownloadAdress
{
    SynchronousadressViewController *VC = [[SynchronousadressViewController alloc]initWithNibName:@"SynchronousadressViewController" bundle:nil];
    if (!PhoneContactsVC) {
        PhoneContactsVC = [PhoneContactsViewController shareController];
        PhoneContactsVC.PhoneContactsNav = self.navigationController;
        PhoneContactsVC.PhoneContactsView = self.view;
        [self.view addSubview:PhoneContactsVC.view];
        [self.view bringSubviewToFront:self.tableView];//

    }else{
        VC.PhoneContactsVC = PhoneContactsVC;
    }
    
    
    [self.navigationController pushViewController:VC animated:YES];

}



@end
