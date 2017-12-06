//
//  BusinessOutletsViewController.m
//  baozhifu
//
//  Created by mac on 13-9-8.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "BusinessOutletsViewController.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"

@interface BusinessOutletsViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *m_titleVIew;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@end

@implementation BusinessOutletsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"我的银行卡"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
   
    for(id cc in [self.searchBar subviews]){
        if([cc isKindOfClass:[UIButton class]]){
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }  
    }
    self.searchBar.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    self.tableView.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
   
    [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
     [self loadData];
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


- (void)loadData {
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    
    NSString *orgName = self.searchBar.text;
    if (!orgName) {
        orgName = @"";
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberid",
                           key,   @"key",
                           self.bankCode,   @"OrgCode",
                           orgName,   @"OrgName",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"CNAPSList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            items = [json valueForKey:@"cNAPSInfo"];
            
            self.tableView.hidden = NO;
            [self.tableView reloadData];
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (void)doSearch {
    [self loadData];
}

#pragma UITableView Delete

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    //初始化cell并指定其类型，也可自定义cell
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    NSUInteger row = [indexPath row];
    NSDictionary *item = [items objectAtIndex:row];
    cell.textLabel.text = [item objectForKey:@"OrgName"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    NSUInteger row = [indexPath row];
    NSDictionary *item = [items objectAtIndex:row];
    [self.bankViewController setSelectBankStation:item];
    if ([self.brachEnter isEqualToString:@"brachEnter"]) {
        
        [self.ChoseBrachdelegate ChosesBrachValue:[item objectForKey:@"OrgName"] Brachcode:[item objectForKey:@"OrgValue"]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma UISearchBar Delete
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{

    [self hiddenNumPadDone:nil];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    [self doSearch];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
}

@end
