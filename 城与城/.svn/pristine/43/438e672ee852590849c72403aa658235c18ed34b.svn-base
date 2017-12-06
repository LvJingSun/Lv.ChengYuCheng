//
//  CtriphoteldetailViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-9-16.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "CtriphoteldetailViewController.h"

#import "CtriphoteldetailCell.h"

#import "CPD_imagelistViewController.h"

#import "CtripHBMapViewController.h"

#import "CommonUtil.h"
#import "UIImageView+AFNetworking.h"

#import "Ctrip_RoomServiceTableViewCell.h"
#import "Ctrip_hotelInfomationViewController.h"
#import "CtripwebViewController.h"

@interface CtriphoteldetailViewController ()

@property (nonatomic,weak) IBOutlet UITableView *HotelTableView;


@end

@implementation CtriphoteldetailViewController

@synthesize Ctriphotel_detailheadD;
@synthesize m_showRoomName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        Ctriphotel_detailheadD = [[NSMutableDictionary alloc]initWithCapacity:0];
        self.Ctrip_hotelInfomation = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"酒店详情";
    self.m_showViewRoom.hidden = YES;
    self.m_showDetailRoom.layer.masksToBounds = YES;//设置圈角
    self.m_showDetailRoom.layer.cornerRadius = 5.0;
    self.CheckRoomAvai.layer.masksToBounds = YES;//设置圈角
    self.CheckRoomAvai.layer.cornerRadius = 4.0;
    self.m_showViewRoom.alpha = 0;
    self.m_showUIControl.alpha = 0;
    
    self.m_showDetailRoom.frame = CGRectMake(8, (WindowSize.size.height - 416)/2, 304, 416);
    
    [self.CheckRoomAvai addTarget:self action:@selector(CheckDIngdangSure) forControlEvents:UIControlEventTouchUpInside];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
//    [self setRightButtonWithNormalImage:@"xxqd.png" withTitle:@"分享" action:@selector(rightClicked)];
//    self.navigationController.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self Ctrip_HotelDetailRequest];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    if (Pushdingdan) {
//        [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(Pushhotelorder) userInfo:nil repeats:NO];
//    }
//    Pushdingdan = NO;
}

-(void)Pushhotelorder
{
    Ctrip_hotelorderdetailViewController *VC = [[Ctrip_hotelorderdetailViewController alloc]initWithNibName:@"Ctrip_hotelorderdetailViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)leftClicked{
    
    [self goBack];
}


- (void)rightClicked{
   
}

- (void)Ctrip_hotelorderdelegate;
{
    Pushdingdan = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    [self.navigationController.view.window addSubview:self.m_showViewRoom];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
    
    [self.navigationController.view.window removeFromSuperview];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSMutableArray *HotelDetailRoom = [self.Ctriphotel_detailheadD objectForKey:@"HotelRoomList"];

    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            if (HotelDetailRoom.count ==0 && (!RequestFin)) {
                return HotelDetailRoom.count +2;
            }
            return HotelDetailRoom.count +1;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            cell = [self tableView0:tableView cellForRowAtIndexPath:indexPath];

        }
        
    }else if (indexPath.section ==1){
        if (indexPath.row == 0) {
            
            cell = [self tableView1:tableView cellForRowAtIndexPath:indexPath];
            
        }else if (indexPath.row ==1)
        {
            cell = [self tableView2:tableView cellForRowAtIndexPath:indexPath];
            
        }
        
    }else if (indexPath.section ==2){
        
        if (indexPath.row == 0) {
            
            cell = [self tableView3:tableView cellForRowAtIndexPath:indexPath];

        }else{
            
            cell = [self tableView4:tableView cellForRowAtIndexPath:indexPath];

        }
    }
    
    return cell;
}



// 第0行显示的数据
- (UITableViewCell *)tableView0:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    CtriphoteldetailCell0 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CtriphoteldetailCell" owner:self options:nil];
        
        cell = (CtriphoteldetailCell0 *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.CPD_PhotoIMG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.Ctriphotel_detailheadD objectForKey:@"ImgText"]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
    }
    
    
    
    [cell.CPD_PhotoBtn addTarget:self action:@selector(CPD_imageview) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.hotel_PingjiaBtn addTarget:self action:@selector(CPD_Pingjia) forControlEvents:UIControlEventTouchUpInside];
    
    cell.hotel_name.text = [NSString stringWithFormat:@"%@",[self.Ctriphotel_detailheadD objectForKey:@"HotelName"]];
    [self.Ctrip_hotelInfomation setObject:[NSString stringWithFormat:@"%@",[self.Ctriphotel_detailheadD objectForKey:@"HotelName"]] forKey:@"HotelName"];
    
    cell.hotel_type.text = [NSString stringWithFormat:@"%@",[self.Ctriphotel_detailheadD objectForKey:@"SegmentCategoryName"]];

    cell.hotel_secoreA.text = [NSString stringWithFormat:@"%.1f",[[self.Ctriphotel_detailheadD objectForKey:@"CtripCommRate"] floatValue]];
    
    cell.hotel_secore1.text = [NSString stringWithFormat:@"%.1f",[[self.Ctriphotel_detailheadD objectForKey:@"CommSurroundingRate"] floatValue]];
    
    cell.hotel_secore2.text = [NSString stringWithFormat:@"%.1f",[[self.Ctriphotel_detailheadD objectForKey:@"CommFacilityRate"] floatValue]];
    
    cell.hotel_secore3.text = [NSString stringWithFormat:@"%.1f",[[self.Ctriphotel_detailheadD objectForKey:@"CommServiceRate"] floatValue]];

    cell.hotel_secore4.text = [NSString stringWithFormat:@"%.1f",[[self.Ctriphotel_detailheadD objectForKey:@"CommCleanRate"] floatValue]];
    
    NSMutableArray *count =[self.Ctriphotel_detailheadD objectForKey:@"HotelPicList"];
    cell.hotel_HI.text = [NSString stringWithFormat:@"%lu张",(unsigned long)count.count];
    
    if ([[self.Ctriphotel_detailheadD objectForKey:@"HotelPicList"] count]>0) {
        NSDictionary *Img = [[self.Ctriphotel_detailheadD objectForKey:@"HotelPicList"] objectAtIndex:0];
        [cell.CPD_PhotoIMG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[Img objectForKey:@"Url"]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
    }
    
   
    return cell;
    
    
}

// 第1行显示的数据
- (UITableViewCell *)tableView1:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    CtriphoteldetailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CtriphoteldetailCell" owner:self options:nil];
        
        cell = (CtriphoteldetailCell1 *)[nib objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    cell.hotel_address.text = [NSString stringWithFormat:@"%@",[self.Ctriphotel_detailheadD objectForKey:@"Address"]];

    return cell;
    
}

// 第2行显示的数据
- (UITableViewCell *)tableView2:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    CtriphoteldetailCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CtriphoteldetailCell" owner:self options:nil];
        
        cell = (CtriphoteldetailCell2 *)[nib objectAtIndex:2];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }

    cell.hotel_WhenBuild.text =[[NSString stringWithFormat:@"%@开业",[self.Ctriphotel_detailheadD objectForKey:@"WhenBuild"]] stringByReplacingOccurrencesOfString:@"(null)" withString:@"--年--月--日开业"];

    return cell;
}


// 第3行显示的数据
- (UITableViewCell *)tableView3:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    CtriphoteldetailCell3 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CtriphoteldetailCell" owner:self options:nil];
        
        cell = (CtriphoteldetailCell3 *)[nib objectAtIndex:3];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    cell.hotel_StartTimeANDendTime.text = [NSString stringWithFormat:@"%@  %@",[self.Ctrip_hotelInfomation objectForKey:@"startTime"],[self.Ctrip_hotelInfomation objectForKey:@"InNumDays"]];

    return cell;
}


// 第4行显示的数据
- (UITableViewCell *)tableView4:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    CtriphoteldetailCell4 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CtriphoteldetailCell" owner:self options:nil];
        
        cell = (CtriphoteldetailCell4 *)[nib objectAtIndex:4];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        cell.hotel_RoomPOBtn.layer.masksToBounds = YES;//设置圈角
        cell.hotel_RoomPOBtn.layer.cornerRadius = 4.0;
        
    }
    
    NSMutableArray *HotelDetailRoom =[self.Ctriphotel_detailheadD objectForKey:@"HotelRoomList"];
    
    if (HotelDetailRoom.count ==0 && (!RequestFin)) {
        cell.hotel_ActivingView.hidden = NO;
        return cell;
    }
    cell.hotel_ActivingView.hidden = YES;
    [cell.hotel_ActivingView removeFromSuperview];

    cell.hotel_RoomTypeName.text =[NSString stringWithFormat:@"%@",[[HotelDetailRoom objectAtIndex:indexPath.row -1] objectForKey:@"RoomTypeName"]];
    
    cell.hotel_ListPrice.text =[NSString stringWithFormat:@"￥%@",[[HotelDetailRoom objectAtIndex:indexPath.row -1] objectForKey:@"ListPrice"]];
    
    [cell.hotel_ImgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[HotelDetailRoom objectAtIndex:indexPath.row -1] objectForKey:@"ImgUrl"]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
    
    if ([[NSString stringWithFormat:@"%@",[[HotelDetailRoom objectAtIndex:indexPath.row -1] objectForKey:@"BreakFast"]] isEqualToString:@"false"]) {
        cell.hotel_BreakFastBedTypeName.text = [NSString stringWithFormat:@"无早  %@",[NSString stringWithFormat:@"%@",[[HotelDetailRoom objectAtIndex:indexPath.row -1] objectForKey:@"BedTypeName"]]];
    }else
    {
        cell.hotel_BreakFastBedTypeName.text = [NSString stringWithFormat:@"有早  %@",[NSString stringWithFormat:@"%@",[[HotelDetailRoom objectAtIndex:indexPath.row -1] objectForKey:@"BedTypeName"]]];
    }

    cell.hotel_RoomPOBtn.tag = indexPath.row -1;
    [cell.hotel_RoomPOBtn addTarget:self action:@selector(CheckDIngCellBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}





#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 120;
            
        }
        
    }else if (indexPath.section ==1){
        if (indexPath.row == 0) {
            return 44;
            
        }
        else if (indexPath.row ==1){
            return 72;
            
        }
        
    }else if (indexPath.section ==2){
        
        if (indexPath.row == 0) {
            return 44;
            
        }else{
            return 78;
            
        }
    }
    return 0;
}




#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
        }
        
    }else if (indexPath.section ==1){
        if (indexPath.row == 0) {
            
            [self CPD_Bmap];
            
        }else if (indexPath.row ==1)
        {
            [self CPD_Infomation];
        }
        
    }else if (indexPath.section ==2){
        
        if (indexPath.row == 0) {
            
            
        }else{
            
            [self DidselectShowRoom:indexPath.row -1];
        }
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

        if (section == 0) {
            return 0.000001f;
        }
        return 20.0f;

}

//酒店评价
-(void)CPD_Pingjia
{
//    NSLog(@"%@,%@",[NSString stringWithFormat:@"%@",[self.Ctriphotel_detailheadD objectForKey:@"HotelDescriptiveInfoID"]],);

        CtripwebViewController * VC = [[CtripwebViewController alloc]initWithNibName:@"CtripwebViewController" bundle:nil];
        VC.Ctrip_webstring = [NSString stringWithFormat:@"http://wap.ctrip.com/webapp/hotel/hoteldetail/dianping/%@.html",[NSString stringWithFormat:@"%@",[self.Ctriphotel_detailheadD objectForKey:@"HotelCode"]]];
        [self.navigationController pushViewController:VC animated:YES];
}

//酒店图片预览
-(void)CPD_imageview
{
    NSMutableArray *HotelDetailRoom =[self.Ctriphotel_detailheadD objectForKey:@"HotelPicList"];
    if (HotelDetailRoom.count !=0) {
        CPD_imagelistViewController *VC = [[CPD_imagelistViewController alloc]init];
        for (int iii =0; iii<HotelDetailRoom.count; iii++) {
            NSString *url = [NSString  stringWithFormat:@"%@",[[HotelDetailRoom objectAtIndex:iii] objectForKey:@"Url"]];
            [VC.myImageUrlArr addObject:url];
        }
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}
//酒店地图
-(void)CPD_Bmap
{
    CtripHBMapViewController *VC = [[CtripHBMapViewController alloc]init];
    VC.Latitude = [NSString stringWithFormat:@"%@",[self.Ctriphotel_detailheadD objectForKey:@"Latitude"]];
    VC.Longitude = [NSString stringWithFormat:@"%@",[self.Ctriphotel_detailheadD objectForKey:@"Longitude"]];
    VC.AdressTitle = [NSString stringWithFormat:@"%@",[self.Ctriphotel_detailheadD objectForKey:@"Address"]];
    [self.navigationController pushViewController:VC animated:YES];
    
}
//酒店详细介绍及设施
-(void)CPD_Infomation
{
    Ctrip_hotelInfomationViewController *VC = [[Ctrip_hotelInfomationViewController alloc]initWithNibName:@"Ctrip_hotelInfomationViewController"bundle:nil];
    VC.ServiceDesList = [self.Ctriphotel_detailheadD objectForKey:@"ServiceDesList"];
    VC.Description = [self.Ctriphotel_detailheadD objectForKey:@"Description"];
    [self.navigationController pushViewController:VC animated:YES];

}


#pragma mark - 酒店请求
-(void)Ctrip_HotelDetailRequest{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    AppHttpClient* httpClient = [AppHttpClient sharedCtrip];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSString stringWithFormat:@"%@",[self.Ctriphotel_detailheadD objectForKey:@"HotelCityCode"]],@"cityCode",
                           [NSString stringWithFormat:@"%@",[self.Ctriphotel_detailheadD objectForKey:@"HotelDescriptiveInfoID"]],@"hotelDescriptiveInfoID",
                           [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"startTimeRequest"]],@"startTime",
                           [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"endTimeRequest"]],@"endTime",
                           nil];
    NSLog(@"%@",param);
    
    [httpClient requestCtrip:@"HotelDetail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        [SVProgressHUD dismiss];
        BOOL success = [[json valueForKey:@"status"] boolValue];
         RequestFin = YES;
        if (success) {
            self.Ctriphotel_detailheadD = [json valueForKey:@"HotelDetailSession"];
            [self.HotelTableView reloadData];
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            [self.HotelTableView reloadData];

        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"获取酒店失败"];
        RequestFin = YES;
        [self.HotelTableView reloadData];

    }];
    
}


-(void)DidselectShowRoom:(int)Indexpath
{
    self.m_showViewRoom.hidden = NO;
    [self WriteToRoomInfomation:Indexpath];
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.m_showViewRoom.alpha = 1;
                         self.m_showUIControl.alpha = 0.4;
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];

}

-(IBAction)DidselectHideRoom:(id)sender
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.m_showViewRoom.alpha = 0;
                         self.m_showUIControl.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         self.m_showViewRoom.hidden = YES;
                     }
     ];
    
}

-(void)WriteToRoomInfomation:(int)row;
{
    NSMutableArray *HotelDetailRoom =[self.Ctriphotel_detailheadD objectForKey:@"HotelRoomList"];
    self.m_showRoomName.text =[NSString stringWithFormat:@"%@",[[HotelDetailRoom objectAtIndex:row] objectForKey:@"RoomTypeName"]];
    self.m_showRoomPrice.text =[NSString stringWithFormat:@"%@元",[[HotelDetailRoom objectAtIndex:row] objectForKey:@"ListPrice"]];
    [self.m_showRoomImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[HotelDetailRoom objectAtIndex:row] objectForKey:@"ImgUrl"]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
    indexRow = row;//检测房间是否可预订，房间列表数组的下标，
    self.CheckRoomAvai.enabled = YES;

    [self DetailRoomCell:HotelDetailRoom androw:row];
    //tabble滚动第0行
    [self.DetailRoomTableview reloadData];
//    [self.DetailRoomTableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]atScrollPosition:UITableViewScrollPositionTop animated:NO];
    [self.DetailRoomTableview setContentOffset:CGPointMake(0,0) animated:NO];

}


-(void)DetailRoomCell:(NSMutableArray *)HotelDetailRoom androw:(int)ROW
{
    
    [self.DetailRoomTableview initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSArray * count  = [[HotelDetailRoom objectAtIndex:ROW] objectForKey:@"RoomFacilityDetailList"];
         NSInteger Num=count.count+4;
         return Num;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         
         Ctrip_RoomServiceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Ctrip_RoomServiceTableViewCell"];
         if (!cell){
             cell=[[[NSBundle mainBundle]loadNibNamed:@"Ctrip_RoomServiceTableViewCell" owner:self options:nil]objectAtIndex:0];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
         }
         if (indexPath.row>=4) {
             NSMutableArray * RoomFacilityDetailList =[[HotelDetailRoom objectAtIndex:ROW] objectForKey:@"RoomFacilityDetailList"];
             NSDictionary * DIC = [RoomFacilityDetailList objectAtIndex:indexPath.row -4];
             cell.m_RoomService.text =[NSString stringWithFormat:@"%@",[DIC objectForKey:@"DescriptiveText"]];
             return cell;
         }
         switch (indexPath.row) {
             case 0:
                 cell.m_RoomService.text =[NSString stringWithFormat:@"面积  %@㎡",[[HotelDetailRoom objectAtIndex:ROW] objectForKey:@"RoomSize"]];
                 break;
             case 1:
                 cell.m_RoomService.text =[NSString stringWithFormat:@"可住  %@人",[[HotelDetailRoom objectAtIndex:ROW] objectForKey:@"StandardOccupancy"]];
                 break;
             case 2:
                 cell.m_RoomService.text =[[NSString stringWithFormat:@"床宽  %@米",[[HotelDetailRoom objectAtIndex:ROW] objectForKey:@"Size"]] stringByReplacingOccurrencesOfString:@"or" withString:@"或"];
                 break;
             case 3:
                 cell.m_RoomService.text =[NSString stringWithFormat:@"楼层  %@层",[[HotelDetailRoom objectAtIndex:ROW] objectForKey:@"Floor"]];
                 break;
             default:
                 break;
         }
         return cell;

     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         //         RightCell *cell=(RightCell*)[tableView cellForRowAtIndexPath:indexPath];
     }];
    
    [self.DetailRoomTableview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.DetailRoomTableview.layer setBorderWidth:0];
}

-(void)CheckDIngCellBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    indexRow = btn.tag;
    [self CheckDIngdangSure];
}


//验证酒店是否可以下订单
-(void)CheckDIngdangSure
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    self.CheckRoomAvai.enabled = NO;
    NSMutableArray *HotelDetailRoom =[self.Ctriphotel_detailheadD objectForKey:@"HotelRoomList"];
    
    [self.Ctrip_hotelInfomation setObject:[NSString stringWithFormat:@"%@",[[HotelDetailRoom objectAtIndex:indexRow] objectForKey:@"RoomTypeName"]] forKey:@"RoomTypeName"];
    [self.Ctrip_hotelInfomation setObject:[NSString stringWithFormat:@"%@",[[HotelDetailRoom objectAtIndex:indexRow] objectForKey:@"ListPrice"]] forKey:@"ListPrice"];
    [self.Ctrip_hotelInfomation setObject:[NSString stringWithFormat:@"%@",[self.Ctriphotel_detailheadD objectForKey:@"HotelCode"]] forKey:@"HotelCode"];
    [self.Ctrip_hotelInfomation setObject:[NSString stringWithFormat:@"%@",[[HotelDetailRoom objectAtIndex:indexRow] objectForKey:@"HotelRoomCode"]] forKey:@"HotelRoomCode"];

    
    AppHttpClient* httpClient = [AppHttpClient sharedCtrip];
    if (self.m_showViewRoom.hidden) {
        [self showHudInView:self.view hint:@"正在检测..."];
    }else{
    [self showHudInView:self.m_showDetailRoom hint:@"正在检测..."];
    }
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSString stringWithFormat:@"%@",[self.Ctriphotel_detailheadD objectForKey:@"HotelCode"]],@"hotelId",
                           [NSString stringWithFormat:@"%@",[[HotelDetailRoom objectAtIndex:indexRow] objectForKey:@"HotelRoomCode"]],@"roomTypeCode",
                           @"1",@"roomCount",//房间数
                           @"1",@"guestCount",//客人数量
                           [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"startTimeRequest"]],@"checkinTime",
                           [NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"endTimeRequest"]],@"lastCheckInTime",
                           nil];
    [httpClient requestCtrip:@"CheckHotelAvai.ashx" parameters:param success:^(NSJSONSerialization* json) {
        [SVProgressHUD dismiss];
        [self hideHud];
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [self DidselectHideRoom:nil];
            Ctrip_hotelPlaceorderViewController *VC = [[Ctrip_hotelPlaceorderViewController alloc]initWithNibName:@"Ctrip_hotelPlaceorderViewController" bundle:nil];
            VC.Ctrip_hotelInfomation = self.Ctrip_hotelInfomation;
            VC.hotelorderdelegate = self;
            [self.navigationController pushViewController:VC animated:YES];

        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [self showHint:msg];
            
        }
        
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"当前房间不可预订，请重新选择！"];
        
    }];
    
    
}


@end
