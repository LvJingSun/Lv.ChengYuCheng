//
//  Ctrip_hotelPlaceorderViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-1-4.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "Ctrip_hotelPlaceorderViewController.h"
#import "Ctrip_hotelPOTableViewCell.h"
#import "CommonUtil.h"

@interface Ctrip_hotelPlaceorderViewController ()

@property (strong, nonatomic)  NSMutableDictionary *Ctrip_POpickviewDIC;//下单的数据

@end

@implementation Ctrip_hotelPlaceorderViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.Ctrip_hotelInfomation = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Ctrip_POpickviewDIC = [[NSMutableDictionary alloc]initWithCapacity:0];
    [self setTitle:@"订单填写"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self.view addSubview:self.PO_alphaView];
    self.PO_alphaView.alpha = 0;
    
    NSArray *array= @[@"1间",@"2间",@"3间",@"4间",@"5间",@"6间",@"7间",@"8间",@"9间",@"10间"];//房间数
    _RoomNumpickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
    [self.view addSubview:_RoomNumpickview];
    
    
    //为了匹配是否是同一天
    NSDateFormatter *dateFor = [[NSDateFormatter alloc] init];
    [dateFor setDateFormat:@"yyy-MM-dd"];
    NSString *currentDate = [dateFor stringFromDate:[NSDate date]];
    
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"HH:mm"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *NowDate = [dateFormatter dateFromString:currentDateStr];
    
    
    NSDate *NowDate6 = [dateFormatter dateFromString:@"06:00"];
    NSDate *NowDate20 = [dateFormatter dateFromString:@"20:00"];
    NSDate *NowDate24 = [dateFormatter dateFromString:@"23:59"];
    
    NSMutableArray *Timearray= [[NSMutableArray alloc]initWithCapacity:0];
    
    
    NSLog(@"%@,%@",[self.Ctrip_hotelInfomation objectForKey:@"startTimeRequest"],currentDate);
    
    //比较时间日期的大小
    if (![[NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"startTimeRequest"]] isEqualToString:currentDate]) {
        [Timearray addObject:@"06:00之前"];
        [Timearray addObject:@"20:00之前"];
        [Timearray addObject:@"23:59之前"];
        [self.Ctrip_hotelInfomation setObject:@"20:00之前" forKey:@"InTime"];
        [self.Ctrip_hotelInfomation setObject:@"20:00" forKey:@"lastCheckInTime"];
    }else{
    
    if ([NowDate timeIntervalSinceDate:NowDate6]<0.0) {
        [Timearray addObject:@"06:00之前"];
        [Timearray addObject:@"20:00之前"];
        [Timearray addObject:@"23:59之前"];
        [self.Ctrip_hotelInfomation setObject:@"20:00之前" forKey:@"InTime"];
        [self.Ctrip_hotelInfomation setObject:@"20:00" forKey:@"lastCheckInTime"];
    }else if ([NowDate timeIntervalSinceDate:NowDate20]<0.0){
        [Timearray addObject:@"20:00之前"];
        [Timearray addObject:@"23:59之前"];
        [self.Ctrip_hotelInfomation setObject:@"20:00之前" forKey:@"InTime"];
        [self.Ctrip_hotelInfomation setObject:@"20:00" forKey:@"lastCheckInTime"];
    }else if ([NowDate timeIntervalSinceDate:NowDate24]<0.0){
        [Timearray addObject:@"23:59之前"];
        [self.Ctrip_hotelInfomation setObject:@"23:59之前" forKey:@"InTime"];
        [self.Ctrip_hotelInfomation setObject:@"23:59" forKey:@"lastCheckInTime"];
    }
    }

    _TimeINpickview=[[ZHPickView alloc] initPickviewWithArray:Timearray isHaveNavControler:NO];
    [self.view addSubview:_TimeINpickview];

    self.Ctrip_HotelName.text = [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"HotelName"]];
    self.Ctrip_RoomName.text = [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"RoomTypeName"]];
    self.Ctrip_TimeName.text = [NSString stringWithFormat:@"入住:%@    离店:%@    %@",[self.Ctrip_hotelInfomation objectForKey:@"startTime"],[self.Ctrip_hotelInfomation objectForKey:@"endTime"],[self.Ctrip_hotelInfomation objectForKey:@"InNumDays"]];
    
    [self.Ctrip_hotelInfomation setObject:@"1间" forKey:@"RoomNum"];
    [self.Ctrip_hotelInfomation setObject:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_NAME]] forKey:@"customers_0"];//默认联系人
    [self.Ctrip_hotelInfomation setObject:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:ACCOUNT]] forKey:@"PhoneNum"];


    [self WriteALLprice];
    
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    //给self.view添加一个手势监测；
    [self.Ctrip_Headview addGestureRecognizer:singleRecognizer];

    [self setExtraCellLineHidden:self.Ctrip_POtableview];
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    [self.view endEditing:YES];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];

}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    Ctrip_hotelPOTableViewCell *cell = (Ctrip_hotelPOTableViewCell *)[self.Ctrip_POtableview cellForRowAtIndexPath:_indexPath];
    cell.detail.text = resultString;
    if (_indexPath.section == 0) {
        //人数发生变化 再检测是否可预订
        [self.Ctrip_hotelInfomation setObject:resultString forKey:@"RoomNum"];
        [self.Ctrip_POtableview reloadData];
        [self WriteALLprice];
        [self CheckDIngdangSure:resultString];

    }else if(_indexPath.section ==2)
    {
        [self.Ctrip_hotelInfomation setObject:resultString forKey:@"InTime"];
        [self.Ctrip_hotelInfomation setObject:[resultString substringToIndex:5] forKey:@"lastCheckInTime"];
//        startTimeRequest

    }
    
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return [[NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"RoomNum"]] integerValue];
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 1;
            break;
        default:
            break;
    }

    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        UITableViewCell *cell = nil;
        if (indexPath.section ==0) {
        if ( indexPath.row == 0 ) {
    
            cell = [self tableView0:tableView cellForRowAtIndexPath:indexPath];
        }

        }
        else if ( indexPath.section ==1 ){
            
            cell = [self tableView1:tableView cellForRowAtIndexPath:indexPath];
    
        }else if (indexPath.section ==2){
            
            if (indexPath.row ==0) {
                
                cell = [self tableView1:tableView cellForRowAtIndexPath:indexPath];

            }else if (indexPath.row ==1)
            {
                cell = [self tableView0:tableView cellForRowAtIndexPath:indexPath];

            }
        }else if (indexPath.section ==3)
        {
            cell = [self tableView2:tableView cellForRowAtIndexPath:indexPath];

        }
        
        return cell;
    
}

// 第0行显示的数据
- (UITableViewCell *)tableView0:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    Ctrip_hotelPOTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Ctrip_hotelPOTableViewCell" owner:self options:nil];
        
        cell = (Ctrip_hotelPOTableViewCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    if (indexPath.section ==0) {
      
        cell.title.text = @"房间数";
        cell.detail.text = [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"RoomNum"]];
        cell.detailRight.hidden = YES;

    }else if (indexPath.section ==2 && indexPath.row ==1)
    {
        cell.title.text = @"到店时间";
        cell.detail.text = [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"InTime"]];
        cell.detailRight.hidden = NO;

    }
    
    return cell;
  
}

// 第1行显示的数据
- (UITableViewCell *)tableView1:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section ==1) {
        
        static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
        
        Ctrip_hotelPOTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if ( cell == nil ) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Ctrip_hotelPOTableViewCell" owner:self options:nil];
            cell = (Ctrip_hotelPOTableViewCell1 *)[nib objectAtIndex:1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.title.text = @"入住人";
        
        if (indexPath.row ==0) {
            cell.titleView.hidden = NO;
            
            if (![CommonUtil getValueByKey:Ctrip_RealName]) {
                cell.detail.text = [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"customers_0"]];
            }else{
                cell.detail.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:Ctrip_RealName]];
            }
        }else{
            cell.detail.text = [[NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:[NSString stringWithFormat:@"customers_%d",indexPath.row]]] stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            [self.Ctrip_hotelInfomation setObject:cell.detail.text forKey:[NSString stringWithFormat:@"customers_%d",indexPath.row]];
        }
        
        if ([[NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"RoomNum"]] integerValue]/2 ==indexPath.row) {
            cell.titleView.hidden = NO;
        }else{
            cell.titleView.hidden = YES;
        }
        [cell.titleBtn addTarget:self action:@selector(Checkincompleting) forControlEvents:UIControlEventTouchUpInside];
        
        cell.detail.tag = indexPath.row;
        cell.detail.delegate = self;
        return cell;


    }else if (indexPath.section ==2 && indexPath.row ==0)
    {
        static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
        
        Ctrip_hotelPOTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Ctrip_hotelPOTableViewCell" owner:self options:nil];
            
            cell = (Ctrip_hotelPOTableViewCell2 *)[nib objectAtIndex:2];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.title.text = @"境内手机";
        cell.detail.text =  [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"PhoneNum"]];
        cell.detail.delegate = self;
        cell.detail.tag =999;
        return cell;

    }
    
    return nil;
    
}

// 第3行显示的数据
- (UITableViewCell *)tableView2:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    Ctrip_hotelPOTableViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Ctrip_hotelPOTableViewCell" owner:self options:nil];
        
        cell = (Ctrip_hotelPOTableViewCell3 *)[nib objectAtIndex:3];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    cell.title.layer.masksToBounds = YES;//设置圈角
    cell.title.layer.cornerRadius = 5.0;
    cell.title2.layer.masksToBounds = YES;//设置圈角
    cell.title2.layer.cornerRadius = 5.0;

    return cell;
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    [self.view endEditing:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField;
{
    if (textField.tag ==999) {
        [self.Ctrip_hotelInfomation setObject:@"" forKey:@"PhoneNum"];

    }else{
    [self.Ctrip_hotelInfomation setObject:@"" forKey:[NSString stringWithFormat:@"customers_%d",textField.tag]];
    }

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField;{

    if (textField.tag ==999) {
        [self.Ctrip_hotelInfomation setObject:textField.text forKey:@"PhoneNum"];
        
    }else{
        [self.Ctrip_hotelInfomation setObject:textField.text forKey:[NSString stringWithFormat:@"customers_%d",textField.tag]];
    }
    
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section ==1) {
        return 45.0f;
    }else if (indexPath.section ==3) {
        return 152.0f;
    }
    return 44.0f;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    if (indexPath.section ==0||indexPath.section ==2) {
        Ctrip_hotelPOTableViewCell *cell = (Ctrip_hotelPOTableViewCell *)[self.Ctrip_POtableview cellForRowAtIndexPath:indexPath];
        
        if ([cell.title.text isEqualToString:@"房间数"]) {
//            _indexPath = indexPath;
//            _RoomNumpickview.delegate=self;
//            [UIView animateWithDuration:0.3 animations:^{
//                self.PO_alphaView.alpha = 0.3;
//                _RoomNumpickview.frame = CGRectMake(0,WindowSize.size.height-240-64, WindowSize.size.width, 240);
//            } completion:^(BOOL finished){
//            }];

        }else if ([cell.title.text isEqualToString:@"到店时间"])
        {
            _indexPath = indexPath;
            _TimeINpickview.delegate = self;
            [UIView animateWithDuration:0.3 animations:^{
                self.PO_alphaView.alpha = 0.3;
                _TimeINpickview.frame = CGRectMake(0,WindowSize.size.height-240-64, WindowSize.size.width, 240);
            } completion:^(BOOL finished){
            }];
        }

    }
}

//隐藏picker
- (IBAction)HidetoobarDonBtnHaveClick:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.PO_alphaView.alpha = 0;
        _RoomNumpickview.frame = CGRectMake(0, WindowSize.size.height, WindowSize.size.width, 240);
        _TimeINpickview.frame = CGRectMake(0, WindowSize.size.height, WindowSize.size.width, 240);
    } completion:^(BOOL finished){
    }];
    [self.view endEditing:YES];

}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    [self hiddenNumPadDone:nil];
    if (textField.tag ==999) {
        [self.Ctrip_POtableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else{
    [self.Ctrip_POtableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:1]atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }

}

//入住人填写说明
-(void)Checkincompleting
{
    [self.view endEditing:YES];
    [self alertWithMessage:@"1、预订酒店需要提供入住人的姓名。需与入住时所持证件完成一致。\n2、中文姓名中不能包含英文字母。" tag:0 delegate:nil];
    
}

//显示总价钱
-(void)WriteALLprice
{
    self.Ctrip_ALLListPrice.text = [NSString stringWithFormat:@"%.2f",[[self.Ctrip_hotelInfomation objectForKey:@"ListPrice"] floatValue]*[[self.Ctrip_hotelInfomation objectForKey:@"RoomNum"] integerValue]];
}


//检测房间数是否可以下订单
-(void)CheckDIngdangSure:(NSString *)resultString
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }

    AppHttpClient* httpClient = [AppHttpClient sharedCtrip];

    [self showHudInView:self.view hint:@"正在检测..."];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"HotelCode"]],@"hotelId",
                           [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"HotelRoomCode"]],@"roomTypeCode",
                           [resultString stringByReplacingOccurrencesOfString:@"间" withString:@""],@"roomCount",//房间数
                           [resultString stringByReplacingOccurrencesOfString:@"间" withString:@""],@"guestCount",//客人数量
                           [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"startTimeRequest"]],@"checkinTime",
                           [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"endTimeRequest"]],@"lastCheckInTime",
                           nil];
    [httpClient requestCtrip:@"CheckHotelAvai.ashx" parameters:param success:^(NSJSONSerialization* json) {
        [SVProgressHUD dismiss];
        [self hideHud];
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {

            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [self showHint:msg];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"当前房间数不可预订，请重新选择！"];
        
    }];
    
}

//下单
-(IBAction)Ctrip_hotelplaceorder:(id)sender{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *guestInfoS = nil;
    NSMutableArray *guestInfosArray = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i =0; i<[[NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"RoomNum"]] integerValue]; i++) {
        NSString *PER = [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:[NSString stringWithFormat:@"customers_%d",i]]];
        if (![PER isEqualToString:@""]) {
            [guestInfosArray addObject:PER];
        }
    }
    guestInfoS = [guestInfosArray componentsJoinedByString:@"$"];
    NSString *isPerRoom;
    if (guestInfosArray.count ==[[NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"RoomNum"]] integerValue]) {
        isPerRoom = @"1";
    }else{
        isPerRoom = @"0";
    }
    
    NSString * NightCount =[NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"InNumDays"]];
    NightCount = [NightCount stringByReplacingOccurrencesOfString:@"住" withString:@""];
    NightCount = [NightCount stringByReplacingOccurrencesOfString:@"晚" withString:@""];

    AppHttpClient* httpClient = [AppHttpClient sharedCtrip];
    [self showHudInView:self.navigationController.view.window hint:@"正在下单..."];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:MEMBER_ID]],@"memberId",
                            [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:hotelCityCode]],@"cityId",
                           [NSString stringWithFormat:@"%@",self.Ctrip_ALLListPrice.text],@"amountBeforeTax",
                           @"",@"beforeCheckInTime",
                           [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"startTimeRequest"]],@"inRoomDate",
                           [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"endTimeRequest"]],@"offRoomDate",
                           [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"customers_0"]],@"contactName",
//                           @"测试勿回电话",@"contactName",
                           @"",@"contactEmail",
                           guestInfoS,@"customers",
                           [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"HotelCode"]],@"hotelCode",
                           [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"HotelRoomCode"]],@"roomTypeCode",
                           isPerRoom,@"isPerRoom",
                           [NSString stringWithFormat:@"%@ %@",[self.Ctrip_hotelInfomation objectForKey:@"startTimeRequest"],[self.Ctrip_hotelInfomation objectForKey:@"lastCheckInTime"]],@"lastCheckInTime",
                           [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"PhoneNum"]],@"mobilePhone",
//                            @"18706206831",@"mobilePhone",
                           [[NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"RoomNum"]] stringByReplacingOccurrencesOfString:@"间" withString:@""],@"roomCount",
                           NightCount,@"NightCount",
                           nil];
    
    NSLog(@"%@",param);
    [httpClient requestCtrip:@"HotelRoomBook.ashx" parameters:param success:^(NSJSONSerialization* json) {
        [SVProgressHUD dismiss];
        [self hideHud];
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        if (success) {
     
            NSString *MSG = [NSString stringWithFormat:@"%@\n%@\n入住:%@\n离店:%@\n%@\n*重要提醒*\n我们还会电话为您再次确认订单，请耐心等待，付款方式:到店付款 :)",self.Ctrip_HotelName.text,self.Ctrip_RoomName.text,[self.Ctrip_hotelInfomation objectForKey:@"startTime"],[self.Ctrip_hotelInfomation objectForKey:@"endTime"],[self.Ctrip_hotelInfomation objectForKey:@"InNumDays"]];
            [self alertWithTitle:@"您的订单预订成功！" Message:MSG cancelBtn:@"确定" otherBtn:nil tag:1001 delegate:self];
            
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"customers_0"]] andKey:Ctrip_RealName];
            
        } else {
            
            [self showHint:msg];
            
        }
        
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"订单提交失败，请稍后再试！"];
        
    }];
    
    

    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 1001 ) {
        
        [self leftClicked];

//        if ( buttonIndex == 1 ) {
//
//            [self.hotelorderdelegate Ctrip_hotelorderdelegate];
//            
//        }
    }
    
}


@end
