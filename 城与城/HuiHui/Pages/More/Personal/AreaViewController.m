//
//  AreaViewController.m
//  HuiHui
//
//  Created by mac on 13-12-4.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "AreaViewController.h"

#import "AreaCell.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

@interface AreaViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *m_searchBar;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UIView *m_zhezhaoView;

@end

@implementation AreaViewController

@synthesize m_cityList;

@synthesize delegate;

@synthesize m_searchArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_cityList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_searchArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        self.m_isSearching = NO;
        
        dbhelp = [[AreaDB alloc] init];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"地区"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
//    self.m_cityList = [NSMutableArray arrayWithObjects:@"苏州",@"上海",@"北京",@"广东",@"深圳", nil];
    
    // 设置遮罩view的透明度
    self.m_zhezhaoView.alpha = 0.8f;
    self.m_zhezhaoView.hidden = YES;
    
    self.m_searchBar.showsCancelButton = NO;
    
    // 设置searchBar上的取消按钮的背景
    for(id cc in [self.m_searchBar subviews]){
        if([cc isKindOfClass:[UIButton class]]){
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
    
    // 请求数据
    [self requestAreaSubmit];
        
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ( !self.m_isSearching ) {
        
        return self.m_cityList.count;

    }else{
        
        if ( self.m_searchArray.count != 0 ) {
            
            return self.m_searchArray.count;
        }else{
            
            return 1;
        }

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"AreaCellIdentifier";
    
    AreaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AreaCell" owner:self options:nil];
        
        cell = (AreaCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    
    if ( !self.m_isSearching ) {
        // 赋值
        if ( self.m_cityList.count != 0 ) {
            
            NSDictionary *dic = [self.m_cityList objectAtIndex:indexPath.row];
            
            cell.m_cityName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        }
        
    }else{
        
        if ( self.m_searchArray.count != 0 ) {
            
            // 赋值
            NSDictionary *dic = [self.m_searchArray objectAtIndex:indexPath.row];
            
            cell.m_cityName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        }else{
            
            // 赋值
            cell.m_cityName.text = @"无结果";
        }
    }
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
//    if ( delegate && [delegate respondsToSelector:@selector(getAreaName:)] ) {
//        
//        [delegate performSelector:@selector(getAreaName:) withObject:[self.m_cityList objectAtIndex:indexPath.row]];
//    }
//    
//    [self.navigationController popViewControllerAnimated:YES];
    
   if ( !self.m_isSearching ) {
       
       if ( self.m_cityList.count != 0 ) {
           
           NSDictionary *dic = [self.m_cityList objectAtIndex:indexPath.row];
           
           NSArray *array = [dbhelp queryArea:[dic objectForKey:@"code"]];
           
           NSLog(@"%@,%i",[[array objectAtIndex:0]objectForKey:@"name"],array.count);
       }
     
   }else{
       
       if ( self.m_searchArray.count != 0 ) {
           
           NSDictionary *dic = [self.m_searchArray objectAtIndex:indexPath.row];
           
           NSArray *array = [dbhelp queryArea:[dic objectForKey:@"code"]];
           
           NSLog(@"%@,%i",array,array.count);
       }

   }
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if ( searchBar.text.length != 0 ) {
        
        self.m_isSearching = YES;
        
    }else{
        
        self.m_isSearching = NO;
    }
    
    // textField进行改变的时候 搜索:将数组里的数据与m_searchBar.text进行比较,若存在,则存入搜索数组中
    // 先将数组里的数据remove,以存放新的数据
    [self.m_searchArray removeAllObjects];
    // 遍历整个数组
    for (NSDictionary * obj in self.m_cityList) {
        // 开头字 [cellTitle rangeOfString:searchBar.text options:NSCaseInsensitiveSearch].location != NSNotFound这个表示带有这个字得所有结果
        NSComparisonResult result = [[obj objectForKey:@"name"] compare:searchBar.text options:NSCaseInsensitiveSearch range:NSMakeRange(0, [searchBar.text length])];
        if ( result == NSOrderedSame || [[obj objectForKey:@"name"] rangeOfString:searchBar.text options:NSCaseInsensitiveSearch].location != NSNotFound ) {
            
            [self.m_searchArray addObject:obj];
        }
        
    }
    
    [self.m_tableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    [self hiddenNumPadDone:nil];
    
    if ( searchBar.text.length != 0 ) {
        
        self.m_isSearching = YES;
        
    }else{
        
        self.m_isSearching = NO;
    }
   
    self.m_searchBar.showsCancelButton = YES;
 
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    
    if ( searchBar.text.length != 0 ) {
        
        self.m_isSearching = YES;
        
    }else{
        
        self.m_isSearching = NO;
    }
    
    
    [self.m_searchBar resignFirstResponder];
    
    self.m_zhezhaoView.hidden = YES;
   
    self.m_searchBar.showsCancelButton = NO;

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.m_searchBar resignFirstResponder];
    
    self.m_zhezhaoView.hidden = YES;
    
    self.m_searchBar.showsCancelButton = NO;
    
}

#pragma mark - 城市请求数据
- (void)requestAreaSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
        NSDictionary *versions = [dbhelp queryVersion];
        NSString *cityVer = [versions objectForKey:TYPE_CITY];
    
    for (int i = 0; i < [dbhelp queryArea:@"319"].count; i ++) {
        
        NSDictionary *dic = [[dbhelp queryArea:@"319"] objectAtIndex:i];
        
        NSLog(@"%@",[dic objectForKey:@"name"]);
        
    }
    
      if (cityVer == nil) {
          cityVer = @"0";
        }
    //    NSString *categoryVer = [versions objectForKey:TYPE_CATEGORY];
    //    if (categoryVer == nil) {
    //        categoryVer = @"-1";
    //    }
    
    //    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    //    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           //                           memberId,     @"memberid",
                           //                           key,   @"key",
                           
                           cityVer,@"memberCityVer",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MemberCity.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
//            [self.m_cityList addObjectsFromArray:[dbhelp queryCity]];
//
//            NSLog(@"%@,%i",[dbhelp queryCity],[dbhelp queryCity].count);

            
            NSArray *versionList = [json valueForKey:@"MemberVersion"];
            if (versionList == nil || [versionList count] == 0) {
                
                [self.m_cityList addObjectsFromArray:[dbhelp queryCity]];
                
                [self.m_tableView reloadData];
                
                return;
            }
            
            
            NSInteger cityVersion = 0;
            NSInteger categoryVersion = 0;
            for (NSDictionary *version in versionList) {
                NSString *type = [version objectForKey:@"VersionType"];
                if ([@"VersionMemberCity" isEqualToString:type]) {
                    cityVersion = [[version objectForKey:@"MemberVersionNum"] intValue];
                }
                if ([@"VersionClass" isEqualToString:type]) {
                    categoryVersion = [[version objectForKey:@"VersionNum"] intValue];
                }

            }
            
            if (cityVersion > 0) {
                NSArray *cityList = [json valueForKey:@"memberCity"];
                [dbhelp updateData:cityList andType:TYPE_CITY andVersion:[NSString stringWithFormat:@"%d", cityVersion]];
               
            }
            
            
            [self.m_cityList addObjectsFromArray:[dbhelp queryCity]];
            
            [self.m_tableView reloadData];
        
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
    
}



@end
