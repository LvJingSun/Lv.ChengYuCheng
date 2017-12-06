//
//  SceneryFilterViewController.m
//  HuiHui
//
//  Created by mac on 15-1-14.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryFilterViewController.h"

#import "SceneryListCell.h"

#import "CommonUtil.h"

@interface SceneryFilterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@end

static SceneryFilterViewController *vc = nil;

@implementation SceneryFilterViewController

@synthesize m_list;

@synthesize m_SectionsSet;

@synthesize m_dic;

@synthesize delegate;

@synthesize m_levelList;
@synthesize m_priceList;
@synthesize m_countryList;

// 保证筛选只初始化一次
+ (SceneryFilterViewController *)shareobject;
{
    if (vc == nil)
    {
        vc = [[SceneryFilterViewController alloc]init];
        
    }
    
    return vc;
}

- (id)init{
    
    self = [super init];
    if (self) {
        // Custom initialization
        m_list = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_SectionsSet = [[NSMutableSet alloc]init];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_levelList = [[NSMutableArray alloc]initWithCapacity:0];

        m_priceList = [[NSMutableArray alloc]initWithCapacity:0];

        m_countryList = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"筛选"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    [self setRightButtonWithTitle:@"确定" action:@selector(sureClicked)];
    
    // 设置数组的值
    self.m_list = [NSMutableArray arrayWithObjects:@"行政区",@"景点级别",@"景点价格", nil];

    self.m_levelList = [NSMutableArray arrayWithObjects:@"不限",@"A",@"AA",@"AAA",@"AAAA",@"AAAAA", nil];

    self.m_priceList = [NSMutableArray arrayWithObjects:@"不限",@"0-50",@"50-100",@"100以上", nil];

    
    // 将tableView上多余的线去掉
    self.m_tableView.tableFooterView = [[UIView alloc]init];
    
    sectionIndex = 0;
    
    // 测试
    for (int i = 0; i < 3; i++) {
        
        NSMutableSet *set = [NSMutableSet set];
        
        [set addObject:[NSNumber numberWithInteger:0]];
        
        [self.m_dic setObject:set forKey:[NSNumber numberWithInteger:i]];

    }
    
    // 请求行政区列表的数据
    [self requwstCountrySubmit];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

// 导航栏右按钮确定按钮触发的事件
- (void)sureClicked{
    
    // 设置临时字典用于传值
    NSMutableDictionary *l_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    // 根据字典里的值显示按钮勾选的状态
    for (int i = 0; i < self.m_dic.count; i++) {
        
        NSMutableSet *expandedSectionsSet = [self.m_dic objectForKey:[NSNumber numberWithInteger:i]];
        // 取出集合里面的值存放到数组里面，然后进行复制
        NSArray *arr = [expandedSectionsSet allObjects];
      
        if ( arr.count != 0 ) {
            
            NSInteger index = [[arr objectAtIndex:0] integerValue];
            
            if ( i == 0 ) {
                // 行政区
                NSDictionary *dic = [self.m_countryList objectAtIndex:index];
                [l_dic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Id"]] forKey:@"CountyIdKey"];
                
            } else if ( i == 1 ) {
                
                // 景区级别
                NSString *string = [NSString stringWithFormat:@"%@",[self.m_levelList objectAtIndex:index]];
                
                [l_dic setObject:string forKey:@"LevelKey"];
            
            }else if ( i == 2 ){
                // 景区价格
                NSString *string = [NSString stringWithFormat:@"%@",[self.m_priceList objectAtIndex:index]];
                
                [l_dic setObject:string forKey:@"PriceKey"];

            }else{
                
                
            }
       
        
        
        }
    
        
    }
    
    if ( delegate && [delegate respondsToSelector:@selector(filterChoose:)] ) {
        
        [delegate performSelector:@selector(filterChoose:) withObject:l_dic];
    }
    
    [self goBack];
    
}
 
// 判断是否展开
- (BOOL)isSection:(NSInteger)section{
    
    BOOL result = NO;
    
    if ( [self.m_SectionsSet containsObject:[NSNumber numberWithInteger:section]] ) {
       
        result = YES;
    
    }
    
    return result;
}

// 展开的section保存到expandedSectionsSet里面
- (void)setSection:(int)section expand:(BOOL)expand{
    
    if ( expand ) {
        
        if ( ![self.m_SectionsSet containsObject:[NSNumber numberWithInteger:section]] ) {
            // 首先是只显示一个点击展开的列表-即删除数据
            [self.m_SectionsSet removeAllObjects];
            
            [self.m_SectionsSet addObject:[NSNumber numberWithInteger:section]];
        
            // 如果展开全部的数据则写下面这行代码
//          [self.m_SectionsSet addObject:[NSNumber numberWithInteger:section]];

            
        }
        
    }else{
          // 如果展开全部的数据则写下面这行代码
//        [self.m_SectionsSet removeObject:[NSNumber numberWithInteger:section]];
        
        // 首先是只显示一个点击展开的列表-即删除数据
        [self.m_SectionsSet removeAllObjects];
        
    }
    
}

- (void)headerClicked:(id)sender{
 
    // button的tag值
    UIButton *btn = (UIButton *)sender;
    
    sectionIndex = btn.tag;
    
    // bool值判断哪个section是展开还是合起来的
    BOOL expand = [self isSection:sectionIndex];
    
    [self setSection:sectionIndex expand:!expand];
    
    // 刷新tableView 展开全部的列表的话则就刷新某一行
//    [self.m_tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.m_tableView reloadData];

    
}

- (void)btnChoose:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    // 将点击的某一行保存到字典里
    NSMutableSet *expandedSectionsSet = [self.m_dic objectForKey:[NSNumber numberWithInteger:sectionIndex]];
    // 如果集合不包含这个值的话，则先将数据清空，再把数据加进去
    if ( ![expandedSectionsSet containsObject:[NSNumber numberWithInteger:btn.tag]] ) {
        
        [expandedSectionsSet removeAllObjects];
        [expandedSectionsSet addObject:[NSNumber numberWithInteger:btn.tag]];
        
        // 刷新某一区
        [self.m_tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationNone];
        
    }else{
        
        
    }
   
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.m_list.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    BOOL expand = [self isSection:section];
    
    if ( expand ) {
        
        if ( section == 0 ) {
            
            return self.m_countryList.count;
            
        }else if ( section == 1 ) {
            
            return self.m_levelList.count;
            
        }else{
            
            return self.m_priceList.count;
        }
        
    }else {
        
        return 0;
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 44)];
    tempView.backgroundColor = [UIColor whiteColor];
    
    // 显示名称
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 100, 34)];
    label.text = [NSString stringWithFormat:@"%@",[self.m_list objectAtIndex:section]];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentLeft;
    [tempView addSubview:label];
    
    // 显示副标题
    UILabel *subLabel = [[UILabel alloc]initWithFrame:CGRectMake(180, 5, 100, 34)];
    
    
    // 根据字典里的值显示按钮勾选的状态
    NSMutableSet *expandedSectionsSet = [self.m_dic objectForKey:[NSNumber numberWithInteger:section]];
    // 取出集合里面的值存放到数组里面，然后进行复制
    NSArray *arr = [expandedSectionsSet allObjects];
    
    if ( arr.count != 0 ) {
        
        NSInteger index = [[arr objectAtIndex:0] integerValue];
                
        if ( section == 0 ) {
            // 行政区
            
            if ( self.m_countryList.count != 0 ) {
                
                NSDictionary *dic = [self.m_countryList objectAtIndex:index];
                
                subLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Name"]];
                
            }else{
                
                subLabel.text = @"不限";
            
            }
           
        }else if ( section == 1 ) {
             // 景区级别
             subLabel.text = [NSString stringWithFormat:@"%@",[self.m_levelList objectAtIndex:index]];
            
        }else{
            // 景区价格
            subLabel.text = [NSString stringWithFormat:@"%@",[self.m_priceList objectAtIndex:index]];
        }
        
    }else{
        
        subLabel.text = @"不限";

    }
    
    subLabel.tag = 300 + section;
    subLabel.font = [UIFont systemFontOfSize:12.0f];
    subLabel.textColor = RGBACKTAB;
    subLabel.backgroundColor = [UIColor clearColor];
    subLabel.textAlignment = NSTextAlignmentRight;
    [tempView addSubview:subLabel];
    
    // 添加按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, WindowSizeWidth, 44);
    [btn addTarget:self action:@selector(headerClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = section;
    [tempView addSubview:btn];
    
    // 添加箭头变化的图片
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(290, 17, 16, 10)];
    
    BOOL expand = [self isSection:section];
    
    // 判断是展开还是闭合
    if ( expand ) {
        
        imgV.image = [UIImage imageNamed:@"arrow_L_up.png"];
        
    } else {
        
        imgV.image = [UIImage imageNamed:@"arrow_L_down.png"];
        
    }
   
    
    [tempView addSubview:imgV];
    
    // 添加分割线
    UIImageView *lineimgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43, WindowSizeWidth, 1)];
    lineimgV.image = [UIImage imageNamed:@"line.png"];
    [tempView addSubview:lineimgV];
    
    
    return tempView;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"SceneryChooseCellIdentifier";
    
    SceneryChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SceneryListCell" owner:self options:nil];
        
        cell = (SceneryChooseCell *)[nib objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    // 根据字典里的值显示按钮勾选的状态
    NSMutableSet *expandedSectionsSet = [self.m_dic objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    
    // 如果集合不包含这个值的话，则先将数据清空，再把数据加进去
    if ( ![expandedSectionsSet containsObject:[NSNumber numberWithInteger:indexPath.row]] ) {
        
        [cell.m_btn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
        
    }else{
        
        [cell.m_btn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];

    }
    
    // 赋值
    if ( indexPath.section == 0 ) {
        
        // 行政区
        if ( self.m_countryList.count != 0 ) {
            
            NSDictionary *dic = [self.m_countryList objectAtIndex:indexPath.row];
            
            cell.m_name.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Name"]];
        }
        
    }else if ( indexPath.section == 1 ) {
        
        if ( self.m_levelList.count != 0 ) {
            // 景区级别
            cell.m_name.text = [NSString stringWithFormat:@"%@",[self.m_levelList objectAtIndex:indexPath.row]];
            
        }

    }else{
        
        if ( self.m_priceList.count != 0 ) {
            // 景区价格
            cell.m_name.text = [NSString stringWithFormat:@"%@",[self.m_priceList objectAtIndex:indexPath.row]];
        }
        
    }
    
    
    cell.m_btn.tag = indexPath.row;
    [cell.m_btn addTarget:self action:@selector(btnChoose:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}

#pragma mark - NetWork
- (void)requwstCountrySubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *cityId = [CommonUtil getValueByKey:SceneryCityId];

    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           cityId,@"cityId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestScenery:@"Scenery/GetCountyList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            self.m_countryList = [json valueForKey:@"countyList"];
            
            if ( self.m_countryList.count != 0 ) {
                // 将不限的数据加载数组的第一个
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"不限",@"Name",@"",@"CountyId",@"",@"EnName",@"不限",@"Id",@"",@"ParentId",@"",@"PrefixLetter", nil];
                
                [self.m_countryList insertObject:dic atIndex:0];
                
            }
            
            
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
