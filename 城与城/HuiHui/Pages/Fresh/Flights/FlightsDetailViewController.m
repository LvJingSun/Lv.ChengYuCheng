//
//  FlightsDetailViewController.m
//  HuiHui
//
//  Created by mac on 14-12-10.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "FlightsDetailViewController.h"

#import "CommonUtil.h"

#import "FlightsDetailCell.h"

#import "FlightsFillOrdersViewController.h"

@interface FlightsDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *m_dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_airLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_airCompany;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_distanceLabel;

@end

@implementation FlightsDetailViewController

@synthesize m_dic;

@synthesize m_list;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_list = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 设置导航栏的标题
    NSString *string = [NSString stringWithFormat:@"%@→%@",[self.m_dic objectForKey:@"dptCity"],[self.m_dic objectForKey:@"arrCity"]];
    
    [self setTitle:string];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftCilcked)];
    
    
    // 赋值
    // 将日期转换成星期几来进行赋值
    NSString *dateString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"dptDate"]];
    
    self.m_dateLabel.text = [NSString stringWithFormat:@"%@",[self getDate:dateString]];
    
    self.m_timeLabel.text = [NSString stringWithFormat:@"%@-%@",[self.m_dic objectForKey:@"dptTime"],[self.m_dic objectForKey:@"arrTime"]];
    
    self.m_airLabel.text = [NSString stringWithFormat:@"%@-%@",[self.m_dic objectForKey:@"dptCodeName"],[self.m_dic objectForKey:@"arrCodeName"]];
    
    self.m_airCompany.text = [NSString stringWithFormat:@"%@%@",[self.m_dic objectForKey:@"airlineCompany"],[self.m_dic objectForKey:@"flightNum"]];

    self.m_distanceLabel.text = [NSString stringWithFormat:@"飞行%@|相距%@公里",[self.m_dic objectForKey:@"flightTime"],[self.m_dic objectForKey:@"distance"]];

    // 默认隐藏tableView
    self.m_tableView.hidden = YES;
    
    // 隐藏多余的线
    [self setExtraCellLineHidden:self.m_tableView];

    // 请求数据
    [self requestDetailSubmit];
   
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

- (void)leftCilcked{
    
    [self goBack];
}


#pragma mark - UINetWorking 请求数据
- (void)requestDetailSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient1];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"dptCity"]], @"dptCity",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"arrCity"]],@"arrCity",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"dptDate"]],@"dptDate",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"flightNum"]],@"flightNum",
                           memberId,@"memberId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestFlights:@"QunarQbSearch.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
                
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            // 赋值
            self.m_list = [json valueForKey:@"xiangxi"];
            
            // 显示列表
            self.m_tableView.hidden = NO;
            
            if ( self.m_list.count != 0 ) {
                
//                self.m_emptyLabel.hidden = YES;
                
                // 刷新列表
                [self.m_tableView reloadData];
                
                
            }else{
                
                // 没有数据的情况下
//                self.m_tableView.hidden = YES;
                
//                self.m_emptyLabel.hidden = NO;
                
//                self.m_emptyLabel.text = @"没有搜索结果";
            }
            

            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
//            self.m_tableView.hidden = YES;
//            
//            self.m_emptyLabel.hidden = NO;
//            
//            self.m_emptyLabel.text = [NSString stringWithFormat:@"%@",msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"failed:%@", error);
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_list.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"FlightsXiangCellIdentifier";
    
    FlightsXiangCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FlightsDetailCell" owner:self options:nil];
        
        cell = (FlightsXiangCell *)[nib objectAtIndex:1];
    }
    
    // 赋值
    if ( self.m_list.count != 0 ) {
        
        NSDictionary *dic = [self.m_list objectAtIndex:indexPath.row];
        
        cell.m_supplyName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"supplierName"]];

        cell.m_price.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"hhDiscountPrice"]];
        
        // 判断折扣的，大于10表示原价，小于10表示是经济舱打几折
        NSString *discount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"discount"]];
        
        if ( [discount floatValue] < 10.00 ) {
            
            cell.m_cabin.text = [NSString stringWithFormat:@"经济舱%@折",discount];
            
        }else{
            
            cell.m_cabin.text = @"";
        }
        

    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableDictionary *dic = [self.m_list objectAtIndex:indexPath.row];
    
    // 进入机票下单的页面
    FlightsFillOrdersViewController *VC = [[FlightsFillOrdersViewController alloc]initWithNibName:@"FlightsFillOrdersViewController" bundle:nil];
    VC.m_dic = dic;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70.0f;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
