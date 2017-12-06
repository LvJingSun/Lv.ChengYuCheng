//
//  AddressDetailViewController.m
//  HuiHui
//
//  Created by mac on 15-2-15.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "AddressDetailViewController.h"

#import "AddressListCell.h"

#import "AddAddressViewController.h"

@interface AddressDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@end

@implementation AddressDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_index = 0;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"地址详情"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"修改" action:@selector(modifyAddress)];
    
    
    NSLog(@"dic = %@",self.m_dic);
    
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

- (void)modifyAddress{
    
    // 进入修改收货地址的页面
    AddAddressViewController *VC = [[AddAddressViewController alloc]initWithNibName:@"AddAddressViewController" bundle:nil];
    VC.m_stringType = @"2";
    VC.m_dic = self.m_dic;
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 0 ) {
        
        static NSString *cellIdentifier = @"addressDetailCellIdentifier";
        
        AddressDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AddressListCell" owner:self options:nil];
            
            cell = (AddressDetailCell *)[nib objectAtIndex:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        // 赋值
        cell.m_name.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"LinkName"]];

        cell.m_phone.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"LinkPhone"]];
       
        cell.m_code.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"PostalCode"]];
        
        cell.m_province.text = [NSString stringWithFormat:@"%@%@%@",[self.m_dic objectForKey:@"ProvinceName"],[self.m_dic objectForKey:@"CityName"],[self.m_dic objectForKey:@"AreaName"]];
        
        cell.m_area.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Address"]];
        
        
        return cell;
        
    }else{
        
        // 删除的cell
        
        static NSString *cellIdentifier = @"AddressDeleteCellIdentifier";
        
        AddressDeleteCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AddressListCell" owner:self options:nil];
            
            cell = (AddressDeleteCell *)[nib objectAtIndex:2];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            
            // 设置按钮的坐标
            cell.m_deleteBtn.frame = CGRectMake(10, 7, WindowSizeWidth - 20, cell.m_deleteBtn.frame.size.height);
            
//            cell.m_defaultBtn.frame = CGRectMake((WindowSizeWidth - 40)/2 + 30, 7, (WindowSizeWidth - 40)/2, cell.m_defaultBtn.frame.size.height);
            
        }
        
        // 添加按钮点击事件
        [cell.m_deleteBtn addTarget:self action:@selector(deleteAddress) forControlEvents:UIControlEventTouchUpInside];

//        [cell.m_defaultBtn addTarget:self action:@selector(defaultAddress) forControlEvents:UIControlEventTouchUpInside];
        

        
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 0 ) {
        
        return 260.0f;
        
    }else{
        
        return 60.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0.000001f;
        
    }
    
    return 10.0f;

}

#pragma mark - BtnClicked
- (void)defaultAddress{
    
    // 设置为默认地址
    
    [SVProgressHUD showErrorWithStatus:@"设置默认地址"];
    
}

- (void)deleteAddress{
    
//    [SVProgressHUD showErrorWithStatus:@"删除地址"];

    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"您确定删除该收货地址？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 14532;
    
    [alertView show];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 14532 ) {
        
        if ( buttonIndex == 1 ) {
            
            // 表示删除该地址返回上一级
            [self deleteAddressRequest];
            
            
        }else{
            
            
            
        }
    }
    
    
}

#pragma mark - DeleteAddressRequest
- (void)deleteAddressRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"MemberID",
                           key,@"key",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"AddressID"]],@"AddressID",
                           nil];
    
    NSLog(@"params = %@",param);
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"DeleteCloudMenuAddress.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            
            // 记录是否删除了地址和修改了地址，用于地址列表进行刷新数据
            [CommonUtil addValue:@"1" andKey:ADDRESSMODIFY];
     
            // 删除成功后返回上一个页面
            [self goBack];
            
        }else{
            
            // 记录是否删除了地址和修改了地址，用于地址列表进行刷新数据
            [CommonUtil addValue:@"0" andKey:ADDRESSMODIFY];
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        // 记录是否删除了地址和修改了地址，用于地址列表进行刷新数据
        [CommonUtil addValue:@"0" andKey:ADDRESSMODIFY];
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

    
}

@end
