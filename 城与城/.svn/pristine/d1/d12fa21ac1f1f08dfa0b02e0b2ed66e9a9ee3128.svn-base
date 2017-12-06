//
//  HotelCitylistViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-12-8.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "HotelCitylistViewController.h"

#import "ChineseToPinyin.h"
#import "EMSearchBar.h"
#import "EMSearchDisplayController.h"
#import "RealtimeSearchUtil.h"

#import "Hotel_CitylistDB.h"
#import "CommonUtil.h"
#import "AreaCell.h"
#import "HotelCityClass.h"
@interface HotelCitylistViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
{
    Hotel_CitylistDB *dbhelp;
    
}



@property (strong, nonatomic) NSMutableArray *CitysSource;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableArray *sectionTitles;

@property (strong, nonatomic) NSMutableArray *HistoryArray;


@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) EMSearchBar *searchBar;
@property (strong, nonatomic) EMSearchDisplayController *searchController;

@property (nonatomic, strong) NSMutableArray        *sectionIndex;//用于存储索引栏，对应section下标

@end

@implementation HotelCitylistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _dataSource = [NSMutableArray array];
        _CitysSource = [NSMutableArray array];
        _sectionTitles = [NSMutableArray array];
        _HistoryArray = [NSMutableArray array];
        
        dbhelp = [[Hotel_CitylistDB alloc] init];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [super viewDidLoad];
    
    [self setTitle:@"选择城市"];
    
    [self searchController];
    self.searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
//    [self.view addSubview:self.searchBar];
    
    self.tableView.frame = CGRectMake(0, self.searchBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.searchBar.frame.size.height);
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height );

    [self.view addSubview:self.tableView];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    //当前
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    [dic setObject:@"我附近的酒店" forKey:@"CityName"];
    NSMutableArray * array = [[NSMutableArray alloc]initWithObjects:dic,nil];
    [self.dataSource addObject:array];
    
    [self.sectionTitles addObject:@"当前"];
    
    self.HistoryArray = [NSMutableArray arrayWithArray:[dbhelp queryHChistory]];

    if (self.HistoryArray.count!=0) {
        [self.dataSource addObject:self.HistoryArray];
        [self.sectionTitles addObject:@"历史"];
    }
    
    [self loadHotelCity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)leftClicked{

    [self goBack];
    
}
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

- (EMSearchDisplayController *)searchController
{
    if (_searchController == nil) {
        _searchController = [[EMSearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        _searchController.delegate = self;
        _searchController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        __weak HotelCitylistViewController *weakSelf = self;
        [_searchController setCellForRowAtIndexPathCompletion:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            static NSString *CellIdentifier = @"ContactListCell";
            BaseTableViewCell *cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            // Configure the cell...
            if (cell == nil) {
                cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            NSDictionary *buddy = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            cell.textLabel.frame = CGRectMake(5, 5, 200, 20);
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[buddy objectForKey:@"CityName"]];
            
            return cell;
        }];
        
        [_searchController setHeightForRowAtIndexPathCompletion:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            return 55;
        }];
        
        [_searchController setDidSelectRowAtIndexPathCompletion:^(UITableView *tableView, NSIndexPath *indexPath) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
//            EMBuddy *buddy = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
//            NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
//            NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
//            if (loginUsername && loginUsername.length > 0) {
//                if ([loginUsername isEqualToString:buddy.username]) {
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不能跟自己聊天" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                    [alertView show];
//                    
//                    return;
//                }
//            }
//            
//            [weakSelf.searchController.searchBar endEditing:YES];
//            ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:buddy.username isGroup:NO];
//            chatVC.title = buddy.username;
//            [weakSelf.navigationController pushViewController:chatVC animated:YES];
        }];
    }
    
    return _searchController;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
//    if (self.dataSource.count>2) {
        return [self.dataSource count];
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataSource objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"AreaCellIdentifier";
    AreaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AreaCell" owner:self options:nil];
        cell = (AreaCell *)[nib objectAtIndex:0];
    }
    
    NSMutableDictionary* dic = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.m_cityName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CityName"]];
    
    return cell;
}


#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 0;
    }
    else {
        if ([[self.dataSource objectAtIndex:section] count] == 0)
        {
            return 0;
        }
        return 25.0f;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    }
    else {
        if ([[self.dataSource objectAtIndex:section] count] == 0)
        {
            return nil;
        }
        UIView* l_View = [[UIView alloc] init];
        l_View.backgroundColor = [UIColor clearColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 25)];
        titleLabel.textColor=[UIColor blackColor];
        titleLabel.textAlignment = UITextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleLabel.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f  blue:245/255.f  alpha:1];
        NSString *str = [self.sectionTitles objectAtIndex:section];
        titleLabel.text = [NSString stringWithFormat:@"  %@",str];
        [l_View addSubview:titleLabel];
        return l_View;
        
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    _sectionIndex = [[NSMutableArray alloc]init];
    NSMutableArray * existTitles = [NSMutableArray array];
    //section数组为空的title过滤掉，不显示
    for (int i = 0; i < [self.sectionTitles count]; i++) {
        if ([[self.dataSource objectAtIndex:i] count] > 0) {
            [_sectionIndex addObject:[NSString stringWithFormat:@"%d",i]];

            [existTitles addObject:[self.sectionTitles objectAtIndex:i]];
        }
    }
    return existTitles;
}


// 点击目录
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    
    NSInteger section = [[_sectionIndex objectAtIndex:index] integerValue];
    // 获取所点目录对应的indexPath值
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    // 让table滚动到对应的indexPath位置
    [tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    
    return section;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *buddy = [[self.dataSource objectAtIndex:(indexPath.section)] objectAtIndex:indexPath.row];
    [self.Chosectriphoteldelegate GetCtrip_hotel_cityname:buddy];
    
    for (int i =0; i<self.HistoryArray.count; i++) {
        NSDictionary *dic = [self.HistoryArray objectAtIndex:i];
        NSString * city = [dic objectForKey:@"CityName"];
        if ([city isEqualToString:[buddy objectForKey:@"CityName"]]) {
            [self goBack];
            return;
        }
    }
    
    if (self.HistoryArray.count<3) {

        [self.HistoryArray addObject:buddy];

    }else
    {
        [self.HistoryArray replaceObjectAtIndex:0 withObject:buddy];
        
    }
    
    if (![[NSString stringWithFormat:@"%@",[buddy objectForKey:@"CityName"]] isEqualToString:@"我附近的酒店"]) {
        [dbhelp updateHChistoryData:[self.HistoryArray mutableCopy]];
    }
    
    [self goBack];

}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    [self hiddenNumPadDone:nil];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [[RealtimeSearchUtil currentUtil] realtimeSearchWithSource:self.CitysSource searchText:(NSString *)searchText collationStringSelector:@selector(CityName) resultBlock:^(NSArray *results) {
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

#pragma mark - private

- (NSMutableArray *)sortDataArray:(NSArray *)dataArray
{
    //建立索引的核心
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    [self.sectionTitles addObjectsFromArray:[indexCollation sectionTitles]];
    
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
        HotelCityClass *Class = [[HotelCityClass alloc]init];
        Class.CityName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CityName"]];
        NSString *firstLetter = [ChineseToPinyin pinyinFromChineseString:Class.CityName];
        NSInteger section = [indexCollation sectionForObject:[firstLetter substringToIndex:1] collationStringSelector:@selector(uppercaseString)];
        
        NSMutableArray *array = [sortedArray objectAtIndex:section];
        [array addObject:dic];
    }
    
    for (int i = 0; i < [sortedArray count]; i++) {
        NSArray *array = [[sortedArray objectAtIndex:i] sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
            NSString *str1 = [NSString stringWithFormat:@"%@",[obj1 objectForKey:@"CityName"] ];
            NSString *str2 = [NSString stringWithFormat:@"%@",[obj2 objectForKey:@"CityName"] ];
            
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


- (void)loadHotelCity {
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        [self loadCityView];
        return;
    }
    
    NSString *cityVer = [dbhelp queryVersion];
    
    NSLog(@"cityVer%@",cityVer);
    
    if (cityVer == nil ||[cityVer isEqualToString:@""]) {
        cityVer = @"-1";
    }
    
    AppHttpClient* httpClient = [AppHttpClient sharedCtrip];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           cityVer, @"cityVersion",
                           nil];
    [httpClient requestCtrip:@"CityList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSArray *versionList = [json valueForKey:@"CityListSessions"];
            
            if ([versionList count] != 0) {
                
                NSString *cityVersion = [NSString stringWithFormat:@"%@",[json valueForKey:@"CityVersion"]];
                if (cityVersion > 0) {
                    NSArray *cityList = [json valueForKey:@"CityListSessions"];
                    [dbhelp updateData:cityList andVersion:[NSString stringWithFormat:@"%@",cityVersion]];
                }
                
            }
            
            [self loadCityView];
            
        }
        else {
            
            NSLog(@"%@",[json valueForKey:@"msg"]);
            [self loadCityView];

        }
    } failure:^(NSError *error) {
        
        NSLog(@"1111111113");
        [self loadCityView];

        
    }];
}


//城市
-(void)loadCityView
{
    self.CitysSource = [NSMutableArray arrayWithArray: [dbhelp queryCity]];
    [self.dataSource addObjectsFromArray:[self sortDataArray:self.CitysSource]];
    [SVProgressHUD dismiss];
    [self.tableView reloadData];
    
}

@end
