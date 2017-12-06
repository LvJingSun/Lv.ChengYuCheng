//
//  HH_menuToHomeViewController.m
//  HuiHui
//
//  Created by mac on 15-7-23.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HH_menuToHomeViewController.h"

#import "HH_toHomeCell.h"

#import "BCloundMenuCell.h"

#import "MyAddressListViewController.h"

#import "HH_CardPayViewController.h"


@interface HH_menuToHomeViewController ()
{
    //用于保存json字典
    NSJSONSerialization *ShopInfojson;
}

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_totalPriceLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UILabel *m_songPrice;

@property (weak, nonatomic) IBOutlet UILabel *m_orignPrice;

@property (weak, nonatomic) IBOutlet UILabel *m_lineLabel;

// 确定下单按钮触发的事件
- (IBAction)submitOrder:(id)sender;

@property (copy, nonatomic) NSString *IsZCFirstBuy;//首次购买
@property (copy, nonatomic) NSString *IsZCHowMuchLess;//满立减
@property (copy, nonatomic) NSString *IsZCMLZ;//满立赠

@property (copy, nonatomic) NSString *FirstBuyYHPrice;//首次购买减
@property (copy, nonatomic) NSString *ManPrice;//满立赠
@property (copy, nonatomic) NSString *ZengPin;//满立赠

@end

@implementation HH_menuToHomeViewController

@synthesize m_menuList;

@synthesize m_menuOrder;

@synthesize m_dic;

@synthesize m_countDic;

@synthesize delegate;

@synthesize m_totalPrice;

@synthesize isYouhui;

@synthesize m_timeList;

@synthesize m_todayArray;

@synthesize m_pickerView;

@synthesize m_pickerToolBar;

@synthesize isSelectedArea;

@synthesize m_timeString;

@synthesize m_view;

@synthesize m_menuId;

@synthesize m_defaultDic;

@synthesize m_special;

@synthesize m_date;

@synthesize m_merchantId;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        m_menuList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_menuOrder = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_countDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_index = 0;
        
        m_totalPrice = 0;
        
        m_count = 0;
        
        isSelectedArea = NO;
        
        m_todayArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_timeList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_defaultDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"外卖订单"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    [self setExtraCellLineHidden:self.m_tableView];
    
    self.m_special = @"";
    
    // 设置背景透明度
    self.m_imageView.backgroundColor = [UIColor blackColor];
    self.m_imageView.alpha = 0.6f;
    
    // 设置下面的footerView用于显示downview的时候不至于覆盖掉
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(self.m_tableView.frame.origin.x, 0, WindowSizeWidth, 50)];
    view.backgroundColor = [UIColor clearColor];
    
    self.m_tableView.tableFooterView = view;
    
    // 将数据重新整理下-数量为0的数据去掉
    for (int ii = 0; ii < self.m_menuList.count; ii++) {
        
        NSMutableDictionary *l_dic = [self.m_menuList objectAtIndex:ii];
        
        if ( l_dic.count != 0 ) {
            
            NSString *amount = [l_dic objectForKey:@"amount"];
            
            NSString *price = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"price"]];
            
            self.m_totalPrice = self.m_totalPrice + [price floatValue] * [amount intValue];
            
            
            if ( ![amount isEqualToString:@"0"] ) {
                
                [self.m_menuOrder addObject:l_dic];
                
            }
            
        }
        
    }
    
    // 判断价格显示
    [self judgeTotalPrice];
    
//    self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",self.m_totalPrice];


    // 计算label显示的坐标
//    [self suanFrame:[NSString stringWithFormat:@"%.2f元",self.m_totalPrice]];
    
    m_count = self.m_menuOrder.count;
    
    self.m_todayArray = [NSMutableArray arrayWithObjects:@"今天", nil];
    
//    self.m_timeList = [NSMutableArray arrayWithObjects:@"8:00-8:30",@"9:00-10:30",@"11:00-12:30",@"13:00-13:30",@"14:00-15:30", nil];

//    self.m_timeString = [NSString stringWithFormat:@"今天 %@",[self.m_timeList objectAtIndex:0]];
    
    //    ========
    
    // 初始化pickerView
    [self initpickerView];
    
    self.m_pickerToolBar.hidden = YES;
    self.m_pickerView.hidden = YES;
    self.m_view.hidden = YES;
    
    // 请求时间和默认地址的接口
    [self timeRequest];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 默认为0-未设置数量
    [CommonUtil addValue:@"0" andKey:@"addMenuCountKey"];
    
    // 如果将地址列表的数据全部清空了，则返回的时候重新请求数据刷新页面
    NSString *chooseAddressKey = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"chooseAddressKey"]];
    
    if ( [chooseAddressKey isEqualToString:@"1"] ) {
        
        [CommonUtil addValue:@"0" andKey:@"chooseAddressKey"];
        
        // 请求时间和默认地址的接口
        [self timeRequest];
        
    }else{
        
        
    }

    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.m_pickerToolBar.hidden = YES;
    self.m_pickerView.hidden = YES;
    self.m_view.hidden = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)suanFrame:(NSString *)aPrice{
    
    // 计算价格的显示的坐标
    
    CGSize size = [aPrice sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(MAXFLOAT, self.m_totalPriceLabel.frame.size.height) lineBreakMode:NSLineBreakByWordWrapping];
    
    self.m_totalPriceLabel.frame = CGRectMake(self.m_totalPriceLabel.frame.origin.x, self.m_totalPriceLabel.frame.origin.y, size.width, size.height);
    
    
    NSString *orignPrice = @"10000元";
    
    self.m_orignPrice.text = orignPrice;

    CGSize size1 = [orignPrice sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(MAXFLOAT, self.m_orignPrice.frame.size.height) lineBreakMode:NSLineBreakByWordWrapping];
    
    self.m_orignPrice.frame = CGRectMake(self.m_totalPriceLabel.frame.origin.x + size.width + 10, self.m_orignPrice.frame.origin.y, size1.width, size1.height);
    
    self.m_lineLabel.frame = CGRectMake(self.m_totalPriceLabel.frame.origin.x + size.width + 8, self.m_lineLabel.frame.origin.y, size1.width + 4, 1);
}

- (void)leftClicked{
    
    // 如果更改了数量返回上一个页面的时候重新赋值进行刷新页面
    NSString *string = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"addMenuCountKey"]];
    
    if ( [string isEqualToString:@"1"] ) {
        
        // 数量发生了变化则重新进行赋值
        if ( self.delegate && [self.delegate respondsToSelector:@selector(getFlagDic:withCoutDic:)] ) {
            
            [self.delegate performSelector:@selector(getFlagDic:withCoutDic:) withObject:self.m_dic withObject:self.m_countDic];
            
        }
        
    }
    
    [self goBack];
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    [self hiddenNumPadDone:nil];
    
    // 获取所点目录对应的indexPath值
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:self.m_menuOrder.count + 2 inSection:3];
    // 让table滚动到对应的indexPath位置
    [self.m_tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    self.m_special = [NSString stringWithFormat:@"%@",textField.text];
    
    // 刷新某一行
    NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:self.m_menuOrder.count + 2 inSection:3], nil];
    
    [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if ( section == 3 ) {
        return self.m_menuOrder.count + 3;
        
    }else{
        return 1;

    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 0 ) {
        
        static NSString *cellIdentifier = @"HH_toHomeCellIdentifier";
        
        HH_toHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_toHomeCell" owner:self options:nil];
            cell = (HH_toHomeCell *)[nib objectAtIndex:0];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        
        if ( self.m_defaultDic.count != 0 ) {
            
            cell.m_tipLabel.hidden = YES;
            
            cell.m_name.hidden = NO;
            cell.m_phone.hidden = NO;
            cell.m_address.hidden = NO;
            
            cell.m_name.text = [NSString stringWithFormat:@"%@",[self.m_defaultDic objectForKey:@"LinkName"]];
            cell.m_phone.text = [NSString stringWithFormat:@"%@",[self.m_defaultDic objectForKey:@"LinkPhone"]];
            cell.m_address.text = [NSString stringWithFormat:@"%@%@%@%@",[self.m_defaultDic objectForKey:@"ProvinceName"],[self.m_defaultDic objectForKey:@"CityName"],[self.m_defaultDic objectForKey:@"AreaName"],[self.m_defaultDic objectForKey:@"Address"]];
            
            cell.m_phone.frame = CGRectMake(WindowSizeWidth - cell.m_phone.frame.size.width - 30, cell.m_phone.frame.origin.y, cell.m_phone.frame.size.width, cell.m_phone.frame.size.height);
            
            cell.m_address.frame = CGRectMake(cell.m_address.frame.origin.x, cell.m_address.frame.origin.y, WindowSizeWidth - 35, cell.m_address.frame.size.height);
 
            
        }else{
            
            cell.m_tipLabel.hidden = NO;

            cell.m_name.hidden = YES;
            cell.m_phone.hidden = YES;
            cell.m_address.hidden = YES;
        }
        
        return cell;
        
    }else if ( indexPath.section == 1 ){
        
        
        static NSString *cellIdentifier = @"HH_toHomeTimeCellIdentifier";
        
        HH_toHomeTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_toHomeCell" owner:self options:nil];
            cell = (HH_toHomeTimeCell *)[nib objectAtIndex:1];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
            // 设置label的frame
            cell.m_time.frame = CGRectMake(WindowSizeWidth - cell.m_time.frame.size.width - 30, cell.m_time.frame.origin.y, cell.m_time.frame.size.width, cell.m_time.frame.size.height);
        }
        
        // 赋值
        cell.m_time.text = [NSString stringWithFormat:@"今天 %@",self.m_timeString1];
        if ([self.m_ModelType isEqualToString:@"2"]) {
            cell.hidden = YES;
        }
        
        return cell;
        
        
    }else if ( indexPath.section == 2 ){
        
        static NSString *cellIdentifier = @"HH_toHomePayCellIdentifier";
        
        HH_toHomePayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_toHomeCell" owner:self options:nil];
            cell = (HH_toHomePayCell *)[nib objectAtIndex:2];
            
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        // 设置label的frame
        cell.m_payType.frame = CGRectMake(WindowSizeWidth - 70 - 30, cell.m_payType.frame.origin.y, 70, cell.m_payType.frame.size.height);
        
        cell.m_payType.layer.borderWidth = 1.0;
        cell.m_payType.layer.borderColor = [UIColor redColor].CGColor;
        
        cell.m_payType.textAlignment = NSTextAlignmentCenter;
        
        cell.m_title.text = @"支付方式";
        
        cell.m_payType.text = @"线上支付";
        
        return cell;
        
    }else{
        
        if ( indexPath.row < self.m_menuOrder.count ) {
            
            
            BCloundMenuTaocanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BCloundMenuTaocanCellIdentifier"];
            
            if (!cell)
                
            {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"BCloundMenuCell" owner:self options:nil]objectAtIndex:2];
                
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                
            }
            
            if ( self.m_menuOrder.count != 0 ) {
                
                cell.m_time.hidden = YES;
                
                NSDictionary *dic = [self.m_menuOrder objectAtIndex:indexPath.row];
                
                cell.m_labelname.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"menuName"]];
                
                cell.m_labelpice.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"price"]];
                
                // 赋值自定义参数的值
                NSString *CustomName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CustomNameKey"]];
                
                if ( CustomName.length == 0 || [CustomName isEqualToString:@"(null)"] ) {
                    
                    cell.m_usedCount.text = @"";
                    
                }else{
                    
                    cell.m_usedCount.text = [NSString stringWithFormat:@"%@",CustomName];

                }

                [cell setImagePath:[dic objectForKey:@"MenuImage"]];
                
                NSString *Istring = [dic objectForKey:@"amount"];
                
                if ((!Istring) ||([Istring isEqualToString:@"0"])) {
                    
                    cell.m_Btnjian.hidden = cell.m_Btnnum.hidden = YES;
                    
                    // 设置加号的颜色
                    //            [cell.m_Btnjia1.titleLabel setTextColor:[UIColor darkGrayColor]];
                    //
                    //            [cell.m_Btnjia1.layer setBorderColor:[UIColor darkGrayColor].CGColor];//边框颜色
                    
                    
                    cell.hidden = YES;
                    
                }else
                    
                {
                    
                    cell.hidden = NO;
                    
                    cell.m_Btnjian.hidden = cell.m_Btnnum.hidden = NO;
                    
                    [cell.m_Btnnum setTitle:[NSString stringWithFormat:@"%@",Istring] forState:UIControlStateNormal];
                    //            // 设置加号的颜色
                    //            [cell.m_Btnjia1.titleLabel setTextColor:[UIColor darkGrayColor]];
                    //
                    //            [cell.m_Btnjia1.layer setBorderColor:[UIColor redColor].CGColor];//边框颜色
                    
                }
                
            }
            
            
            cell.m_Btnjia.tag = indexPath.row;
            
            cell.m_Btnjian.tag = indexPath.row;
            
            [cell.m_Btnjia addTarget:self action:@selector(AddMenuNum:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.m_Btnjian addTarget:self action:@selector(JianMenuNum:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
            
            
            
            /*
            BCloundMenuCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"BCloundMenuCell1Identifier"];
            
            if (!cell)
                
            {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"BCloundMenuCell" owner:self options:nil]objectAtIndex:1];
                
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                
            }
            
            if ( self.m_menuOrder.count != 0 ) {
                
                NSDictionary *dic = [self.m_menuOrder objectAtIndex:indexPath.row];
                
                cell.m_labelname.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"menuName"]];
                
                cell.m_labelpice.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"price"]];
                
                [cell setImagePath:[dic objectForKey:@"MenuImage"]];
                
                NSString *Istring = [dic objectForKey:@"amount"];
                
                if ((!Istring) ||([Istring isEqualToString:@"0"])) {
                    
                    cell.m_Btnjian.hidden = cell.m_Btnnum.hidden = YES;
                    
                    // 设置加号的颜色
                    //            [cell.m_Btnjia1.titleLabel setTextColor:[UIColor darkGrayColor]];
                    //
                    //            [cell.m_Btnjia1.layer setBorderColor:[UIColor darkGrayColor].CGColor];//边框颜色
                    
                    
                    cell.hidden = YES;
                    
                }else
                    
                {
                    
                    cell.hidden = NO;

                    cell.m_Btnjian.hidden = cell.m_Btnnum.hidden = NO;
                    
                    [cell.m_Btnnum setTitle:[NSString stringWithFormat:@"%@",Istring] forState:UIControlStateNormal];
                    //            // 设置加号的颜色
                    //            [cell.m_Btnjia1.titleLabel setTextColor:[UIColor darkGrayColor]];
                    //
                    //            [cell.m_Btnjia1.layer setBorderColor:[UIColor redColor].CGColor];//边框颜色
                    
                }
                
            }
            
            
            cell.m_Btnjia.tag = indexPath.row;
            
            cell.m_Btnjian.tag = indexPath.row;
            
            [cell.m_Btnjia addTarget:self action:@selector(AddMenuNum:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.m_Btnjian addTarget:self action:@selector(JianMenuNum:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;*/
          
        } else{
            
            if ( indexPath.row == self.m_menuOrder.count ) {
                
                
                static NSString *cellIdentifier = @"HH_toHomePayCellIdentifier";
                
                HH_toHomePayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                
                if ( cell == nil ) {
                    
                    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_toHomeCell" owner:self options:nil];
                    cell = (HH_toHomePayCell *)[nib objectAtIndex:2];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                }
                
                // 设置label的frame
                cell.m_payType.frame = CGRectMake(WindowSizeWidth - 150, cell.m_payType.frame.origin.y, 120, cell.m_payType.frame.size.height);
                
                cell.m_payType.backgroundColor = [UIColor clearColor];
                cell.m_payType.layer.borderWidth = 0.0f;
                cell.m_payType.layer.borderColor = [UIColor clearColor].CGColor;
                
                cell.m_payType.textAlignment = NSTextAlignmentRight;
                
                // 赋值
                cell.m_title.text = [NSString stringWithFormat:@"共有%li商品",(long)m_count];
                
                cell.m_payType.text = [NSString stringWithFormat:@"合计：%.2f元",self.m_totalPrice];
                
                
                return cell;

                
            }else if ( indexPath.row == self.m_menuOrder.count + 1 ){
                
                
                static NSString *cellIdentifier = @"HH_toHomeYouhuiCellIdentifier";
                
                HH_toHomeYouhuiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if ( cell == nil ) {
                    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_toHomeCell" owner:self options:nil];
                    cell = (HH_toHomeYouhuiCell *)[nib objectAtIndex:4];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                
                
                
                
                
                
                // 判断是否有优惠活动
                if ( [self.isYouhui isEqualToString:@"1"] ) {
                    
                    cell.hidden = NO;

                    //支持首次购买
                    if ([self.IsZCFirstBuy isEqualToString:@"1"]) {
                        if ([self.IsZCMLZ isEqualToString:@"1"]) {
                            
                            cell.m_yhDescription.text = [NSString stringWithFormat:@"首次购买优惠"];
                            cell.m_yhDescriptionZeng.hidden = NO;
                            cell.m_yhDescriptionZeng.text = [NSString stringWithFormat:@"满%@赠%@",self.ManPrice,self.ZengPin];
                            cell.m_jian.text = [NSString stringWithFormat:@"-%@",self.FirstBuyYHPrice];
                            cell.m_yhJian.text = [NSString stringWithFormat:@"赠%@",self.ZengPin];
                        

                        }else{
                            cell.m_yhDescription.text = [NSString stringWithFormat:@"首次购买优惠"];
                            cell.m_yhDescriptionZeng.hidden = YES;
                            cell.m_jian.text = [NSString stringWithFormat:@"-%@",self.FirstBuyYHPrice];
                            cell.m_yhJian.text = [NSString stringWithFormat:@"优惠%@无",self.FirstBuyYHPrice];
                        }
                    
                    }else
                        //不支持首次购买
                    {
                        //支持满立减
                        if ([self.IsZCHowMuchLess isEqualToString:@"1"]) {
                                
                                if ([self.IsZCMLZ isEqualToString:@"1"]) {
                                    NSString *jianString = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:JIANKEY]];
                                    NSString *yhDescription = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:YHDESCRIPTION]];
                                    cell.m_yhDescription.text = [NSString stringWithFormat:@"%@",yhDescription];
                                    cell.m_yhDescriptionZeng.hidden = NO;
                                    cell.m_yhDescriptionZeng.text = [NSString stringWithFormat:@"满%@赠%@",self.ManPrice,self.ZengPin];
                                    cell.m_jian.text = [NSString stringWithFormat:@"-%@",jianString];
                                    cell.m_yhJian.text = [NSString stringWithFormat:@"赠%@",self.ZengPin];
                                }else
                                {
                                    // 赋值
                                    NSString *yhDescription = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:YHDESCRIPTION]];
                                    NSString *jianString = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:JIANKEY]];
                                    cell.m_yhDescription.text = [NSString stringWithFormat:@"%@",yhDescription];
                                    cell.m_yhDescriptionZeng.hidden = YES;
                                    cell.m_yhJian.text = [NSString stringWithFormat:@"优惠%@元",jianString];
                                    cell.m_jian.text = [NSString stringWithFormat:@"-%@",jianString];
                                    
                                }

                            
                        }else
                        //不支持满立减
                        {
                            //支持满立赠
                            if ([self.IsZCMLZ isEqualToString:@"1"]) {
                                
                                    cell.m_yhDescriptionZeng.hidden = YES;
                                    cell.m_yhDescription.text = [NSString stringWithFormat:@"满%@赠%@",self.ManPrice,self.ZengPin];
                                    cell.m_jian.text = [NSString stringWithFormat:@"%@",self.ZengPin];
                                    cell.m_yhJian.text = [NSString stringWithFormat:@"赠%@",self.ZengPin];
                                
                            }else
                            {
                                cell.hidden =YES;
                                
                            }
                        }
                    }

                    
                }else{
                    
                    cell.hidden = YES;
                    
                }
                
                return cell;
                
            }else{
                
                
                static NSString *cellIdentifier = @"HH_toHomeSpecialCellIdentifier";
                
                HH_toHomeSpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                
                if ( cell == nil ) {
                    
                    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_toHomeCell" owner:self options:nil];
                    cell = (HH_toHomeSpecialCell *)[nib objectAtIndex:3];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    // 设置坐标
                    cell.m_backImgV.frame = CGRectMake(cell.m_backImgV.frame.origin.x, cell.m_backImgV.frame.origin.y, WindowSizeWidth - 20, cell.m_backImgV.frame.size.height);
                    
                    cell.m_textField.frame = CGRectMake(cell.m_textField.frame.origin.x, cell.m_textField.frame.origin.y, WindowSizeWidth - 30, cell.m_textField.frame.size.height);
                    
                    cell.m_textField.delegate = self;
                    cell.m_textField.tag = 2030;

                    cell.m_textField.text = [NSString stringWithFormat:@"%@",self.m_special];
                    
                }

                
                return cell;
              
            }
        }
        
        
    }
    
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 0 ) {
        
        return 80.0f;
        
    }else if ( indexPath.section == 1 ){
        if ([self.m_ModelType isEqualToString:@"2"]) {
            return 0.f;
        }
        return 44.0f;
    
    }else if ( indexPath.section == 2 ){
        
        return 44.0f;
        
    }
    else{
        
        if ( indexPath.row < self.m_menuOrder.count ) {
            
//            return 100.0f;
            
            NSDictionary *dic = [self.m_menuOrder objectAtIndex:indexPath.row];
            
            NSString *Istring = [dic objectForKey:@"amount"];
            
            if ((!Istring) ||([Istring isEqualToString:@"0"])) {
                
                return 0.0f;
                
            }else  {
                
                return 80.0f;
                
            }

        }else{
            

            if ( indexPath.row == self.m_menuOrder.count ) {
                
                return 44.0f;

            }else if ( indexPath.row == self.m_menuOrder.count + 1 ){
                
                if ( [self.isYouhui isEqualToString:@"1"] ) {
                    
                    return 130.0f;
                    
                }else{
                    
                    return 0.0f;
                }
                
            }else{
                
                return 60.0f;

            }
        
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ( section == 3 ) {
        
        return 30.0f;
        
    }else{
        
        return 1.0f;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if ( section == 3 ) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WindowSizeWidth-20, 21)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"  已选的商品";
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textColor = [UIColor blackColor];
        
        
        return label;
        
    }else{
        
        return nil;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view endEditing:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ( indexPath.section == 0 ) {
        
        if ( indexPath.row == 0 ) {
            
            // 进入到地址列表
//            MyAddressListViewController *VC = [[MyAddressListViewController alloc]initWithNibName:@"MyAddressListViewController" bundle:nil];
//            [self.navigationController pushViewController:VC animated:YES];
            
            ChooseAddressViewController *VC = [[ChooseAddressViewController alloc]initWithNibName:@"ChooseAddressViewController" bundle:nil];
            VC.m_addressId = [NSString stringWithFormat:@"%@",[self.m_defaultDic objectForKey:@"AddressID"]];
            VC.delegate = self;
            [self.navigationController pushViewController:VC animated:YES];
            
        }
        
    }else if ( indexPath.section == 1 ){
        
        if ( indexPath.row == 0 ) {
            
            self.m_pickerToolBar.hidden = NO;
            self.m_pickerView.hidden = NO;
            self.m_view.hidden = NO;

        }
        
    }
    
}

#pragma mark - ChooseAddressDelegate
- (void)getAddressDetail:(NSMutableDictionary *)aDic{

    self.m_defaultDic = aDic;
    
    [self.m_tableView reloadData];
    
}


#pragma mark - BtnClicked
- (void)AddMenuNum:(id)sender
{

    [self.view endEditing:YES];
    // 如果更改了数量返回上一个页面的时候重新赋值进行刷新页面
    [CommonUtil addValue:@"1" andKey:@"addMenuCountKey"];

    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *l_dic = [self.m_menuList objectAtIndex:btn.tag];
    
    NSString *Istring = [l_dic objectForKey:@"amount"];
    
    // 所在的区
    NSString *sectionKey = [l_dic objectForKey:@"sectionKey"];

    int section = [sectionKey intValue];
    
    int nownum;
    
    if ((!Istring) ||([Istring isEqualToString:@"0"])) {
        
        nownum = 1;
        
    }else{
        
        NSString *num = [NSString stringWithFormat:@"%@",Istring];
        
        nownum = [num intValue]+1;
        
    }
    
    [l_dic setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"amount"];
    
    // ====设置数组的显示=========
    
    NSMutableDictionary *dic_1 = [self.m_dic objectForKey:[NSNumber numberWithInt:section]];
    
    NSString *totalCount = [dic_1 objectForKey:@"TotalCount"];
    
//    NSMutableArray *l_arr = [[NSMutableArray alloc]initWithCapacity:0];
    
    // 获取到当前点击的菜单的menuId
    NSString *menuId_1 = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"menuId"]];
    
    int index_menuId = 0;
    
    for (int ii = 0; ii < [totalCount intValue]; ii++) {
        
        NSMutableDictionary *l_dic = [dic_1 objectForKey:[NSString stringWithFormat:@"%d",ii]];
        
        NSString *menuId = [l_dic objectForKey:@"menuId"];
        
        if ( [menuId isEqualToString:menuId_1] ) {
            
            index_menuId = ii;
            
        }
        
    }
    
    
    NSDictionary *dic_2 = [dic_1 objectForKey:[NSString stringWithFormat:@"%i",index_menuId]];
    
    NSString *Istring1 = [dic_2 objectForKey:@"amount"];
    
    int nownum1;
    
    if ((!Istring1) ||([Istring1 isEqualToString:@"0"])) {
        
        nownum1 = 1;
        
    }else{
        
        NSString *num = [NSString stringWithFormat:@"%@",Istring1];
        
        nownum1 = [num intValue]+1;
        
    }
    
    
    [dic_2 setValue:[NSString stringWithFormat:@"%i",nownum1] forKey:@"amount"];
    
    // ========计算总价钱的算法===========
    NSString *price = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"price"]];
    
    self.m_totalPrice = self.m_totalPrice + [price floatValue];
    
    // 判断价格显示
    [self judgeTotalPrice];
    
    // 计算label显示的坐标
//    [self suanFrame:[NSString stringWithFormat:@"%.2f元",self.m_totalPrice]];
    
    
    [self.m_tableView reloadData];
    
}

//- (void)judgeTotalPrice{
//    
//    // 根据是否有满立减的条件，如果有值的话，则显示优惠信息的提示 ====
//    NSString *yhDescription = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:YHDESCRIPTION]];
//    
//    NSString *manString = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:MANKEY]];
//    
//    NSString *jianString = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:JIANKEY]];
//
//    float manValue = [manString floatValue];
//    
//    float jianValue = [jianString floatValue];
//    
//    
//    if ( yhDescription.length != 0 ) {
//        // 判断总价格是否大于满的价格，如果大于的话则显示优惠的信息，不大于的则不显示
//        if ( self.m_totalPrice >= manValue ) {
//            
//            self.isYouhui = @"1";
//            
//            float value = self.m_totalPrice - jianValue;
//            
//            self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",value];
//            
//        }else{
//            
//            self.isYouhui = @"0";
//            
//            self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",self.m_totalPrice];
//        }
//        
//    }else{
//        
//        self.isYouhui = @"0";
//        
//        
//        self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",self.m_totalPrice];
//        
//    }
// 
//}

- (void)JianMenuNum:(id)sender
{
    
    [self.view endEditing:YES];
    
    // 如果更改了数量返回上一个页面的时候重新赋值进行刷新页面
    [CommonUtil addValue:@"1" andKey:@"addMenuCountKey"];
    
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *l_dic = [self.m_menuOrder objectAtIndex:btn.tag];
    
    NSString *Istring = [l_dic objectForKey:@"amount"];
    
    // 所在的区
    NSString *sectionKey = [l_dic objectForKey:@"sectionKey"];
    
    int section = [sectionKey intValue];
    
    int nownum;
    
    if ([Istring isEqualToString:@"1"]) {
        
        nownum = 0;
        
        m_index = btn.tag;
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@""
                                                           message:[NSString stringWithFormat:@"确定删除%@吗?",[l_dic objectForKey:@"menuName"]]
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:@"取消", nil];
        alertView.tag = 111234;
        [alertView show];
        
    }else{
        
        NSString *num = [NSString stringWithFormat:@"%@",Istring];
        
        nownum = [num intValue] - 1;
        
        [l_dic setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"amount"];
       
        // ====设置数组的显示=========
        
        NSMutableDictionary *dic_1 = [self.m_dic objectForKey:[NSNumber numberWithInt:section]];
        
        NSString *totalCount = [dic_1 objectForKey:@"TotalCount"];
        NSString *menuId_1 = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"menuId"]];

//        NSMutableArray *l_arr = [[NSMutableArray alloc]initWithCapacity:0];
        int index_menuId = 0;
        
        for (int ii = 0; ii < [totalCount intValue]; ii++) {
            
            
            NSMutableDictionary *l_dic = [dic_1 objectForKey:[NSString stringWithFormat:@"%d",ii]];
            
            NSString *menuId = [l_dic objectForKey:@"menuId"];
            
            if ( [menuId isEqualToString:menuId_1] ) {
                
                index_menuId = ii;
                
            }
            
        }
        
        NSDictionary *dic_2 = [dic_1 objectForKey:[NSString stringWithFormat:@"%i",index_menuId]];
        
        NSString *Istring1 = [dic_2 objectForKey:@"amount"];
        
        int nownum1;
        
        if ([Istring1 isEqualToString:@"0"]) {
            
            nownum1 = 0;
            
        }else{
            
            NSString *num = [NSString stringWithFormat:@"%@",Istring1];
            
            nownum1 = [num intValue] - 1;
            
        }
        
        [dic_2 setValue:[NSString stringWithFormat:@"%i",nownum1] forKey:@"amount"];
        
        // 计算左边tableView上面数量的显示======
        NSString *count = [self.m_countDic objectForKey:[NSString stringWithFormat:@"%i",section]];
        
        int countValue = [count intValue];
        
        if ( dic_2.count != 0 ) {
            
            NSString *amount = [dic_2 objectForKey:@"amount"];
            
            if ( [amount isEqualToString:@"0"] ) {
                
                if ( countValue != 0 ) {
                    
                    countValue = countValue - 1;
                    
                }else{
                    
                    countValue = 0;
                }
            }
            
            // 赋值到字典里
            [self.m_countDic setObject:[NSString stringWithFormat:@"%i",countValue] forKey:[NSString stringWithFormat:@"%i",section]];
            
        }
        
        // ========计算总价钱的算法===========
        NSString *price = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"price"]];
        
        self.m_totalPrice = self.m_totalPrice - [price floatValue];
        
//        self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",self.m_totalPrice];
        
        // 判断价格显示
        [self judgeTotalPrice];
        
        
        // 计算label显示的坐标
//        [self suanFrame:[NSString stringWithFormat:@"%.2f元",self.m_totalPrice]];
        // =======总价钱的计算========
        
        [self.m_tableView reloadData];

        
    }
    
  
}

- (void)refreshData:(NSInteger)aIndex{
    
    
    NSMutableDictionary *l_dic = [self.m_menuOrder objectAtIndex:aIndex];
    
    NSString *Istring = [l_dic objectForKey:@"amount"];
    
    // 所在的区
    NSString *sectionKey = [l_dic objectForKey:@"sectionKey"];
    
    int section = [sectionKey intValue];
    
    int nownum;
    
    
    NSString *num = [NSString stringWithFormat:@"%@",Istring];
    
    nownum = [num intValue] - 1;
    
    [l_dic setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"amount"];
    
    // ====设置数组的显示=========
    
    NSMutableDictionary *dic_1 = [self.m_dic objectForKey:[NSNumber numberWithInt:section]];
    
    NSString *totalCount = [dic_1 objectForKey:@"TotalCount"];
    
//    NSMutableArray *l_arr = [[NSMutableArray alloc]initWithCapacity:0];
    NSString *menuId_1 = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"menuId"]];

    int index_menuId = 0;
    
    for (int ii = 0; ii < [totalCount intValue]; ii++) {
        
        NSMutableDictionary *l_dic = [dic_1 objectForKey:[NSString stringWithFormat:@"%d",ii]];
        
        NSString *menuId = [l_dic objectForKey:@"menuId"];
        
        if ( [menuId isEqualToString:menuId_1] ) {
            
            index_menuId = ii;
            
        }
        
    }
    
    NSDictionary *dic_2 = [dic_1 objectForKey:[NSString stringWithFormat:@"%i",index_menuId]];
    
    NSString *Istring1 = [dic_2 objectForKey:@"amount"];
    
    int nownum1;
    
    if ([Istring1 isEqualToString:@"0"]) {
        
        nownum1 = 0;
        
    }else{
        
        NSString *num = [NSString stringWithFormat:@"%@",Istring1];
        
        nownum1 = [num intValue] - 1;
        
    }
    
    [dic_2 setValue:[NSString stringWithFormat:@"%i",nownum1] forKey:@"amount"];
    
    // 计算左边tableView上面数量的显示======
    NSString *count = [self.m_countDic objectForKey:[NSString stringWithFormat:@"%i",section]];
    
    int countValue = [count intValue];
    
    if ( dic_2.count != 0 ) {
        
        NSString *amount = [dic_2 objectForKey:@"amount"];
        
        if ( [amount isEqualToString:@"0"] ) {
            
            if ( countValue != 0 ) {
                
                countValue = countValue - 1;
                
            }else{
                
                countValue = 0;
            }
        }
        
        // 赋值到字典里
        [self.m_countDic setObject:[NSString stringWithFormat:@"%i",countValue] forKey:[NSString stringWithFormat:@"%i",section]];
        
    }
    
    // ========计算总价钱的算法===========
    NSString *price = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"price"]];
    
    self.m_totalPrice = self.m_totalPrice - [price floatValue];
    
//    self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",self.m_totalPrice];
    
    // 判断价格显示
    [self judgeTotalPrice];
    
    
    // 计算label显示的坐标
//    [self suanFrame:[NSString stringWithFormat:@"%.2f元",self.m_totalPrice]];
    // =======总价钱的计算========
    
    [self.m_menuList removeObjectAtIndex:m_index];
    
    [self.m_menuOrder removeObjectAtIndex:m_index];
    
    [self.m_tableView reloadData];
   
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    // 删除某一菜的提示
    if ( alertView.tag == 111234 ) {
        
        if ( buttonIndex == 0 ) {
            
            // 刷新数据
            [self refreshData:m_index];
 
            if ( m_count == 1 ) {
                
                // 如果只有一个的话则删除后直接返回上一级
                [self leftClicked];
                
            }else{
                
                m_count = m_count - 1;

                [self.m_tableView reloadData];
                
            }
            
        }
    }
    
    
}



- (IBAction)submitOrder:(id)sender {
    
    [self.view endEditing:YES];
    
    // 将值拼接起来请求服务器
    [self jsonWithDic];
    
    if ( self.m_defaultDic.count == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择外卖送货地址"];
        
        return;
    }
    
    // 请求下单的接口
    [self submitorderRequest];
    
    
}

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
                           [NSString stringWithFormat:@"%@%@%@%@",[self.m_defaultDic objectForKey:@"ProvinceName"],[self.m_defaultDic objectForKey:@"CityName"],[self.m_defaultDic objectForKey:@"AreaName"],[self.m_defaultDic objectForKey:@"Address"]],@"address",
                           @"",@"bookDateTime",
                           @"",@"cloudMenuPerson",
                           [NSString stringWithFormat:@"%@",self.m_menuId],@"goods",
                           @"1",@"isWaiMai",
                           [NSString stringWithFormat:@"%@",[self.m_defaultDic objectForKey:@"LinkName"]],@"linkName",
                           [NSString stringWithFormat:@"%@",[self.m_defaultDic objectForKey:@"LinkPhone"]],@"linkPhone",
                           [NSString stringWithFormat:@"%@",self.m_shopId],@"merchantShopId",
//                           self.m_merchantId,@"merchantId",
                           [NSString stringWithFormat:@"%@ %@",self.m_date,self.m_timeString1],@"peiSongTime",
                           self.m_special,@"remark",
                           @"",@"seatId",

                           nil];
    
    NSLog(@"params = %@",param);
    
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
   
    [httpClient request:@"AddCloudMenuOrder_3.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
     
        NSString *msg = [json valueForKey:@"msg"];
        
        
        if (success) {
            
//            [SVProgressHUD dismiss];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            NSLog(@"json = %@",json);
            
            // 确定下单成功后跳转到去支付的页面
            
            // 外卖的情况-下单成功后进入到支付的页面
            HH_CardPayViewController *VC = [[HH_CardPayViewController alloc]initWithNibName:@"HH_CardPayViewController" bundle:nil];
            VC.m_orderId = [NSString stringWithFormat:@"%@",[json valueForKey:@"CloudMenuOrderId"]];
            VC.m_shopId = [NSString stringWithFormat:@"%@",self.m_shopId];
            [self.navigationController pushViewController:VC animated:YES];
            
        
        }else{
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

}

// 把选择的菜单拼接成json字符传递给服务器
- (void)jsonWithDic{
    
    NSString *l_string = @"";
    NSString *string = @"";
    
    for (int i = 0; i < self.m_menuList.count; i++) {
        
        NSDictionary *dic = [self.m_menuList objectAtIndex:i];
        
        NSString *amount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"amount"]];
        
        NSString *menuId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"menuId"]];

        NSString *attributekey = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CustomKey"]];
        
        NSString *customKey = @"";
        
        if ( attributekey.length != 0 && ![attributekey isEqualToString:@"(null)"]) {
            
            customKey = attributekey;
            
        }else{
            
            customKey = @"";
            
        }
        
        
        NSLog(@"custonkey = %@",customKey);

        
        l_string = [NSString stringWithFormat:@"{\"menuId\":\"%@\",\"amount\":\"%@\",\"attribute\":\"%@\"},",menuId,amount,customKey];
        
        string = [string stringByAppendingString:l_string];
        
    }
    
    if ( string.length != 0 ) {
        
        // 设置拼接的字符串
        string = [string substringWithRange:NSMakeRange(0, string.length - 1)];
        
    }
    
    
    self.m_menuId = [NSString stringWithFormat:@"\{\"goodlist\":[%@]}",string];
    
    NSLog(@"menuId = %@",self.m_menuId);
    
}

- (void)timeRequest{
    
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
    
    
    [httpClient request:@"CloudMenuPeiSongTime.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            [self infoRequestGetMerchantShopInfo];
            NSLog(@"json = %@",json);
            
            // 赋值
            NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
            
            array = [json valueForKey:@"DefaultAddress"];
            
            if ( array.count != 0 ) {
                
                self.m_defaultDic = [array objectAtIndex:0];
                
            }else{
            
                // 如果地址列表数据被清空了，则将字典里的值全部删除重新赋值
                if ( self.m_defaultDic.count != 0 ) {
                    
                    [self.m_defaultDic removeAllObjects];
        
                }
            
            }

            NSDictionary *dic = [json valueForKey:@"PsTime"];
            
            self.m_date = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Date"]];
            
            self.m_timeList = [dic objectForKey:@"TimesList"];

            // 默认时间为第一个
            if ( self.m_timeList.count != 0 ) {
                
                NSDictionary *dic = [self.m_timeList objectAtIndex:0];
                
                self.m_timeString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Time"]];

                self.m_timeString1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Time"]];
                
                self.m_timeString2 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Time"]];

            }
            
            // 刷新列表
            [self.m_tableView reloadData];
            
            [self.m_pickerView reloadAllComponents];
            
            
        }else{
            
            NSString *msg = [json valueForKey:@"msg"];

            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

#pragma mark - 初始化显示地区的pickerView
- (void)initpickerView{
    
    
    UIWindow *window = self.navigationController.view.window;
    
    self.m_view = [[UIControl alloc]initWithFrame:window.frame];
    self.m_view.backgroundColor = [UIColor blackColor];
    self.m_view.alpha = 0.6;
    [self.m_view addTarget:self action:@selector(backTap:) forControlEvents:UIControlEventTouchDown];
    
    [window addSubview:self.m_view];
    
    //  datePickerView初始化
//    m_pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(40, [UIScreen mainScreen].bounds.size.height - 216, WindowSizeWidth - 80, 216)];
    
    m_pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 216, WindowSizeWidth, 216)];

//    m_pickerView.center = self.m_view.center;
    m_pickerView.delegate = self;
    m_pickerView.dataSource = self;
    // 设置pickerView选择时的背景，默认的为NO
    m_pickerView.showsSelectionIndicator = YES;
    m_pickerView.backgroundColor = [UIColor whiteColor];
    
    [window addSubview:m_pickerView];
    
    //添加 PickerView上面的左右按钮
    UIBarButtonItem *pickItemCancle = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(doPickerCancel:)];
    pickItemCancle.style = UIBarButtonItemStyleBordered;
    
    UIBarButtonItem *pickItemOK = [[UIBarButtonItem alloc]initWithTitle:@"确定"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(doPickerDone:)];
    pickItemOK.style = UIBarButtonItemStyleBordered;
    
    UIBarButtonItem *pickSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItem)UIBarButtonSystemItemFlexibleSpace
                                                                               target:self
                                                                               action:nil];
    // 自定义PickerView顶部的Toolbar，加载左右的取消和确定按钮
    UIToolbar *pickerBar = [[UIToolbar alloc] init];
    pickerBar.barStyle = UIBarStyleBlackTranslucent;
    NSArray *pickArray = [NSArray arrayWithObjects:pickItemCancle, pickSpace, pickItemOK,nil];
    [pickerBar setItems:pickArray animated:YES];
    pickerBar.frame = CGRectMake(0, m_pickerView.frame.origin.y - 44, WindowSizeWidth, 44);
  
//    pickerBar.backgroundColor = [UIColor whiteColor];

    [window addSubview:pickerBar];
   
    self.m_pickerToolBar = pickerBar;
    
}

- (void)backTap:(id)sender{
    
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    
    self.m_view.hidden = YES;
}

#pragma mark - PickerBar按钮
- (void)doPickerDone:(id)sender{
    
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    
    self.m_view.hidden = YES;
    
    if ( self.isSelectedArea ) {
        
        self.m_timeString1 = [NSString stringWithFormat:@"%@",self.m_timeString];
        
        self.m_timeString2 = [NSString stringWithFormat:@"%@",self.m_timeString];

        
    }else{
        
        self.m_timeString1 = [NSString stringWithFormat:@"%@",self.m_timeString];
        
        self.m_timeString2 = [NSString stringWithFormat:@"%@",self.m_timeString];
        
    }
    
    
    self.isSelectedArea = NO;
    
    // 刷新某一行
    NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:1], nil];
    
    [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];

    
}

- (void)doPickerCancel:(id)sender{
    
    self.m_timeString1 = [NSString stringWithFormat:@"%@",self.m_timeString2];
    
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    
    self.m_view.hidden = YES;

}

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if ( component == 0 ) {
        
        return self.m_todayArray.count;
        
    }else if ( component == 1 ){
        
        return self.m_timeList.count;
        
    }else{
        
        return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *titleResult = @"";
    
    if ( component == 0 ) {
        
        if ( self.m_todayArray.count > 0 ) {
            
//            NSDictionary *dic = [self.m_provinceArray objectAtIndex:row];
            
            titleResult = [NSString stringWithFormat:@"%@",[self.m_todayArray objectAtIndex:row]];
            
        }
    }else if ( component == 1 ){
        
        if ( self.m_timeList.count > 0 ) {
            
            NSDictionary *dic = [self.m_timeList objectAtIndex:row];
            
            titleResult = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Time"]];
            
        }
    }else{
        
        titleResult = @"";
    }
    
    return titleResult;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.isSelectedArea = YES;
    
    if ( component == 0 ) {
        
//        NSDictionary *dic = [self.m_provinceArray objectAtIndex:row];
        
//        self.m_provinceId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
//        
//        self.m_provinceName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
//        
//        self.m_CityArray = [dbhelp queryArea:self.m_provinceId];
        
        if ( self.m_todayArray && [self.m_todayArray count] > 0 ) {
            
//            NSDictionary *dic = [self.m_CityArray objectAtIndex:0];
//            
//            self.m_cityId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
//            
//            self.m_cityName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
//            
//            // 取得市数组第一个所对应的区
//            if ( self.m_cityId ) {
//                
//                self.m_AreaArray = [dbhelp queryArea:self.m_cityId];
//                
//                NSDictionary *dic = [self.m_AreaArray objectAtIndex:0];
//                
//                self.m_areaId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
//                
//                self.m_areaName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
//                
//                
//            }
            
            // 刷新选择器
            [self.m_pickerView selectRow:0 inComponent:1 animated:YES];
        }
        
    }else if ( component == 1 ){
        
//        NSDictionary *dic = [self.m_CityArray objectAtIndex:row];
        
//        self.m_cityId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
//        
//        self.m_cityName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
//        
//        self.m_AreaArray = [dbhelp queryArea:self.m_cityId];
//        
//        NSDictionary *areaDic = [self.m_AreaArray objectAtIndex:0];
//        
//        self.m_areaId = [NSString stringWithFormat:@"%@",[areaDic objectForKey:@"code"]];
//        
//        self.m_areaName = [NSString stringWithFormat:@"%@",[areaDic objectForKey:@"name"]];
        
        NSDictionary *dic = [self.m_timeList objectAtIndex:row];
        
        self.m_timeString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Time"]];

        
    }else{
        
//        NSDictionary *dic = [self.m_AreaArray objectAtIndex:row];
        
//        self.m_areaId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
//        
//        self.m_areaName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        
    }
    
   
    
    for (int i=0; i<[pickerView numberOfComponents]; i++) {
        
        [self.m_pickerView reloadComponent:i];
        
    }
 
    
}


//请求店铺信息 用于优惠信息处理
- (void)infoRequestGetMerchantShopInfo{
    
    // 经纬度 ======
    NSString *latitudeString = [CommonUtil getValueByKey:kLatitudeKey];
    NSString *lontiduteString = [CommonUtil getValueByKey:kLongitudeKey];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"MemberID",
                           key,@"Key",
                           self.m_shopId,@"MerchantShopID",
                           [NSString stringWithFormat:@"%f",[lontiduteString floatValue]],@"MapX",
                           [NSString stringWithFormat:@"%f",[latitudeString floatValue]],@"MapY",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];

    [httpClient request:@"GetMerchantShopInfo.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        if (success) {

            [SVProgressHUD dismiss];
            [CommonUtil addValue:[json valueForKey:@"Logo"] andKey:@"MarchantImageKey"];
            [CommonUtil addValue:[NSString stringWithFormat:@"满%@减%@",[ShopInfojson valueForKey:@"ManPrice"],[ShopInfojson valueForKey:@"MinuesPrice"]] andKey:YHDESCRIPTION];
            [CommonUtil addValue:[json valueForKey:@"MoreThanPrice"] andKey:MANKEY];
            [CommonUtil addValue:[json valueForKey:@"MinuesPrice"] andKey:JIANKEY];
            
            ShopInfojson = json;

            [self judgeTotalPrice];
            [self.m_tableView reloadData];

            
        }else{
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)judgeTotalPrice{
    
    NSString *manString = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:MANKEY]];
    float manValue = [manString floatValue];
    
    self.FirstBuyYHPrice = [NSString stringWithFormat:@"%@",[ShopInfojson valueForKey:@"FirstBuyYHPrice"]];
    self.ManPrice = [NSString stringWithFormat:@"%@",[ShopInfojson valueForKey:@"ManPrice"]];
    self.ZengPin = [NSString stringWithFormat:@"%@",[ShopInfojson valueForKey:@"ZengPin"]];
    
    if ([[NSString stringWithFormat:@"%@",[ShopInfojson valueForKey:@"IsZCFirstBuy"]] isEqualToString:@"1"]&&[[NSString stringWithFormat:@"%@",[ShopInfojson valueForKey:@"IsFirstBuy"]] isEqualToString:@"1"]) {
        //满足首付条件（必须是商家支持首付，并且用户是首次购买）
        //支持了首次购买就不可以同时支持满立减
        self.IsZCFirstBuy=@"1";
        self.IsZCHowMuchLess=@"0";
        //满立赠，也是同时满足【满】和【支持】两个条件
        if ([[NSString stringWithFormat:@"%@",[ShopInfojson valueForKey:@"IsZCMLZ"]] isEqualToString:@"1"]&&self.m_totalPrice>=[self.ManPrice floatValue]) {
            self.IsZCMLZ=@"1";
        }else
        {
            self.IsZCMLZ=@"0";
        }
    }else{
        //不满足首付条件的时候
        //满足满立减
        if ([[NSString stringWithFormat:@"%@",[ShopInfojson valueForKey:@"IsZCHowMuchLess"]] isEqualToString:@"1"]&&self.m_totalPrice >= manValue) {
            if ([[NSString stringWithFormat:@"%@",[ShopInfojson valueForKey:@"IsZCMLZ"]] isEqualToString:@"1"]&&self.m_totalPrice>=[self.ManPrice floatValue]) {
                self.IsZCFirstBuy=@"0";
                self.IsZCHowMuchLess=@"1";
                self.IsZCMLZ=@"1";
            }else
            {
                self.IsZCFirstBuy=@"0";
                self.IsZCHowMuchLess=@"1";
                self.IsZCMLZ=@"0";
            }
            
        }else
        {
            if ([[NSString stringWithFormat:@"%@",[ShopInfojson valueForKey:@"IsZCMLZ"]] isEqualToString:@"1"]&&self.m_totalPrice>=[self.ManPrice floatValue]) {
                self.IsZCFirstBuy=@"0";
                self.IsZCHowMuchLess=@"0";
                self.IsZCMLZ=@"1";
            }else
            {
                self.IsZCFirstBuy=@"0";
                self.IsZCHowMuchLess=@"0";
                self.IsZCMLZ=@"0";
            }
        }
        
    }

    NSString *jianString = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:JIANKEY]];
    float jianValue = [jianString floatValue];
    
    //IsZCFirstBuy已经判断是【支持】【是首次】同时满足
    if ([self.IsZCFirstBuy isEqualToString:@"1"]) {
        self.isYouhui=@"1";
        float value = self.m_totalPrice - [self.FirstBuyYHPrice floatValue];
        self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",value];
    }else
    {
        if ([self.IsZCHowMuchLess isEqualToString:@"1"]) {
//            // 判断总价格是否大于满的价格，如果大于的话则显示优惠的信息，不大于的则不显示
            
                self.isYouhui = @"1";
                
                float value = self.m_totalPrice - jianValue;
                
                self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",value];
        
        }else{
            if ([self.IsZCMLZ isEqualToString:@"1"]) {
                
                self.isYouhui = @"1";
                self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",self.m_totalPrice];
                
            }else
            {
                self.isYouhui = @"0";
                
                self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",self.m_totalPrice];
                
            }
        }
    }
    
}


@end
