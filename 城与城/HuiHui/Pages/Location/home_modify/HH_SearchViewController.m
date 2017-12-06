//
//  HH_SearchViewController.m
//  HuiHui
//
//  Created by mac on 14-11-10.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "HH_SearchViewController.h"

#import "HH_searchCell.h"

#import "HH_ProductListViewController.h"


@interface HH_SearchViewController ()

@property (strong, nonatomic) IBOutlet UIView *m_headerView;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (strong, nonatomic) IBOutlet UIView *m_footerView;

// 清空所有的搜索记录
- (IBAction)cleanSearchRecords:(id)sender;

@end

@implementation HH_SearchViewController

@synthesize m_searchList;

@synthesize m_searchRecordsList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        m_searchList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_searchRecordsList = [[NSMutableArray alloc]initWithCapacity:0];
        
        searchHelper = [[SearchRecordsHelper alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"搜索"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    // 初始化热门搜索的数组
    self.m_searchList = [NSMutableArray arrayWithObjects:@"酸菜鱼",@"火锅",@"自助餐",@"酒店",@"蛋糕",@"电影", nil];
    
    // 添加tableView的headerView
    [self getHotSearch];
    
    
   
    // 设置导航栏上的搜索框
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 270, 40)];
    view.backgroundColor = [UIColor clearColor];
    
    // 背景图片
    UIImageView *backImgV = [[UIImageView alloc]initWithFrame: CGRectMake(0, 3, 220, 34)];
    backImgV.backgroundColor = [UIColor whiteColor];
    backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
    backImgV.layer.borderWidth = 1.0f;
    backImgV.layer.cornerRadius = 10.0f;
    
    [view addSubview:backImgV];
    
    // 搜索的图片
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"skin_searchbar_icon.png"]];
    imgView.frame = CGRectMake(5, 13, 12, 14);
    [view addSubview:imgView];
    
    // 搜索框
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(22, 6, 200, 30)];
    field.backgroundColor = [UIColor clearColor];
    field.returnKeyType = UIReturnKeyDone;
    field.font = [UIFont systemFontOfSize:14.0f];
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    field.placeholder = @"请输入商品名称";
    field.delegate = self;
    self.m_textField = field;
    
    [view addSubview:field];
    
    // 搜索按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(225, 6, 40, 30);
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    [btn.titleLabel setTextColor:[UIColor whiteColor]];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    
    self.navigationItem.titleView = view;
    
    
    // 从数据库中读取数据
    self.m_searchRecordsList = [searchHelper searchRecordList];
    
    if ( self.m_searchRecordsList.count != 0 ) {
        
        // 设置tableView的footerView
        self.m_tableView.tableFooterView = self.m_footerView;
        
    }else{
        
        // 设置tableView的footerView
        self.m_tableView.tableFooterView = nil;
        
    }
    
    // 刷新列表
    [self.m_tableView reloadData];

    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
    
    [self.m_textField resignFirstResponder];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self.m_textField resignFirstResponder];
    
    [self goBack];
    
}

// 将数据保存到数组里面，然后进入下一级搜索的商品列表页面
- (void)getSearching:(NSString *)aString{
    
    // 将搜索的内容添加到数组里-先判断数组里是否已经存在这个搜索的关键字,如果不存在的话则直接添加进来，否则不添加
    if ( ![self.m_searchRecordsList containsObject:aString] ) {
        
        // 判断数组是否有值
        if ( self.m_searchRecordsList.count == 0 ) {
            
            [self.m_searchRecordsList addObject:aString];
            
        }else{
            
            [self.m_searchRecordsList insertObject:aString atIndex:0];
            
        }
        
        
        [searchHelper upDateSearch:self.m_searchRecordsList];
        
        // 刷新列表
        [self.m_tableView reloadData];
        
    }
    
    if ( self.m_searchRecordsList.count != 0 ) {
        
        // 设置tableView的footerView
        self.m_tableView.tableFooterView = self.m_footerView;
        
    }else{
        
        // 设置tableView的footerView
        self.m_tableView.tableFooterView = nil;
        
    }
    
    // 进入搜索的商品列表页面
    HH_ProductListViewController *VC = [[HH_ProductListViewController alloc]initWithNibName:@"HH_ProductListViewController" bundle:nil];
    VC.m_serchString = [NSString stringWithFormat:@"%@",aString];
    [self.navigationController pushViewController:VC animated:YES];

}

// 搜索按钮触发的事件
- (void)searchClick{
    
    [self.m_textField resignFirstResponder];
    
    NSLog(@"return");
    
    if ( self.m_textField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入要搜索的内容"];
        
        return;
    }
    
    // 搜索内容保存
    [self getSearching:[NSString stringWithFormat:@"%@",self.m_textField.text]];
    
}

- (void)getHotSearch{
    
    float sum = 0.0f;
    
    int i = 0;
    
    int width = (WindowSizeWidth - 50)/3;
    
    for (i = 0; i < [self.m_searchList count]; i++ ) {
      
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((width + 10) * (i%3) + 10, 45 * (i/3) + 30, width, 35);
        [btn setTitle:[NSString stringWithFormat:@"%@",[self.m_searchList objectAtIndex:i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"bd_14.png"] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
        btn.titleLabel.textColor = [UIColor blackColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        
        [self.m_headerView addSubview:btn];
      
    }
    
    int index = 0;
 
     index =  self.m_searchList.count % 3 == 0 ? self.m_searchList.count / 3 : self.m_searchList.count / 3 + 1;
    
    sum = (35 + 10) * index;
    
    // 设置headerView的大小
    self.m_headerView.frame = CGRectMake(self.m_headerView.frame.origin.x, self.m_headerView.frame.origin.y, self.m_headerView.frame.size.width, sum + 30);
    
    // 设置tableView的headerView
    self.m_tableView.tableHeaderView = self.m_headerView;
    
}

- (void)btnClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSLog(@"tag = %i,title = %@",btn.tag,btn.titleLabel.text);
    
    // 按钮点击搜索后进行保存数据
    [self getSearching:[NSString stringWithFormat:@"%@",btn.titleLabel.text]];
   
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if ( self.m_searchRecordsList.count != 0 ) {
        
        return self.m_searchRecordsList.count + 1;

    }else{
        
        return 0;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( self.m_searchRecordsList.count != 0 ) {
        
        if ( indexPath.row == 0 ) {
            
            static NSString *cellIdentifier = @"HH_searchCellIdentifier";
            
            HH_searchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_searchCell" owner:self options:nil];
                
                cell = (HH_searchCell *)[nib objectAtIndex:0];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            // 赋值
            cell.m_nameLabel.text = @"搜索历史";
            
            return cell;
            
        }else{
            
            static NSString *cellIdentifier = @"HH_searchListCellIdentifier";
            
            HH_searchListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_searchCell" owner:self options:nil];
                
                cell = (HH_searchListCell *)[nib objectAtIndex:1];
                
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                
            }
            
            if ( self.m_searchRecordsList.count != 0 ) {
                
                // 赋值
                cell.m_searchName.text = [NSString stringWithFormat:@"%@",[self.m_searchRecordsList objectAtIndex:indexPath.row - 1]];
            }
            
            return cell;
            
        }

    }else{
        
        return nil;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( self.m_searchRecordsList.count != 0 ) {
        
        if ( indexPath.row == 0 ) {
            
            return 30.0f;
            
        }else{
            
            return 44.0f;
            
        }

    }else{
        
        return 0.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ( indexPath.row != 0 ) {
        
        // 进入搜索的商品列表页面
        HH_ProductListViewController *VC = [[HH_ProductListViewController alloc]initWithNibName:@"HH_ProductListViewController" bundle:nil];
        VC.m_serchString = [NSString stringWithFormat:@"%@",[self.m_searchRecordsList objectAtIndex:indexPath.row -1]];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (IBAction)cleanSearchRecords:(id)sender {
    
    [self.m_textField resignFirstResponder];
    
    // 清空数组里的数据
    if ( [searchHelper deleteSearchList] ) {
        
        // 数组重新赋值
        self.m_searchRecordsList = [searchHelper searchRecordList];
        
        // 刷新列表
        [self.m_tableView reloadData];
        
        // 设置tableView的footerView
        self.m_tableView.tableFooterView = nil;
        // 清空搜索框里的内容
        self.m_textField.text = @"";
    }

}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ( textField == self.m_textField ) {
        
        [self hiddenNumPadDone:nil];
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"return");
    
    // 调用搜索按钮触发的事件
    [self searchClick];
    
    [textField resignFirstResponder];
    
    return YES;
}


@end
