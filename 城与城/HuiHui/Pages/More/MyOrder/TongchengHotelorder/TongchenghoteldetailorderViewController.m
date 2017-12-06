//
//  TongchenghoteldetailorderViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-3-19.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "TongchenghoteldetailorderViewController.h"
#import "TongchenghoteldetailorderTableViewCell.h"

@interface TongchenghoteldetailorderViewController ()

@end

@implementation TongchenghoteldetailorderViewController
@synthesize OrderdetailDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        OrderdetailDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"订单详情"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    [self setRightButtonWithTitle:@"取消" action:@selector(rightClicked)];
    allpaylabel.text = [NSString stringWithFormat:@"￥%@",[OrderdetailDic objectForKey:@"payAmount"]];
    [self requestOrderSubmit];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}


- (void)leftClicked{
    
    [self goBack];
    
}

-(void)rightClicked{
    UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:@"取消订单原因" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"行程变更",@"不满意服务",@"预订流程不方便",@"信息错误重新预订",@"变更流程不方便",@"通过其他更优惠的渠道预订了酒店",@"其他原因",nil];
    sheet.tag = 10002;
    [sheet showInView:self.view];
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
            return 3;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 4;
            break;
        default:
            return 1;
            break;
    }
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
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            
            cell = [self tableView1:tableView cellForRowAtIndexPath:indexPath];
        }else{
            
            cell = [self tableView0:tableView cellForRowAtIndexPath:indexPath];
        }
        
    }else if (indexPath.section ==1){
        
        cell = [self tableView3:tableView cellForRowAtIndexPath:indexPath];
        
    }else if (indexPath.section ==2){
        
        if (indexPath.row == 2) {
            
            cell = [self tableView1:tableView cellForRowAtIndexPath:indexPath];
            
        }else{
            
            cell = [self tableView2:tableView cellForRowAtIndexPath:indexPath];
        }
        
    }else if (indexPath.section ==3){
        
        cell = [self tableView4:tableView cellForRowAtIndexPath:indexPath];
        
    }
    
    return cell;
}



// 第0行显示的数据
- (UITableViewCell *)tableView0:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    TongchenghoteldetailorderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TongchenghoteldetailorderTableViewCell" owner:self options:nil];
        
        cell = (TongchenghoteldetailorderTableViewCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            cell.titlelabel.text = @"订单状态";
            
            NSInteger  orderStatus = [[NSString stringWithFormat:@"%@",[OrderdetailDic objectForKey:@"orderStatus"]] integerValue];
            
            switch (orderStatus) {
                case 1:
                    cell.detaillabel.text = @"酒店待确认";
                    break;
                case 2:
                    cell.detaillabel.text = @"已取消";
                    break;
                case 3:
                    cell.detaillabel.text = @"酒店已确认";
                    break;
                case 4:
                    cell.detaillabel.text = @"客人入住";
                    break;
                case 5:
                    cell.detaillabel.text = @"客人未住";
                    break;
            }

            
        }else if (indexPath.row ==2){
            cell.titlelabel.text = @"会员返利";
            cell.detaillabel.text = [NSString stringWithFormat:@"￥%@",[OrderdetailDic objectForKey:@"rebate"]];
        }
    }
    
    
    
    return cell;
    
    
}

- (UITableViewCell *)tableView1:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    TongchenghoteldetailorderTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TongchenghoteldetailorderTableViewCell" owner:self options:nil];
        
        cell = (TongchenghoteldetailorderTableViewCell1 *)[nib objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if (indexPath.section ==0) {
        if (indexPath.row ==1) {
            cell.titlelabel1.text = @"订单编号";
            cell.titlelabel2.text = @"预订日期";
            cell.detaillabel1.text = [NSString stringWithFormat:@"%@",[OrderdetailDic objectForKey:@"orderId"]];
            
            cell.detaillabel2.text = [[NSString stringWithFormat:@"%@",[OrderdetailDic objectForKey:@"createDate"]] substringToIndex:19];
            
        }
    }else if (indexPath.section ==2) {
        if (indexPath.row ==2) {
            cell.titlelabel1.text = @"入住时间";
            cell.titlelabel2.text = @"最晚到店时间";
            cell.detaillabel1.text = [NSString stringWithFormat:@"%@--%@",[[OrderdetailDic objectForKey:@"comeDate"] substringToIndex:10],[[OrderdetailDic objectForKey:@"leaveDate"]substringToIndex:10]];
            
            cell.detaillabel2.text = [NSString stringWithFormat:@"%@",[OrderdetailDic objectForKey:@"arriveTime"]];
            cell.detaillabel2.text = [cell.detaillabel2.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            
        }
    }
    
    
    return cell;
    
    
}


- (UITableViewCell *)tableView2:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    TongchenghoteldetailorderTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TongchenghoteldetailorderTableViewCell" owner:self options:nil];
        cell = (TongchenghoteldetailorderTableViewCell2 *)[nib objectAtIndex:2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if (indexPath.row ==0) {
        cell.detaillabel.text = [NSString stringWithFormat:@"%@",[OrderdetailDic objectForKey:@"hotelName"]];
        cell.detaillabel.text = [cell.detaillabel.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        
        cell.lingimg.hidden = NO;
    }else
    {
        if (indexPath.row ==1) {
            cell.lingimg.hidden = YES;
            cell.detaillabel.text = [NSString stringWithFormat:@"%@    %@间",[OrderdetailDic objectForKey:@"roomName"],[OrderdetailDic objectForKey:@"roomCount"]];
            cell.detaillabel.text = [cell.detaillabel.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            
            
        }else if (indexPath.row ==3)
        {
            cell.detaillabel.text = [NSString stringWithFormat:@"%@",[OrderdetailDic objectForKey:@"hotelAddr"]];
            cell.detaillabel.text = [cell.detaillabel.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            
            cell.lingimg.hidden = YES;
        }
    }
    
    
    
    
    
    return cell;
    
    
}

- (UITableViewCell *)tableView3:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    TongchenghoteldetailorderTableViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TongchenghoteldetailorderTableViewCell" owner:self options:nil];
        cell = (TongchenghoteldetailorderTableViewCell3 *)[nib objectAtIndex:3];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.detaillabel.layer.masksToBounds = YES;//设置圈角
    cell.detaillabel.layer.cornerRadius = 5.0;
    
    return cell;
    
    
}

- (UITableViewCell *)tableView4:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    TongchenghoteldetailorderTableViewCell4 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TongchenghoteldetailorderTableViewCell" owner:self options:nil];
        
        cell = (TongchenghoteldetailorderTableViewCell4 *)[nib objectAtIndex:4];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    [cell.detailBtn addTarget:self action:@selector(chosetelphoen) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
    
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            return 65;
            
        }else{
            
            return 40;
        }
        
    }else if (indexPath.section ==1){
        
        return 50;
        
    }else if (indexPath.section ==2){
        
        if (indexPath.row == 2) {
            
            return 65;
            
        }else{
            
            return 40;
        }
        
    }else if (indexPath.section ==3){
        
        return 70;
        
    }
    return 0;
}




-(void)chosetelphoen
{
    NSString *tel = [NSString stringWithFormat:@"%@",[OrderdetailDic objectForKey:@"hotelTel"]];
    UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:tel,nil];
    sheet.tag = 10001;
    [sheet showInView:self.view];
    
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 10001)
    {
        if (buttonIndex==0)
        {
            NSString *tel = [NSString stringWithFormat:@"%@",[OrderdetailDic objectForKey:@"hotelTel"]];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[tel stringByReplacingOccurrencesOfString:@"-" withString:@""]]]];
        }
        
    }else if (actionSheet.tag == 10002)
    {
        switch (buttonIndex) {
            case 0:
                cancleType = @"1";
                [self CancelOrder];
                break;
            case 1:
                cancleType = @"3";
                [self CancelOrder];
                break;
            case 2:
                cancleType = @"6";
                [self CancelOrder];
                break;
            case 3:
                cancleType = @"5";
                [self CancelOrder];
                break;
            case 4:
                cancleType = @"7";
                [self CancelOrder];
                break;
            case 5:
                cancleType = @"2";
                [self CancelOrder];
                break;
            case 6:
                cancleType = @"3";
                [self CancelOrder];
                break;
                
            default:
                break;
                
        }
        
    }
    
    
}



- (void)requestOrderSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }

    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.m_id,@"orderId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient requestScenery:@"Hotel/GetTCHotelOrderDetail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *resultList = [json valueForKey:@"result"];
            if(resultList.count!=0){
                OrderdetailDic = (NSMutableDictionary*)[resultList objectAtIndex:0];
            }
            
            [detailtable reloadData];
        } else {
  
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {

        [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试！"];

    
    }];
}


-(void)CancelOrder
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.m_id,@"serialId",
                           [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:ACCOUNT]],@"mobile",
                           cancleType,@"cancelReasonCode",
                           nil];
    [SVProgressHUD showWithStatus:@"数据请求中..."];
    [httpClient requestScenery:@"Hotel/CancelOrder_xml.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        if (success) {
            [SVProgressHUD showSuccessWithStatus:msg];
            [self.delegate CancelSuccess];
            [self goBack];
        }else{
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试！"];
    }];
}


@end
