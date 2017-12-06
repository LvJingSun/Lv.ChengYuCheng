//
//  ChooseAddressViewController.m
//  HuiHui
//
//  Created by mac on 15-8-14.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "ChooseAddressViewController.h"

#import "AddressListCell.h"

#import "AddAddressViewController.h"

#import "AddressDetailViewController.h"

#import "MyAddressListViewController.h"


@interface ChooseAddressViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;


@end

@implementation ChooseAddressViewController

@synthesize m_addressList;

@synthesize m_dic;

@synthesize m_addressId;

@synthesize delegate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_addressList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"选择送货地址"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"管理地址" action:@selector(addAddressClicked)];
    
    self.m_emptyLabel.hidden = YES;
    
    // 去掉tableView上面多余的分割线
    [self setExtraCellLineHidden:self.m_tableView];
    
    // 请求地址列表的数据
//    [self submitorderRequest];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 请求数据
    [self submitorderRequest];
    
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
    
    // 当地址数据被删除了的情况下
    // 判断新赋值的数组里面是否包含之前选择的地址id，如果不包含，则默认选择地址列表的第一个
//    NSMutableArray *l_array = [[NSMutableArray alloc]initWithCapacity:0];
//    
//    for (int i = 0; i < self.m_addressList.count; i++) {
//        
//        NSDictionary *dic = [self.m_addressList objectAtIndex:i];
//        
//        NSString *addressID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AddressID"]];
//        
//        [l_array addObject:addressID];
//        
//    }
    
//    if ( l_array.count != 0 ) {
//        
//        if ( ![l_array containsObject:self.m_addressId] ) {
//            
//            [CommonUtil addValue:@"1" andKey:@"chooseAddressKey"];
//            
//            [self goBack];
//            
//        }else{
//            
//            [CommonUtil addValue:@"1" andKey:@"chooseAddressKey"];
//            
//            [self goBack];
//
//        }
//
//    }else{
//        
//        [CommonUtil addValue:@"1" andKey:@"chooseAddressKey"];
//        
//        [self goBack];
//        
//    }

    
    [CommonUtil addValue:@"1" andKey:@"chooseAddressKey"];
    
    [self goBack];
    
    
}

// 添加新地址按钮触发的事件
- (void)addAddressClicked{

    // 进入到我的地址列表的页面
    MyAddressListViewController *VC = [[MyAddressListViewController alloc]initWithNibName:@"MyAddressListViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_addressList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"AddressListCellIdentifier";
    
    ChooseAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AddressListCell" owner:self options:nil];
        
        cell = (ChooseAddressCell *)[nib objectAtIndex:3];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    // 赋值
    if ( self.m_addressList.count != 0 ) {
        
        NSDictionary *dic = [self.m_addressList objectAtIndex:indexPath.row];
        
        cell.m_name.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"LinkName"]];
        cell.m_phone.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"LinkPhone"]];
        
        
        // 判断是否是默认地址
        NSString *isDefault = [NSString stringWithFormat:@"%@",[dic objectForKey:@"IsDefault"]];
        
        if ( [isDefault isEqualToString:@"1"] ) {
            
            
            cell.m_address.text = [NSString stringWithFormat:@"[默认地址]%@%@%@%@",[dic objectForKey:@"ProvinceName"],[dic objectForKey:@"CityName"],[dic objectForKey:@"AreaName"],[dic objectForKey:@"Address"]];
            
//            cell.m_name.textColor = [UIColor redColor];
//            cell.m_phone.textColor = [UIColor redColor];
//            cell.m_address.textColor = [UIColor redColor];
            
        }else{
            
            
            cell.m_address.text = [NSString stringWithFormat:@"%@%@%@%@",[dic objectForKey:@"ProvinceName"],[dic objectForKey:@"CityName"],[dic objectForKey:@"AreaName"],[dic objectForKey:@"Address"]];
            
//            cell.m_name.textColor = [UIColor blackColor];
//            cell.m_phone.textColor = [UIColor blackColor];
//            cell.m_address.textColor = [UIColor blackColor];
            
        }
        
        // 判断勾选第几个
        NSString *string = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AddressID"]];

        
        if ( [string isEqualToString:self.m_addressId] ) {
            
            cell.m_gouxuanImagV.hidden = NO;

        }else{
            
            cell.m_gouxuanImagV.hidden = YES;

        }
        
        
        CGSize size = [cell.m_address.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 20, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        cell.m_address.frame = CGRectMake(cell.m_address.frame.origin.x, cell.m_address.frame.origin.y, WindowSizeWidth - 40, size.height);
        
        cell.m_line.frame = CGRectMake(cell.m_line.frame.origin.x, cell.m_address.frame.origin.y + size.height + 9, cell.m_line.frame.size.width, cell.m_line.frame.size.height);
        
        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, 35 + size.height + 10);
        
        
        cell.m_phone.frame = CGRectMake(WindowSizeWidth - cell.m_phone.frame.size.width - 40, cell.m_phone.frame.origin.y, cell.m_phone.frame.size.width, cell.m_phone.frame.size.height);
            
        
        cell.m_gouxuanImagV.frame = CGRectMake(WindowSizeWidth - cell.m_gouxuanImagV.frame.size.width - 10, cell.m_gouxuanImagV.frame.origin.y, cell.m_gouxuanImagV.frame.size.width, cell.m_gouxuanImagV.frame.size.height);
        
    }
    
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    return 60.0f;
    
    NSDictionary *dic = [self.m_addressList objectAtIndex:indexPath.row];
    
    // 判断是否是默认地址
    NSString *string = @"";
    
    NSString *isDefault = [NSString stringWithFormat:@"%@",[dic objectForKey:@"IsDefault"]];
    
    if ( [isDefault isEqualToString:@"1"] ) {
        
        string = [NSString stringWithFormat:@"[默认地址]%@%@%@%@",[dic objectForKey:@"ProvinceName"],[dic objectForKey:@"CityName"],[dic objectForKey:@"AreaName"],[dic objectForKey:@"Address"]];
        
    }else{
        
        string =  [NSString stringWithFormat:@"%@%@%@%@",[dic objectForKey:@"ProvinceName"],[dic objectForKey:@"CityName"],[dic objectForKey:@"AreaName"],[dic objectForKey:@"Address"]];
        
    }
    
    
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    return 35 + size.height + 10;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    // 进入地址详情的页面
//    NSMutableDictionary *dic = [self.m_addressList objectAtIndex:indexPath.row];
//    
//    //    AddressDetailViewController *VC = [[AddressDetailViewController alloc]initWithNibName:@"AddressDetailViewController" bundle:nil];
//    //    VC.m_dic = dic;
//    //    [self.navigationController pushViewController:VC animated:YES];
//    
//    
//    // 进入修改收货地址的页面
//    AddAddressViewController *VC = [[AddAddressViewController alloc]initWithNibName:@"AddAddressViewController" bundle:nil];
//    VC.m_stringType = @"2";
//    VC.m_dic = dic;
//    [self.navigationController pushViewController:VC animated:YES];
    
    NSMutableDictionary *dic = [self.m_addressList objectAtIndex:indexPath.row];
    NSString *addressId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AddressID"]];
    
    self.m_addressId = [NSString stringWithFormat:@"%@",addressId];
    
    [self.m_tableView reloadData];
    
    if ( self.delegate && [self.delegate respondsToSelector:@selector(getAddressDetail:)] ) {
        
        [self.delegate performSelector:@selector(getAddressDetail:) withObject:dic];
        
    }
    
    [self goBack];
    
}

#pragma add Networking
- (void)submitorderRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"CloudMenuAddressList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            // 赋值
            self.m_addressList = [json valueForKey:@"AddressList"];
            
            if ( self.m_addressList.count != 0 ) {
                
                self.m_tableView.hidden = NO;
                self.m_emptyLabel.hidden = YES;
                [self.m_tableView reloadData];
                
            }else{
                
                self.m_emptyLabel.hidden = NO;
                self.m_tableView.hidden = YES;
                
            }
            
        }else{
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}




@end
