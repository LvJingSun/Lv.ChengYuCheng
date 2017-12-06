//
//  Ctrip_hotelorderlistViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-1-7.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "Ctrip_hotelorderlistViewController.h"
#import "CommonUtil.h"
#import "Ctrip_hotelOrderTableViewCell.h"
#import "Ctrip_hotelorderdetailViewController.h"

@interface Ctrip_hotelorderlistViewController ()

@property (weak, nonatomic) IBOutlet UITableView *Ctrip_hotelOrdertableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *m_moveImgV;
@property (weak, nonatomic) IBOutlet UIButton *m_waitpayBtn;
@property (weak, nonatomic) IBOutlet UIButton *m_buyedBtn;

@end

@implementation Ctrip_hotelorderlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Ctrip_WAITPAY = @"XCWeiFuKuan";
    Ctrip_OldIN  = @"XCYiFuKuan";
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"酒店订单"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
//    self.Ctrip_hotelOrdertableView.hidden = YES;
    self.m_emptyLabel.hidden = YES;
    
    self.m_typeString = Ctrip_WAITPAY;
    [self setLeft:YES withRight:NO];

}

- (void)leftClicked{
    
    [self goBack];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
//    if ( self.m_typeString == Ctrip_WAITPAY ) {
//        
//        // 默认选中待付款
//        [self setLeft:YES withRight:NO];
//        
//    }else{
//        
//        [self setLeft:NO withRight:YES];
//        
//    }
}

// 滑块移动位置
- (void)moveImageMoveTo:(CGFloat)rectPoint
{
    [UIView beginAnimations:@"Flips1" context:(__bridge void *)(self)];
    [UIView setAnimationDuration:0.3];
    self.m_moveImgV.frame = CGRectMake(rectPoint, 40, 159, 4);
    [UIView commitAnimations];
}

- (IBAction)typeChange:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 100 ) {
        
        [self setLeft:YES withRight:NO];
        
        // 设置滑块滚动的坐标
        [self moveImageMoveTo:0];
        
    }else{
        
        [self setLeft:NO withRight:YES];
        
        // 设置滑块滚动的坐标
        [self moveImageMoveTo:161];
        
    }
    
}

- (void)setLeft:(BOOL)isLeft withRight:(BOOL)isRight{
    
    self.m_waitpayBtn.selected = isLeft;
    
    self.m_buyedBtn.selected = isRight;
    
    if ( isLeft ) {
        
        self.m_waitpayBtn.userInteractionEnabled = NO;
        self.m_buyedBtn.userInteractionEnabled = YES;
        
        self.m_typeString = Ctrip_WAITPAY;
        
        
    }else{
        
        self.m_waitpayBtn.userInteractionEnabled = YES;
        self.m_buyedBtn.userInteractionEnabled = NO;
        
        self.m_typeString = Ctrip_OldIN;
    }
    
    // 请求数据
    [self requestOrderSubmit];
}

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
    
    Ctrip_hotelOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Ctrip_hotelOrderTableViewCell" owner:self options:nil];
        
        cell = (Ctrip_hotelOrderTableViewCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    NSDictionary * dic = [self.m_productList objectAtIndex:indexPath.row];
    cell.HotelName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"HotelName"]];
    cell.RoomName.text = [NSString stringWithFormat:@"%@    %@间",[dic objectForKey:@"RoomTypeName"],[dic objectForKey:@"RoomCount"]];
    cell.TimeName.text = [NSString stringWithFormat:@"预订时间：%@",[dic objectForKey:@"CreateDate"]];
    [cell setCtrip_hotelImage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"HotelImgText"]]];
    
    cell.HotelName.text = [cell.HotelName.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    cell.RoomName.text = [cell.RoomName.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    cell.TimeName.text = [cell.TimeName.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];

    

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Ctrip_hotelorderdetailViewController * VC = [[Ctrip_hotelorderdetailViewController alloc]initWithNibName:@"Ctrip_hotelorderdetailViewController" bundle:nil];
    VC.OrderdetailDic = [self.m_productList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 92;
}

#pragma mark - 请求数据
 //订单请求数据
- (void)requestOrderSubmit{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    // ordStatus	状态(XCYiFuKuan:已支付、XCWeiFuKuan待付款)
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    AppHttpClient* httpClient = [AppHttpClient sharedCtrip];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           self.m_typeString,@"status",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient requestCtrip:@"OrderList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        [self hideHud];
        if (success) {
            [SVProgressHUD dismiss];
            self.m_productList = [json valueForKey:@"OrderModelSessions"];
            if ( self.m_productList.count != 0 ) {
                self.m_emptyLabel.hidden = YES;
                self.Ctrip_hotelOrdertableView.hidden = NO;
                // 刷新列表
                [self.Ctrip_hotelOrdertableView reloadData];
            }else{
                self.m_emptyLabel.hidden = NO;
                self.Ctrip_hotelOrdertableView.hidden = YES;
                if ( self.m_typeString == Ctrip_WAITPAY ) {
                    self.m_emptyLabel.text = @"暂无待付款的订单！";
                }else{
                    self.m_emptyLabel.text = @"暂无已付款的订单！";
                }
            }
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [self hideHud];
        [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试！"];
    }];
    
}
@end
