//
//  MenuSettingViewController.m
//  HuiHui
//
//  Created by mac on 15-8-16.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "MenuSettingViewController.h"
#import "MenuSettingTableViewCell.h"

@interface MenuSettingViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *m_total;

@property (weak, nonatomic) IBOutlet UITextField *m_jian;

@property (weak, nonatomic) IBOutlet UIButton *m_manlijianBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_waimaiBtn;

@property (weak, nonatomic) IBOutlet UIView *m_manlijianView;

@property (copy, nonatomic) NSString *m_Notice;//公告

@property (copy, nonatomic) NSString *m_PsMinutes;//配送时间N分钟送达
@property (copy, nonatomic) NSString *m_QsPrice;//起送价
@property (copy, nonatomic) NSString *m_PsPrice;//配送费（modeltype=2运费）

@property (copy, nonatomic) NSString *FirstBuyYHPrice;//首购减多少元
@property (copy, nonatomic) NSString *ManPrice;//满立赠
@property (copy, nonatomic) NSString *ZengPin;//满立赠多少元


// 满立减按钮触发的事件
- (IBAction)manlijianBtnClicked:(id)sender;
// 是否支持外卖的按钮触发的事件
- (IBAction)waimaiBtnClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *m_tableview;

@end

@implementation MenuSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        isManlijian = NO;
        
        isWaimai = NO;
        
        isGonggao = NO;
        
        IsZCMLZ = NO;
        
        IsZCFirstBuy = NO;
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"菜单设置"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"保存" action:@selector(settingClicked)];
    
    self.m_tableview.delegate = self;
    self.m_tableview.dataSource = self;
    [self setExtraCellLineHidden:self.m_tableview];
    
    // 请求数据进行赋值
    [self infoRequest];

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

- (void)settingClicked{
    
    [self.view endEditing:YES];
    
    // 如果支持满立减的话则要输入满立减的值
    if ( isManlijian ) {
       
        if ( self.m_total.text.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请输入满的价钱"];
            
            return;
            
        }
        
        if ( self.m_jian.text.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请输入减的价钱"];
            
            return;
            
        }
        
    }
    
    // 请求数据
    [self settingRequest];

}

- (void)infoRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    // IsZCHowMuchLess 是不是支持满立减（0否，1是）
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"MemberID",
                           key,@"Key",
                           nil];
    
    NSLog(@"params = %@",param);
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"GetMerchantMLJ.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSString *msg = [json valueForKey:@"msg"];
        
        NSLog(@"json = %@",json);
        
        if (success) {
            
            [SVProgressHUD dismiss];
            ModelType =[[NSString stringWithFormat:@"%@",[json valueForKey:@"ModelType"]] integerValue];
            
            // 获取支持外卖和支持满立减的参数
            NSString *l_isWaimai = [NSString stringWithFormat:@"%@",[json valueForKey:@"IsZCWaiMai"]];
            NSString *l_isManlijian = [NSString stringWithFormat:@"%@",[json valueForKey:@"IsZCHowMuchLess"]];
            //是否设置公告
            NSString *l_isgonggao = [NSString stringWithFormat:@"%@",[json valueForKey:@"IsZCNotice"]];
            //是否支持首次购买减
            IsZCFirstBuy = [[NSString stringWithFormat:@"%@",[json valueForKey:@"IsZCFirstBuy"]] integerValue];
            if (IsZCFirstBuy) {
                self.FirstBuyYHPrice =[NSString stringWithFormat:@"%@",[json valueForKey:@"FirstBuyYHPrice"]];
            }else{
                self.FirstBuyYHPrice =@"";
            }
            //是否支持满立赠
            IsZCMLZ = [[NSString stringWithFormat:@"%@",[json valueForKey:@"IsZCMLZ"]] integerValue];
            if (IsZCMLZ) {
                self.ManPrice =[NSString stringWithFormat:@"%@",[json valueForKey:@"ManPrice"]];
                self.ZengPin =[NSString stringWithFormat:@"%@",[json valueForKey:@"ZengPin"]];
            }else{
                self.ManPrice = @"";
                self.ZengPin = @"";
            }
            
            if ( [l_isWaimai isEqualToString:@"1"] ) {
                // 表示支持外卖
                [self.m_waimaiBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
                isWaimai = 1;
                //起送价，运费，时间
                self.m_QsPrice =[json valueForKey:@"QsPrice"];
                self.m_PsPrice =[json valueForKey:@"PsPrice"];
                self.m_PsMinutes =[json valueForKey:@"PsMinutes"];
                if ([self.m_QsPrice isEqualToString:@"0"]) {                    self.m_QsPrice =@"";
                }
                if ([self.m_PsPrice isEqualToString:@"0"]) {                    self.m_PsPrice =@"";
                }
                if ([self.m_PsMinutes isEqualToString:@"0"]) {                    self.m_PsMinutes =@"";
                }

                
            }else{
                [self.m_waimaiBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
                isWaimai = 0;
            }
            
            if ( [l_isManlijian isEqualToString:@"1"] ) {
                // 支持满立减
                [self.m_manlijianBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
                isManlijian = 1;
                self.m_manlijianView.hidden = NO;
                // 赋值 满立减的值进行赋值 如果不为0的话则表示设置过进行编辑的，如果为0的话则表示没设置过
                NSString *manString = [json valueForKey:@"Man"];
                NSString *jianString = [json valueForKey:@"Jian"];
                
                if ( [manString isEqualToString:@"0"] ) {
                    self.m_total.text = @"";
                }else{
                    self.m_total.text = manString;
                }
                if ( [jianString isEqualToString:@"0"] ) {
                    self.m_jian.text = @"";
                }else{
                    self.m_jian.text = jianString;
                }
            }else{
                [self.m_manlijianBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
                isManlijian = 0;
                self.m_manlijianView.hidden = YES;
            }
            
            if ( [l_isgonggao isEqualToString:@"1"] ) {
                // 公告
                isGonggao = 1;
                self.m_Notice = [NSString stringWithFormat:@"%@",[json valueForKey:@"Notice"]];
            }else{
                isGonggao = 0;
                self.m_Notice = @"";
            }
            
            
            [self.m_tableview reloadData];

            
        }else{
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)settingRequest{
    
    NSLog(@"isManlijian = %i",isManlijian);
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSString *man = @"";
    NSString *jian = @"";
    if ( isManlijian == 1 ) {
        jian = [NSString stringWithFormat:@"%@",self.m_jian.text];
        man = [NSString stringWithFormat:@"%@",self.m_total.text];
    }else{
        jian = @"";
        man = @"";
    }
    NSString *Notice= @"";
    if ( isGonggao == 1 ) {
        Notice = [NSString stringWithFormat:@"%@",self.m_Notice];
    }
    //支持外卖
    NSString *m_PsMinutes = @"";
    NSString *m_PsPrice = @"";
    NSString *m_QsPrice = @"";
    if (isWaimai) {
        m_PsMinutes=self.m_PsMinutes;
        m_PsPrice=self.m_PsPrice;
        m_QsPrice=self.m_QsPrice;
        if (ModelType==2) {
            m_PsMinutes=@"";
            m_QsPrice=@"";
        }else if (ModelType==1){
            m_PsMinutes=@"";
            m_PsPrice=@"";
            m_QsPrice=@"";
        }
    }else{
        m_PsMinutes=@"";
        m_PsPrice=@"";
        m_QsPrice=@"";
    }
    //满立赠
    NSString *ManPrice = @"";
    NSString *ZengPin = @"";
    if (IsZCMLZ) {
        ManPrice=self.ZengPin;
        ZengPin=self.ZengPin;
    }else{
        ManPrice=@"";
        ZengPin=@"";
    }
    //首购减
    NSString *FirstBuyYHPrice = @"";
    if (IsZCFirstBuy) {
        FirstBuyYHPrice=self.FirstBuyYHPrice;
    }else{
        FirstBuyYHPrice=@"";
    }
    
    // IsZCHowMuchLess 是不是支持满立减（0否，1是）
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"MemberID",
                           key,@"Key",
                           [NSString stringWithFormat:@"%i",isManlijian],@"IsZCHowMuchLess",
                           jian,@"MinuesPrice",
                           man,@"MoreThanPrice",
                           [NSString stringWithFormat:@"%i",isGonggao],@"IsZCNotice",
                           Notice,@"Notice",
                           [NSString stringWithFormat:@"%i",IsZCFirstBuy],@"IsZCFirstBuy",
                           FirstBuyYHPrice,@"FirstBuyYHPrice",
                           [NSString stringWithFormat:@"%i",isWaimai],@"IsZCWaiMai",
                           m_PsMinutes,@"PsMinutes",
                           m_PsPrice,@"PsPrice",
                           m_QsPrice,@"QsPrice",
                           [NSString stringWithFormat:@"%i",IsZCMLZ],@"IsZCMLZ",
                           ManPrice,@"ManPrice",
                           ZengPin,@"ZengPin",
                           
                           nil];
    
    
    NSLog(@"params = %@",param);
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"SetCloudMenuActivity_2.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSString *msg = [json valueForKey:@"msg"];
        
        NSLog(@"json = %@",json);
        
        
        if (success) {
            
            //            [SVProgressHUD dismiss];
            // 设置成功了之后返回上一级
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [self goBack];
            
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    if (textField.tag ==2000016) {
        [self hiddenNumPadDone:nil];
        return;
    }
    if (textField.tag ==2000014) {
        CGRect cellFrameInTableView = [self.m_tableview rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
        CGRect cellFrameInSuperview = [self.m_tableview convertRect:cellFrameInTableView toView:[self.m_tableview superview]];
        [self.m_tableview setContentOffset:CGPointMake(0, cellFrameInSuperview.origin.y) animated:YES];
    }
    [self showNumPadDone:nil];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    [textField resignFirstResponder];
    if (textField.tag ==1000011) {
        self.m_total.text = textField.text;
    }else if (textField.tag ==1000012){
        self.m_jian.text = textField.text;
    }else if (textField.tag ==2000011){
        self.m_PsMinutes = textField.text;
    }else if (textField.tag ==2000012){
        self.m_PsPrice = textField.text;
    }else if (textField.tag ==2000013){
        self.m_QsPrice = textField.text;
    }else if (textField.tag ==2000014){
        self.FirstBuyYHPrice = textField.text;
    }else if (textField.tag ==2000015){
        self.ManPrice = textField.text;
    }else if (textField.tag ==2000016){
        self.ZengPin = textField.text;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView;
{
    [self hiddenNumPadDone:nil];
    CGRect cellFrameInTableView = [self.m_tableview rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
    CGRect cellFrameInSuperview = [self.m_tableview convertRect:cellFrameInTableView toView:[self.m_tableview superview]];
    [self.m_tableview setContentOffset:CGPointMake(0, cellFrameInSuperview.origin.y) animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView;
{
    [textView resignFirstResponder];

    if (textView.tag ==1000013) {
        self.m_Notice = textView.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)manlijianBtnClicked:(id)sender {
    
    isManlijian = !isManlijian;
    
    if ( isManlijian ) {
        
        // 设置按钮的背景图片
        [self.m_manlijianBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
        
        self.m_manlijianView.hidden = NO;
        
    }else{
        
        // 设置按钮的背景图片
        [self.m_manlijianBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
        
        self.m_manlijianView.hidden = YES;

    }
    
    NSLog(@"manlijian = %i",isManlijian);
    
}

- (IBAction)waimaiBtnClicked:(id)sender {

    isWaimai = !isWaimai;
    
    if ( isWaimai ) {
        
        // 设置按钮的背景图片
        [self.m_waimaiBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
        
    }else{
        
        // 设置按钮的背景图片
        [self.m_waimaiBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
    }
    
    NSLog(@"isWaimai = %i",isWaimai);

    
}




#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    switch (section) {
        case 0:
            if (isWaimai) {
                //为1的时候不支持外卖
                if (ModelType==1) {
                    return 0;
                }
                return 1;
            }return 0;
            break;
        case 1:
            if (isManlijian) {
                return 1;
            }return 0;
            break;
        case 2:
            if (IsZCMLZ) {
                return 1;
            }return 0;
            break;
        case 3:
            if (IsZCFirstBuy) {
                return 1;
            }return 0;
            break;
        case 4:
            if (isGonggao) {
                return 1;
            }return 0;
            break;
        default:
            break;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    static NSString *cellIdentifier = @"MenuSettingTableViewCell";
    MenuSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MenuSettingTableViewCell" owner:self options:nil];
        cell = (MenuSettingTableViewCell *)[nib objectAtIndex:0];
    }
    
    switch (section) {
        case 0:
            cell.m_titleLabel.text = @"是否支持外卖";
            cell.m_imglin.hidden = NO;
            if (isWaimai) {
                cell.m_imglin.hidden = YES;
            }
            [cell.m_switcher setOn:isWaimai];
            break;
        case 1:
            cell.m_titleLabel.text = @"是否支持满立减";
            cell.m_imglin.hidden = NO;
            if (isManlijian) {
                cell.m_imglin.hidden = YES;
            }
            [cell.m_switcher setOn:isManlijian];

            break;
        case 2:
            cell.m_titleLabel.text = @"是否支持满立赠";
            cell.m_imglin.hidden = NO;
            if (IsZCMLZ) {
                cell.m_imglin.hidden = YES;
            }
            [cell.m_switcher setOn:IsZCMLZ];
            
            break;
        case 3:
            cell.m_titleLabel.text = @"是否支持首次购买优惠活动";
            cell.m_imglin.hidden = NO;
            if (IsZCFirstBuy) {
                cell.m_imglin.hidden = YES;
            }
            [cell.m_switcher setOn:IsZCFirstBuy];
            
            break;
        case 4:
            cell.m_titleLabel.text = @"是否发布公告";
            cell.m_imglin.hidden = NO;
            if (isGonggao) {
                cell.m_imglin.hidden = YES;
            }
            [cell.m_switcher setOn:isGonggao];

            break;
        default:
            break;
    }
    cell.m_switcher.tag = section;
    [cell.m_switcher addTarget:self action:@selector(ChangeSwitcher:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
    
}
#pragma mark tableView赋值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section==0) {
        if (ModelType==0) {
            static NSString *cellIdentifier = @"MenuSettingTableViewCell3";
            MenuSettingTableViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if ( cell == nil ) {
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MenuSettingTableViewCell" owner:self options:nil];
                cell = (MenuSettingTableViewCell3 *)[nib objectAtIndex:3];
            }
            cell.PsMinutes.text = self.m_PsMinutes;
            cell.PsPrice.text = self.m_PsPrice;
            cell.QsPrice.text = self.m_QsPrice;
            cell.PsMinutes.tag = 2000011;
            cell.PsPrice.tag = 2000012;
            cell.QsPrice.tag = 2000013;
            cell.PsMinutes.delegate = self;
            cell.PsPrice.delegate = self;
            cell.QsPrice.delegate = self;
            return cell;

        }else if (ModelType==2){
            static NSString *cellIdentifier = @"MenuSettingTableViewCell6";
            MenuSettingTableViewCell6 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if ( cell == nil ) {
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MenuSettingTableViewCell" owner:self options:nil];
                cell = (MenuSettingTableViewCell6 *)[nib objectAtIndex:6];
            }
            cell.PsPrice.text = self.m_PsPrice;
            cell.PsPrice.tag = 2000012;
            cell.PsPrice.delegate = self;

            return cell;

        }
        
    }else if (indexPath.section==1) {
        
        static NSString *cellIdentifier = @"MenuSettingTableViewCell1";
        MenuSettingTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if ( cell == nil ) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MenuSettingTableViewCell" owner:self options:nil];
            cell = (MenuSettingTableViewCell1 *)[nib objectAtIndex:1];
        }
        
        cell.m_total.text = self.m_total.text;
        cell.m_jian.text = self.m_jian.text;
        cell.m_total.tag = 1000011;
        cell.m_jian.tag = 1000012;
        cell.m_total.delegate = self;
        cell.m_jian.delegate = self;
        
        
        return cell;
        
    }else if (indexPath.section==2) {
        
        static NSString *cellIdentifier = @"MenuSettingTableViewCell5";
        MenuSettingTableViewCell5 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if ( cell == nil ) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MenuSettingTableViewCell" owner:self options:nil];
            cell = (MenuSettingTableViewCell5 *)[nib objectAtIndex:5];
        }
        cell.ManPrice.text = self.ManPrice;
        cell.ManPrice.delegate = self;
        cell.ManPrice.tag = 2000015;
        cell.ZengPin.text = self.ZengPin;
        cell.ZengPin.delegate = self;
        cell.ZengPin.tag = 2000016;
        return cell;
        
    }else if (indexPath.section==3) {
        
        static NSString *cellIdentifier = @"MenuSettingTableViewCell4";
        MenuSettingTableViewCell4 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if ( cell == nil ) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MenuSettingTableViewCell" owner:self options:nil];
            cell = (MenuSettingTableViewCell4 *)[nib objectAtIndex:4];
        }
        cell.FirstBuyYHPrice.text = self.FirstBuyYHPrice;
        cell.FirstBuyYHPrice.delegate = self;
        cell.FirstBuyYHPrice.tag = 2000014;

        return cell;
        
    }
    else if (indexPath.section==4)
    {
        
        static NSString *cellIdentifier = @"MenuSettingTableViewCell2";
        MenuSettingTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if ( cell == nil ) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MenuSettingTableViewCell" owner:self options:nil];
            cell = (MenuSettingTableViewCell2 *)[nib objectAtIndex:2];
        }
        cell.m_TejiaTextview.text = self.m_Notice;
        cell.m_TejiaTextview.delegate = self;
        cell.m_TejiaTextview.tag = 1000013;

        return cell;
        
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    switch (indexPath.section) {
        case 0:
            if (ModelType==2) {
                return 70.f;
            }
            return 125.f;
            break;
        case 1:
            return 70.f;
            break;
        case 2:
            return 70.f;
            break;
        case 3:
            return 70.f;
            break;
        case 4:
            return 125.f;
            break;
        default:
            return 0;
            break;
    }
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.1f;
}

-(void)ChangeSwitcher:(id)sender{
    
    UISwitch *switcher = (UISwitch *)sender;
    
    if ( switcher.tag == 0 ) {
        isWaimai = !isWaimai;

    }
    else if( switcher.tag == 1){
        isManlijian = !isManlijian;

    }
    else if( switcher.tag == 2){
        IsZCMLZ = !IsZCMLZ;
        
    }
    else if( switcher.tag == 3){
        IsZCFirstBuy = !IsZCFirstBuy;
        
    }
    else if( switcher.tag == 4){
        isGonggao = !isGonggao;

    }

    [self.m_tableview reloadData];
}


@end
