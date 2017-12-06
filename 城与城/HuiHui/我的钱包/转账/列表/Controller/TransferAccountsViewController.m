//
//  TransferAccountsViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "TransferAccountsViewController.h"
#import "RedHorseHeader.h"
#import "ZZ_FunctionModel.h"
#import "ZZ_FunctionFrame.h"
#import "ZZ_FunctionCell.h"

#import "ZZ_FriendModel.h"
#import "ZZ_FriendFrame.h"
#import "ZZ_FriendCell.h"

#import "ZZ_SectionHeadView.h"
#import "TransferTransactionModel.h"
#import "TransferTransactionViewController.h"
#import "Z_SearchViewController.h"

@interface TransferAccountsViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *FunctionsArray;

@property (nonatomic, strong) NSArray *FriendsArray;

@end

@implementation TransferAccountsViewController

-(NSArray *)FunctionsArray {

    if (_FunctionsArray == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ZZ_Function.plist" ofType:nil];
        
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *dd in array) {
            
            ZZ_FunctionModel *model = [[ZZ_FunctionModel alloc] initWithDict:dd];
            
            ZZ_FunctionFrame *frame = [[ZZ_FunctionFrame alloc] init];
            
            frame.functionModel = model;
            
            [tempArray addObject:frame];
            
        }
        
        _FunctionsArray = tempArray;
        
    }
    
    return _FunctionsArray;
    
}

-(NSArray *)FriendsArray {

    if (_FriendsArray == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ZZ_Friend.plist" ofType:nil];
        
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *dd in array) {
            
            ZZ_FriendModel *model = [[ZZ_FriendModel alloc] initWithDict:dd];
            
            ZZ_FriendFrame *frame = [[ZZ_FriendFrame alloc] init];
            
            frame.friendModel = model;
            
            [tempArray addObject:frame];
            
        }
        
        _FriendsArray = tempArray;
        
    }
    
    return _FriendsArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:@"转账"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.view.backgroundColor = RH_ViewBGColor;
    
    [self allocWithTableview];

}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == 1) {
        
        ZZ_SectionHeadView *view = [[ZZ_SectionHeadView alloc] init];
        
        view.titleName = @"好友列表";
        
        return view;
        
    }else {
    
        return nil;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 1) {
        
        ZZ_SectionHeadView *view = [[ZZ_SectionHeadView alloc] init];
        
        return view.height;
        
    }else {
    
        return 0;
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        
        return self.FunctionsArray.count;
        
    }else if (section == 1) {
    
        return self.FriendsArray.count;
        
    }else {
    
        return 0;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        ZZ_FunctionCell *cell = [[ZZ_FunctionCell alloc] init];
        
        ZZ_FunctionFrame *frame = self.FunctionsArray[indexPath.row];
        
        cell.frameModel = frame;
        
        return cell;
        
    }else if (indexPath.section == 1) {
    
        ZZ_FriendCell *cell = [[ZZ_FriendCell alloc] init];
        
        ZZ_FriendFrame *frame = self.FriendsArray[indexPath.row];
        
        cell.frameModel = frame;
        
        return cell;
        
    }else {
    
        return nil;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        ZZ_FunctionFrame *frame = self.FunctionsArray[indexPath.row];
        
        return frame.height;
        
    }else if (indexPath.section == 1) {
    
        ZZ_FriendFrame *frame = self.FriendsArray[indexPath.row];
        
        return frame.height;
        
    }else {
    
        return 0;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            Z_SearchViewController *vc = [[Z_SearchViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }else if (indexPath.section == 1) {
        
        TransferTransactionModel *model = [[TransferTransactionModel alloc] init];
        
        ZZ_FriendFrame *frame = self.FriendsArray[indexPath.row];
        
        model.toFriendImg = frame.friendModel.iconImg;
        
        model.toFriendName = frame.friendModel.friendName;
        
        TransferTransactionViewController *vc = [[TransferTransactionViewController alloc] init];
        
        vc.tranModel = model;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

- (void)leftClicked{
    
    [self goBack];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
