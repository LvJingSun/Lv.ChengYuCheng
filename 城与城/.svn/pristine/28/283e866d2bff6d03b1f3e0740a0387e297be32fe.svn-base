//
//  FlightsFillOrdersViewController.m
//  HuiHui
//
//  Created by mac on 14-12-25.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "FlightsFillOrdersViewController.h"

#import "FlightsOrderCell.h"

#import "CommonUtil.h"

#import "FlightsPayViewController.h"


@interface FlightsFillOrdersViewController ()

@property (weak, nonatomic) IBOutlet UILabel *m_cityName;

@property (weak, nonatomic) IBOutlet UILabel *m_price;

@property (weak, nonatomic) IBOutlet UILabel *m_fuelTax;

@property (weak, nonatomic) IBOutlet UILabel *m_date;

@property (weak, nonatomic) IBOutlet UILabel *m_time;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_countPeople;

@property (weak, nonatomic) IBOutlet UILabel *m_totalPrice;


// 提交订单按钮触发的事件
- (IBAction)submitOrder:(id)sender;

@end

@implementation FlightsFillOrdersViewController

@synthesize m_dic;

@synthesize m_contactArray;

@synthesize m_contactString;

@synthesize m_phoneString;

@synthesize m_orderDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_contactArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_orderDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_index = 0;
        
        m_trideIndex = 0;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"订单填写"];
    
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 默认设置为空
    self.m_contactString = @"";
    self.m_phoneString = @"";
    
    // 赋值
    self.m_cityName.text = [NSString stringWithFormat:@"%@-%@",[self.m_dic objectForKey:@"dptCity"],[self.m_dic objectForKey:@"arrCity"]];
    
    // 根据日期计算出星期几
    NSString *dateString = [self getDate:[NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"dptDate"]]];
    
    self.m_date.text = [NSString stringWithFormat:@"%@",dateString];
    self.m_time.text = [NSString stringWithFormat:@"%@-%@",[self.m_dic objectForKey:@"dptTime"],[self.m_dic objectForKey:@"arrTime"]];
    self.m_price.text = [NSString stringWithFormat:@"￥%@",[self.m_dic objectForKey:@"hhDiscountPrice"]];
    self.m_fuelTax.text = [NSString stringWithFormat:@"机建+燃油 ￥%i",[[self.m_dic objectForKey:@"constructionFee"] intValue] + [[self.m_dic objectForKey:@"fuelTax"] intValue]];
    

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

- (void)leftClicked{
    
    [self goBack];
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if ( section == 0 ) {
        
        return 1 + self.m_contactArray.count;
        
    }else{
        
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = nil;
    
    if ( indexPath.section == 0 ) {
        
        if ( self.m_contactArray.count == 0 ) {
            
            if ( indexPath.row == 0 ) {
                // 乘机人
                cell = [self tableViewTride:tableView cellForRowAtIndexPath:indexPath];
           
            }else{
                
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"0"];

            }
            
        }else{
            
            if ( indexPath.row == 0 ) {
                // 乘机人
                cell = [self tableViewTride:tableView cellForRowAtIndexPath:indexPath];
                
            }else{
                // 有联系人的情况下显示联系人的列表
                cell = [self tableViewIdCard:tableView cellForRowAtIndexPath:indexPath];
            
            }
            
        }
        
    }else if ( indexPath.section == 1 ){
        
        
        if ( indexPath.row == 0 ){
            // 联系人
            cell = [self tableViewContact:tableView cellForRowAtIndexPath:indexPath];
            
        }else if ( indexPath.row == 1 ){
            // 手机号
            cell = [self tableViewPhone:tableView cellForRowAtIndexPath:indexPath];
            
        }else{
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"0"];
        }
    }

    
    return cell;

}

- (UITableViewCell *)tableViewTride:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"FlightsOrderCellIdentifier";
    
    FlightsOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FlightsOrderCell" owner:self options:nil];
        
        cell = (FlightsOrderCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    // 乘机人-记录填写了几个乘机人信息
    if ( self.m_contactArray.count != 0 ) {
        
        // 如果数组不为空的话则隐藏按钮不再可以添加乘机人
        cell.m_btn.hidden = YES;
        cell.m_clickBtn.hidden = YES;
    
        
        cell.m_countLabel.hidden = NO;
        
        cell.m_countLabel.text = [NSString stringWithFormat:@"(共%i人)",self.m_contactArray.count];
  
    }else{
        
        // 如果数组为空的话则显示按钮可以添加乘机人
        cell.m_btn.hidden = NO;
        cell.m_clickBtn.hidden = NO;
        
        cell.m_countLabel.hidden = YES;
        
        cell.m_countLabel.text = @"";
        
    }
    
    [cell.m_clickBtn addTarget:self action:@selector(addTride:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.m_btn addTarget:self action:@selector(addTride:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
    
}

- (UITableViewCell *)tableViewContact:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellIdentifier = @"FlightsContactCellIdentifier";
    
    FlightsContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FlightsOrderCell" owner:self options:nil];
        
        cell = (FlightsContactCell *)[nib objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    // 联系人
    cell.m_contactTextField.placeholder = @"请填写联系人姓名";
    
    cell.m_contactTextField.delegate = self;
    // 赋值-如果数组里只有一个数据的时候则将数组的第一值赋值给联系人的信息
    // 字符为空的情况下就从数组里面直接获取第一个联系人的名称
    if ( self.m_contactArray.count == 1 ) {
        
        NSDictionary *dic = [self.m_contactArray objectAtIndex:0];
        
        cell.m_contactTextField.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        
    }else if ( self.m_contactArray.count == 0 ) {
        
        cell.m_contactTextField.text = @"";
    }
    
    self.m_contactField = cell.m_contactTextField;
    
    cell.m_addBtn.hidden = YES;
    
    cell.m_contactTextField.userInteractionEnabled = NO;
    
    // 添加按钮触发的事件
//    [cell.m_addBtn addTarget:self action:@selector(addContactPeople) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (UITableViewCell *)tableViewPhone:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"FlightsPhoneCellIdentifier";
    
    FlightsPhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FlightsOrderCell" owner:self options:nil];
        
        cell = (FlightsPhoneCell *)[nib objectAtIndex:2];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    // 手机号
    cell.m_phoneTextField.placeholder = @"用于接收通知短信";
    
    cell.m_phoneTextField.delegate = self;
    
    self.m_phoneField = cell.m_phoneTextField;
    
    return cell;
    
}

// 联系人信息的cell
- (UITableViewCell *)tableViewIdCard:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"FlightsTrideCellIdentifier";
    
    FlightsIdCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FlightsOrderCell" owner:self options:nil];
        
        cell = (FlightsIdCardCell *)[nib objectAtIndex:3];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    // 赋值
    if ( self.m_contactArray.count != 0 ) {
        
        NSDictionary *dic = [self.m_contactArray objectAtIndex:indexPath.row - 1];
        
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        // 表示身份证
        NSString *typeString = @"";
        if ( [[dic objectForKey:@"cardType"]isEqualToString:@"NI"] ) {
            
            typeString = @"身份证";
            
        }else if ( [[dic objectForKey:@"cardType"]isEqualToString:@"护照"] ) {
            
            typeString = @"护照";
            
        }else if ( [[dic objectForKey:@"cardType"]isEqualToString:@"其他"] ) {
            
            typeString = @"其他";
            
        }
        
        cell.m_idCard.text = [NSString stringWithFormat:@"%@ %@",typeString,[dic objectForKey:@"cardNum"]];

        
        if ( indexPath.row != self.m_contactArray.count ) {
            
            cell.m_imgV.frame = CGRectMake(30, 59, 290, 0.4);
            
        }else{
            
            cell.m_imgV.frame = CGRectMake(15, 59, 305, 0.4);
            
        }
        
        cell.m_deleteBtn.tag = indexPath.row - 1;
        
        [cell.m_deleteBtn addTarget:self action:@selector(deleteIdCard:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 0 ) {
        
        if ( self.m_contactArray.count != 0 ) {
            
            if ( indexPath.row == 0 ) {
                
                return 44.0f;

            }else{
                
                return 60.0f;

            }

        }else{
            
            return 44.0f;

        }
        
    }else{
        
        return 44.0f;

    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ( indexPath.section == 0 ) {
        
        if ( indexPath.row != 0 ) {
            
            m_trideIndex = indexPath.row - 1;
            
            NSMutableDictionary *dic = [self.m_contactArray objectAtIndex:indexPath.row - 1];
            
            // 点击联系人信息进入修改联系人的页面
            Fl_ContactViewController *VC = [[Fl_ContactViewController alloc]initWithNibName:@"Fl_ContactViewController" bundle:nil];
            VC.m_stringType = @"2";
            VC.m_dic = dic;
            VC.delegate = self;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
    
}

#pragma mark - BtnClicked
- (void)addTride:(id)sender{
    // 添加乘机人的信息
    Fl_ContactViewController *VC = [[Fl_ContactViewController alloc]initWithNibName:@"Fl_ContactViewController" bundle:nil];
    VC.m_stringType = @"1";
    VC.delegate = self;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)deleteIdCard:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    m_index = btn.tag;
    
    // 删除联系人
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"确定删除该联系人?"
                                                       message:@""
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 109920;
    [alertView show];
    
}

/*
- (void)addContactPeople{
    
    [self.view endEditing:YES];
    
    // 添加联系人进入系统联系人选择的页面
    
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    
}
 
*/

- (IBAction)submitOrder:(id)sender {
    
    // 提交订单
    if ( self.m_contactArray.count == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"您没有添加任何乘机人，请至少添加一位乘机人"];
        
        return;
    }
    
    if ( self.m_contactField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请填写联系人"];
        
        return;
    }
    
    if ( self.m_phoneField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请填写手机号码"];
        
        return;
        
    }
    
    if ( self.m_phoneField.text.length != 11 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请填写正确的手机号码"];
        
        return;
        
    }
    
//    <span>原代理商officeID：</span><input type="text" name="officeID" value=""/>
//    <span>出票用代理商域名：</span><input type="text" name="clientId" value="xxb.trade.qunar.com"/>
//    <span>采购总价：</span><input type="text" name="purchasePrice" value="490"/>
//    <span>政策FID：</span><input type="text" name="policyFid" value="APP14122608451305ND00"/>
//    <span>政策类型：</span><input type="text" name="policyType" value="1"/>

//    <span>成人pnr，没有pnr 时生成人pnr：</span><input type="text" name="pnr" value=""/>
//    <span>联系人电话，乘客生成pnr时用到：</span><input type="text" name="contactTel" value="18550037019"/>
//    <span>qunar 用户名：</span><input type="text" name="quserName" value="cdzcxkt2197"/>

//    <h4>************航段信息****************</h4>
//    <span>航班号：</span><input type="text" name="flightNum" value="MU2913"/>
//    <span>航空公司二字码：</span><input type="text" name="airlineCompany" value="MU"/>
//    <span>舱位：</span><input type="text" name="cabin" value="V"/>
//    <span>出发日期：</span><input type="text" name="departureDate" value="2015-01-20"/>
//    <span>出发机场，大写，三字码：</span><input type="text" name="departureAirport" value="CZX"/>
//    <span>到达机场，大写，三字码：</span><input type="text" name="arrivalAirport" value="XMN"/>
//    <span>出发城市，汉字：</span><input type="text" name="departureCity" value="常州"/>
//    <span>到达城市，汉字：</span><input type="text" name="arrivalCity" value="厦门"/>
//    <span>出发时间：</span><input type="text" name="departureTime" value="07:50"/>
//    <span>到达时间：</span><input type="text" name="arrivalTime" value="09:30"/>
//    <span>Y 舱价格，公布运价：</span><input type="text" name="yPrice" value="1000"/>
//    <span>里程：</span><input type="text" name="discount" value="989"/>
//    <span>机场建设费：</span><input type="text" name="constructionFee" value="50"/>
//    <span>燃油费：</span><input type="text" name="fuelTax" value="60"/>
//    <span>票面价：</span><input type="text" name="printPrice" value="400"/>
//    <span>销售价：</span><input type="text" name="realPrice" value="380"/>
//    <span>政策ID：</span><input type="text" name="policyId" value="4344393"/>
//    <span>政策来源：</span><input type="text" name="policySource" value=""/>

//    <h4>************乘机人信息**************</h4>
//    <span>乘机人姓名：</span><input type="text" name="name" value=""/>
//    <span>证件类型：</span><input type="text" name="cardType" value="NI"/>
//    <span>证件号码：</span><input type="text" name="cardNum" value="321081199007015139"/>
//    <span>年龄类型（0：成人；1：儿童年）:</span><input type="text" name="ageType" value="0"/>
//    <span>生日（19920123）：</span><input type="text" name="birthday" value="19900701"/>
//    <span>订单价格：</span><input type="text" name="totalPrice" value="490"/>
//    <span>性别：</span><input type="text" name="gender" value="true"/>
//    <span>机票价格：</span><input type="text" name="price" value="380"/>

//    <h4>************会员ID**************</h4>
//    <span>会员ID：</span><input type="text" name="memberID" value="7923"/>
//    <br /><br />
    
    // 总价就是一个人的价格
//    NSString *totalString = [NSString stringWithFormat:@"%i",[[self.m_dic objectForKey:@"discountPrice"] intValue] + [[self.m_dic objectForKey:@"constructionFee"] intValue] + [[self.m_dic objectForKey:@"fuelTax"] intValue]];
//    
//    // 采购总价是所有人的价格
//    NSString *purchasePrice = [NSString stringWithFormat:@"%i",[totalString intValue] * self.m_contactArray.count];
//    
//    
//    NSString *hhtotalString = [NSString stringWithFormat:@"%i",[[self.m_dic objectForKey:@"hhDiscountPrice"] intValue] + [[self.m_dic objectForKey:@"constructionFee"] intValue] + [[self.m_dic objectForKey:@"fuelTax"] intValue]];
//
//    NSString *hhPurchasePrice = [NSString stringWithFormat:@"%i",[hhtotalString intValue] * self.m_contactArray.count];

    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];

    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                @"",@"officeID",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"clientId"]],@"clientId",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"purchasePrice"]],@"purchasePrice",
                                 [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"hhPurchasePrice"]],@"hhPurchasePrice",
                                 [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"pid"]],@"policyFid",
                                 [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"policyType"]],@"policyType",
                                
                                @"",@"pnr",
                                [NSString stringWithFormat:@"%@",self.m_phoneField.text],@"contactTel",
                                @"cdzcxkt2197",@"quserName",
                                
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"flightNum"]],@"flightNum",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"airlineCompany"]],@"airlineCompany",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"cabin"]],@"cabin",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"dptDate"]],@"departureDate",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"dptCodeName"]],@"departureAirport",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"arrCodeName"]],@"arrivalAirport",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"dptCity"]],@"departureCity",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"arrCity"]],@"arrivalCity",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"dptTime"]],@"departureTime",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"arrTime"]],@"arrivalTime",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"yprice"]],@"yPrice",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"distance"]],@"discount",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"constructionFee"]],@"constructionFee",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"fuelTax"]],@"fuelTax",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"oriPrice"]],@"printPrice",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"discountPrice"]],@"realPrice",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"policyId"]],@"policyId",
                                @"",@"policySource",

                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"purchasePrice"]],@"totalPrice",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"discountPrice"]],@"price",
                                
                                memberId,     @"memberID",

                                
//                                @"",@"name",
//                                @"",@"cardType",
//                                @"",@"cardNum",
//                                @"",@"ageType",
//                                @"",@"birthday",
//                                @"",@"gender",
                                
                                nil];
    
    
    NSDictionary *l_dic = [self.m_contactArray objectAtIndex:0];
    
    [dic addEntriesFromDictionary:[NSDictionary dictionaryWithDictionary:l_dic]];
    
    // 提交订单请求接口
    [self requestSubmitOrder:dic];
   
}

- (void)requestSubmitOrder:(NSMutableDictionary *)dic{
        
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient1];
   
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestFlights:@"QunarQbBook.ashx" parameters:dic success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSLog(@"json = %@",json);
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
//            NSString *msg = [json valueForKey:@"msg"];
//            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 下单成功后进行赋值
            self.m_orderDic = [json valueForKey:@"result"];
            
            
//            result =     {
//                clientId = "kyv.trade.qunar.com";
//                elapsed = 9240;
//                officeId = SZX355;
//                orderId = 16990;
//                orderNo = kyv141231104125973;
//                "pxy_point" = 120;
//                timestamp = 1419993676038;
//                "track_id" = BO141231104116038983209520;
//                vendorID = LCS;
//                vendorIP = "59.151.44.183";
//                version = 1;
//            }
            
            // 下单成功后的操作
            self.m_orderDic = [json valueForKey:@"result"];
            
            // 下单成功后进入到支付的页面
            FlightsPayViewController *VC = [[FlightsPayViewController alloc]initWithNibName:@"FlightsPayViewController" bundle:nil];
            VC.m_dic = self.m_dic;
            
            if ( self.m_contactArray.count != 0 ) {
                
                NSMutableDictionary *l_dic = [self.m_contactArray objectAtIndex:0];
                VC.m_contactDic = l_dic;
                
            }
            
            VC.m_orderdic = self.m_orderDic;
            VC.m_phoneString = [NSString stringWithFormat:@"%@",self.m_phoneField.text];
            [self.navigationController pushViewController:VC animated:YES];

        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"failed:%@", error);
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

    
}

#pragma mark - UItextDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ( textField == self.m_contactField ) {
        
        [self hiddenNumPadDone:nil];
        
    }else if ( textField == self.m_phoneField ){
        
        [self showNumPadDone:nil];

    }else{
        
        [self hiddenNumPadDone:nil];
        
    }
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 109920 ) {
        if ( buttonIndex == 1 ) {
            
            // 删除联系人信息
            [self.m_contactArray removeObjectAtIndex:m_index];
            
            // 刷新列表
            [self.m_tableView reloadData];
            
            // 赋值
            self.m_countPeople.text = [NSString stringWithFormat:@"%i人",[self.m_contactArray count]];
            self.m_totalPrice.text = [NSString stringWithFormat:@"￥%@",[self.m_dic objectForKey:@"hhPurchasePrice"]];
            
        }else{
            
            
        }
    }
    
}

#pragma mark - FlightsTrideDelegate
- (void)flightsTride:(NSDictionary *)dic{
    
    // 添加到乘机人数组里面
    if ( self.m_contactArray.count == 0 ) {
        
        [self.m_contactArray addObject:dic];
    
    }else{
        
        [self.m_contactArray insertObject:dic  atIndex:0];
    }
    
    // 刷新列表
    [self.m_tableView reloadData];
    
    // 赋值
    self.m_countPeople.text = [NSString stringWithFormat:@"%i人",[self.m_contactArray count]];
    self.m_totalPrice.text = [NSString stringWithFormat:@"￥%@",[self.m_dic objectForKey:@"hhPurchasePrice"]];
    
}

- (void)EditTride:(NSDictionary *)dic{
    
    [self.m_contactArray replaceObjectAtIndex:m_trideIndex withObject:dic];
    
    // 刷新列表
    [self.m_tableView reloadData];

    
}

/*
#pragma mark ABPeoplePickerNavigationControllerDelegate Method
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person NS_AVAILABLE_IOS(8_0);
{
    [self peoplePickerNavigationController:peoplePicker shouldContinueAfterSelectingPerson:person];
}

- (BOOL)peoplePickerNavigationController: (ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    NSString *personName = @"";
    //读取lastname
    NSString *lastname = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
    if(lastname != nil)
        personName = [personName stringByAppendingFormat:@"%@",lastname];
    
    //读取middlename
    NSString *middlename = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonMiddleNameProperty));
    if(middlename != nil)
        personName = [personName stringByAppendingFormat:@"%@",middlename];
    
    //读取firstname
    NSString *firstname = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    
    if(personName != nil){
        
        if ( firstname.length != 0 ) {
            personName = [personName stringByAppendingFormat:@"%@",firstname];
            
        }
    }
    // 赋值
    self.m_contactString = [NSString stringWithFormat:@"%@",personName];
    
    //获取联系人电话
    ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSMutableArray *phones = [[NSMutableArray alloc] init];
    
    
    for (int i = 0; i < ABMultiValueGetCount(phoneMulti); i++) {
        NSString *aPhone = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneMulti, i));
        NSString *aLabel = (NSString*)CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phoneMulti, i));
        
        if([aLabel isEqualToString:@"_$!<Mobile>!$_"]) {
            
            if ( aPhone.length != 0 ) {
                
                [phones addObject:aPhone];
                
            }
        }else if ( [aLabel isEqualToString:@"_$!<Home>!$_"] ){
            if ( aPhone.length != 0 ) {
                
                [phones addObject:aPhone];
                
            }
            
        }else if ( [aLabel isEqualToString:@"iPhone"] ){
            if ( aPhone.length != 0 ) {
                
                [phones addObject:aPhone];
                
            }
            
        }else if ( [aLabel isEqualToString:@"_$!<Work>!$_"] ){
            if ( aPhone.length != 0 ) {
                
                [phones addObject:aPhone];
                
            }
            
        }
        
    }
    
    if([phones count]>0) {
        
        
        for (int i = 0; i < phones.count; i ++) {
            
            NSString *mobileNo = [phones objectAtIndex:i];
            
            if (mobileNo != nil) {
                mobileNo = [mobileNo stringByReplacingOccurrencesOfString:@"-" withString:@""];
                mobileNo = [mobileNo stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            }
            
            // 判断是手机号的格式
//            if ( mobileNo.length == 11 ) {
            
                self.m_phoneString = [NSString stringWithFormat:@"%@",mobileNo];
                
                i = phones.count;
                
                
//            }else{
            
                
//            }
            
            
        }
        
        
        //        NSString *mobileNo = [phones objectAtIndex:0];
        //        if (mobileNo != nil) {
        //            mobileNo = [mobileNo stringByReplacingOccurrencesOfString:@"-" withString:@""];
        //            mobileNo = [mobileNo stringByReplacingOccurrencesOfString:@"+86" withString:@""];
        //            self.phone.text = mobileNo;
        //        }
    }
    
    NSLog(@"contact = %@,phone = %@",self.m_contactString,self.m_phoneString);
    
    // 刷新列表
    [self.m_tableView reloadData];
    
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    return NO;
}
*/

@end
