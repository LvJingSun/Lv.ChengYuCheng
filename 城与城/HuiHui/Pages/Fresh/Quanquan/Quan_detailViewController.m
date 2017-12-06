//
//  Quan_detailViewController.m
//  HuiHui
//
//  Created by mac on 15-5-28.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "Quan_detailViewController.h"

#import "HH_RelseaeQuanViewController.h"

#import "hh_shopListCell.h"

@interface Quan_detailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_title;

@property (weak, nonatomic) IBOutlet UILabel *m_time;

@property (weak, nonatomic) IBOutlet UILabel *m_desprition;

@end

@implementation Quan_detailViewController

@synthesize m_SectionsSet;

@synthesize m_dic;

@synthesize m_shopList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        m_SectionsSet = [[NSMutableSet alloc]init];

        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_shopList = [[NSMutableArray alloc]initWithCapacity:0];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"券券详情"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"编辑" action:@selector(editClicked)];
    
    
    [self setExtraCellLineHidden:self.m_tableView];
    
    // 测试 存放选择的第几个区的数据
    NSMutableSet *set = [NSMutableSet set];
    
    [set addObject:[NSNumber numberWithInteger:0]];
    
    [self.m_dic setObject:set forKey:[NSNumber numberWithInteger:0]];
    
    // 赋值
    self.m_shopList = [self.m_quanquanDic objectForKey:@"VoucherMctShopList"];
    
    self.m_title.text = [NSString stringWithFormat:@"%@",[self.m_quanquanDic objectForKey:@"Title"]];

    self.m_time.text = [NSString stringWithFormat:@"%@ 至 %@",[self.m_quanquanDic objectForKey:@"MinDateTime"],[self.m_quanquanDic objectForKey:@"MaxDateTime"]];
    
    self.m_desprition.text = [NSString stringWithFormat:@"%@",[self.m_quanquanDic objectForKey:@"Description"]];

    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSLog(@"m_quanquanDic = %@,shopList = %@",self.m_quanquanDic,self.m_shopList);
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

- (void)editClicked{
    
    // 进入编辑券券的页面
    HH_RelseaeQuanViewController *VC = [[HH_RelseaeQuanViewController alloc]initWithNibName:@"HH_RelseaeQuanViewController" bundle:nil];
    VC.m_type = @"2";
    VC.m_dic = self.m_quanquanDic;
    [self.navigationController pushViewController:VC animated:YES];

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
//    return 2;
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    BOOL expand = [self isSection:section];
    
    if ( expand ) {
        
        if ( section == 0 ) {
            
            return self.m_shopList.count;
            
        }else{
            
//            return 3;
            
            return 0;

        }
        
    }else {
        
        return 0;
        
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 44)];
    tempView.backgroundColor = [UIColor whiteColor];
    
    // 显示名称
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200, 34)];

    if ( section == 0 ) {
        
        label.text = @"可支持使用的店铺";

    }
    
//    else{
//        
//        label.text = @"查看领取券券的成员";
//
//    }
    
//    label.textColor = RGBACKTAB;
    label.font = [UIFont systemFontOfSize:14.0f];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentLeft;
    [tempView addSubview:label];
    
    
    // 根据字典里的值显示按钮勾选的状态
    //    NSMutableSet *expandedSectionsSet = [self.m_dic objectForKey:[NSNumber numberWithInteger:section]];
    
    
    // 添加按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, WindowSizeWidth, 44);
    [btn addTarget:self action:@selector(headerClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = section;
    [tempView addSubview:btn];
    
    // 添加箭头变化的图片
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(WindowSizeWidth - 30, 17, 16, 10)];
    
    BOOL expand = [self isSection:section];
    
    // 判断是展开还是闭合
    if ( expand ) {
        
        imgV.image = [UIImage imageNamed:@"arrow_L_up.png"];
        
    } else {
        
        imgV.image = [UIImage imageNamed:@"arrow_L_down.png"];
        
    }
    
    
    [tempView addSubview:imgV];
    
    
    return tempView;
     
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"MactQuanDetailCellIdentifier";
    
    MactQuanDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"hh_shopListCell" owner:self options:nil];
        
        cell = (MactQuanDetailCell *)[nib objectAtIndex:2];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    // 赋值
    if ( indexPath.section == 0 ) {
        
        cell.m_imageV.hidden = YES;
        cell.m_name.hidden = YES;
        cell.m_shopName.hidden = NO;
        
        if ( self.m_shopList.count != 0 ) {
            
            NSDictionary *dic = [self.m_shopList objectAtIndex:indexPath.row];
            
            cell.m_shopName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopName"]];
            
        }
        
    }
    
//    else{
//        
//        cell.m_imageV.hidden = NO;
//        cell.m_name.hidden = NO;
//        cell.m_shopName.hidden = YES;
//        
//        
//    }

    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 53.0f;
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
//            [self.m_SectionsSet removeAllObjects];
//            
//            [self.m_SectionsSet addObject:[NSNumber numberWithInteger:section]];
            
            // 如果展开全部的数据则写下面这行代码
            [self.m_SectionsSet addObject:[NSNumber numberWithInteger:section]];
            
            
        }
        
    }else{
        // 如果展开全部的数据则写下面这行代码
        [self.m_SectionsSet removeObject:[NSNumber numberWithInteger:section]];
        
        // 首先是只显示一个点击展开的列表-即删除数据
//        [self.m_SectionsSet removeAllObjects];
        
    }
        
}

- (void)headerClicked:(id)sender{
    
    // button的tag值
    UIButton *btn = (UIButton *)sender;
    
//    sectionIndex = btn.tag;
    
    // bool值判断哪个section是展开还是合起来的
    BOOL expand = [self isSection:btn.tag];
    
    [self setSection:btn.tag expand:!expand];
    
    // 刷新tableView 展开全部的列表的话则就刷新某一行
//    [self.m_tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.m_tableView reloadData];
    
    
}


@end
