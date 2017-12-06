//
//  HH_advCityListViewController.m
//  HuiHui
//
//  Created by mac on 15-4-15.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HH_advCityListViewController.h"

#import "AreaCell.h"

#import "JPinYinUtil.h"

@interface HH_advCityListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@end

@implementation HH_advCityListViewController

@synthesize m_cityList;

@synthesize m_dic;

@synthesize delegate;

@synthesize m_cityName;

@synthesize m_cityId;


+ (HH_advCityListViewController *)shareobject{
    
    static HH_advCityListViewController *VC = nil;
    
    if ( VC == nil){
        
        VC = [[HH_advCityListViewController alloc]init];
    }
    
    return VC;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        m_cityList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        self.m_cityListDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        self.m_allKeys = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"城市选择"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
//    [self setRightButtonWithTitle:@"确定" action:@selector(sureChooseClicked)];
    
//    self.m_tableView.hidden = YES;
    
    // 请求城市列表的数据
    [self getCityListSubmit];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideTabBar:YES];
//    
//    if ( self.m_cityList.count != 0 ) {
//        
//        if ( self.m_cityName.length == 0 ) {
//            
//            for (int i = 0; i < self.m_cityList.count; i++) {
//                [self.m_dic setValue:@"0" forKey:[NSString stringWithFormat:@"%i",i]];
//            }
//            
//            [self.m_tableView reloadData];
//           
//            
//        }else{
//            
//            // 判断是否包含该城市
//            [self cityChoose];
//        
//            
//        }
//    }
//    
//   
//  
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

//- (void)cityChoose{
//    
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.m_cityId,@"CityId",self.m_cityName,@"CityName", nil];
//    
//    NSInteger index = -1;
//    
//    if ( [self.m_cityList containsObject:dic] ) {
//        
//        index = [self.m_cityList indexOfObject:dic];
//        
//        [self.m_dic setValue:@"1" forKey:[NSString stringWithFormat:@"%li",(long)index]];
//        
//    }
//    
//    for (int i = 0; i < self.m_cityList.count; i++) {
//        
//        if ( index == i ) {
//            
//            [self.m_dic setValue:@"1" forKey:[NSString stringWithFormat:@"%li",(long)index]];
//            
//        }else{
//            
//            [self.m_dic setValue:@"0" forKey:[NSString stringWithFormat:@"%i",i]];
//            
//        }
//    }
//    
//    [self.m_tableView reloadData];
//
//}

- (void)getCityListSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }

    AppHttpClient* httpClient = [AppHttpClient sharedClient];

    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"UpAdCity.ashx" parameters:nil success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
        
//            self.m_tableView.hidden = NO;
//            
//            if ( self.m_cityList.count != 0 ) {
//                
//                [self.m_cityList removeAllObjects];
//            }
//            
//            if ( self.m_dic.count != 0 ) {
//                
//                [self.m_dic removeAllObjects];
//            }
            
            self.m_cityList = [json valueForKey:@"UpAdCityList"];
            
            [self sortCitys];
            
            // 赋值 - 记录选中了哪一个城市
//            [self cityChoose];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}

// 列表进行字母分类
- (void)sortCitys{
    
    NSString *mutPinYin = [NSString string];
    
    // 进行排序循环
    for (int i = 0; i< self.m_cityList.count; i++) {
        
//        blockcount++;
        
        NSDictionary *dic = [self.m_cityList objectAtIndex:i];
        NSString *pinyin = [self firstLetterForCompositeNames:[dic objectForKey:@"CityName"]];
        NSArray *array = [self sortBypinyin:pinyin];
        
        if ([mutPinYin isEqualToString:pinyin]) {
            
            
            
        }else {
        
            [self.m_cityListDic setObject:array forKey:pinyin];
            
            mutPinYin = pinyin;
            
        }
        
        
//        if (blockcount==self.m_cityList.count) {
//            self.m_allKeys  = [[[self.m_cityListDic allKeys] sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
//        }
        
    }
    
    self.m_allKeys  = [[[self.m_cityListDic allKeys] sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
    
    [self.m_tableView reloadData];

}

-(NSString *)firstLetterForCompositeNames:(NSString *)cityString {
    if (![cityString length]) {
        return @"";
    }
    unichar charString = [cityString characterAtIndex:0];
    NSArray *array = pinYinWithoutToneOnlyLetter(charString);
    if ([array count]) {
        
        return [[[array objectAtIndex:0] substringToIndex:1] uppercaseString];
        
        
    }
    return @"";
}

- (NSMutableArray *)sortBypinyin:(NSString *)pinyin{
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i< self.m_cityList.count; i++) {
        
        NSDictionary *dic = [self.m_cityList objectAtIndex:i];
        NSString *data_pinyin = [self firstLetterForCompositeNames:[dic objectForKey:@"CityName"]];
        
        if ([data_pinyin isEqualToString:pinyin]) {
            
            [array addObject:dic];
        }
    }
    
    return array;
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.m_allKeys.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString *str = [self.m_allKeys objectAtIndex:section];
    
    NSArray *friendsArr = [self.m_cityListDic objectForKey:str];
    
    return friendsArr.count;
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    return self.m_allKeys;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    UIView* l_View = [[UIView alloc] init];
    l_View.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, WindowSizeWidth, 22)];
    titleLabel.textColor=[UIColor grayColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    NSString *str = [self.m_allKeys objectAtIndex:section];
    titleLabel.text = str;
    
    
    [l_View addSubview:titleLabel];
    
    return l_View;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 30.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"AreaCellIdentifier";
    
    AreaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AreaCell" owner:self options:nil];
        
        cell = (AreaCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    // 赋值
    if ( self.m_cityList.count != 0 ) {
        
//        NSDictionary *dic = [self.m_cityList objectAtIndex:indexPath.row];
        
//        cell.m_cityName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CityName"]];
        
        // 赋值
        NSString *key = [self.m_allKeys objectAtIndex:indexPath.section];
        
        NSArray *array = [self.m_cityListDic objectForKey:key];
        
        NSDictionary *dic = [array objectAtIndex:indexPath.row];
        
        cell.m_cityName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CityName"]];
        
//        NSString *string = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:[NSString stringWithFormat:@"%li",(long)indexPath.row]]];
//        
//        // 根据值来判断是否选中某一个
//        if ( [string isEqualToString:@"1"] ) {
//            
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//       
//        }else{
//            
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            
//        }
       
    }

    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    // 选中某行后设置dic里面的值为1
//    for (int i = 0; i < self.m_cityList.count; i++) {
//        
//        if ( i == indexPath.row ) {
//            
//            [self.m_dic setValue:@"1" forKey:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
//
//        }else{
//            
//            [self.m_dic setValue:@"0" forKey:[NSString stringWithFormat:@"%i",i]];
//
//        }
//        
//    }

    [self.m_tableView reloadData];
    
    // 代理方法
    if ( delegate && [delegate respondsToSelector:@selector(getCityList:)] ) {
        
        NSString *key = [self.m_allKeys objectAtIndex:indexPath.section];
        
        NSArray *array = [self.m_cityListDic objectForKey:key];
        
        NSDictionary *dic = [array objectAtIndex:indexPath.row];
        
//        NSMutableDictionary *dic = [self.m_cityList objectAtIndex:indexPath.row];
        
        [delegate performSelector:@selector(getCityList:) withObject:dic];
        
    }
    
    [self goBack];
    
}


@end
