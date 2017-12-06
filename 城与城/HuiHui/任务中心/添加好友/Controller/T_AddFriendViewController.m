//
//  T_AddFriendViewController.m
//  HuiHui
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_AddFriendViewController.h"

#import "Add_SearchCell.h"
#import "AddFriend_ChooseCell.h"
#import "Add_ScrollCell.h"
#import "AddFriend_ScrollImageCell.h"
#import "T_SearchFriendViewController.h"
#import "T_ContactsViewController.h"

#import "Add_MoreFriends.h"
#import "Add_ScrollFrame.h"
#import "Add_FriendsCell.h"

#define TabBGCOLOR [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface T_AddFriendViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@end

@implementation T_AddFriendViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加";
    
    [self initWithTableview];
    
}

- (void)initWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = TabBGCOLOR;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        
        return 1;
        
    }else if (section == 1) {
    
        return 2;
        
    }else if (section == 2) {
        
        return 2;
        
    }else {
    
        return 0;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        Add_SearchCell *cell = [[Add_SearchCell alloc] init];
        
        return cell;
        
    }else if (indexPath.section == 1) {
    
        AddFriend_ChooseCell *cell = [[AddFriend_ChooseCell alloc] init];
        
        if (indexPath.row == 0) {
            
            cell.titleLab.text = @"添加手机联系人";
            
            cell.iconImageview.image = [UIImage imageNamed:@"ADD_LianXiRen.png"];
            
        }else if (indexPath.row == 1) {
            
            cell.titleLab.text = @"扫一扫添加好友";
            
            cell.iconImageview.image = [UIImage imageNamed:@"ADD_SaoMiao.png"];
            
        }
        
        return cell;
        
    }else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            Add_ScrollCell *cell = [[Add_ScrollCell alloc] init];
            
            return cell;
            
        }else if (indexPath.row == 1) {
        
            AddFriend_ScrollImageCell *cell = [[AddFriend_ScrollImageCell alloc] init];
            
            [cell.collectionView reloadData];
            
            return cell;
            
        }else {
        
            return nil;
            
        }

    }else {
        
        return nil;
        
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    
    view.backgroundColor = TabBGCOLOR;
        
    return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        
    return 20;

}

//设置组头的view不悬浮
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = 20;
    
    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0,0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        Add_SearchCell *cell = [[Add_SearchCell alloc] init];
        
        return cell.height;
        
    }else if (indexPath.section == 1) {
    
        AddFriend_ChooseCell *cell = [[AddFriend_ChooseCell alloc] init];
        
        return cell.height;
        
    }else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            Add_ScrollCell *cell = [[Add_ScrollCell alloc] init];
            
            return cell.height;
            
        }else if (indexPath.row == 1) {
        
            AddFriend_ScrollImageCell *cell = [[AddFriend_ScrollImageCell alloc] init];
            
            return cell.height;
            
        }else {
        
            return 0;
            
        }
        
    }else {
        
        return 0;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        T_SearchFriendViewController *vc = [[T_SearchFriendViewController alloc] init];
        
        [self presentViewController:vc animated:YES completion:^{
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            
        }];
        
    }else if (indexPath.section == 1) {
    
        T_ContactsViewController *vc = [[T_ContactsViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
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
