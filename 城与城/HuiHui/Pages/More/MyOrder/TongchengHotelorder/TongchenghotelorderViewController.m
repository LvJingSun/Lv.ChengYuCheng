//
//  TongchenghotelorderViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-3-19.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "TongchenghotelorderViewController.h"
#import "CommonUtil.h"
#import "TongchenghotelorderTableViewCell.h"
@interface TongchenghotelorderViewController ()
@property (weak, nonatomic) IBOutlet PullTableView *Tongcheng_hotelOrdertableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *m_moveImgV;
@property (weak, nonatomic) IBOutlet UIButton *m_waitpayBtn;
@property (weak, nonatomic) IBOutlet UIButton *m_buyedBtn;
@end

@implementation TongchenghotelorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pageIndex = 1;
    [self.Tongcheng_hotelOrdertableView setDelegate:self];
    [self.Tongcheng_hotelOrdertableView setDataSource:self];
    [self.Tongcheng_hotelOrdertableView setPullDelegate:self];
    self.Tongcheng_hotelOrdertableView.pullBackgroundColor = [UIColor whiteColor];
    self.Tongcheng_hotelOrdertableView.useRefreshView = YES;
    self.Tongcheng_hotelOrdertableView.useLoadingMoreView= YES;
    
//    Ctrip_WAITPAY = @"XCWeiFuKuan";
//    Ctrip_OldIN  = @"XCYiFuKuan";
    [self setTitle:@"同程网酒店订单"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    self.m_emptyLabel.hidden = YES;
    
//    self.m_typeString = Ctrip_WAITPAY;
//    [self setLeft:YES withRight:NO];
        [self requestOrderSubmit];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc{
    
    [self.Tongcheng_hotelOrdertableView setDelegate:nil];
    [self.Tongcheng_hotelOrdertableView setDataSource:nil];
    [self.Tongcheng_hotelOrdertableView setPullDelegate:nil];
    
}
// 滑块移动位置
//- (void)moveImageMoveTo:(CGFloat)rectPoint
//{
//    [UIView beginAnimations:@"Flips1" context:(__bridge void *)(self)];
//    [UIView setAnimationDuration:0.3];
//    self.m_moveImgV.frame = CGRectMake(rectPoint, 40, 159, 4);
//    [UIView commitAnimations];
//}

//- (IBAction)typeChange:(id)sender{
//    
//    UIButton *btn = (UIButton *)sender;
//    
//    if ( btn.tag == 100 ) {
//        
//        [self setLeft:YES withRight:NO];
//        // 设置滑块滚动的坐标
//        [self moveImageMoveTo:0];
//        
//    }else{
//        
//        [self setLeft:NO withRight:YES];
//        // 设置滑块滚动的坐标
//        [self moveImageMoveTo:161];
//        
//    }
//    
//}

//- (void)setLeft:(BOOL)isLeft withRight:(BOOL)isRight{
//    
//    self.m_waitpayBtn.selected = isLeft;
//    self.m_buyedBtn.selected = isRight;
//    
//    if ( isLeft ) {
//        
//        self.m_waitpayBtn.userInteractionEnabled = NO;
//        self.m_buyedBtn.userInteractionEnabled = YES;
//        
//        self.m_typeString = Ctrip_WAITPAY;
//        
//        
//    }else{
//        
//        self.m_waitpayBtn.userInteractionEnabled = YES;
//        self.m_buyedBtn.userInteractionEnabled = NO;
//        
//        self.m_typeString = Ctrip_OldIN;
//    }
//    
//    // 请求数据
//}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_productList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"OrderCellIdentifier";
    
    TongchenghotelorderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TongchenghotelorderTableViewCell" owner:self options:nil];
        
        cell = (TongchenghotelorderTableViewCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    NSDictionary * dic = [self.m_productList objectAtIndex:indexPath.row];
    cell.HotelName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"hotelName"]];
    cell.RoomName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"roomName"]];
    cell.roomCount.text = [NSString stringWithFormat:@"%@间",[dic objectForKey:@"roomCount"]];
    
    NSString *time = [NSString stringWithFormat:@"%@",[dic objectForKey:@"createDate"]];

    if (time.length>19) {
        time = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"createDate"]]substringToIndex:19];
    }
    
    cell.TimeName.text = [NSString stringWithFormat:@"预订时间：\t%@",time];
    
    cell.payAmount.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"payAmount"]];
    
     NSInteger  orderStatus = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"orderStatus"]] integerValue];
    
    switch (orderStatus) {
        case 1:
            cell.orderStatus.text = @"酒店待确认";
            cell.orderStatus.textColor = RGBACKTAB;
            break;
        case 3:
            cell.orderStatus.text = @"已确认";
            cell.orderStatus.textColor = RGBACKTAB;
            break;
        case 4:
            cell.orderStatus.text = @"已入住";
            cell.orderStatus.textColor = RGBACKTAB;
            break;
        default:
            cell.orderStatus.text = @"已取消";
            cell.orderStatus.textColor = [UIColor lightGrayColor];
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TongchenghoteldetailorderViewController * VC = [[TongchenghoteldetailorderViewController alloc]initWithNibName:@"TongchenghoteldetailorderViewController" bundle:nil];
    VC.OrderdetailDic = [self.m_productList objectAtIndex:indexPath.row];
    VC.m_id = [[self.m_productList objectAtIndex:indexPath.row] objectForKey:@"orderId"];
    VC.delegate = self;
    [self.navigationController pushViewController:VC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 92;
}

#pragma mark - 请求数据



- (void)requestOrderSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    //   orderStatus 订单状态 , 0：所有订单,即返回包含所有订单状态的订单列表1：新建待确认,2：取消,3：酒店已确认 ,4：客人入住,5：客人未住,6：暂存 ）
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSString stringWithFormat:@"%ld", (long)pageIndex],   @"pageIndex",
                           @"0",@"orderStatus",
//                           @"",@"bookMan",
//                           @"",@"bookMobile",
                           [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:ACCOUNT]],@"bookMobile",
//                           @"",@"endDate",
//                           @"",@"guestMobile",
//                           @"",@"guestName",
//                           @"",@"orderId",
//                           @"",@"orderType",
//                           @"",@"pageSize",
//                           @"",@"startDate",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient requestScenery:@"Hotel/GetTCHotelOrderList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *resultList = [json valueForKey:@"orderList"];
            
            if (pageIndex == 1) {
                if (resultList == nil || resultList.count == 0) {
                    [self.m_productList removeAllObjects];
                    
                    self.Tongcheng_hotelOrdertableView.hidden = YES;
                    
                    self.m_emptyLabel.hidden = NO;
                    
//                    if ( self.m_typeString == Ctrip_WAITPAY ) {
//                        self.m_emptyLabel.text = @"暂无待付款的订单！";
//                    }else{
//                        self.m_emptyLabel.text = @"暂无已付款的订单！";
//                    }
                    return;
                } else {
                    
                    self.m_productList = resultList;
                    
                    self.m_emptyLabel.hidden = YES;
                    
                    self.Tongcheng_hotelOrdertableView.hidden = NO;
                    
                }
            } else {
                
                self.Tongcheng_hotelOrdertableView.hidden = NO;
                
                if (resultList == nil || resultList.count == 0) {
                    pageIndex--;
                } else {
                    [self.m_productList  addObjectsFromArray:resultList];
                }
            }
            [self.Tongcheng_hotelOrdertableView reloadData];
        } else {
            if (pageIndex > 1) {
                pageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.Tongcheng_hotelOrdertableView.pullTableIsRefreshing = NO;
        self.Tongcheng_hotelOrdertableView.pullTableIsLoadingMore = NO;

    
    } failure:^(NSError *error) {
        if (pageIndex > 1) {
            pageIndex--;
        }
        [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试！"];
        self.Tongcheng_hotelOrdertableView.pullTableIsRefreshing = NO;
        self.Tongcheng_hotelOrdertableView.pullTableIsLoadingMore = NO;
        
    }];
    
}


#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    pageIndex = 1;
    [self requestOrderSubmit];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    pageIndex++;
    [self performSelector:@selector(requestOrderSubmit) withObject:nil];
}

-(void)CancelSuccess
{
    pageIndex = 1;
    [self requestOrderSubmit];
    
}


@end
