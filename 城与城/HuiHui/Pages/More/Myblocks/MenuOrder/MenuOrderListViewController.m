//
//  MenuOrderListViewController.m
//  HuiHui
//
//  Created by mac on 15-10-17.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "MenuOrderListViewController.h"
#import "SegmentView.h"
#import "MenuOrderListTableViewCell.h"
#import "CardMenuOrderCell.h"
#import "PullTableView.h"
#import "MenuEvaluationViewController.h"
#import "HH_CardPayViewController.h"


@interface MenuOrderListViewController ()<PullTableViewDelegate,SegmentViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet PullTableView *MenuTableview;
    NSMutableArray *MenuDataArray;
    NSMutableArray *DetailListArray;
    
    NSInteger segmentType;//订单类别1-3
    NSInteger typeType;//订单状态（已支付未支付）1-4
    NSInteger Menupage;//页数
    
    SegmentView*segTypeType;//下面的状态选择器；
    UIView *segBGView;//选择器下面标签；
    
    NSInteger m_index;//点击订单标记的下标；
    
}

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UIControl *m_control;

@property (weak, nonatomic) IBOutlet UITableView *m_menuTableView;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageV;

@property (nonatomic, strong) IBOutlet UIView *m_footerView;

@property (weak, nonatomic) IBOutlet UIButton *m_leftB;//左侧按钮
@property (weak, nonatomic) IBOutlet UIButton *m_middleBBtn;
@property (weak, nonatomic) IBOutlet UIButton *m_rightB;
@property (weak, nonatomic) IBOutlet UILabel *MerchantShopName;

@property (copy, nonatomic) NSString *CloudMenuOrderID;//用于操作


// 取消订单
- (void)cancelOrderClicked;
// 立即支付
- (void)payNowClicked;
@end

@implementation MenuOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    self.m_emptyLabel.hidden = YES;
    self.m_imageV.alpha = 0.6;
    self.m_menuTableView.delegate = self;
    self.m_menuTableView.dataSource = self;
    [self.m_control setFrame:CGRectMake(0, self.view.frame.size.height, WindowSizeWidth, 0)];
    // 隐藏多余的分割线
    [self setExtraCellLineHidden:self.m_menuTableView];
    
    [self SetNavigationView];
    
    [self SetMenu];
    
    MenuDataArray = [[NSMutableArray alloc]initWithCapacity:0];
    DetailListArray = [[NSMutableArray alloc]initWithCapacity:0];

    MenuTableview.delegate = self;
    MenuTableview.dataSource = self;
    MenuTableview.separatorStyle = NO;
    [MenuTableview setPullDelegate:self];
    MenuTableview.pullBackgroundColor = [UIColor whiteColor];
    MenuTableview.useRefreshView = YES;
    MenuTableview.useLoadingMoreView = YES;
    Menupage=1;
    
    [self RequestSubmitGetMyCloudMenuOrder];

}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self HiddenControl:nil];

}

- (void)SetNavigationView
{
    SegmentView *  segOne = [[SegmentView alloc]initWithTitles:@[@"预约订单",@"外卖订单",@"物流订单"] withFram:CGRectMake(0, 2, 200, 35) withBtnWidth:kBtnWidth1 andSelected:YES];
    segOne.backgroundColor = [UIColor groupTableViewBackgroundColor];
    segOne.delegate = self;
    segOne.tag=1;
    segOne.layer.cornerRadius = 2;  // 将图层的边框设置为圆脚
    segOne.layer.masksToBounds = YES; // 隐藏边界
    segOne.layer.borderWidth = 1;  // 给图层添加一个有色边框
    segOne.layer.borderColor = RGBA(213, 213, 213, 1).CGColor;
    self.navigationItem.titleView = segOne;
    segmentType=1;
}

- (void)SetMenu
{
    segBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 33, kBtnWidth2, 2)];
    switch (segmentType) {
            //预约订单
        case 1:
            segTypeType = [[SegmentView alloc]initWithTitles:@[@"未支付",@"未消费",@"已支付",@"退款"] withFram:CGRectMake(0, 0, WindowSizeWidth, 35) withBtnWidth:kBtnWidth2 andSelected:NO];
            break;
        case 2:
            //外卖订单
            segTypeType = [[SegmentView alloc]initWithTitles:@[@"待付款",@"待配送",@"待评价",@"退款"] withFram:CGRectMake(0, 0, WindowSizeWidth, 35) withBtnWidth:kBtnWidth2 andSelected:NO];
            break;
        case 3:
            //物流订单
            segTypeType = [[SegmentView alloc]initWithTitles:@[@"待付款",@"待发货",@"待收货",@"待评价",@"退款"] withFram:CGRectMake(0, 0, WindowSizeWidth, 35) withBtnWidth:kBtnWidth3 andSelected:NO];
            segBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 33, kBtnWidth3, 2)];
            break;
        default:
            //默认预约订单
            segTypeType = [[SegmentView alloc]initWithTitles:@[@"待付款",@"待配送",@"待评价",@"退款"] withFram:CGRectMake(0, 0, WindowSizeWidth, 35) withBtnWidth:kBtnWidth2 andSelected:NO];
            break;
    }
    segBGView.backgroundColor = RGBACOLOR(100, 163, 243, 1);
    [segTypeType addSubview:segBGView];
    segTypeType.backgroundColor = [UIColor groupTableViewBackgroundColor];
    segTypeType.delegate = self;
    segTypeType.tag=2;
    segTypeType.layer.cornerRadius = 2;  // 将图层的边框设置为圆脚
    segTypeType.layer.masksToBounds = YES; // 隐藏边界
    segTypeType.layer.borderWidth = 1;  // 给图层添加一个有色边框
    segTypeType.layer.borderColor = RGBA(213, 213, 213, 1).CGColor;
    [self.view addSubview:segTypeType];
    typeType=1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
    
}

#pragma segmentView代理
- (void)segmentView:(SegmentView *)segmentView didSelectedSegmentAtIndex:(int)index
{
    [self HiddenControl:nil];

    if (segmentView.tag==1) {
        segmentType=index+1;
        typeType=1;
//        [segTypeType segemtBtnChange:0];
        [self SetMenu];
        segBGView.frame = CGRectMake(0, segBGView.frame.origin.y, segBGView.frame.size.width, segBGView.frame.size.height);

        
    }else if (segmentView.tag ==2){
        typeType=index+1;
        if (segmentType!=3) {
            segBGView.frame = CGRectMake(index*kBtnWidth2, segBGView.frame.origin.y, segBGView.frame.size.width, segBGView.frame.size.height);
        }else{
            segBGView.frame = CGRectMake(index*kBtnWidth3, segBGView.frame.origin.y, segBGView.frame.size.width, segBGView.frame.size.height);
        }
    }else{
    
    }
    
    [self RequestSubmitGetMyCloudMenuOrder];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ( tableView == MenuTableview ) {
        if (segmentType==2) {
            return 215;
        }
        return 185;
        
    }else{
        
        return 60.0f;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ( tableView == MenuTableview ) {
        
        return MenuDataArray.count;
        
    }else{
    
        return DetailListArray.count;

    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if ( tableView == MenuTableview ) {
        return nil;

    }else{
        
        if (typeType==1) {
            [self setBtnisHidden:2];
            [self.m_leftB setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.m_leftB addTarget:self action:@selector(cancelOrderClicked) forControlEvents:UIControlEventTouchUpInside];
            [self.m_rightB setTitle:@"立即支付" forState:UIControlStateNormal];
            [self.m_rightB addTarget:self action:@selector(payNowClicked) forControlEvents:UIControlEventTouchUpInside];
            
        }else if (typeType==2){
            [self setBtnisHidden:1];
            [self.m_middleBBtn setTitle:@"退款" forState:UIControlStateNormal];
            [self.m_middleBBtn addTarget:self action:@selector(MenuRefundClicked) forControlEvents:UIControlEventTouchUpInside];

        }else if (typeType==3){
            if (segmentType==3) {
                [self setBtnisHidden:2];
                [self.m_leftB setTitle:@"退款" forState:UIControlStateNormal];
                [self.m_leftB addTarget:self action:@selector(MenuRefundClicked) forControlEvents:UIControlEventTouchUpInside];
                [self.m_rightB setTitle:@"确认收货" forState:UIControlStateNormal];
                [self.m_rightB addTarget:self action:@selector(ConfirmReceivingClicked) forControlEvents:UIControlEventTouchUpInside];


            }else{
                [self setBtnisHidden:1];
                [self.m_middleBBtn setTitle:@"立即评价" forState:UIControlStateNormal];
                [self.m_middleBBtn addTarget:self action:@selector(AddCloudMenuScore) forControlEvents:UIControlEventTouchUpInside];
            }

        }else if (typeType==4){
            if (segmentType==3) {
                [self setBtnisHidden:1];
                [self.m_middleBBtn setTitle:@"立即评价" forState:UIControlStateNormal];
                [self.m_middleBBtn addTarget:self action:@selector(AddCloudMenuScore) forControlEvents:UIControlEventTouchUpInside];

            }else{
                [self setBtnisHidden:0];
            }
        }else if (typeType==5){
            [self setBtnisHidden:0];
        }
        return self.m_footerView;
    }
    
}

- (void)removeAllTargets {
//    for (id target in [self.m_leftB allTargets]) {
        [self.m_leftB removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
//    }
//    for (id target in [self.m_middleBBtn allTargets]) {
        [self.m_middleBBtn removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
//    }
//    for (id target in [self.m_rightB allTargets]) {
        [self.m_rightB removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
//    }
}

- (void)setBtnisHidden:(int)showNum{
    [self removeAllTargets];
//    [self.m_leftB removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
//    [self.m_middleBBtn removeTarget:self action:@selector(ApplyCloudMenuRefund) forControlEvents:UIControlEventTouchUpInside];
//    [self.m_rightB removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    if (showNum==0) {
        self.m_leftB.hidden=YES;
        self.m_middleBBtn.hidden=YES;
        self.m_rightB.hidden=YES;
        
    }else if (showNum==1) {
       self.m_leftB.hidden=YES;
       self.m_middleBBtn.hidden=NO;
       self.m_rightB.hidden=YES;

    }else if (showNum==2) {
        self.m_leftB.hidden=NO;
        self.m_middleBBtn.hidden=YES;
        self.m_rightB.hidden=NO;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ( tableView == MenuTableview ) {
        return 0.0f;
       
    }else{
        return 60.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( tableView == MenuTableview ){
        
        NSDictionary *orderDic = [MenuDataArray objectAtIndex:indexPath.row];

        
        if (segmentType==1) {
            
            static NSString *CellIdentifier = @"MenuOrderListTableViewCell";
            MenuOrderListTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray*cellarray=[[NSBundle mainBundle]
                                   loadNibNamed:@"MenuOrderListTableViewCell" owner:self options:nil];
                cell =[cellarray objectAtIndex:0];
            }
            
            cell.NickName.text = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"NickName"]];
            cell.Account.text = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"Account"]];
            cell.CreateDate.text = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"CreateDate"]];
            cell.CloudMenuPerson.text = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"CloudMenuPerson"]];
            cell.OrderNumber.text = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"OrderNumber"]];
//            cell.Status.text = [self conversionType:[NSString stringWithFormat:@"%@",[orderDic objectForKey:@"Status"]]];
            cell.Status.text = [self conversionType];
            cell.PriceAmount.text = [NSString stringWithFormat:@"￥%@",[orderDic objectForKey:@"PriceAmount"]];
            switch (typeType) {
                case 1:
                    cell.Status.textColor = RGBA(107, 135, 72, 1);
                    break;
                case 2:
                    cell.Status.textColor = RGBACKTAB;
                    break;
                case 3:
                    cell.Status.textColor = RGBA(102, 115, 150, 1);
                    break;
                case 4:
                    cell.Status.textColor = RGBA(202, 71, 82, 1);
                    break;
                    
                default:
                    break;
            }
            return cell;

            
        }else if (segmentType==2){
            
            static NSString *CellIdentifier = @"MenuOrderListTableViewCell1";
            MenuOrderListTableViewCell1*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray*cellarray=[[NSBundle mainBundle]
                                   loadNibNamed:@"MenuOrderListTableViewCell" owner:self options:nil];
                cell =[cellarray objectAtIndex:1];
            }
            
            cell.NickName.text = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"NickName"]];
            cell.Account.text = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"Account"]];
            cell.CreateDate.text = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"CreateDate"]];
            cell.OrderNumber.text = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"OrderNumber"]];
//            cell.Status.text = [self conversionType:[NSString stringWithFormat:@"%@",[orderDic objectForKey:@"Status"]]];
            cell.Status.text = [self conversionType];
            cell.PriceAmount.text = [NSString stringWithFormat:@"￥%@",[orderDic objectForKey:@"PriceAmount"]];
            cell.PeiSongTime.text = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"PeiSongTime"]];
            switch (typeType) {
                case 1:
                    cell.Status.textColor = RGBA(107, 135, 72, 1);
                    break;
                case 2:
                    cell.Status.textColor = RGBACKTAB;
                    break;
                case 3:
                    cell.Status.textColor = RGBA(102, 115, 150, 1);
                    break;
                case 4:
                    cell.Status.textColor = RGBA(202, 71, 82, 1);
                    break;
                    
                default:
                    break;
            }
            return cell;
        
        }else if (segmentType==3){
            
            static NSString *CellIdentifier = @"MenuOrderListTableViewCell2";
            MenuOrderListTableViewCell2*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray*cellarray=[[NSBundle mainBundle]
                                   loadNibNamed:@"MenuOrderListTableViewCell" owner:self options:nil];
                cell =[cellarray objectAtIndex:2];
            }
            
            cell.NickName.text = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"NickName"]];
            cell.Account.text = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"Account"]];
            cell.CreateDate.text = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"CreateDate"]];
            cell.OrderNumber.text = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"OrderNumber"]];
//            cell.Status.text = [self conversionType:[NSString stringWithFormat:@"%@",[orderDic objectForKey:@"Status"]]];
            cell.Status.text = [self conversionType];
            cell.PriceAmount.text = [NSString stringWithFormat:@"￥%@",[orderDic objectForKey:@"PriceAmount"]];
            switch (typeType) {
                case 1:
                    cell.Status.textColor = RGBA(107, 135, 72, 1);
                    break;
                case 2:
                    cell.Status.textColor = RGBACKTAB;
                    break;
                case 3:
                    cell.Status.textColor = RGBA(102, 115, 150, 1);
                    break;
                case 4:
                    cell.Status.textColor = RGBA(202, 71, 82, 1);
                    break;
                    
                default:
                    break;
            }
            return cell;
            
        }


        
        
    }else
    {
        // 预定菜单的tableView页面
        static NSString *cellIdentifier = @"CardMenuOrderCellIdentifier1";
        CardMenuOrderCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if ( cell == nil ) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CardMenuOrderCell" owner:self options:nil];
            cell = (CardMenuOrderCell1 *)[nib objectAtIndex:1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        if (DetailListArray) {
            NSDictionary *DetailListDIC = [DetailListArray objectAtIndex:indexPath.row];
            [cell setImageView:[NSString stringWithFormat:@"%@",[DetailListDIC objectForKey:@"MenuImageS"]]];
            cell.MenuName.text = [NSString stringWithFormat:@"%@",[DetailListDIC objectForKey:@"MenuName"]];
            cell.MenuAmount.text = [NSString stringWithFormat:@"%@份",[DetailListDIC objectForKey:@"MenuAmount"]];
            cell.MenuPrice.text = [NSString stringWithFormat:@"%@元",[DetailListDIC objectForKey:@"MenuPrice"]];
        }

        return cell;

    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==MenuTableview) {
        m_index = indexPath.row;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中状态。。
        // 设置view的坐标大小
        CGRect frame = self.view.frame;
        frame.size.height = self.view.frame.size.height;
        [self.m_control setFrame:CGRectMake(0, 0, WindowSizeWidth, frame.size.height)];
        NSDictionary *orderDic = [MenuDataArray objectAtIndex:indexPath.row];
        self.MerchantShopName.text = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"MerchantShopName"]];
        self.CloudMenuOrderID = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"CloudMenuOrderID"]];
        if (MenuDataArray.count) {
            DetailListArray = [[MenuDataArray objectAtIndex:indexPath.row] objectForKey:@"DetailList"];
        }
        
        [self.m_menuTableView reloadData];
    }
    
}

- (IBAction)HiddenControl:(id)sender{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.m_control setFrame:CGRectMake(0, self.view.frame.size.height, WindowSizeWidth, 0)];
        
    } completion:^(BOOL finished){
        
        
    }];
    
}


-(void)RequestSubmitGetMyCloudMenuOrder
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"MemberID",
                           key,   @"key",
                           [NSString stringWithFormat:@"%ld",(long)Menupage],@"pageIndex",
                           @"10",@"PageSize",
                           [NSString stringWithFormat:@"%ld",(long)typeType],@"Status",
                           nil];
    NSLog(@"%@",param);
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:[NSString stringWithFormat:@"GetMyCloudMenuOrder%ld.ashx",(long)segmentType] parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"orderList"];
            if (Menupage == 1) {
                if (metchantShop == nil || metchantShop.count == 0) {
                    [MenuDataArray removeAllObjects];
                    self.m_emptyLabel.hidden = NO;
                    [SVProgressHUD showErrorWithStatus:@"暂无订单数据"];
                    [MenuTableview reloadData];
                    return;
                } else {
                    MenuDataArray = metchantShop;
                }
            } else {
                if (metchantShop == nil || metchantShop.count == 0) {
                    Menupage--;
                } else {
                    [MenuDataArray addObjectsFromArray:metchantShop];
                }
            }
            MenuTableview.hidden = NO;
            self.m_emptyLabel.hidden = YES;
            [MenuTableview reloadData];
            
        } else {
            if (Menupage > 1) {
                Menupage--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
        MenuTableview.pullLastRefreshDate = [NSDate date];
        MenuTableview.pullTableIsRefreshing = NO;
        MenuTableview.pullTableIsLoadingMore = NO;
    } failure:^(NSError *error) {
        if (Menupage > 1) {
            Menupage--;
        }
        //self.tableView.pullLastRefreshDate = [NSDate date];
        [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        MenuTableview.pullTableIsRefreshing = NO;
        MenuTableview.pullTableIsLoadingMore = NO;
    }];
    
}


#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    Menupage=1;
    [self performSelector:@selector(RequestSubmitGetMyCloudMenuOrder) withObject:nil];
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    Menupage++;
    [self performSelector:@selector(RequestSubmitGetMyCloudMenuOrder) withObject:nil];
    
}

- (NSString *)conversionType{

    if (segmentType==1) {
        switch (typeType) {
            case 1:
                return @"未支付";
                break;
            case 2:
                return @"未消费";
                break;
            case 3:
                return @"已支付";
                break;
            case 4:
                return @"退款";
                break;
            default:
                break;
        }
        
    }else if (segmentType==2){
        switch (typeType) {
            case 1:
                return @"待付款";
                break;
            case 2:
                return @"待配送";
                break;
            case 3:
                return @"待评价";
                break;
            case 4:
                return @"退款";
                break;
            default:
                break;
        }
    
    }else if (segmentType==3){
        switch (typeType) {
            case 1:
                return @"待付款";
                break;
            case 2:
                return @"待发货";
                break;
            case 3:
                return @"待收货";
                break;
            case 4:
                return @"待评价";
                break;
            case 5:
                return @"退款";
                break;
            default:
                break;
        }
    }
    return @"";
}

- (NSString *)conversionType:(NSString *)status{
    NSInteger type = [status integerValue];
    switch (type) {
        case 0:
            return @"待支付";
            break;
        case 1:
            return @"已支付";
            break;
        case 2:
            return @"已取消";
            break;
        case 3:
            return @"已结束";
            break;
        case 4:
            return @"异常";
            break;
        case 5:
            return @"已退款";
            break;
        case 6:
            return @"待收货";
            break;
        case 7:
            return @"退款中";
            break;
        case 8:
            return @"已评价";
            break;
        default:
            break;
    }
    return @"";
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if ( alertView.tag == 19093 ) {
        if ( buttonIndex == 1 ) {
            // 取消订单
            [self cancelOrderRequest];
        }
    }
    if ( alertView.tag == 83023 ) {
        if ( buttonIndex == 1 ) {
            //申请退款
            [self ApplyCloudMenuRefund];
        }
    }
    if ( alertView.tag == 64654 ) {
        if ( buttonIndex == 1 ) {
            //确认收货
            [self ConfirmReceiving];
        }
    }
    
    
}


//评价
-(void)AddCloudMenuScore {
    
    MenuEvaluationViewController *VC = [[MenuEvaluationViewController alloc]initWithNibName:@"MenuEvaluationViewController" bundle:nil];
    VC.CloudMenuOrderID = self.CloudMenuOrderID;
    [self.navigationController pushViewController:VC animated:YES];

}

// 取消订单按钮的操作
- (void)cancelOrderClicked {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"您确定取消订单？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 19093;
    [alertView show];
}

//申请退款
- (void)MenuRefundClicked {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"您确定需要退款？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 83023;
    [alertView show];
}


//确认收货
- (void)ConfirmReceivingClicked {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"您确定需要确认收货？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 64654;
    [alertView show];
}



- (void)payNowClicked {
    // 立即支付
    NSDictionary *dic = [MenuDataArray objectAtIndex:m_index];
    
    HH_CardPayViewController *VC = [[HH_CardPayViewController alloc]initWithNibName:@"HH_CardPayViewController" bundle:nil];
    VC.m_orderId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuOrderID"]];
    VC.m_shopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantShopID"]];
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - NetWork
- (void)cancelOrderRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSDictionary *dic = [MenuDataArray objectAtIndex:m_index];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           [NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuOrderID"]],@"cloudMenuOrderId",nil];
    
    [SVProgressHUD showWithStatus:@"取消订单中"];
    [httpClient request:@"DeleteCloudMenuOrder.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSString *msg = [json valueForKey:@"msg"];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            [self HiddenControl:nil];
            [MenuDataArray removeObjectAtIndex:m_index];
            [MenuTableview reloadData];
            
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}


//退款
- (void)ApplyCloudMenuRefund{
    
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
                           self.CloudMenuOrderID,@"CloudMenuOrderID",
                           @"退款",@"RefundReason",
                           nil];
    
    [httpClient request:@"ApplyCloudMenuRefund.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        
        if (success) {
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [self HiddenControl:nil];
            [MenuDataArray removeObjectAtIndex:m_index];
            [MenuTableview reloadData];
            
        }else
        {
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}


//确认收货
- (void)ConfirmReceiving{
    
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
                           self.CloudMenuOrderID,@"CloudMenuOrderID",
                           nil];
    
    [httpClient request:@"ConfirmReceiving.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        
        if (success) {
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [self HiddenControl:nil];
            [MenuDataArray removeObjectAtIndex:m_index];
            [MenuTableview reloadData];
            
        }else
        {
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

@end
