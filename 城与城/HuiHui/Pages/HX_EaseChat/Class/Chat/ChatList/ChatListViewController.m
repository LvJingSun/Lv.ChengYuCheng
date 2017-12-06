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

#import "ChatListViewController.h"
#import "SRRefreshView.h"
#import "ChatListCell.h"
#import "EMSearchBar.h"
#import "NSDate+Category.h"
#import "RealtimeSearchUtil.h"
#import "ChatViewController.h"
#import "EMSearchDisplayController.h"
#import "ConvertToCommonEmoticonsHelper.h"
#import "CommonUtil.h"
#import "Reachability.h"

#import "FriendHelper.h"
#import "InviteViewController.h"
#import "NotsupportViewController.h"

#import "ContactsViewController.h"
#import "DynamicViewController.h"

#import "PengYouQuanView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

@interface ChatListViewController ()<UITableViewDelegate,UITableViewDataSource, UISearchDisplayDelegate,SRRefreshDelegate, UISearchBarDelegate, IChatManagerDelegate>
{
    FriendHelper  *friendHelp;

}

@property (strong, nonatomic) NSMutableArray        *dataSource;

@property (strong, nonatomic) NSMutableArray        *dataSourceInfo;

@property (strong, nonatomic) UITableView           *tableView;
//@property (nonatomic, strong) EMSearchBar           *searchBar;
@property (nonatomic, strong) SRRefreshView         *slimeView;
@property (nonatomic, strong) UIView                *networkStateView;

@property (strong, nonatomic) EMSearchDisplayController *searchController;

@property (strong, nonatomic) UILabel        *dataSourceLabel;

@end

@implementation ChatListViewController

@synthesize isEnterSecondPage;

@synthesize RedTipCnt;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataSource = [NSMutableArray array];
        self.InfoCache  = [[IDInfoCache alloc]init];
        self.M_ImageV = [[UIImageView alloc]init];
        _dataSourceInfo = [NSMutableArray array];
        friendHelp = [[FriendHelper alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setBackBtn];
    
    self.title = @"消息";
    
//    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.slimeView];
    [self networkStateView];
    
    [self searchController];
    
    self.dataSourceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, WindowSize.size.height/2 , WindowSizeWidth, 30)];
    self.dataSourceLabel.textColor = [UIColor lightGrayColor];
    self.dataSourceLabel.textAlignment = NSTextAlignmentCenter;
    [self.dataSourceLabel setFont:[UIFont fontWithName:@"Helvetica"size:23.0]];
    self.dataSourceLabel.text = @"暂无消息";
    self.dataSourceLabel.hidden = YES;
    [self.tableView addSubview:self.dataSourceLabel];
    
    [self setRightButtonWithNormalImage:@"add.png" action:@selector(rightClicked)];
    
    //点群里头像进行个聊
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GroupselectedO:) name:@"GroupselectedO" object:nil];
    
    
    if ( isIOS7 ) {
        self.navigationController.navigationBar.translucent = NO;
    }
 
    
    // 设置导航栏的背景和tabBar的背景颜色 区分低版本和高版本
    if ( isIOS7 ) {
 
        [self.navigationController.navigationBar setBarTintColor:RGBACKTAB];
        [self.tabBarController.tabBar setBarTintColor:RGBACKTAB];
        
    }else{
        
        [self.navigationController.navigationBar setTintColor:RGBACKTAB];
        [self.tabBarController.tabBar setTintColor:RGBACKTAB];
    }
    self.navigationController.navigationBar.titleTextAttributes = @{ UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:20]};

    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0) {
        NotsupportViewController * VC = [[NotsupportViewController alloc]initWithNibName:@"NotsupportViewController" bundle:nil];
        [self.view addSubview:VC.view];
        
    }
    
}

- (void)setRightButtonWithNormalImage:(NSString *)aImageName action:(SEL)action{
    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0, 0, 50, 29)];
    _button.backgroundColor = [UIColor clearColor];
    [_button setImage:[UIImage imageNamed:aImageName] forState:UIControlStateNormal];
    [_button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
    [self.navigationItem setRightBarButtonItem:_barButton];
    
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [leftBtn setFrame:CGRectMake(0, 0, 60, 30)];
//    
//    [leftBtn setTitle:@"联系人" forState:UIControlStateNormal];
//    
//    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    
//    [self.navigationItem setLeftBarButtonItem:leftBarBtn];
    
}

//- (void)leftBtnClick {
//    
//    ContactsViewController *vc = [[ContactsViewController alloc] init];
//    
//    [self.navigationController pushViewController:vc animated:YES];
//    
//}

- (void)setBackBtn {
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backItem;
    
}

-(void)rightClicked
{
    InviteViewController * VC = [[InviteViewController alloc]initWithNibName:@"InviteViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0) {
        return;
    }
    
    [self refreshDataSource];
    [self registerNotifications];
    
    isEnterSecondPage = NO;
    
    [self requestSubmitRedDian];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0) {
        return;
    }
    [self unregisterNotifications];
    
}

#pragma mark - getter

- (SRRefreshView *)slimeView
{
    if (!_slimeView) {
        _slimeView = [[SRRefreshView alloc] init];
        _slimeView.delegate = self;
        _slimeView.upInset = 0;
        _slimeView.slimeMissWhenGoingBack = YES;
        _slimeView.slime.bodyColor = [UIColor grayColor];
        _slimeView.slime.skinColor = [UIColor grayColor];
        _slimeView.slime.lineWith = 1;
        _slimeView.slime.shadowBlur = 4;
        _slimeView.slime.shadowColor = [UIColor grayColor];
        _slimeView.backgroundColor = [UIColor whiteColor];
    }
    
    return _slimeView;
}

//- (UISearchBar *)searchBar
//{
//    if (!_searchBar) {
//        _searchBar = [[EMSearchBar alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 44)];
//        _searchBar.delegate = self;
//        _searchBar.placeholder = @"搜索";
//        _searchBar.backgroundColor = [UIColor colorWithRed:0.747 green:0.756 blue:0.751 alpha:1.000];
//    }
//    
//    return _searchBar;
//}

- (UITableView *)tableView
{
    if (_tableView == nil) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.searchBar.frame.size.height) style:UITableViewStylePlain];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ChatListCell class] forCellReuseIdentifier:@"chatListCell"];
    }
    
    return _tableView;
}

- (EMSearchDisplayController *)searchController
{
    if (_searchController == nil) {
//        _searchController = [[EMSearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        _searchController.delegate = self;
        _searchController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        __weak ChatListViewController *weakSelf = self;
        [_searchController setCellForRowAtIndexPathCompletion:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            static NSString *CellIdentifier = @"ChatListCell";
            ChatListCell *cell = (ChatListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            // Configure the cell...
            if (cell == nil) {
                cell = [[ChatListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            EMConversation *conversation = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            cell.name = conversation.chatter;
            if (!conversation.isGroup) {
                cell.placeholderImage = [UIImage imageNamed:@"chatListCellHead.png"];
            }
            else{
                NSString *imageName = @"groupPublicHeader";
                NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
                for (EMGroup *group in groupArray) {
                    if ([group.groupId isEqualToString:conversation.chatter]) {
                        cell.name = group.groupSubject;
                        imageName = group.isPublic ? @"groupPublicHeader" : @"groupPrivateHeader";
                        break;
                    }
                }
                cell.placeholderImage = [UIImage imageNamed:imageName];
            }
            cell.detailMsg = [weakSelf subTitleMessageByConversation:conversation];
            cell.time = [weakSelf lastMessageTimeByConversation:conversation];
            cell.unreadCount = [weakSelf unreadMessageCountByConversation:conversation];
            if (indexPath.row % 2 == 1) {
                cell.contentView.backgroundColor = RGBACOLOR(246, 246, 246, 1);
            }else{
                cell.contentView.backgroundColor = [UIColor whiteColor];
            }
            return cell;
        }];
        
        [_searchController setHeightForRowAtIndexPathCompletion:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            return [ChatListCell tableView:tableView heightForRowAtIndexPath:indexPath];
        }];
        
        [_searchController setDidSelectRowAtIndexPathCompletion:^(UITableView *tableView, NSIndexPath *indexPath) {
            [weakSelf.searchController.searchBar endEditing:YES];
            
            EMConversation *conversation = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:conversation.chatter isGroup:conversation.isGroup];
            chatVC.title = conversation.chatter;
            [weakSelf.navigationController pushViewController:chatVC animated:YES];
            
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];

        }];
    }
    
    return _searchController;
}

- (UIView *)networkStateView
{
    if (_networkStateView == nil) {
        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
        _networkStateView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:0.5];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 20) / 2, 20, 20)];
        imageView.image = [UIImage imageNamed:@"messageSendFail"];
        [_networkStateView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"当前网络连接失败";
        [_networkStateView addSubview:label];
    }
    
    return _networkStateView;
}

#pragma mark - private

- (NSMutableArray *)loadDataSource
{
    NSMutableArray *ret = nil;
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    NSArray* sorte = [conversations sortedArrayUsingComparator:
           ^(EMConversation *obj1, EMConversation* obj2){
               EMMessage *message1 = [obj1 latestMessage];
               EMMessage *message2 = [obj2 latestMessage];
               if(message1.timestamp > message2.timestamp) {
                   return(NSComparisonResult)NSOrderedAscending;
               }else {
                   return(NSComparisonResult)NSOrderedDescending;
               }
           }];
    ret = [[NSMutableArray alloc] initWithArray:sorte];
    return ret;
}

// 得到最后消息时间
-(NSString *)lastMessageTimeByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];;
    if (lastMessage) {
        ret = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    
    return ret;
}

// 得到未读消息条数
- (NSInteger)unreadMessageCountByConversation:(EMConversation *)conversation
{
    NSInteger ret = 0;
    ret = conversation.unreadMessagesCount;
    
    return  ret;
}

// 得到最后消息文字或者类型
-(NSString *)subTitleMessageByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];
    
    if (lastMessage) {
        if(lastMessage.ext && [lastMessage.ext objectForKey:@"type"]){
            if ([[NSString stringWithFormat:@"%@",[lastMessage.ext objectForKey:@"type"]] isEqualToString:@"PRO"]) {
                ret = @"[产品]";
                return ret;
            }else if ([[NSString stringWithFormat:@"%@",[lastMessage.ext objectForKey:@"type"]] isEqualToString:@"WEB"]) {
                ret = @"[链接]";
                return ret;
            }else if ([[NSString stringWithFormat:@"%@",[lastMessage.ext objectForKey:@"type"]] isEqualToString:@"DALI"]) {
                ret = @"[服务打评]";
                return ret;
            }else if ([[NSString stringWithFormat:@"%@",[lastMessage.ext objectForKey:@"type"]] isEqualToString:@"MENU"]) {
                ret = @"[订单通知]";
                return ret;
            }else if ([[NSString stringWithFormat:@"%@",[lastMessage.ext objectForKey:@"type"]] isEqualToString:@"game"]) {
                ret = @"[游戏结果]";
                return ret;
            }
        }
        id<IEMMessageBody> messageBody = lastMessage.messageBodies.lastObject;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Image:{
                ret = @"[图片]";
            } break;
            case eMessageBodyType_Text:{
                if ([CommonUtil getValueByKey:[NSString stringWithFormat:@"[草稿]%@",conversation.chatter]]) {
                    NSString *didReceiveText = [ConvertToCommonEmoticonsHelper
                                                convertToSystemEmoticons:[CommonUtil getValueByKey:[NSString stringWithFormat:@"[草稿]%@",conversation.chatter]]];
                    return  [NSString stringWithFormat:@"[草稿]%@",didReceiveText];
                }
                // 表情映射。
                NSString *didReceiveText = [ConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                ret = didReceiveText;
            } break;
            case eMessageBodyType_Voice:{
                ret = @"[声音]";
            } break;
            case eMessageBodyType_Location: {
                ret = @"[位置]";
            } break;
            case eMessageBodyType_Video: {
                ret = @"[视频]";
            } break;
            default: {
            } break;
        }
    }
    
    return ret;
}

#pragma mark - TableViewDelegate & TableViewDatasource

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        static NSString *identify = @"chatListCell";
        
        ChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        
        if (!cell) {
            cell = [[ChatListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        if (self.dataSource.count == 0) {
            cell.hidden = YES;
            return cell;
        }
        if (indexPath.row >= self.dataSource.count) {
            return cell;
        }
        EMConversation *conversation = [self.dataSource objectAtIndex:indexPath.row];
        cell.name = conversation.chatter;
        
        cell.detailMsg = [self subTitleMessageByConversation:conversation];
        cell.time = [self lastMessageTimeByConversation:conversation];
        cell.unreadCount = [self unreadMessageCountByConversation:conversation];
        if (indexPath.row % 2 == 1) {
            cell.contentView.backgroundColor = RGBACOLOR(246, 246, 246, 1);
        }else{
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        
        if (!conversation.isGroup) {
            cell.placeholderImage = [UIImage imageNamed:@"chatListCellHead.png"];
            if (self.dataSourceInfo.count !=self.dataSource.count) {
                return cell;
            }
            NSDictionary *dic = [self.dataSourceInfo objectAtIndex:indexPath.row];
            if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberId"]] isEqualToString:@"-10001"]) {
                return cell;
            }else{
                cell.name = [dic objectForKey:@"RealName"];
            }
            NSString *imagePath = [NSString stringWithFormat:@"%@",[dic objectForKey:@"PhotoMidUrl"]];
            
            [cell.imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imagePath]] placeholderImage:[UIImage imageNamed:@"moren.png"] completed:^(UIImage *image, NSError *error, HHImageType cacheType) {
                cell.placeholderImage = image;
                cell.imageView.image = image;
            }];
            
        }
        else{
            
            NSString *imageName = @"groupPublicHeader";
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.chatter]) {
                    cell.name = group.groupSubject;
                    imageName = group.isPublic ? @"groupPublicHeader" : @"groupPrivateHeader";
                    break;
                }
            }
            cell.placeholderImage = [UIImage imageNamed:imageName];
        }
        
        cell.imageView.layer.cornerRadius = 5;
        cell.imageView.clipsToBounds = YES;
        
        return cell;
        
//    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.dataSource.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [ChatListCell tableView:tableView heightForRowAtIndexPath:indexPath];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0) {
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"警告" message:@"由于您的手机操作系统版本太低，城与城 部分功能不能使用，若想完美使用城与城，请在设置中更新您手机的操作系统。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [view show];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
    isEnterSecondPage = YES;
    
    EMConversation *conversation = [self.dataSource objectAtIndex:indexPath.row];
    ChatListCell *cell = (ChatListCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    ChatViewController *chatController;
    NSString *title = cell.textLabel.text;
    if (conversation.isGroup) {
        NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
        for (EMGroup *group in groupArray) {
            if ([group.groupId isEqualToString:conversation.chatter]) {
                title = group.groupSubject;
                break;
            }
        }
    }
    
    NSString *chatter = conversation.chatter;
    chatController = [[ChatViewController alloc] initWithChatter:chatter isGroup:conversation.isGroup];
    chatController.title = title;
    chatController.Uimage = cell.placeholderImage;
    [conversation markAllMessagesAsRead:YES];
    [self.navigationController pushViewController:chatController animated:YES];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (void)requestSubmitRedDian{
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           nil];
    
    [httpClient request:@"RedTip.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            self.RedTipCnt = [json valueForKey:@"RedTipCnt"];
            
        } else {
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    PengYouQuanView *view = [[PengYouQuanView alloc] init];
    
    [view.button addTarget:self action:@selector(jinruPengyouquan) forControlEvents:UIControlEventTouchUpInside];
    
    return view;
    
}

- (void)jinruPengyouquan {
    
    // 更新红点的数据保存到数据库中  DynamicComments
    [friendHelp updateDynamictCount:[self.RedTipCnt objectForKey:@"DynamicList"]withDynamicComments:@"0"];

    NSString *countString = [NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"DynamicComments"]];

    NSString *path = [NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"CommentPhotoMid"]];

    if ( path.length != 0 ) {

        // 保存头像
        [CommonUtil addValue:path andKey:CommentPhotoMid];

    }

    // 保存起来评论的数据
    if ( ![countString isEqualToString:@"(null)"] ) {

        [CommonUtil addValue:countString andKey:DynamicComments];

    }else{

        [CommonUtil addValue:@"0" andKey:DynamicComments];
        
    }

    DynamicViewController *VC = [DynamicViewController shareobject];

    [self.navigationController pushViewController:VC animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    PengYouQuanView *view = [[PengYouQuanView alloc] init];
    
    return view.height;
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EMConversation *converation = [self.dataSource objectAtIndex:indexPath.row];
        [[EaseMob sharedInstance].chatManager removeConversationByChatter:converation.chatter deleteMessages:YES append2Chat:NO];
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [self.dataSourceInfo removeObjectAtIndex:indexPath.row];
        //更新数据库
        [friendHelp upEXChatData:self.dataSourceInfo];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }

}


#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [[RealtimeSearchUtil currentUtil] realtimeSearchWithSource:self.dataSource searchText:(NSString *)searchText collationStringSelector:@selector(chatter) resultBlock:^(NSArray *results) {
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
//刷新消息列表
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [self refreshDataSource];
    [_slimeView endRefresh];
}

#pragma mark - IChatMangerDelegate

-(void)didUnreadMessagesCountChanged
{
    [self refreshDataSource];
}

- (void)didUpdateGroupList:(NSArray *)allGroups error:(EMError *)error
{
    [self refreshDataSource];
}

#pragma mark - registerNotifications
-(void)registerNotifications{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)dealloc{
    [self unregisterNotifications];
}

#pragma mark - public

-(void)refreshDataSource
{
    self.dataSource = [self loadDataSource];
    
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
        self.dataSourceInfo = [friendHelp EX_ChatList];
        int count = (int)self.dataSource.count - (int)self.dataSourceInfo.count;
        if (count >0) {
            for (int iii = 0; iii<count; iii++) {
                [self.dataSource removeLastObject];
            }
        }
        [_tableView reloadData];
        [self hideHud];
        
    }else{
        //更新信息
        NSMutableArray *IDArray = [[NSMutableArray alloc]init];
        
        for (int iii = 0; iii<self.dataSource.count; iii++) {
            if (iii<=self.dataSource.count -1) {
                EMConversation *conversation = [self.dataSource objectAtIndex:iii];
                if (!conversation.isGroup)
                {
                    if ([conversation.chatter isEqualToString:@"admin"]||[conversation.chatter isEqualToString:@""]) {
                        [IDArray addObject:@"30"];
                        continue;
                    }
                    [IDArray addObject:conversation.chatter];
                }
            }

        }
        
        [self requestSubmitFromIDS:[NSString stringWithFormat:@"%@",[IDArray componentsJoinedByString:@","]]];
    }
    
    if (self.dataSource.count == 0) {
        self.dataSourceLabel.hidden = NO;
    }else
    {
    self.dataSourceLabel.hidden = YES;
    }

}

- (void)networkChanged:(EMConnectionState)connectionState
{
    if (connectionState == eEMConnectionDisconnected) {
        _tableView.tableHeaderView = _networkStateView;
    }
    else{
        _tableView.tableHeaderView = nil;
    }
}

- (void)willReceiveOfflineMessages{
    NSLog(@"开始接收离线消息");
}

- (void)didFinishedReceiveOfflineMessages:(NSArray *)offlineMessages{
    NSLog(@"离线消息接收成功");
    [self refreshDataSource];
    
}



- (void)requestSubmitFromIDS:(NSString *)IDS{
    if ([IDS isEqualToString:@""]) {
        [_tableView reloadData];
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           IDS,@"otherIds",
                           nil];
    [httpClient request:@"GetMemberDetail.ashx" parameters:param success:^(NSJSONSerialization* json){
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            self.dataSourceInfo = [json valueForKey:@"friendsInfos"];
            for (int iii = 0; iii<self.dataSource.count; iii++) {
                if (iii <=self.dataSource.count -1) {
                EMConversation *conversation = [self.dataSource objectAtIndex:iii];
                if (conversation.isGroup) {
                    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
                    [dic setObject:@"" forKey:@"RealName"];
                    [dic setObject:@"" forKey:@"PhotoMidUrl"];
                    [dic setObject:@"" forKey:@"NickName"];
                    [dic setObject:@"-10001" forKey:@"MemberId"];
                    [self.dataSourceInfo insertObject:dic atIndex:iii];
                }else
                {
                    if (iii<=self.dataSource.count -1) {
                        
                        if ( iii <= self.dataSourceInfo.count - 1 ) {
                            
                            NSMutableDictionary *dic = [self.dataSourceInfo objectAtIndex:iii];
                            [self.InfoCache addInfo:dic andID:[dic objectForKey:@"MemberId"]];

                        }
                        
                    }
                }
            }
            }
            
            // 将数据保存到数据库里面
            [friendHelp upEXChatData:self.dataSourceInfo];
            
            [_tableView reloadData];
            [self hideHud];
        }else
        {
            [_tableView reloadData];
            [self hideHud];
        }
    } failure:^(NSError *error) {
        
        [_tableView reloadData];
        [self hideHud];


    }];
    
}

-(void)GroupselectedO:(id)sender
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0) {
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"警告" message:@"由于您的手机操作系统版本太低，城与城 部分功能不能使用，若想完美使用城与城，请在设置中更新您手机的操作系统。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [view show];
        return;
    }
    
    if ([sender isKindOfClass:[NSNotification class]]) {
        NSMutableDictionary *DIC = (NSMutableDictionary *)[(NSNotification *)sender object];
    
        NSString * username = [NSString stringWithFormat:@"%@",[DIC objectForKey:@"username"]];
        ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:username isGroup:NO];
        chatVC.title = [DIC objectForKey:@"RName"];
        chatVC.Uimage = [DIC objectForKey:@"m_headImagV"];
        [self.navigationController pushViewController:chatVC animated:YES];
    }

}

@end
