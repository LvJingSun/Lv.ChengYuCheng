//
//  CardMemberListViewController.m
//  HuiHui
//
//  Created by mac on 15-6-8.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "CardMemberListViewController.h"

#import "hh_shopListCell.h"

#import "UserInformationViewController.h"

#import "CardMemeberDetaiViewController.h"

#import "ChineseToPinyin.h"

#import "RealtimeSearchUtil.h"

#import "PinYinForObjc.h"

@interface CardMemberListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

- (IBAction)controlTap:(id)sender;

@end

@implementation CardMemberListViewController

@synthesize m_vipCardId;

@synthesize m_memberList;

@synthesize m_IsSelectSeat;

@synthesize m_searchArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        m_memberList = [[NSMutableArray alloc]initWithCapacity:0];
        
        _dataSource = [NSMutableArray array];
        _contactsSource = [NSMutableArray array];
        _sectionTitles = [NSMutableArray array];
        
        m_searchArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        _isSearch = NO;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"会员列表";
 
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    self.m_emptyLabel.hidden = YES;
    
    self.m_tableView.hidden = YES;
    
    // 隐藏多余的分割线
    [self setExtraCellLineHidden:self.m_tableView];
    
    if ( isIOS7 ) {
        // section索引的背景色-右边排序的ABCD所在的视图
        self.m_tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    }

    // 请求数据
    [self memberListRequest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
    
}

#pragma mark - getter
//- (UISearchBar *)searchBar
//{
//    if (_searchBar == nil) {
//        _searchBar = [[EMSearchBar alloc] init];
//        _searchBar.delegate = self;
//        _searchBar.placeholder = @"搜索";
//        _searchBar.backgroundColor = [UIColor colorWithRed:0.747 green:0.756 blue:0.751 alpha:1.000];
//    }
//    
//    return _searchBar;
//}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_isSearch) {
        
        return 1;

    }else{
        
        return [self.m_memberList count];

    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //    return self.m_memberList.count;
    if (_isSearch) {
        
        return [self.m_searchArray count];
    }else{
        return [[self.m_memberList objectAtIndex:section] count];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"MactQuanDetailCellIdentifier";
    
    MactQuanDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"hh_shopListCell" owner:self options:nil];
        
        cell = (MactQuanDetailCell *)[nib objectAtIndex:2];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if (_isSearch) {
        
        if ( self.m_searchArray.count != 0 ) {
            
            cell.m_imageV.hidden = NO;
            cell.m_name.hidden = NO;
            cell.m_shopName.hidden = YES;
            
            NSDictionary * dic = [self.m_searchArray objectAtIndex:indexPath.row];
            
            cell.m_name.text = [NSString stringWithFormat:@"%@(%@)",[dic objectForKey:@"RealName"],[dic objectForKey:@"NickName"]];
            
            [cell setImageViewWithPath:[NSString stringWithFormat:@"%@",[dic objectForKey:@"PhotoBigUrl"]]];
            
            cell.m_membersStatus.hidden = NO;
            
            cell.m_membersStatus.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"GradeName"]];
            
            cell.m_membersStatus.frame = CGRectMake(WindowSizeWidth - 70, cell.m_membersStatus.frame.origin.y, 60, cell.m_membersStatus.frame.size.height);
            
        }

    }else{
        
        if ( self.m_memberList.count != 0 ) {
            
            cell.m_imageV.hidden = NO;
            cell.m_name.hidden = NO;
            cell.m_shopName.hidden = YES;
            
            NSDictionary * dic = [[self.m_memberList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            
            cell.m_name.text = [NSString stringWithFormat:@"%@(%@)",[dic objectForKey:@"RealName"],[dic objectForKey:@"NickName"]];
            
            [cell setImageViewWithPath:[NSString stringWithFormat:@"%@",[dic objectForKey:@"PhotoBigUrl"]]];
            
            cell.m_membersStatus.hidden = NO;
            
            cell.m_membersStatus.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"GradeName"]];
            
            cell.m_membersStatus.frame = CGRectMake(WindowSizeWidth - 75, cell.m_membersStatus.frame.origin.y, 60, cell.m_membersStatus.frame.size.height);
        }

    }
    return cell;
    
}

#pragma mark - UITableviewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 53.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    NSDictionary *dic = [self.m_memberList objectAtIndex:indexPath.row];
//    // 进入详细资料
//    UserInformationViewController *VC = [[UserInformationViewController alloc]initWithNibName:@"UserInformationViewController" bundle:nil];
//    VC.m_typeString = @"2";
//    
//    ///// 好友Id================
//    VC.m_friendId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]];
//    [self.navigationController pushViewController:VC animated:YES];

    
//    NSMutableDictionary *dic = [self.m_memberList objectAtIndex:indexPath.row];
    NSMutableDictionary * dic = nil;

    if (_isSearch) {
        
       dic  = [self.m_searchArray objectAtIndex:indexPath.row];
    }else{
        
        dic = [[self.m_memberList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
    
    
    CardMemeberDetaiViewController *VC = [[CardMemeberDetaiViewController alloc]initWithNibName:@"CardMemeberDetaiViewController" bundle:nil];
    VC.m_dic = dic;
    VC.m_status = self.m_IsSelectSeat;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_isSearch) {
        return 0;
    }else{
        
        if ([[self.m_memberList objectAtIndex:section] count] == 0)
        {
            return 0;
            
        }else{
            
            return 22;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_isSearch) {
        
        return nil;
    }
    
    if ([[self.m_memberList objectAtIndex:section] count] == 0)
    {
        return nil;
    }
    
    UIView *contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 22)];
    label.backgroundColor = [UIColor clearColor];
    [label setText:[self.sectionTitles objectAtIndex:section]];
    [contentView addSubview:label];
    
    return contentView;
    
    
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (_isSearch) {
        return nil;
    }
    
    _sectionIndex = [[NSMutableArray alloc]init];
    NSMutableArray * existTitles = [NSMutableArray array];
    //section数组为空的title过滤掉，不显示
    for (int i = 0; i < [self.sectionTitles count]; i++) {
        
        if ([[self.m_memberList objectAtIndex:i] count] > 0) {
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
    if (_isSearch) {
        return 0;
    }
    NSInteger section = [[_sectionIndex objectAtIndex:index] integerValue];
    
    // 获取所点目录对应的indexPath值
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    // 让table滚动到对应的indexPath位置
    [tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    
    return section;
    
}

#pragma mark - UINetWork
- (void)memberListRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    //    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
//                           self.m_vipCardId,@"vipCardId",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    //VIPCardMemberList.ashx
    
    [httpClient request:@"VIPCardMemberListAll.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            self.m_IsSelectSeat = [NSString stringWithFormat:@"%@",[json valueForKey:@"IsSelectSeat"]];
            
            // 赋值
            self.dataSource = [json valueForKey:@"MemberList"];
            
            self.m_memberList  = [self sortDataArray:self.dataSource];
            
            if ( self.m_memberList.count != 0 ) {
                
                self.m_emptyLabel.hidden = YES;
                
                self.m_tableView.hidden = NO;
                
                [self.m_tableView reloadData];
                
            }else{
                
                self.m_emptyLabel.hidden = NO;
                
                self.m_tableView.hidden = YES;
                
            }
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
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
#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if ( searchBar.text.length != 0 ) {
        
        self.isSearch = YES;
        
    }else{
        
        self.isSearch = NO;
    }
    
    // textField进行改变的时候 搜索:将数组里的数据与m_searchBar.text进行比较,若存在,则存入搜索数组中
    // 先将数组里的数据remove,以存放新的数据
    [self.m_searchArray removeAllObjects];
    
    if (![self isIncludeChineseInString:searchText]) {
        
        for (NSDictionary * obj in self.dataSource) {
            
            NSString *realName = [NSString stringWithFormat:@"%@",[obj objectForKey:@"RealName"]];
            
            if ([self isIncludeChineseInString:realName]) {
                
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:realName];
                NSRange titleResult = [tempPinYinStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                
                if (titleResult.length>0) {
                    [self.m_searchArray addObject:obj];
                } else {
                    NSString *tempPinYinHeadStr =
                    [PinYinForObjc stringConvertToPinYinHead:realName];
                    NSRange titleHeadResult = [tempPinYinHeadStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                    
                    if (titleHeadResult.length>0) {
                        [self.m_searchArray addObject:obj];
                    }
                }
            } else {
                NSRange titleResult = [realName rangeOfString:searchText options:NSCaseInsensitiveSearch];
                
                if (titleResult.length > 0) {
                    [self.m_searchArray addObject:obj];
                }
            }
        }
    } else {
        for (NSDictionary * obj in self.dataSource) {
            
            NSString *realName = [NSString stringWithFormat:@"%@",[obj objectForKey:@"RealName"]];
            
            NSRange titleResult=[realName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (titleResult.length>0) {
                [self.m_searchArray addObject:obj];
            }
        }
    }

    [self.m_tableView reloadData];

}

- (BOOL)isIncludeChineseInString:(NSString*)str {
    
    for (int i=0; i<str.length; i++) {
        unichar ch = [str characterAtIndex:i];
        
        if (0x4e00 < ch  && ch < 0x9fff) {
            return YES;
        }
    }
    
    return NO;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    

    
    [self hiddenNumPadDone:nil];
    
    if ( searchBar.text.length != 0 ) {
        
        self.isSearch = YES;
        
    }else{
        
        self.isSearch = NO;
    }
    
    self.m_searchBar.showsCancelButton = YES;
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    self.isSearch = NO;
    
    [self.m_searchBar resignFirstResponder];
    
    self.m_searchBar.text = @"";
    
    self.m_searchBar.showsCancelButton = NO;
    
    [self.m_tableView reloadData];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.m_searchBar resignFirstResponder];
    
    self.m_searchBar.showsCancelButton = NO;
    
}

@end
