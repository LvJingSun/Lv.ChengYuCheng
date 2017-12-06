//
//  Ctrip_hotelorderdetailViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-1-8.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "Ctrip_hotelorderdetailViewController.h"
#import "Ctrip_hotelorderdetailTableViewCell.h"

@interface Ctrip_hotelorderdetailViewController ()

@end

@implementation Ctrip_hotelorderdetailViewController
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

}
- (void)leftClicked{

    [self goBack];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    
    Ctrip_hotelorderdetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Ctrip_hotelorderdetailTableViewCell" owner:self options:nil];
        
        cell = (Ctrip_hotelorderdetailTableViewCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        

    }
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            cell.titlelabel.text = @"订单状态";
            cell.detaillabel.text = @"已确认";
            cell.detaillabel.text = [NSString stringWithFormat:@"已确认-%@",[OrderdetailDic objectForKey:@"StatusName"]];
            cell.detaillabel.text = [cell.detaillabel.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];

        }else if (indexPath.row ==2){
            cell.titlelabel.text = @"支付方式";
            cell.detaillabel.text = @"到店付款";
        }
    }
    
    
    
    return cell;
    
    
}

- (UITableViewCell *)tableView1:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    Ctrip_hotelorderdetailTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Ctrip_hotelorderdetailTableViewCell" owner:self options:nil];
        
        cell = (Ctrip_hotelorderdetailTableViewCell1 *)[nib objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if (indexPath.section ==0) {
        if (indexPath.row ==1) {
            cell.titlelabel1.text = @"订单编号";
            cell.titlelabel2.text = @"预订日期";
            cell.detaillabel1.text = [NSString stringWithFormat:@"%@",[OrderdetailDic objectForKey:@"ResIDValue"]];
            cell.detaillabel1.text = [cell.detaillabel1.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];

            cell.detaillabel2.text = [[NSString stringWithFormat:@"%@",[OrderdetailDic objectForKey:@"CreateDate"]] substringToIndex:10];
            cell.detaillabel2.text = [cell.detaillabel2.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];

        }
    }else if (indexPath.section ==2) {
        if (indexPath.row ==2) {
            cell.titlelabel1.text = @"入住时间";
            cell.titlelabel2.text = @"最晚到店时间";
            cell.detaillabel1.text = [NSString stringWithFormat:@"%@-%@    %@晚",[OrderdetailDic objectForKey:@"InRoomDateZh"],[OrderdetailDic objectForKey:@"OffRoomDateZh"],[OrderdetailDic objectForKey:@"NightCount"]];
            cell.detaillabel1.text = [cell.detaillabel1.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];

            cell.detaillabel2.text = [NSString stringWithFormat:@"%@",[OrderdetailDic objectForKey:@"LastCheckInTime"]];
            cell.detaillabel2.text = [cell.detaillabel2.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];

        }
    }
    
    
    return cell;
    
    
}


- (UITableViewCell *)tableView2:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    Ctrip_hotelorderdetailTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Ctrip_hotelorderdetailTableViewCell" owner:self options:nil];
        cell = (Ctrip_hotelorderdetailTableViewCell2 *)[nib objectAtIndex:2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if (indexPath.row ==0) {
        cell.detaillabel.text = [NSString stringWithFormat:@"%@",[OrderdetailDic objectForKey:@"HotelName"]];
        cell.detaillabel.text = [cell.detaillabel.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];

        cell.lingimg.hidden = NO;
    }else
    {
        if (indexPath.row ==1) {
            cell.lingimg.hidden = YES;
            cell.detaillabel.text = [NSString stringWithFormat:@"%@    %@间",[OrderdetailDic objectForKey:@"RoomTypeName"],[OrderdetailDic objectForKey:@"RoomCount"]];
            cell.detaillabel.text = [cell.detaillabel.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];


        }else if (indexPath.row ==3)
        {
            cell.detaillabel.text = [NSString stringWithFormat:@"%@",[OrderdetailDic objectForKey:@"Address"]];
            cell.detaillabel.text = [cell.detaillabel.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];

            cell.lingimg.hidden = YES;
        }
    }
    
    
    
    
    
    return cell;
    
    
}

- (UITableViewCell *)tableView3:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    Ctrip_hotelorderdetailTableViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Ctrip_hotelorderdetailTableViewCell" owner:self options:nil];
        cell = (Ctrip_hotelorderdetailTableViewCell3 *)[nib objectAtIndex:3];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.detaillabel.layer.masksToBounds = YES;//设置圈角
    cell.detaillabel.layer.cornerRadius = 5.0;
    
    return cell;
    
    
}

- (UITableViewCell *)tableView4:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    Ctrip_hotelorderdetailTableViewCell4 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Ctrip_hotelorderdetailTableViewCell" owner:self options:nil];
        
        cell = (Ctrip_hotelorderdetailTableViewCell4 *)[nib objectAtIndex:4];
        
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
    UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"400-921-0661",nil];
    sheet.tag = 10001;
    [sheet showInView:self.view];
    
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 10001)
    {
        if (buttonIndex==0)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4009210661"]];
        }
        
    }
    
    
}


@end
