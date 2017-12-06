//
//  EnterViewController.m
//  baozhifu
//
//  Created by 冯海强 on 14-3-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "EnterViewController.h"
#import "EnterCell.h"
#import "SVProgressHUD.h"
#import "AppHttpClient.h"
#import "CommonUtil.h"
#import "DetailViewController.h"
#import "IncomeoneViewController.h"
#import "PBaseViewController.h"
#import "BprodetailViewController.h"
#import "WwebViewController.h"
#import "HuiViewController.h"

@interface EnterViewController ()

@end

@implementation EnterViewController

@synthesize m_BusinessArray;

@synthesize m_ToolArray;

@synthesize BlagDictinary;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_BusinessArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_ToolArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        BlagDictinary = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        [m_ToolArray  addObject:@"我的微网站"];
        [m_ToolArray  addObject:@"我的APP"];


        [BlagDictinary setObject:[NSMutableSet set] forKey:[NSNumber numberWithInt:self.m_tableView.tag]];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 初始化每一个tableview的所有分区的开关状态字典
    

    if ([self.PorB isEqualToString:@"1"])
    {

        [self setTitle:@"分享的产品"];
        
    }else if ([self.PorB isEqualToString:@"2"])
    {
        [self setTitle:@"分享的商户"];

        
    }
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    [self setRightButtonWithTitle:@"新增" action:@selector(addBusinesserInCome:)];
    
}

- (void)leftClicked{
    
    [self goBack];
    
}



- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
}

//默认打开
-(void)initopen
{
    int sectionIndex = 1;
    
    // bool值判断那个section是展开还是合起来的
    BOOL expand = [self isSection:sectionIndex ExpandOfTableView:self.m_tableView];
    
    [self setSection:sectionIndex tableView:self.m_tableView expand:YES];
    
    // 刷新tableView
    [self.m_tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
    
    // 判断选中的是第几个区域来进行图片的动画
    if ( sectionIndex == 0 ) {
        
        if ( expand ) {
            
            self.m_imageView1.image = [UIImage imageNamed:@"bd_04@2x.png"];
            
        }else{
            
            self.m_imageView1.image = [UIImage imageNamed:@"bd_05@2x.png"];
            
        }
        
    }else if ( sectionIndex == 1 ) {
        
        if ( expand ) {
            
            self.m_imageView1.image = [UIImage imageNamed:@"bd_04@2x.png"];
            
        }else{
            
            self.m_imageView1.image = [UIImage imageNamed:@"bd_05@2x.png"];
            
        }
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    if ([self.PorB isEqualToString:@"1"])
    {
        page=1;//请求产品需要页数；
        
        //是否是商户
        [self Ismerchant];
        self.m_titlelabel.text=@"分享的产品";
        
    }else if ([self.PorB isEqualToString:@"2"])
    {
        
        [self requestMerchantList];
        
    }
    
}


//会员状态
-(void)Ismerchant
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MemberMerchantList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"merchantInfo"];
            if (metchantShop == nil || metchantShop.count == 0) {
                
                status =@"Noenter";//没入驻
                
                return;
            } else {
                
                for (int i=0; i<metchantShop.count; i++)
                {
                    NSMutableDictionary *dic = [metchantShop objectAtIndex:i];
                    if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"Status"]]isEqualToString:@"Contracted"]) {
                        status =@"sign";//已签约
                        [self requestservicelist];
                        return;
                    }
                }
                
                status =@"Nosign";//没签约
                
            }
            
        }
        else
        {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}



//产品列表
-(void)requestservicelist
{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
        
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
//                           [NSString stringWithFormat:@"%d",page],@"pageIndex",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MemberServiceList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {

            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"memberSerivceInfo"];
            if (metchantShop == nil || metchantShop.count == 0) {
                [self.m_BusinessArray removeAllObjects];
                return;
            } else {
                self.m_BusinessArray = metchantShop;
                [self.m_tableView reloadData];
                
                [self initopen];
            }
            
        }
        else
        {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }

    } failure:^(NSError *error) {
        if (page > 1) {
            page--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    
    }];
    
}



// 请求数据(商户)
- (void)requestMerchantList{
    
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MemberMerchantList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"merchantInfo"];
            if (metchantShop == nil || metchantShop.count == 0) {
                [self.m_BusinessArray removeAllObjects];
                return;
            } else {
                self.m_BusinessArray = metchantShop;
                [self.m_tableView reloadData];
                
                [self initopen];

            }
            
        }
        else
        {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
    
}



#pragma mark - UITableViewDataSource
//区块
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    int count = [self numberOfRowsInSection:tableView Section:section];
        
    return count;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    
    UITableViewCell *cell = [self CommonTableView:tableView cellForRowAtIndexPath:indexPath];
    
    
    return cell;
        
}

- (UITableViewCell *)CommonTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"EnterCellCellIdentifier";
    
    EnterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EnterCell" owner:self options:nil];
        
        cell = (EnterCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

        
    }
 
    if ( indexPath.section == 0 ) {
        
        cell.m_NameLabel.hidden = YES;
        
        cell.BL_Name.hidden = NO;
        
        cell.BL_faren.hidden = NO;
        
        cell.BL_states.hidden = NO;
        
        cell.BL_Data.hidden = NO;
        
        if ( self.m_BusinessArray.count != 0 ) {
            
            NSDictionary *dic = [self.m_BusinessArray objectAtIndex:indexPath.row];

            if ([self.PorB isEqualToString:@"1"])
            {
                //产品赋值；

                    cell.BL_Data.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"ShelfTime"]];
                    
                    if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"Status"]] isEqualToString:@"SVCProjecting"])
                    {
                        cell.BL_states.text=@"开发中";
                    }else if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"Status"]] isEqualToString:@"SVCSelling"])
                    {
                        cell.BL_states.text=@"销售中";
                        cell.BL_states.textColor=[UIColor colorWithRed:0.6 green:0.9  blue:0.35 alpha:1.0f];
                    }else if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"Status"]] isEqualToString:@"SVCAuditing"])
                    {
                        cell.BL_states.text=@"审核中";
                        cell.BL_states.textColor=[UIColor colorWithRed:0.8 green:0.85  blue:0.25 alpha:1.0f];
                        
                    }
                    else if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"Status"]] isEqualToString:@"SVCPasted"])
                    {
                        cell.BL_states.text=@"已过期";
                        cell.BL_states.textColor=[UIColor colorWithRed:1 green:0.3  blue:0.2 alpha:1.0f];
                    }else if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"Status"]] isEqualToString:@"SVCSelled"])
                    {
                        cell.BL_states.text=@"已售完";
                        cell.BL_states.textColor=[UIColor colorWithRed:1 green:0  blue:0 alpha:1.0f];
                    }else if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"Status"]] isEqualToString:@"SVCUnder"])
                    {
                        cell.BL_states.text=@"已下架";
                        cell.BL_states.textColor=[UIColor colorWithRed:1 green:0  blue:0 alpha:1.0f];
                    }
                    else if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"Status"]] isEqualToString:@"FeedBack"])
                    {
                        cell.BL_states.text=@"返回";
                        cell.BL_states.textColor=[UIColor colorWithRed:1 green:0  blue:0 alpha:1.0f];
                    }
                    else if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"Status"]] isEqualToString:@"SVCViolation"])
                    {
                        cell.BL_states.text=@"违规";
                        cell.BL_states.textColor=[UIColor colorWithRed:1 green:0  blue:0 alpha:1.0f];
                    }
                    cell.BL_Name.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"SvcName"]];
                    
                    float aaa= [[NSString stringWithFormat:@"%@",[dic objectForKey:@"CommissionRate"]] floatValue];
                    float bbb=(aaa/100)*[[NSString stringWithFormat:@"%@",[dic objectForKey:@"Price"]] floatValue];
                    cell.BL_faren.text =[NSString stringWithFormat:@"%@(返利:%0.2f)",[NSString stringWithFormat:@"%@",[dic objectForKey:@"Price"]],bbb];
                    
                
            }else if ([self.PorB isEqualToString:@"2"])
            {
                
                // 赋值
                cell.BL_Data.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ModifyDate"]];
                cell.BL_faren.text = [NSString stringWithFormat:@"%@(%@)",[dic objectForKey:@"OfficialContactsPhone"],[dic objectForKey:@"OfficialContacts"]];
                cell.BL_Name.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AllName"]];
                cell.BL_states.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"StatusName"]];
                if ([cell.BL_states.text isEqualToString:@"审核中"])
                {
                    cell.BL_states.textColor=[UIColor colorWithRed:0.85 green:0.85  blue:0.25 alpha:1.0f];
                }else if ([cell.BL_states.text isEqualToString:@"已签约"])
                {
                    cell.BL_states.textColor=[UIColor colorWithRed:0.5 green:0.9  blue:0.35 alpha:1.0f];
                }else if ([cell.BL_states.text isEqualToString:@"冻结"])
                {
                    cell.BL_states.textColor=[UIColor colorWithRed:1 green:0.3  blue:0.2 alpha:1.0f];
                }else if ([cell.BL_states.text isEqualToString:@"已退回"])
                {
                    cell.BL_states.textColor=[UIColor colorWithRed:1 green:0  blue:0 alpha:1.0f];
                }
                
            }

            
        }
        
    }else if (indexPath.section == 1 ){
        
        if ( self.m_ToolArray.count != 0 ) {
            
            cell.m_NameLabel.hidden = NO;
            
            cell.BL_Name.hidden = YES;
            
            cell.BL_faren.hidden = YES;
            
            cell.BL_states.hidden = YES;
            
            cell.BL_Data.hidden = YES;
            
            cell.m_NameLabel.text = [self.m_ToolArray objectAtIndex:indexPath.row];
            
        }
        
    }
        
    
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 45)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg_sousuo.png"]];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 310, 23)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label.font = [UIFont systemFontOfSize:16.0f];
    [view addSubview:label];
    
    // button
    UIButton *l_button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 45)];
    l_button.backgroundColor = [UIColor clearColor];
    [l_button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    // ImageView
    
    self.m_imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(290, 18, 16, 10)];
    self.m_imageView1.image = [UIImage imageNamed:@"bd_04@2x.png"];
    self.m_imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(290, 18, 16, 10)];
    self.m_imageView2.image = [UIImage imageNamed:@"bd_04@2x.png"];

    l_button.tag = section;
    [l_button addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:l_button];
    
        if ( section == 0 ) {
            
            if ([self.PorB isEqualToString:@"1"])
            {
                label.text = @"我的产品";
                [view addSubview:self.m_imageView1];
                return view;
                
            }else if ([self.PorB isEqualToString:@"2"])
            {
                
                label.text = @"我的商户";
                [view addSubview:self.m_imageView1];
                return view;
            }
            else
            {
                return nil;
            }

            
        }else if (section == 1 ){
            
            label.text = @"我的工具";
            [view addSubview:self.m_imageView1];
            return view;
            
        }else {
            
            return nil;
        }

    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 0 ) {
        
        if ([self.PorB isEqualToString:@"1"]){//是分享产品
            
            BprodetailViewController*BproDetailVC=[[BprodetailViewController alloc]initWithNibName:@"BprodetailViewController" bundle:nil];
            
            BproDetailVC.ProDic=[self.m_BusinessArray objectAtIndex:indexPath.row];
            
            if ([[BproDetailVC.ProDic objectForKey:@"Status"] isEqualToString:@"SVCProjecting"]) {
                BproDetailVC.ProductStatus=@"1";//开发中
            }
            else if ([[BproDetailVC.ProDic objectForKey:@"Status"] isEqualToString:@"SVCAuditing"])
            {
                BproDetailVC.ProductStatus=@"2";//审核中
            }
            else if ([[BproDetailVC.ProDic objectForKey:@"Status"] isEqualToString:@"SVCSelling"])
            {
                BproDetailVC.ProductStatus=@"3";//销售中
            }
            else if ([[BproDetailVC.ProDic objectForKey:@"Status"] isEqualToString:@"SVCPasted"])
            {
                BproDetailVC.ProductStatus=@"4";//已过期
            }
            else if ([[BproDetailVC.ProDic objectForKey:@"Status"] isEqualToString:@"SVCSelled"])
            {
                BproDetailVC.ProductStatus=@"5";//已售完
            }
            else if ([[BproDetailVC.ProDic objectForKey:@"Status"] isEqualToString:@"SVCUnder"])
            {
                BproDetailVC.ProductStatus=@"6";//已下架
            }
            else if ([[BproDetailVC.ProDic objectForKey:@"Status"] isEqualToString:@"FeedBack"])
            {
                BproDetailVC.ProductStatus=@"7";//退回
            }
            else if ([[BproDetailVC.ProDic objectForKey:@"Status"] isEqualToString:@"SVCViolation"])
            {
                BproDetailVC.ProductStatus=@"8";//违规
            }
            [self .navigationController pushViewController:BproDetailVC animated:YES];
            
            
        }else if ([self.PorB isEqualToString:@"2"]){//是商户入驻
            
            DetailViewController*DetailVC=[[DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:nil];
            
            DetailVC.faxDic=[self.m_BusinessArray objectAtIndex:indexPath.row];
            
            if ([[DetailVC.faxDic objectForKey:@"StatusName"] isEqualToString:@"完善中"]&&[[DetailVC.faxDic objectForKey:@"Status"] isEqualToString:@"Projecting"]) {
                DetailVC.Iscanchange=@"1";
            }else  if ([[DetailVC.faxDic objectForKey:@"StatusName"] isEqualToString:@"审核中"]&&[[DetailVC.faxDic objectForKey:@"Status"] isEqualToString:@"Processing"]) {
                DetailVC.Iscanchange=@"2";
            }
            else if ([[DetailVC.faxDic objectForKey:@"StatusName"] isEqualToString:@"已签约"]&&[[DetailVC.faxDic objectForKey:@"Status"] isEqualToString:@"Contracted"]) {
                DetailVC.Iscanchange=@"3";
            }
            else  if ([[DetailVC.faxDic objectForKey:@"StatusName"] isEqualToString:@"冻结"]&&[[DetailVC.faxDic objectForKey:@"Status"] isEqualToString:@"Stop"]) {
                DetailVC.Iscanchange=@"4";
            }
            else if ([[DetailVC.faxDic objectForKey:@"StatusName"] isEqualToString:@"已退回"]&&[[DetailVC.faxDic objectForKey:@"Status"] isEqualToString:@"Returned"]) {
                DetailVC.Iscanchange=@"5";
            }
            
            [self .navigationController pushViewController:DetailVC animated:YES];
            
        }

    }else if ( indexPath.section == 1 ){
        
        if (indexPath.row==0)
        {
            
            WwebViewController *webVC=[[WwebViewController alloc]initWithNibName:@"WwebViewController" bundle:nil];
            
            [self.navigationController pushViewController:webVC animated:YES];
            
        }else if (indexPath.row==1)
        {
            HuiViewController *HuiVC=[[HuiViewController alloc]initWithNibName:@"HuiViewController" bundle:nil];
            
            [self.navigationController pushViewController:HuiVC animated:YES];

        }
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 45.0f;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 53.0f;
}

// 判断是否展开
- (BOOL)isSection:(int)section ExpandOfTableView:(UITableView*)tableView{
    
    BOOL result = NO;
    
    NSMutableSet *expandedSectionsSet = [BlagDictinary objectForKey:[NSNumber numberWithInt:tableView.tag]];
    
    
    if ( [expandedSectionsSet containsObject:[NSNumber numberWithInt:section]] ) {
        result = YES;
    }
    
    return result;
}

// 展开的section保存到expandedSectionsSet里面
- (void)setSection:(int)section tableView:(UITableView*)tableView expand:(BOOL)expand{
    
    NSMutableSet *expandedSectionsSet = [BlagDictinary objectForKey:[NSNumber numberWithInt:tableView.tag]];
    
    if ( expand ) {
        
        if ( ![expandedSectionsSet containsObject:[NSNumber numberWithInt:section]] ) {
            
            [expandedSectionsSet addObject:[NSNumber numberWithInt:section]];
        }
        
    }else{
        
        [expandedSectionsSet removeObject:[NSNumber numberWithInt:section]];
        
    }
    
}

// 返回行数
- (int)numberOfRowsInSection:(UITableView *)Tableview Section:(NSInteger)section{
    
    BOOL expand = [self isSection:section ExpandOfTableView:Tableview];
    
    if ( expand ) {
        
        if ( section == 0 ) {
            
            return self.m_BusinessArray.count;
            
        }else {
            
            return self.m_ToolArray.count;
            
        } 
    }
    else {
        if ( section == 0 ) {
            
            return 0;
            
        }else{
            
            return 0;
        }
    }
}


#pragma mark - button click
-(void)headerClick:(id)sender{
    // button的tag值
    int sectionIndex = ((UIButton*)sender).tag;
    
    // bool值判断那个section是展开还是合起来的
    BOOL expand = [self isSection:sectionIndex ExpandOfTableView:self.m_tableView];
    
    [self setSection:sectionIndex tableView:self.m_tableView expand:!expand];
    
    // 刷新tableView
    [self.m_tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
    
    // 判断选中的是第几个区域来进行图片的动画
    if ( sectionIndex == 0 ) {
        
        if ( expand ) {
            
            self.m_imageView1.image = [UIImage imageNamed:@"bd_04@2x.png"];
            
        }else{
            
            self.m_imageView1.image = [UIImage imageNamed:@"bd_05@2x.png"];
            
        }

    }else if ( sectionIndex == 1 ) {
        
        if ( expand ) {
            
            self.m_imageView1.image = [UIImage imageNamed:@"bd_04@2x.png"];
            
        }else{
            
            self.m_imageView1.image = [UIImage imageNamed:@"bd_05@2x.png"];
            
        }
    }
}



-(IBAction)addBusinesserInCome:(id)sender
{
    
    IncomeoneViewController*incomeVC=[[IncomeoneViewController alloc]initWithNibName:@"IncomeoneViewController" bundle:nil];
    
    PBaseViewController*PBaseVC=[[PBaseViewController alloc]initWithNibName:@"PBaseViewController" bundle:nil];
    
    if ([self.PorB isEqualToString:@"1"]){//是分享产品
        
        if ([status isEqualToString:@"Noenter"]) {//没入驻
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提醒"
                                                               message:@"您还没有入驻商户,暂时不能分享产品!!!"
                                                              delegate:self
                                                     cancelButtonTitle:@"暂不分享"
                                                     otherButtonTitles:@"立即入驻", nil];
            
            alertView.tag = 100001;
            [alertView show];
            
        }
        else if ([status isEqualToString:@"sign"]){//已签约
            
            [self .navigationController pushViewController:PBaseVC animated:YES];
        }
        else if ([status isEqualToString:@"Nosign"]){//未签约
            
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提醒"
                                                               message:@"您的所有商户都没有签约成功,如果您已经提交商户审核请耐心等待\n请提交商户审核,我们将尽快为您办理!!!"
                                                              delegate:self
                                                     cancelButtonTitle:@"暂不分享"
                                                     otherButtonTitles:@"完善商户", nil];
            
            alertView.tag = 100002;
            [alertView show];
            
        }
        
    }else if ([self.PorB isEqualToString:@"2"]){//是商户入驻
        
        [self .navigationController pushViewController:incomeVC animated:YES];
    }

}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        IncomeoneViewController*incomeVC=[[IncomeoneViewController alloc]initWithNibName:@"IncomeoneViewController" bundle:nil];
    
    if ( alertView.tag == 100001 ) {
        
        if ( buttonIndex == 1 ) {
            
            [self .navigationController pushViewController:incomeVC animated:YES];

        }
    }
    else if (alertView.tag == 100002)
    {
        if ( buttonIndex == 1 ) {
            
            self.PorB = @"2";
            self.m_titlelabel.text=@"入驻的商户";
            [self requestMerchantList];
        }
    }
}





@end
