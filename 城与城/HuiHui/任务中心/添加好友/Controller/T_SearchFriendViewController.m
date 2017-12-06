//
//  T_SearchFriendViewController.m
//  HuiHui
//
//  Created by mac on 2017/3/31.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_SearchFriendViewController.h"
#import "T_S_FriendModel.h"
#import "T_S_FriendFrame.h"
#import "T_S_FriendCell.h"

#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import <MJRefresh.h>

#define TabBGCOLOR [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.]
#define SearchBGCOLOR [UIColor colorWithRed:238/255. green:239/255. blue:243/255. alpha:1.]
#define SearchTextCOLOR [UIColor colorWithRed:169/255. green:169/255. blue:169/255. alpha:1.]
#define CancliCOLOR [UIColor colorWithRed:133/255. green:133/255. blue:133/255. alpha:1.]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface T_SearchFriendViewController () <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource> {

    NSInteger pageIndex;
    
    NSString *searchStr;
    
}

@property (nonatomic, weak) UISearchBar *searchBar;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation T_SearchFriendViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    pageIndex = 1;
    
    searchStr = @"";

    self.view.backgroundColor = TabBGCOLOR;
    
    [self initWithSearch];
    
    [self initWithTableview];
    
}

- (void)initWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = TabBGCOLOR;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        pageIndex = 1;
        
        [self searchRequestWithString:searchStr];
        
    }];
    
    tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        pageIndex ++;
        
        [self searchRequestWithString:searchStr];
        
    }];
    
    [self.view addSubview:tableview];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableviewClick:)];
    
    [tableview addGestureRecognizer:tap];
    
}

- (void)tableviewClick:(UITapGestureRecognizer *)recognizer {
    
    [self hideKeyBoard];
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        
        return NO;
        
    }
    
    return YES;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    T_S_FriendFrame *frame = self.dataArray[indexPath.row];
    
    T_S_FriendCell *cell = [[T_S_FriendCell alloc] init];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    T_S_FriendFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)initWithSearch {
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    topView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:topView];
    
    UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 22, SCREEN_WIDTH * 0.88, 40)];
    
    self.searchBar = search;
    
    search.delegate = self;
    
    search.barTintColor = [UIColor whiteColor];
    
    search.backgroundImage = [[UIImage alloc] init];
    
    search.placeholder = @"输入姓名/手机号码搜索";
    
    UITextField *searchField = [search valueForKey:@"searchField"];
    
    if (searchField) {
        
        [searchField setBackgroundColor:SearchBGCOLOR];
        
        searchField.layer.cornerRadius = 4.0f;
        
        searchField.layer.masksToBounds = YES;
        
        [searchField becomeFirstResponder];
        
    }
    
    [topView addSubview:search];
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(search.frame), 22, SCREEN_WIDTH * 0.1, 40)];
    
    [cancleBtn setTitle:@"取消" forState:0];
    
    [cancleBtn setTitleColor:CancliCOLOR forState:0];
    
    [cancleBtn addTarget:self action:@selector(ViewDismiss) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:cancleBtn];
    
}

- (void)hideKeyBoard {
    
    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
    
    if ([searchField isFirstResponder]) {
        
        [searchField resignFirstResponder];
        
    }
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self hideKeyBoard];
    
    searchStr = [NSString stringWithFormat:@"%@",searchBar.text];

    [self searchRequestWithString:searchStr];
    
}

- (void)searchRequestWithString:(NSString *)str {
    
    if (![str isEqualToString:@""] && str.length != 0) {
        
        NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
        
        AppHttpClient* httpClient = [AppHttpClient sharedClient];
        
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               memberId,@"Memberid",
                               [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                               str,@"searConditions",
                               nil];
        
        [SVProgressHUD showWithStatus:@"搜索中"];
        
        [httpClient request:@"SearchFriends.ashx" parameters:param success:^(NSJSONSerialization* json) {
            
            BOOL success = [[json valueForKey:@"status"] boolValue];
            
            if (success) {
                
                NSArray *arr = [json valueForKey:@"ListSeCon"];
                
                NSMutableArray *mut = [NSMutableArray array];
                
                for (NSDictionary *dd in arr) {
                    
                    T_S_FriendModel *i_friend = [[T_S_FriendModel alloc] initWithDict:dd];
                    
                    T_S_FriendFrame *frame = [[T_S_FriendFrame alloc] init];
                    
                    frame.friendModel = i_friend;
                    
                    [mut addObject:frame];
                    
                }
                
                if (pageIndex == 1) {
                    
                    self.dataArray = mut;
                    
                }else {
                
                    NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArray];
                    
                    if (mut.count != 0) {
                        
                        [temp addObjectsFromArray:mut];
                        
                    }else {
                    
                        if (pageIndex > 1) {
                            
                            pageIndex --;
                            
                        }
                        
                    }
                    
                    self.dataArray = temp;
                    
                }
                
                [SVProgressHUD dismiss];
                
                [self headAndFootEndRefreshing];
                
                [self.tableview reloadData];
                
            } else {
                
                if (pageIndex > 1) {
                    
                    pageIndex --;
                    
                }
                
                [self headAndFootEndRefreshing];
                
                NSString *msg = [json valueForKey:@"msg"];
                
                [SVProgressHUD showErrorWithStatus:msg];
                
            }
            
        } failure:^(NSError *error) {
            
            if (pageIndex > 1) {
                
                pageIndex --;
                
            }
            
            [self headAndFootEndRefreshing];
            
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            
        }];
        
    }else {
    
        [self headAndFootEndRefreshing];
        
    }
    
}

- (void)headAndFootEndRefreshing {
    
    [self.tableview.mj_header endRefreshing];
    
    [self.tableview.mj_footer endRefreshing];
    
}

- (void)ViewDismiss {
    
    [self hideKeyBoard];

    [self dismissViewControllerAnimated:YES completion:^{
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
