//
//  ShopCartViewController.m
//  HuiHui
//
//  Created by mac on 13-11-20.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "ShopCartViewController.h"

#import "ShopCartCell.h"

#import "ConfirmOrderViewController.h"

#import "ProductDetailViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "AppDelegate.h"

@interface ShopCartViewController () {

    NSString *rukou;
    
}

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (strong, nonatomic) IBOutlet UIView *m_footerView;

@property (weak, nonatomic) IBOutlet UIButton *m_ckeckedBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_totalPriceLabel;

@property (weak, nonatomic) IBOutlet UIButton *m_delegateBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_submitBtn;

@property (weak, nonatomic) IBOutlet UIView *m_emptyView;

// 去逛逛按钮触发的事件
- (IBAction)goShopping:(id)sender;

// 全选按钮触发的事件
- (IBAction)checkedAllProducts:(id)sender;
// 删除按钮触发的事件
- (IBAction)deleteProduct:(id)sender;
// 结算按钮触发的事件
- (IBAction)submitProducts:(id)sender;


@end

@implementation ShopCartViewController

@synthesize m_SelectedDic;

@synthesize m_ProductList;

@synthesize m_selectedArray;

@synthesize m_countDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.isCheckedAll = NO;
        
        m_SelectedDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_ProductList = [[NSMutableArray alloc]initWithCapacity:0];

        m_selectedArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_countDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    rukou = @"normal";
    
    [self setTitle:@"购物车"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
  
    
    // 设置按钮和字体的颜色
    [self setButtonValue];
    
    self.m_tableView.hidden = YES;
    
    self.m_footerView.hidden = YES;
    
    self.m_emptyView.hidden = YES;
    
   
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self.m_selectedArray removeAllObjects];
    
    // 请求数据
    [self requestSubmit];
    
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
    
    [self goBack];
}


#pragma makr - NetWorking  删除商品的时候请求数据
- (void)deleteProductRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *shopId = @"";
    
    for (int i = 0; i < [self.m_selectedArray count]; i ++) {
        
        NSMutableDictionary *dic = [self.m_selectedArray objectAtIndex:i];
        
        NSString *string = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ShopCarId"]];
        
        if ( i == self.m_selectedArray.count - 1 ) {
            
            shopId = [shopId stringByAppendingString:[NSString stringWithFormat:@"%@",string]];
            
        }else{
            
            shopId = [shopId stringByAppendingString:[NSString stringWithFormat:@"%@,",string]];

        }
        
        
    }
        
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",shopId],@"shopCarId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"BuyCarDelete.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 清空数组
            [self.m_selectedArray removeAllObjects];
            
            // 重新设置下删除和合计的状态
            [self setButtonValue];
            
            // 重新请求数据刷新列表
            [self requestSubmit];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}

#pragma makr - NetWorking 购物车列表数据请求
- (void)requestSubmit{
    
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
    [httpClient request:@"BuyCarList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
//            NSString *msg = [json valueForKey:@"msg"];
            
//            [SVProgressHUD showSuccessWithStatus:msg];
            
            [SVProgressHUD dismiss];
            
            [self.m_SelectedDic removeAllObjects];

            [self.m_ProductList removeAllObjects];
            
            NSLog(@"json = %@",json);
            
            self.m_ProductList = [json valueForKey:@"shopCarInfo"];
            
            if ( self.m_ProductList.count != 0 ) {
                
                self.m_tableView.hidden = NO;
                
                self.m_footerView.hidden = NO;
                
                self.m_emptyView.hidden = YES;
                
                for (int i = 0; i < self.m_ProductList.count; i ++) {
                    
                    NSMutableDictionary *dic = [self.m_ProductList objectAtIndex:i];
                    
                    [self.m_SelectedDic setValue:@"0" forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ShopCarId"]]];
                    
                    // 将数量存储在一个字典中
                    [self.m_countDic setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Amount"]] forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceId"]]];
                    
                }
                
                // 重新设置下删除和合计的状态
                [self setButtonValue];
                
                [self.m_tableView reloadData];
                
            }else{
                
                self.m_tableView.hidden = YES;
                
                self.m_footerView.hidden = YES;
                
                self.m_emptyView.hidden = NO;
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

#pragma mark - NetWorking 请求数据生成订单的数据请求
- (void)requestOrderSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *shopId = @"";
    
    for (int i = 0; i < [self.m_selectedArray count]; i ++) {
        
        NSMutableDictionary *dic = [self.m_selectedArray objectAtIndex:i];
        
        NSString *string = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ShopCarId"]];
        
        if ( i == self.m_selectedArray.count - 1 ) {
            
            shopId = [shopId stringByAppendingString:[NSString stringWithFormat:@"%@",string]];
            
        }else{
            
            shopId = [shopId stringByAppendingString:[NSString stringWithFormat:@"%@,",string]];
            
        }
        
        
    }
        
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",shopId],@"shopCarId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    NSLog(@"params = %@,shopId = %@",param,shopId);
    
    [httpClient request:@"SubOrder.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSLog(@"json = %@",json);
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD dismiss];
            
            
            // ==== 进行保存该商品是否支持支付宝支付 0：不支持；1：支持
//            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[l_dic valueForKey:@"IsAlipay"]] andKey:kIsAlipay];
            
            
            NSString *orderId = [NSString stringWithFormat:@"%@",msg];
            
            // 进入确认订单的界面
            ConfirmOrderViewController *VC = [[ConfirmOrderViewController alloc]initWithNibName:@"ConfirmOrderViewController" bundle:nil];
            VC.m_productList = self.m_selectedArray;
            VC.m_countDictionary = self.m_countDic;
          
            VC.rukou = rukou;

            
            VC.m_orderId = [NSString stringWithFormat:@"%@",orderId];
            
            VC.m_typeString = @"1";
            [self.navigationController pushViewController:VC animated:YES];

        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

    
    
}

#pragma mark - NetWorking 加入购物车请求数据
- (void)addShopCartSubmit:(NSString *)aCount withServiceId:(NSString *)aServiceId{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    //  type	标示字段1：加入购物车，2:增加或减少数量

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",aCount],@"amount",
                           [NSString stringWithFormat:@"%@",aServiceId],@"serviceId",
                           @"2",@"type",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"BuyCarAdd.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
//            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD dismiss];
            
            // 保存数量的字典
            [self.m_countDic setValue:aCount forKey:[NSString stringWithFormat:@"%@",aServiceId]];
            
            // 刷新列表
            [self.m_tableView reloadData];
            
            // 重新设置价钱
            [self setButtonValue];
            
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.m_ProductList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ShopCartCellIdentifier";
    
    ShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
    
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopCartCell" owner:self options:nil];
        
        cell = (ShopCartCell *)[nib objectAtIndex:0];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if ( self.m_ProductList.count != 0 ) {
        
        
        NSMutableDictionary *dic = [self.m_ProductList objectAtIndex:indexPath.row];
        
        
        // 赋值
        cell.m_productName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceName"]];
        cell.m_pirceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Price"]];
        cell.m_orignPrice.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"OldPric"]];
        
        NSString *serviceId = [dic objectForKey:@"ServiceId"];
        
        NSString *count = [self.m_countDic objectForKey:[NSString stringWithFormat:@"%@",serviceId]];
        
        cell.m_countTextField.text = [NSString stringWithFormat:@"%@",count];
        
        // 图片赋值
        [cell setImageView:[dic objectForKey:@"ServiceLog"]];

        CGSize size = [cell.m_pirceLabel.text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 16) lineBreakMode:NSLineBreakByWordWrapping];
        
        CGSize size1 = [cell.m_orignPrice.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 15) lineBreakMode:NSLineBreakByWordWrapping];
        
        cell.m_pirceLabel.frame = CGRectMake(cell.m_pirceLabel.frame.origin.x, cell.m_pirceLabel.frame.origin.y, size.width, 16);
        
        cell.m_orignPrice.frame = CGRectMake(cell.m_pirceLabel.frame.origin.x + size.width + 10, cell.m_orignPrice.frame.origin.y, size1.width, 15);
        
        cell.m_lineLabel.frame = CGRectMake(cell.m_pirceLabel.frame.origin.x + size.width + 5, cell.m_lineLabel.frame.origin.y, size1.width + 7, 1);
        
        // 添加按钮的tag值及选择事件
        cell.m_checkBtn.tag = indexPath.row;
        
        [cell.m_checkBtn addTarget:self action:@selector(chooseOneProduct:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.m_minuBtn.tag = indexPath.row;
        
        cell.m_plusBtn.tag = indexPath.row;
        
        // 判断数量，当数量为1时不可点击减少的按钮
        if ( [count isEqualToString:@"1"] ) {
            
            cell.m_minuBtn.userInteractionEnabled = NO;

        }else{
            
            cell.m_minuBtn.userInteractionEnabled = YES;

        }
        
        [cell.m_minuBtn addTarget:self action:@selector(minuClicked:) forControlEvents:UIControlEventTouchUpInside];
        
         [cell.m_plusBtn addTarget:self action:@selector(plusClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.m_countTextField.delegate = self;
        
        cell.m_countTextField.tag = indexPath.row;
        
        NSString *shopId = [dic objectForKey:@"ShopCarId"];
        
        NSString *string = [self.m_SelectedDic objectForKey:[NSString stringWithFormat:@"%@",shopId]];
        
        // 判断是否全选
        if ( [string isEqualToString:@"0"] ) {
            
            cell.m_checkBtn.selected = NO;
            
        }else{
            
            cell.m_checkBtn.selected = YES;
            
        }

    }
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 106.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *dic = [self.m_ProductList objectAtIndex:indexPath.row];
    
    // 进入商品详情
    ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
    VC.m_productId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceId"]];
    VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantShopId"]];
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self showNumPadDone:nil];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

     ShopCartCell *cell = (ShopCartCell *)[self.m_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0]];
    
    cell.m_countTextField.text = textField.text;
    
    [self.m_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - BtnClicked
- (IBAction)checkedAllProducts:(id)sender {
    
    self.isCheckedAll = !self.isCheckedAll;
    
    // 先清空数据后加入
    [self.m_selectedArray removeAllObjects];
        
    for (int i = 0; i < self.m_ProductList.count; i++) {
        
        NSMutableDictionary *dic = [self.m_ProductList objectAtIndex:i];

        if ( self.isCheckedAll ) {
            
            self.m_ckeckedBtn.selected = YES;
            
            [self.m_SelectedDic setValue:@"1" forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ShopCarId"]]];
            
            // 将数据添加到字典里面
            [self.m_selectedArray addObject:dic];
            
            
        }else{
            
            self.m_ckeckedBtn.selected = NO;
            
            [self.m_SelectedDic setValue:@"0" forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ShopCarId"]]];
            
            // 删除所有的数据
            [self.m_selectedArray removeAllObjects];
        }         
    }
    
    // 设置按钮和字体的颜色
    [self setButtonValue];
    
    [self.m_tableView reloadData];

}

- (IBAction)deleteProduct:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"确定删除该商品？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 10235;
    [alertView show];
  
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 10235 ) {
        if ( buttonIndex == 1 ) {
            // 确定取消某个商品进行请求数据
            [self deleteProductRequest];
        }else{
            
            
        }
    }
    
}

- (IBAction)submitProducts:(id)sender {
    
    if ( self.m_selectedArray.count == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择要购买的商品！"];
        
        return;
    }
    
    // 请求数据生成订单id
    [self requestOrderSubmit];
    
}

- (void)chooseOneProduct:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_ProductList objectAtIndex:btn.tag];
            
    if ( btn.selected ) {
        
        [self.m_SelectedDic setValue:@"0" forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ShopCarId"]]];
        
        NSString *shopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ShopCarId"]];
        
        for (int i = 0; i < self.m_selectedArray.count; i ++) {
            NSMutableDictionary *l_dic = [self.m_selectedArray objectAtIndex:i];
            NSString *l_shopId = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"ShopCarId"]];
          
            if ( [l_shopId isEqualToString:shopId] ) {
                
                [self.m_selectedArray removeObject:l_dic];
            }
            
        }
                     
    }else{
        
        [self.m_SelectedDic setValue:@"1" forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ShopCarId"]]];

        // 添加对应的数据
        [self.m_selectedArray addObject:dic];

    }
    
    // 判断如果选中的按钮等于全选的话，则全选的按钮被选中，反之未选中
    if ( self.m_selectedArray.count == self.m_ProductList.count ) {
                
        self.m_ckeckedBtn.selected = YES;
        
        self.isCheckedAll = YES;
    
    }else{
        
        self.m_ckeckedBtn.selected = NO;
        
        self.isCheckedAll = NO;

    }
    
    // 设置按钮和字体的颜色
    [self setButtonValue];
        
    [self.m_tableView reloadData];
}

- (void)setButtonValue {
    
    if ( self.m_selectedArray.count == 0 ) {
        
        self.m_delegateBtn.enabled = NO;
        
        self.m_totalPriceLabel.text = @"0.00";
        
        self.m_totalPriceLabel.textColor = [UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:1.0];
        
    }else{
            
        float totalPrice = 0.00;
        
        for (int i = 0; i < self.m_selectedArray.count; i++) {
            
            NSMutableDictionary *dic = [self.m_selectedArray objectAtIndex:i];
                        
            NSString *price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Price"]];
            
            NSString *serviceId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceId"]];
            
            NSString *productCount =  [self.m_countDic objectForKey:serviceId];
            
            totalPrice = totalPrice + ([price floatValue] * [productCount intValue]);
            
            
        }
        
        self.m_delegateBtn.enabled = YES;
        
        self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f",totalPrice];
        
        self.m_totalPriceLabel.textColor = [UIColor colorWithRed:252/255.0 green:127/255.0 blue:35/255.0 alpha:1.0];
    }

}

- (void)minuClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
        
    ShopCartCell *cell = (ShopCartCell *)[self.m_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag inSection:0]];
    
    self.m_selectedIndex = [cell.m_countTextField.text integerValue];
        
    cell.m_plusBtn.userInteractionEnabled = YES;
    
    cell.m_plusBtn.backgroundColor  = [UIColor  clearColor];
    
    self.m_selectedIndex = self.m_selectedIndex - 1;
    
    if ( self.m_selectedIndex == 1 ) {
        
        cell.m_minuBtn.userInteractionEnabled = NO;
        
        cell.m_minuBtn.backgroundColor  = [UIColor  clearColor];
        
    }else{
        
        cell.m_minuBtn.userInteractionEnabled = YES;
        
        cell.m_minuBtn.backgroundColor = [UIColor  clearColor];
        
    }
        
    NSMutableDictionary *dic = [self.m_ProductList objectAtIndex:btn.tag];
    
    NSString *count = [NSString stringWithFormat:@"%i",self.m_selectedIndex];
    
    NSString *serviceId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceId"]];
    
    // 请求数据
    [self addShopCartSubmit:count withServiceId:serviceId];
    
  
}

- (void)plusClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
        
    ShopCartCell *cell = (ShopCartCell *)[self.m_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag inSection:0]];
    
    self.m_selectedIndex = [cell.m_countTextField.text integerValue];
    
    cell.m_minuBtn.userInteractionEnabled = YES;
    
    cell.m_minuBtn.backgroundColor  = [UIColor clearColor];
    
    self.m_selectedIndex = self.m_selectedIndex + 1;
       
    cell.m_plusBtn.userInteractionEnabled = YES;
    
    cell.m_plusBtn.backgroundColor  = [UIColor  clearColor];
        
    NSMutableDictionary *dic = [self.m_ProductList objectAtIndex:btn.tag];
    
    NSString *count = [NSString stringWithFormat:@"%i",self.m_selectedIndex];
    
    NSString *serviceId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceId"]];
    
    // 请求数据
    [self addShopCartSubmit:count withServiceId:serviceId];

}

- (IBAction)goShopping:(id)sender {
    
    Appdelegate.isSelectgoShopping = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
