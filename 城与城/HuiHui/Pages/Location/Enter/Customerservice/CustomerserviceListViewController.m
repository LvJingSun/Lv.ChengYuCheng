//
//  CustomerserviceListViewController.m
//  HuiHui
//
//  Created by fenghq on 15/9/17.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "CustomerserviceListViewController.h"
#import "CustomerserviceListTableViewCell.h"
#import "EditorCustomerservicerViewController.h"

@interface CustomerserviceListViewController ()<UITableViewDataSource,UITableViewDelegate,EditorCustomerdelelegate>

@property (weak, nonatomic) IBOutlet UITableView *CustomerserviceListtableview;
@property (nonatomic, strong) NSMutableArray    *M_ServiceList;

@end

@implementation CustomerserviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.M_ServiceList = [[NSMutableArray alloc]initWithCapacity:0];
    self.CustomerserviceListtableview.delegate = self;
    self.CustomerserviceListtableview.dataSource = self;
    
    self.HHBase_emptyLabel.hidden = NO;
    self.CustomerserviceListtableview.hidden = YES;
    [self setExtraCellLineHidden:self.CustomerserviceListtableview];
    [self setTitle:@"客服列表"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    [self setRightButtonWithTitle:@"新增" action:@selector(AddNewCustomer)];
    
    [self requestCustomerServiceList];
    
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.M_ServiceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"CustomerserviceListTableViewCell";
    CustomerserviceListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CustomerserviceListTableViewCell" owner:self options:nil];
        cell = (CustomerserviceListTableViewCell *)[nib objectAtIndex:0];
    }
    
    NSDictionary *dic = [self.M_ServiceList objectAtIndex:indexPath.row];
    NSString *status = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Status"]];
    if ([status isEqualToString:@"1"]) {
        cell.Status.hidden = YES;
    }else
    {
        cell.Status.hidden = NO;
    }
    cell.Name.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RealName"]];
    cell.Phone.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Account"]];

    [cell.ImageV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[dic objectForKey:@"PhotoSmlUrl"]]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 80;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableDictionary *dic = [self.M_ServiceList objectAtIndex:indexPath.row];
    EditorCustomerservicerViewController *VC = [[EditorCustomerservicerViewController alloc]initWithNibName:@"EditorCustomerservicerViewController" bundle:nil];
    VC.CustomerType = @"2";
    VC.CustomerDIC = dic;
    VC.delegate = self;
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

//新增
- (void)AddNewCustomer
{
    EditorCustomerservicerViewController *VC = [[EditorCustomerservicerViewController alloc]initWithNibName:@"EditorCustomerservicerViewController" bundle:nil];
    VC.CustomerType = @"1";
    VC.delegate = self;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - UINetWork
- (void)requestCustomerServiceList{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  nil];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"GetCustomerServiceList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            self.M_ServiceList = [json valueForKey:@"CustomerServiceList"];
            
            if ( self.M_ServiceList.count != 0 ) {
                
                self.CustomerserviceListtableview.hidden = NO;
                
                [self.CustomerserviceListtableview reloadData];
                
                self.HHBase_emptyLabel.hidden = YES;
                
            }else{
                
                self.HHBase_emptyLabel.hidden = NO;
                
                self.CustomerserviceListtableview.hidden = YES;
            }
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

- (void)EditorCustomeraction;
{
    [self requestCustomerServiceList];

}

@end
