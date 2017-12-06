//
//  T_InvitationViewController.m
//  HuiHui
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_InvitationViewController.h"
#import "I_Friend.h"
#import "I_FriendFrame.h"
#import "I_FriendCell.h"

#import "T_NewTask.h"

#import "C_FriendCell.h"
#import "C_FriendFrame.h"

#import "I_SuccessViewController.h"
#import "T_AddFriendViewController.h"

#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"

#define TabBGCOLOR [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.]
#define SearchBGCOLOR [UIColor colorWithRed:238/255. green:239/255. blue:243/255. alpha:1.]
#define SearchTextCOLOR [UIColor colorWithRed:169/255. green:169/255. blue:169/255. alpha:1.]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface T_InvitationViewController () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate,C_DeleteDelegate>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UISearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *collectArray;

@property (nonatomic, weak) UICollectionView *collectionview;

@property (nonatomic, weak) UIView *bottomView;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UIButton *sureBtn;

@end

@implementation T_InvitationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.collectArray = [NSMutableArray array];
    
    self.title = @"邀请好友";
    
    [self initWithSearch];
    
    [self initWithTableview];
    
    [self initWithCollectionView];
    
    self.navigationItem.rightBarButtonItem = [self SetNavigationBarRightTitle:@"添加" andaction:@selector(AddFriendClick)];
    
}

-(void)viewWillAppear:(BOOL)animated {

    [self requestFriendsData];
    
}

- (void)AddFriendClick {
    
    [self hideKeyBoard];

    T_AddFriendViewController *vc = [[T_AddFriendViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)initWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), SCREEN_WIDTH, SCREEN_HEIGHT - 64 - self.searchBar.frame.size.height - 60)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = TabBGCOLOR;
    
    [self.view addSubview:tableview];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tableview.frame), SCREEN_WIDTH, 60)];
    
    bottomView.backgroundColor = [UIColor whiteColor];
    
    self.bottomView = bottomView;
    
    [self.view addSubview:bottomView];
    
}

- (void)hideKeyBoard {
    
    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];

    if ([searchField isFirstResponder]) {
        
        [searchField resignFirstResponder];
        
    }
    
}

- (void)initWithCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 5;
    //最小两行之间的间距
    layout.minimumLineSpacing = 5;
    //这个是横向滑动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 5, SCREEN_WIDTH * 0.7, 50) collectionViewLayout:layout];
    
    self.collectionview = collectionview;
    
    collectionview.delegate = self;
    
    collectionview.dataSource = self;
    
    collectionview.backgroundColor = [UIColor whiteColor];
    
    [self.bottomView addSubview:collectionview];
    
    [collectionview registerClass:[C_FriendCell class] forCellWithReuseIdentifier:@"C_cell"];
    
    UILabel *countlab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(collectionview.frame) + 5, 5, SCREEN_WIDTH * 0.2 - 5, 15)];
    
    self.countLab = countlab;
    
    countlab.textAlignment = NSTextAlignmentCenter;
    
    countlab.textColor = [UIColor lightGrayColor];
    
    countlab.font = [UIFont systemFontOfSize:14];
    
    countlab.text = @"共0位";
    
    [self.bottomView addSubview:countlab];
    
    UIButton *sure = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(collectionview.frame) + 5, CGRectGetMaxY(countlab.frame) + 5, SCREEN_WIDTH * 0.2 - 5, 30)];
    
    self.sureBtn = sure;
    
    [sure setTitle:@"邀请" forState:0];
    
    [sure setTitleColor:[UIColor whiteColor] forState:0];
    
    [sure setBackgroundColor:[UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0]];
    
    sure.layer.masksToBounds = YES;
    
    sure.layer.cornerRadius = 5;
    
    [sure addTarget:self action:@selector(SureBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomView addSubview:sure];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.collectArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    C_FriendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"C_cell" forIndexPath:indexPath];
    
    cell.delegate = self;
    
    C_FriendFrame *frame = self.collectArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

- (void)deleteInvitationFriend:(UIButton *)sender {

    NSIndexPath *indexPath = [self.collectionview indexPathForCell:(C_FriendCell *)[sender superview]];
    
    C_FriendFrame *frame = self.collectArray[indexPath.row];
    
    for (I_FriendFrame *ff in self.dataArray) {
        
        if ([ff.friendModel.MemberID isEqual:frame.friendModel.MemberID]) {
            
            ff.friendModel.isChoose = NO;
            
        }
        
    }
    
    [self.tableview reloadData];
    
    [self.collectArray removeObjectAtIndex:indexPath.row];
    
    [self.collectionview reloadData];
    
    self.countLab.text = [NSString stringWithFormat:@"共%lu位",(unsigned long)self.collectArray.count];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    C_FriendFrame *frame = self.collectArray[indexPath.row];
    
    return frame.c_size;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)initWithSearch {
    
    UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    
    self.searchBar = search;
    
    search.delegate = self;
    
    search.barTintColor = [UIColor whiteColor];
    
    search.backgroundImage = [[UIImage alloc] init];
    
    search.placeholder = @"输入姓名、手机号码、昵称搜索";
    
    UITextField *searchField = [search valueForKey:@"searchField"];
    
    if (searchField) {
        
        [searchField setBackgroundColor:SearchBGCOLOR];
        
        searchField.layer.cornerRadius = 4.0f;

        searchField.layer.masksToBounds = YES;
        
    }
    
    [self.view addSubview:search];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self hideKeyBoard];

    [self searchRequestWithString:[NSString stringWithFormat:@"%@",searchBar.text]];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [self searchRequestWithString:searchText];
    
}

- (void)searchRequestWithString:(NSString *)searchStr {

    if (self.ReTaskID.length == 0) {
        
        self.ReTaskID = @"0";
        
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           self.taskModel.TaskID,@"TaskId",
                           self.ReTaskID,@"ReTaskId",
                           searchStr,@"searchConditions",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"MemberInviteListTask.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = [json valueForKey:@"memberJoinedInvite"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in arr) {
                
                I_Friend *i_friend = [[I_Friend alloc] initWithDict:dd];
                
                i_friend.isChoose = NO;
                
                I_FriendFrame *frame = [[I_FriendFrame alloc] init];
                
                frame.friendModel = i_friend;
                
                [mut addObject:frame];
                
            }
            
            if (self.collectArray.count != 0) {
                
                for (C_FriendFrame *frame in self.collectArray) {
                    
                    for (I_FriendFrame *ff in mut) {
                        
                        if ([frame.friendModel.MemberID isEqual:ff.friendModel.MemberID]) {
                            
                            ff.friendModel.isChoose = YES;
                            
                        }
                        
                    }
                    
                }
                
            }
            
            self.dataArray = mut;
            
            [SVProgressHUD dismiss];
            
            [self.tableview reloadData];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    I_FriendFrame *frame = self.dataArray[indexPath.row];
    
    I_FriendCell *cell = [[I_FriendCell alloc] init];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    I_FriendFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self hideKeyBoard];
    
    I_FriendFrame *I_frame = self.dataArray[indexPath.row];
    
    I_Friend *i_friend = I_frame.friendModel;
    
    if (i_friend.isChoose) {
        
        for (int i = 0; i < self.collectArray.count; i ++) {
            
            C_FriendFrame *ff = self.collectArray[i];
            
            if ([ff.friendModel.MemberID isEqual:i_friend.MemberID]) {
                
                [self.collectArray removeObjectAtIndex:i];
                
            }
            
        }
        
        [self.collectionview reloadData];
        
        self.countLab.text = [NSString stringWithFormat:@"共%lu位",(unsigned long)self.collectArray.count];
        
        i_friend.isChoose = NO;
        
    }else {
        
        i_friend.isChoose = YES;
        
        C_FriendFrame *cframe = [[C_FriendFrame alloc] init];
        
        cframe.friendModel = I_frame.friendModel;
        
        [self.collectArray addObject:cframe];
        
        [self.collectionview reloadData];
        
        self.countLab.text = [NSString stringWithFormat:@"共%lu位",(unsigned long)self.collectArray.count];
        
    }
    
    [tableView reloadData];
    
}

//邀请按钮点击
- (void)SureBtnClicked {
    
    [self hideKeyBoard];

    if (self.collectArray.count != 0) {
        
        if ([self.ReTaskID isEqualToString:@"0"]) {
            
            [self InvitationFriends];
            
        }else {
        
            [self ReInvitation];
            
        }

    }
    
}

- (void)ReInvitation {

    NSMutableArray *mutarr = [NSMutableArray array];
    
    for (int i = 0; i < self.collectArray.count; i ++) {
        
        C_FriendFrame *frame = self.collectArray[i];
        
        NSString *inviteID = [NSString stringWithFormat:@"%@",frame.friendModel.MemberID];
        
        [mutarr addObject:inviteID];
        
    }
    
    NSString *IDStr = [mutarr componentsJoinedByString:@","];
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"Memberid",
                           self.ReTaskID,@"ReTaskID",
                           IDStr,@"PushMembersIDStr",
                           nil];
    
    [SVProgressHUD showWithStatus:@"邀请中"];
    
    [httpClient request:@"Task_InviteFriendsAgain.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            I_SuccessViewController *vc = [[I_SuccessViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)InvitationFriends {
    
    NSMutableArray *mutarr = [NSMutableArray array];
    
    for (int i = 0; i < self.collectArray.count; i ++) {
        
        C_FriendFrame *frame = self.collectArray[i];
        
        NSString *inviteID = [NSString stringWithFormat:@"%@",frame.friendModel.MemberID];
        
        [mutarr addObject:inviteID];
        
    }
    
    NSString *IDStr = [mutarr componentsJoinedByString:@","];

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"Memberid",
                           self.taskModel.TaskID,@"TaskID",
                           @"0",@"TaskBonuses",
                           IDStr,@"PushMembersIDStr",
                           nil];
    
    [SVProgressHUD showWithStatus:@"邀请中"];
    
    [httpClient request:@"ReleaseTask.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            I_SuccessViewController *vc = [[I_SuccessViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)requestFriendsData {
    
    if (self.ReTaskID.length == 0) {
        
        self.ReTaskID = @"0";
        
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           self.taskModel.TaskID,@"TaskId",
                           self.ReTaskID,@"ReTaskId",
                           @"",@"searchConditions",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"MemberInviteListTask.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = [json valueForKey:@"memberJoinedInvite"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in arr) {
                
                I_Friend *i_friend = [[I_Friend alloc] initWithDict:dd];
                
                i_friend.isChoose = NO;
                
                I_FriendFrame *frame = [[I_FriendFrame alloc] init];
                
                frame.friendModel = i_friend;
                
                [mut addObject:frame];
                
            }
            
            if (self.collectArray.count != 0) {
                
                for (C_FriendFrame *frame in self.collectArray) {
                    
                    for (I_FriendFrame *ff in mut) {
                        
                        if ([frame.friendModel.MemberID isEqual:ff.friendModel.MemberID]) {
                            
                            ff.friendModel.isChoose = YES;
                            
                        }
                        
                    }
                    
                }
                
            }
            
            self.dataArray = mut;
            
            [SVProgressHUD dismiss];
            
            [self.tableview reloadData];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
