//
//  MyCarddetailViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-4-8.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "MyCarddetailViewController.h"
#import "MyCarddetailTableViewCell.h"
#import "BindCardTableViewCell.h"
#import "ConsumptionlistViewController.h"
#import "QRCodeGenerator.h"
#import "HH_CardListViewController.h"
#import "HH_menuOrderViewController.h"
#import "HH_TakeOrderViewController.h"

#import "RightCell.h"

#import "MemberShip_RecordViewController.h"
#import "MemberShipTiXianViewController.h"

@interface MyCarddetailViewController ()
@property (nonatomic,strong)NSMutableArray *ShopArray;

@property (weak, nonatomic) IBOutlet TableViewWithBlock *m_righttableView;
@property (weak, nonatomic) IBOutlet UIControl *B_m_alphaView;


@end

@implementation MyCarddetailViewController

@synthesize B_RightArray;

@synthesize m_isZD;
@synthesize m_cardId;

@synthesize isWaimai;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        self.ShopArray = [[NSMutableArray alloc]initWithCapacity:0];
        QRimage = [[UIImage alloc]init];
        
        B_RightArray = [[NSMutableArray alloc]initWithCapacity:0];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    isClosed = YES;

    [self setTitle:[NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"cardTitle"]]];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    [self setRightButtonWithTitle:@"操作" action:@selector(rightClicked)];
    
    
    NSString *Description = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"description"]];
    heightsize = [Description sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(284, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    self.ShopArray = [self.m_dic objectForKey:@"shopList"];
    [self QRimageview];
    
    // 初始化tableView
    [self B_PaixuDataTotableview];
    
    // 根据是否置顶来判断显示取消置顶还是设置置顶
    NSString *string = @"";
    if ( [self.m_isZD isEqualToString:@"1"] ) {
        // 表示是已经是置顶 - 可设置为取消置顶
        string = @"取消置顶";
    }else{
        
        //        // 表示不置顶 - 可设置为置顶
        string = @"设置置顶";
    }
    
    // 设置数组
    [self.B_RightArray addObject:string];
    [self.B_RightArray addObject:@"删除"];
  
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [CommonUtil addValue:@"YES" andKey:MycardViewdetailcurrentBool];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MycardViewdetailcurrentBoolRefish) name:MycardViewdetailcurrentBool object:nil];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    B_rightOpened = NO;
    
    self.m_righttableView.hidden = YES;
    CGRect frame4 = self.m_righttableView.frame;
    //    frame4.size.height = 0.0f;
    frame4 = CGRectMake(WindowSizeWidth/2, 0, WindowSizeWidth/2, 0);
    
    [self.m_righttableView setFrame:frame4];
    
    self.B_m_alphaView.alpha = 0;
    
    [self MycardViewdetailcurrentBoolRefish];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [CommonUtil addValue:nil andKey:MycardViewdetailcurrentBool];

    if (timer) {
        //如果定时器在运行
        if ([timer isValid]) {
            [timer invalidate];
            //这行代码很关键
            timer=nil;
        }
    }
    [timer setFireDate:[NSDate distantFuture]];
    
}


- (void)leftClicked{
    
    [self goBack];
}

- (void)rightClicked{
    
//    NSString *isSelectSeat = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsSelectSeat"]];
//    
//    NSLog(@"isSelectSeat = %@",isSelectSeat);
//
//    if ( isSelectSeat.length != 0 ) {
//        
//        // 进入点菜的页面
//        HH_TakeOrderViewController *VC = [[HH_TakeOrderViewController alloc]initWithNibName:@"HH_TakeOrderViewController" bundle:nil];
//        VC.m_shopList = self.ShopArray;
//        VC.m_seat = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsSelectSeat"]];
//        [self.navigationController pushViewController:VC animated:YES];
//
//    }else{
//        
//        [self alertWithMessage:@"本商户还没有开通云菜单功能"];
//        
//    }

    // 点击操作
    [self B_RightOpenBtn];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            return 400;
            break;
        case 1:
            return heightsize.height > 80 ? heightsize.height+30 : 80;
            break;
        case 2:
            if (indexPath.row ==0) {
                return 40;
            }else
            {
                return 50;
            }
            break;

        default:
            break;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{

    return 0.1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 2:
            if (isClosed) {
                return 1;
            }
            return self.ShopArray.count + 1;
            break;
            
        default:
            break;
    }
    return 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    switch (indexPath.section) {
        case 0:
           cell = [self tableView0:tableView cellForRowAtIndexPath:indexPath];
            break;
        case 1:
            cell = [self tableView1:tableView cellForRowAtIndexPath:indexPath];
            break;
        case 2:
            if (indexPath.row ==0) {
                cell = [self tableView2:tableView cellForRowAtIndexPath:indexPath];
            }else
            {
                cell = [self tableView4:tableView cellForRowAtIndexPath:indexPath];
            }
            break;
        case 3:
            cell = [self tableView2:tableView cellForRowAtIndexPath:indexPath];
            break;
        default:
            break;
    }
    
    return cell;
}

- (UITableViewCell*)tableView0:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    MyCarddetailTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"MyCarddetailTableViewCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        cell.m_accountBtn.layer.borderWidth = 1.0f;
        cell.m_accountBtn.layer.borderColor = [UIColor colorWithRed:234/255.0 green:172/255.0 blue:0/255.0 alpha:1.0].CGColor;
        
    }
    
    cell.footview.layer.masksToBounds = YES;
    cell.footview.layer.cornerRadius = 10.0;
    
    cell.cardNumber.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"cardNumber"]];
    cell.balance.text = [NSString stringWithFormat:@"余额:￥%@",[self.m_dic objectForKey:@"balance"]];
    cell.redBalance.text = [NSString stringWithFormat:@"红包:￥%@",[self.m_dic objectForKey:@"HongBao"]];
    cell.jifenBalance.text = [NSString stringWithFormat:@"积分:%@",[self.m_dic objectForKey:@"JiFen"]];
    cell.Qrcode.image = QRimage;
    
    [cell.tixianBtn addTarget:self action:@selector(tixianClick) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.Qrcoderefresh addTarget:self action:@selector(RefreshQR) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.m_accountBtn addTarget:self action:@selector(accountProductClicked) forControlEvents:UIControlEventTouchUpInside];

    
    return cell;
    
}

- (void)tixianClick {
    
    MemberShipTiXianViewController *vc = [[MemberShipTiXianViewController alloc] init];
    
    vc.vipCardRecordId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"vipCardRecordId"]];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(UITableViewCell*)tableView1:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MyCarddetailTableViewCell2*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"MyCarddetailTableViewCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    cell.namelabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"description"]];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 10.0;
    
    return cell;
}

-(UITableViewCell*)tableView2:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    MyCarddetailTableViewCell1*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"MyCarddetailTableViewCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:1];
        
    }
    
    switch (indexPath.section) {
        case 2:
            cell.namelabel.text = @"所支持店铺";
            cell.Numlabel.hidden = NO;
            cell.Numlabel.text = [NSString stringWithFormat:@"%lu家店",(unsigned long)self.ShopArray.count];
            if (isClosed) {
                cell.upview.hidden = YES;
                cell.downview.hidden = NO;
            }else{
                cell.upview.hidden = NO;
                cell.downview.hidden = YES;
            }
            cell.rightview.hidden = YES;
            
            break;
        case 3:
            cell.namelabel.text = @"交易记录";
            cell.Numlabel.hidden = YES;
            cell.upview.hidden = YES;
            cell.downview.hidden = YES;
            cell.rightview.hidden = NO;

            break;
            
        default:
            break;
    }
    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==2 && indexPath.row ==0) {
        if (isClosed) {
            isClosed = NO;
        }else{
            isClosed = YES;
        }
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }else if (indexPath.section ==3)
    {
//        ConsumptionlistViewController *VC = [[ConsumptionlistViewController alloc]initWithNibName:@"ConsumptionlistViewController" bundle:nil];
//        VC.vipCardRecordId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"vipCardRecordId"]];
//        [self.navigationController pushViewController:VC animated:YES];
        
        MemberShip_RecordViewController *vc = [[MemberShip_RecordViewController alloc] init];
        
        vc.vipCardRecordId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"vipCardRecordId"]];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



- (UITableViewCell *)tableView4:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BindCardTableViewCell4*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"BindCardTableViewCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:4];
        
    }
    
    NSDictionary *dic = [self.ShopArray objectAtIndex:indexPath.row -1];
    
    cell.ShopName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopName"]];
    cell.disrictName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"DisrictName"]];
    
    
    return cell;
    
}

//生成二维码
-(void)QRimageview
{
    // 申请通过 生成二维码图片
    UIImage *codeImage = [QRCodeGenerator qrImageForString:[self.m_dic objectForKey:@"QRCode"] imageSize:150];
    QRimage = codeImage;
    
}

-(void)RefreshQR;
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"vipCardRecordId"]],@"vipCardRecordId",nil];
    
    [httpClient request:@"RefreshQRCode.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        if (success) {
            
            UIImage *codeImage = [QRCodeGenerator qrImageForString:[NSString stringWithFormat:@"%@",[json valueForKey:@"qrCode"]] imageSize:150];
            QRimage = codeImage;
    
            NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]];
            [m_tableview reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
            
        } else {
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        if (timer) {
            //如果定时器在运行
            if ([timer isValid]) {
                [timer invalidate];
                //这行代码很关键
                timer=nil;
            }
            timer =  [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(RefreshQR) userInfo:nil repeats:NO];

        }else
        {
           timer =  [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(RefreshQR) userInfo:nil repeats:NO];
            [timer fire];
        }

        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        if (timer) {
            //如果定时器在运行
            if ([timer isValid]) {
                [timer invalidate];
                //这行代码很关键
                timer=nil;
            }
            timer =  [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(RefreshQR) userInfo:nil repeats:NO];

        }else
        {
            //创建一个定时器，这个是直接加到当前消息循环中，注意与其他初始化方法的区别
            timer =  [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(RefreshQR) userInfo:nil repeats:NO];
            [timer fire];
        }

    }];
}

-(void)MycardViewdetailcurrentBoolRefish{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"vipCardRecordId"]],@"vipCardRecordId",nil];
    
    [httpClient request:@"GetMyVIPCardDetail_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        if (success) {
                        
            //扣款或充值后 给卡详细赋值；
            self.m_dic = (NSMutableDictionary *)[[json valueForKey:@"cardList"]objectAtIndex:0];
            NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]];
            [m_tableview reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
            
        } else {
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(RefistCardlist)]){
        [self.delegate RefistCardlist];
    }

}

- (void)accountProductClicked{
    
    NSString *isSelectSeat = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsSelectSeat"]];
    
    // 根据值进行判断进入哪个页面 如果等于1则表示是点菜模式进入点菜模式的订单列表 否则进入美容模式的订单页面
    if ( [[self.m_dic objectForKey:@"IsSelectSeat"]isEqualToString:@"1"] ) {
        // 点单模式的订单页面
        HH_menuOrderViewController *VC = [[HH_menuOrderViewController alloc]initWithNibName:@"HH_menuOrderViewController" bundle:nil];
        VC.m_merchantId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"merchantId"]];
        VC.m_selectSeat = [NSString stringWithFormat:@"%@",isSelectSeat];
        VC.m_ModelType = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ModelType"]];
        VC.m_shopList = self.ShopArray;
        VC.isWaimai = self.isWaimai;
        [self.navigationController pushViewController:VC animated:YES];
    
    }else if ( [[self.m_dic objectForKey:@"IsSelectSeat"]isEqualToString:@"0"] ){
        
        // 进入会员卡商品的列表-美容模式
        HH_CardListViewController *VC = [[HH_CardListViewController alloc]initWithNibName:@"HH_CardListViewController" bundle:nil];
        VC.m_merchantId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"merchantId"]];
        VC.m_selectSeat = [NSString stringWithFormat:@"%@",isSelectSeat];
        VC.m_ModelType = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ModelType"]];
        VC.m_shopList = self.ShopArray;
        VC.isWaimai = self.isWaimai;
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        
        [self alertWithMessage:@"本商户还没有开通云菜单功能"];

    }
    
}

//排序赋值
- (void) B_PaixuDataTotableview
{
    
    [self.m_righttableView initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count = self.B_RightArray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightCell"];
         
         if (!cell)
         {
             cell = [[[NSBundle mainBundle]loadNibNamed:@"RightCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         if ( self.B_RightArray ) {
             
             [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.B_RightArray objectAtIndex:indexPath.row]]];
             
         }
         
         return cell;
         
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         [tableView deselectRowAtIndexPath:indexPath animated:YES];
         
         if ( indexPath.row == 0 ) {
             
             // 设置置顶
             if ( [self.m_isZD isEqualToString:@"1"] ) {
                 
                 // 取消置顶
                 [self cancelZDrequest:[NSString stringWithFormat:@"%@",self.m_cardId]];
                 
             }else{
                 
                 // 设置置顶
                 [self zdRequestSubmit:[NSString stringWithFormat:@"%@",self.m_cardId]];
                 
             }
             
         }else{
             
             
             UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                                message:@"您确定删除该会员卡？"
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"确定", nil];
             alertView.tag = 90341;
             [alertView show];
             
         }

         [self alphaviewtap:nil];
         
     }];
    
    
}

- (void)B_RightOpenBtn {
    
    if (B_rightOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_righttableView.frame;
            
            frame.size.height = 0;
            [self.m_righttableView setFrame:frame];
            self.B_m_alphaView.alpha = 0;
            
        } completion:^(BOOL finished){
            
            B_rightOpened=NO;
        }];
    }else{
        
        self.m_righttableView.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_righttableView.frame;
            
            int fr = self.B_RightArray.count*44;
            if (fr>300) {
                frame.size.height=300;
            }else
            {
                frame.size.height = fr;
            }
            
            [self.m_righttableView setFrame:frame];
            
            self.B_m_alphaView.alpha = 0.3;
            
            
        } completion:^(BOOL finished){
            
            B_rightOpened = YES;
            
        }];
        
    }
    
}

- (IBAction)alphaviewtap:(id)sender
{
    
    B_rightOpened = YES;
    
    [self B_RightOpenBtn];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if ( alertView.tag == 90341 ){
        
        if ( buttonIndex == 1 ) {
            
            // 删除
            [self deleteCardRequestSubmit:[NSString stringWithFormat:@"%@",self.m_cardId]];
            
        }
        
    }

}

// 设置置顶的数据请求
- (void)zdRequestSubmit:(NSString *)vipCardRecordId{
    
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,@"memberId",
                                  key,@"key",
                                  vipCardRecordId,@"vipCardRecordId",
                                  nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"SetTopVIPCard.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [CommonUtil addValue:@"1" andKey:@"MyCardRequestSubmit_Notification"];
            
            // 设置置顶成功后将数据设置为取消置顶的数据
            self.m_isZD = @"1";
            
            if ( self.B_RightArray.count != 0 ) {
                
                [self.B_RightArray removeAllObjects];
                
            }
            
            // 设置数组
            [self.B_RightArray addObject:@"取消置顶"];
            [self.B_RightArray addObject:@"删除"];

            [self.m_righttableView reloadData];
            
            
        } else {
            
            [CommonUtil addValue:@"0" andKey:@"MyCardRequestSubmit_Notification"];
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        [CommonUtil addValue:@"0" andKey:@"MyCardRequestSubmit_Notification"];

        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
    
}

// 取消置顶的数据请求
- (void)cancelZDrequest:(NSString *)vipCardRecordId{
    
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,@"memberId",
                                  key,@"key",
                                  vipCardRecordId,@"vipCardRecordId",
                                  nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"CancelTopVIPCard.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [CommonUtil addValue:@"1" andKey:@"MyCardRequestSubmit_Notification"];

            // 设置置顶成功后将数据设置为取消置顶的数据
            self.m_isZD = @"0";
            
            if ( self.B_RightArray.count != 0 ) {
                
                [self.B_RightArray removeAllObjects];
                
            }
            
            // 设置数组
            [self.B_RightArray addObject:@"设置置顶"];
            [self.B_RightArray addObject:@"删除"];
            
            [self.m_righttableView reloadData];

            
        } else {
            [CommonUtil addValue:@"0" andKey:@"MyCardRequestSubmit_Notification"];

            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        [CommonUtil addValue:@"0" andKey:@"MyCardRequestSubmit_Notification"];

        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

// 删除会员卡的数据请求
- (void)deleteCardRequestSubmit:(NSString *)vipCardRecordId{
    
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,@"memberId",
                                  key,@"key",
                                  vipCardRecordId,@"vipCardRecordId",
                                  nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"DeleteVIPCard.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [CommonUtil addValue:@"1" andKey:@"MyCardRequestSubmit_Notification"];
           
            [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(lastView)
                                           userInfo:nil
                                            repeats:YES];

        } else {
            
            [CommonUtil addValue:@"0" andKey:@"MyCardRequestSubmit_Notification"];

            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        [CommonUtil addValue:@"0" andKey:@"MyCardRequestSubmit_Notification"];

        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)lastView{
    
    [self goBack];
    
}



@end
