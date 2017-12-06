//
//  HH_CardListViewController.m
//  HuiHui
//
//  Created by mac on 15-6-4.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  

#import "HH_CardListViewController.h"

#import "MyCardCell.h"

#import "HH_TakeOrderViewController.h"
#import "CPSHH_TakeOrderViewController.h"

@interface HH_CardListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;
@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@end

@implementation HH_CardListViewController

@synthesize m_array;

@synthesize m_SectionsSet;

@synthesize m_merchantId;

@synthesize m_selectSeat;

@synthesize m_shopList;

@synthesize isWaimai;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_array = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_SectionsSet = [[NSMutableSet alloc]init];

        m_shopList = [[NSMutableArray alloc]initWithCapacity:0];

    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"我的会员卡商品"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"点单" action:@selector(rightClicked)];
    
//    self.m_array = [NSMutableArray arrayWithObjects:@"美甲",@"养生",@"护肤",@"按摩", nil];
    
    self.m_emptyLabel.hidden = YES;
    self.m_tableView.hidden = YES;
    
    // 请求数据
    [self menuRequest];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
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

- (void)rightClicked{
    
    if ( self.m_selectSeat.length != 0 ) {
        
        CPSHH_TakeOrderViewController *VCC = [[CPSHH_TakeOrderViewController alloc]init];
        [VCC.m_dic setObject:self.m_shopList forKey:@"m_shopList"];
        [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",self.m_selectSeat] forKey:@"m_seat"];
        [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",self.m_ModelType] forKey:@"m_ModelType"];
        [VCC.m_dic setObject:self.m_merchantId forKey:@"m_merchantId"];
        [VCC.m_dic setObject:self.isWaimai forKey:@"IsZCWaiMai"];
        [self.navigationController pushViewController:VCC animated:YES];
     
        // 进入点菜的页面
//        HH_TakeOrderViewController *VC = [[HH_TakeOrderViewController alloc]initWithNibName:@"HH_TakeOrderViewController" bundle:nil];
//        VC.m_shopList = self.m_shopList;
//        VC.m_seat = [NSString stringWithFormat:@"%@",self.m_selectSeat];
//        VC.m_ModelType = [NSString stringWithFormat:@"%@",self.m_ModelType];
//        VC.m_merchantId = self.m_merchantId;
//        VC.IsZCWaiMai = self.isWaimai;
//        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        
        [self alertWithMessage:@"本商户还没有开通云菜单功能"];
        
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.m_array.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    BOOL expand = [self isSection:section];
    
    if ( expand ) {
        
        if ( self.m_array.count != 0 ) {
            
            NSDictionary *dic = [self.m_array objectAtIndex:section];
            
            NSMutableArray *arr = [dic objectForKey:@"RecordsList"];
            
            return arr.count;
            
        }
        
        return self.m_array.count;
        
    }else {
        
        return 0;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"AccountProductCellIdentifier";
    
    AccountProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MyCardCell" owner:self options:nil];
        
        cell = (AccountProductCell *)[nib objectAtIndex:2];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
   
    
    // 赋值
    if ( self.m_array.count != 0 ) {
        
        NSDictionary *dic = [self.m_array objectAtIndex:indexPath.section];
        
        NSMutableArray *arr = [dic objectForKey:@"RecordsList"];
        
        if ( arr.count != 0 ) {
            
            NSDictionary *l_dic = [arr objectAtIndex:indexPath.row];
            
            cell.m_name.text = [NSString stringWithFormat:@"%@份",[l_dic objectForKey:@"Amount"]];
            cell.m_time.text = [NSString stringWithFormat:@"使用时间:%@",[l_dic objectForKey:@"UseDate"]];
            
            cell.m_time.backgroundColor = [UIColor clearColor];
            
            cell.m_time.frame = CGRectMake(WindowSizeWidth - cell.m_time.frame.size.width - 40, cell.m_time.frame.origin.y, cell.m_time.frame.size.width, cell.m_time.frame.size.height);
        }

    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    
    if ( self.m_array.count != 0 ) {
        
        NSDictionary *dic = [self.m_array objectAtIndex:section];

        
        UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 44)];
        tempView.backgroundColor = [UIColor whiteColor];
        
        // 显示名称
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200, 34)];
        
        label.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuName"]];
        
        //    label.textColor = RGBACKTAB;
        label.font = [UIFont systemFontOfSize:14.0f];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        [tempView addSubview:label];
        
        
        
        
        
      
        
        
        // 显示副标题
        UILabel *subLabel = [[UILabel alloc]initWithFrame:CGRectMake(WindowSizeWidth - 80, 5, 40, 34)];
        
        subLabel.text = [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"UsedAmount"],[dic objectForKey:@"MenuAmount"]];
        
        subLabel.textColor = RGBACKTAB;
        subLabel.font = [UIFont systemFontOfSize:12.0f];
        subLabel.backgroundColor = [UIColor clearColor];
        subLabel.textAlignment = NSTextAlignmentRight;
        [tempView addSubview:subLabel];
        
        
        // 显示名称
        UILabel *label_1 = [[UILabel alloc]initWithFrame:CGRectMake(subLabel.frame.origin.x - 100, 5, 100, 34)];
        
        label_1.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CreateDate"]];
        
        label_1.textColor = [UIColor lightGrayColor];
        label_1.font = [UIFont systemFontOfSize:12.0f];
        label_1.backgroundColor = [UIColor clearColor];
        label_1.textAlignment = NSTextAlignmentRight;
        [tempView addSubview:label_1];
        
        
        // 添加按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, WindowSizeWidth, 44);
        [btn addTarget:self action:@selector(headerClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = section;
        [tempView addSubview:btn];
        
        // 添加箭头变化的图片
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(WindowSizeWidth - 30, 17, 16, 10)];
        
        BOOL expand = [self isSection:section];
        
        // 根据使用的份数来判断按钮的显示图片
        if ( [[dic objectForKey:@"UsedAmount"]isEqualToString:@"0"] ) {
            
            imgV.image = [UIImage imageNamed:@""];
            
        }else{
            
            // 判断是展开还是闭合
            if ( expand ) {
                
                imgV.image = [UIImage imageNamed:@"arrow_L_up.png"];
                
            } else {
                
                imgV.image = [UIImage imageNamed:@"arrow_L_down.png"];
                
            }
            
        }
        
        [tempView addSubview:imgV];

        
        return tempView;

        
    }else{
        
        
        return nil;

    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
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

#pragma mark - UINetWork
- (void)menuRequest{
    
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
                           self.m_merchantId,@"merchantId",nil];
    
    NSLog(@"params = %@",param);
    
    [httpClient request:@"MyOrderNoUsed.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
       
        if (success) {
            
            NSLog(@"json = %@",json);
            
            [SVProgressHUD dismiss];
            
            self.m_array = [json valueForKey:@"orderDetailList"];
            
            if ( self.m_array.count != 0 ) {
                
                self.m_emptyLabel.hidden = YES;
                self.m_tableView.hidden = NO;
                
                [self.m_tableView reloadData];
                
            }else{
                
                self.m_emptyLabel.hidden = NO;
                self.m_tableView.hidden = YES;
                
                self.m_emptyLabel.text = @"暂时没有数据";
                
            }
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
 
    
}



@end
