//
//  HH_CateChooseViewController.m
//  HuiHui
//
//  Created by mac on 14-11-21.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "HH_CateChooseViewController.h"

#import "ChoosecategoryCell.h"

@interface HH_CateChooseViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_headerView;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@end

@implementation HH_CateChooseViewController

@synthesize m_haderList;

@synthesize m_categoryList;

@synthesize m_count;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_haderList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_categoryList = [[NSMutableArray alloc]initWithCapacity:0];
        
        searchHelper = [[SearchRecordsHelper alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"分类选择"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    NSLog(@"m_categoryList = %@,m_haderList = %@",self.m_categoryList,self.m_haderList);
    
    
    self.m_count = self.m_haderList.count;
    
    NSLog(@"count = %i",self.m_count);
    
    // 设置tableView的headerView
    [self getCategory];
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
    
    // 根据个数来判断是否更换了类别，从而返回上一级来判断是否要重新请求数据刷新数据
    if ( self.m_count == [searchHelper categoryList].count ) {
       
        Appdelegate.m_isCategory = YES;
        
    }else{
        
        Appdelegate.m_isCategory = NO;
    }
    
    [self goBack];
    
}

- (void)getCategory{
    
    // 先清空view里面的所有控件
    for (id view in self.m_headerView.subviews) {
        [view removeFromSuperview];
    }
    
    int BtnW = 70;
    int BtnWS = 6;
    int BtnX = 10;
    
    int BtnH = 30;
    int BtnHS = 10;
    int BtnY = 10;
    
    int i = 0;
    
    for (i = 0; i < [self.m_haderList count]; i++ ) {
        
        NSDictionary *dic = [self.m_haderList objectAtIndex:i];
       
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((BtnW+BtnWS) * (i%4) + BtnX , (BtnH+BtnHS) *(i/4) + BtnY, BtnW, BtnH);
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [btn setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"bd_14.png"] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(deleteCategory:) forControlEvents:UIControlEventTouchUpInside];
        
        // 前四个不能点击删除
        if ( i < 4 ) {
            
            btn.enabled = NO;
            
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
 
            
        }else{
            
            btn.enabled = YES;
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        }
        
        [self.m_headerView addSubview:btn];
        
    }
    
    int index = self.m_haderList.count;
    
    self.m_headerView.backgroundColor = [UIColor clearColor];
    
    int count = index % 4 == 0 ? index / 4 : index / 4 + 1;
    
    int getEndImageYH = (BtnH + BtnHS) * count;
    
    // 计算view的坐标
    self.m_headerView.frame = CGRectMake(self.m_headerView.frame.origin.x, self.m_headerView.frame.origin.y, self.m_headerView.frame.size.width, getEndImageYH + 10);
    
    // 设置tableView的headerView
    self.m_tableView.tableHeaderView = self.m_headerView;
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.m_categoryList.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    ChoosecategoryCellIdentifier
    
    static NSString *cellIdentifier = @"ChoosecategoryCellIdentifier";
    
    ChoosecategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ChoosecategoryCell" owner:self options:nil];
        
        cell = (ChoosecategoryCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if ( self.m_categoryList.count != 0 ) {
        
        NSDictionary *dic = [self.m_categoryList objectAtIndex:indexPath.row];
        
        cell.m_titleLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        
        cell.m_addTitleBtn.tag = indexPath.row;
        
        [cell.m_addTitleBtn addTarget:self action:@selector(addCategory:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    return cell;
    
    
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 30)];
    label.text = @"  其他分类";
    label.backgroundColor = [UIColor lightGrayColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14.0f];
    
    return label;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ( section == 0 ) {
        
        return 30.0f;
        
    }else{
        
        return 0.0f;
    }
    
}

#pragma mark - BtnClicked
- (void)addCategory:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSDictionary *dic = [self.m_categoryList objectAtIndex:btn.tag];
    
    // 添加到headerView上面的数组里，分类里删除该数据
    [self.m_haderList addObject:dic];
    
    [self.m_categoryList removeObject:dic];
    
    // 重新设置，刷新列表
    [self getCategory];
    
    [self.m_tableView reloadData];
    
    // 保存分类的数据
    [searchHelper updatecategoryList:self.m_haderList];
    [searchHelper updateUncategoryList:self.m_categoryList];
    

}

- (void)deleteCategory:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    // 默认第一个不可以删除
    if ( btn.tag != 0 ) {
        
        NSDictionary *dic = [self.m_haderList objectAtIndex:btn.tag];
        
        // 添加到headerView上面的数组里，分类里删除该数据
        [self.m_categoryList addObject:dic];
        
        [self.m_haderList removeObject:dic];
        
        // 重新设置，刷新列表
        [self getCategory];
        
        [self.m_tableView reloadData];
        
        // 保存分类的数据
        [searchHelper updatecategoryList:self.m_haderList];
        
        [searchHelper updateUncategoryList:self.m_categoryList];
    }
    
}

@end
