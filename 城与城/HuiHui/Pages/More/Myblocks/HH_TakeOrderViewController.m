//
//  HH_TakeOrderViewController.m
//  HuiHui
//
//  Created by mac on 15-6-18.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HH_TakeOrderViewController.h"

#import "BCloundMenuCell.h"

#import "HH_OrderMenuCell.h"

#import "HH_MenuOrderListViewController.h"

#import "HH_CardPayViewController.h"

#import "HH_ShareMenuViewController.h"

#import "ProductListViewController.h"

@interface HH_TakeOrderViewController (){
    
    CGFloat Viewheight;
    NSInteger SelectLeft;
    NSInteger SelectRight;
    
    NSString *CloudMenuClass;
    
}

@property(nonatomic,strong) NSMutableArray *BCMLeftArray;

@property(nonatomic,strong) NSMutableArray *BCMRightArray;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UIImageView *m_backImgV;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UIButton *m_stepNextBtn;

@property (weak, nonatomic) IBOutlet UIView *m_timeView;

@property (weak, nonatomic) IBOutlet UIView *m_downView;

@property (weak, nonatomic) IBOutlet UIControl *m_control;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageV;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UIButton *m_sureMenuBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_totalPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_emptylabel1;

@property (weak, nonatomic) IBOutlet UIImageView *m_backImagV;

@property (weak, nonatomic) IBOutlet UIView *m_typeView;

@property (weak, nonatomic) IBOutlet UIButton *m_homeBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_shopBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_morenBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_saleBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_priceBtn;

@property (weak, nonatomic) IBOutlet UIImageView *m_saleImgV;

@property (weak, nonatomic) IBOutlet UIImageView *m_priceImgV;

@property (weak, nonatomic) IBOutlet UILabel *m_yhDescription;


// 按钮触发的点击事件
- (IBAction)btnClicked:(id)sender;


// 送货上门按钮触发的事件
- (IBAction)toHomeBtnClicked:(id)sender;
// 预约按钮触发的事件
- (IBAction)toShopBtnClicked:(id)sender;
// 取消按钮触发的事件
- (IBAction)cancelBtnClicked:(id)sender;


// 点击背景触发的事件
- (IBAction)backTap:(id)sender;

// 点击下一步按钮触发的事件
- (IBAction)nextClicked:(id)sender;
// 确认菜单时的下一步按钮触发的事件
- (IBAction)sureMenuOrder:(id)sender;

//- (IBAction)chooseDateClicked:(id)sender;

@end

@implementation HH_TakeOrderViewController

@synthesize BCMLeftTableview;
@synthesize BCMRightTableview;
@synthesize m_flagDic;
@synthesize m_countDic;
@synthesize BCMLeftArray;
@synthesize BCMRightArray;
@synthesize m_shopList;
//@synthesize m_peopleList;
//@synthesize m_timeList;
@synthesize m_menuTimeController;
@synthesize m_menuList;
@synthesize m_shopId;
@synthesize m_totalPrice;
@synthesize m_menuId;
@synthesize m_seat;
@synthesize m_orderId;
@synthesize m_typeString;
@synthesize m_merchantId;
@synthesize IsZCWaiMai;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  
    if (self) {
        
        BCMLeftArray = [[NSMutableArray alloc]initWithCapacity:0];
        BCMRightArray = [[NSMutableArray alloc]initWithCapacity:0];
        m_flagDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        m_countDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        m_shopList = [[NSMutableArray alloc]initWithCapacity:0];
        m_menuList = [[NSMutableArray alloc]initWithCapacity:0];
        selectedStepNext = NO;
        m_totalPrice = 0.00;
        isSale = NO;
        isPrice = NO;
        isChangeSacle = YES;
        isChangePrice = YES;
        
    }
    return self;
}
//上个界面传过来传赋值
- (void)setXBParamdic:(NSMutableDictionary *)XBParamdic
{
    _XBParamdic = XBParamdic;

    self.m_shopList = (NSMutableArray *)[XBParamdic objectForKey:@"m_shopList"];
    self.m_seat = [NSString stringWithFormat:@"%@",[XBParamdic objectForKey:@"m_seat"]];
    self.m_ModelType = [NSString stringWithFormat:@"%@",[XBParamdic objectForKey:@"m_ModelType"]];
    self.m_merchantId = [NSString stringWithFormat:@"%@",[XBParamdic objectForKey:@"m_merchantId"]];
    self.IsZCWaiMai = [NSString stringWithFormat:@"%@",[XBParamdic objectForKey:@"IsZCWaiMai"]];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"点单"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    [self AllocLeftTB];
    [self AllocRithTB];
    SelectLeft = 0;
    SelectRight = 0;
    // 设置背景颜色
    self.m_backImgV.alpha = 0.6f;
    self.m_scrollerView.backgroundColor = [UIColor clearColor];
    // 设置view的中心位置
    self.m_tempView.center = self.view.center;
    self.m_scrollerView.center = self.view.center;
    self.m_typeView.center = self.view.center;
    self.m_tempView.hidden = NO;
    // 默认隐藏按钮
    self.m_morenBtn.hidden = YES;
    self.m_saleBtn.hidden = YES;
    self.m_priceBtn.hidden = YES;
    self.m_saleImgV.hidden = YES;
    self.m_priceImgV.hidden = YES;

        if ( [self.m_seat isEqualToString:@"1"] )
        {
            // 根据是否是外卖来判断是否显示外卖和预约view的显示
            if ( [self.IsZCWaiMai isEqualToString:@"1"] ) {
            // 支持外卖的情况则显示view去选择外卖还是预约的模式
            // 进入页面后显示view进行选择类型操作
            self.m_typeView.hidden = NO;
            self.m_scrollerView.hidden = YES;

                    NSDictionary *dic = [self.m_shopList objectAtIndex:0];
                    self.m_shopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopID"]];
                    // 将店铺的名称保存起来用于后面支付的页面显示
                    [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopName"]] andKey:@"MctShopNameKey"];

        }
            // 不支持外卖的模式下直接属于是预约的模式
            // 进入页面后显示view进行选择类型操作 - 没有外卖的模式
            else{
            self.m_typeView.hidden = YES;
            self.m_scrollerView.hidden = NO;
            //（1，外卖、2，预定）
            self.m_typeString = @"2";

                    NSDictionary *dic = [self.m_shopList objectAtIndex:0];
                    self.m_shopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopID"]];
                    // 将店铺的名称保存起来用于后面支付的页面显示
                    [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopName"]] andKey:@"MctShopNameKey"];
                    self.m_tempView.hidden = YES;
                    // 设置导航栏右按钮的触发事件
                    [self setRightButtonWithTitle:@"订单列表" action:@selector(orderListClicked)];
                    // 请求类别的数据-根据选择的店铺去请求数据
                    [self categoryRequest];

       
        }
    }
     // 进入页面后显示view进行选择类型操作 - 没有外卖的模式
        else{
        self.m_typeView.hidden = YES;
        self.m_scrollerView.hidden = NO;
        //（1，外卖、2，预定）
        self.m_typeString = @"2";

                NSDictionary *dic = [self.m_shopList objectAtIndex:0];
                self.m_shopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopID"]];
                // 将店铺的名称保存起来用于后面支付的页面显示
                [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopName"]] andKey:@"MctShopNameKey"];
                self.m_tempView.hidden = YES;
                // 设置导航栏右按钮的触发事件
                [self setRightButtonWithTitle:@"订单列表" action:@selector(orderListClicked)];
                // 请求类别的数据-根据选择的店铺去请求数据
                [self categoryRequest];

    }

    // 设置下面view的大小坐标
    [self.m_timeView setFrame:CGRectMake(0, self.m_tempView.frame.size.height - 50, WindowSizeWidth, 0)];
    // 初始化view
    self.m_menuTimeController = [[HH_MenuTimeViewController alloc]initWithNibName:@"HH_MenuTimeViewController" bundle:nil];
    [self.view insertSubview:self.m_menuTimeController.view belowSubview:self.m_downView];
    // 设置下面view的大小坐标
    [self.m_menuTimeController.view setFrame:CGRectMake(0, self.view.frame.size.height - 50, WindowSizeWidth, 0)];
    [self.m_control setFrame:CGRectMake(0, self.view.frame.size.height - 50, WindowSizeWidth, 0)];
//    [self.m_tableView setFrame:CGRectMake(0, 100, WindowSizeWidth, self.m_control.frame.size.height - 100)];
    self.m_imageV.alpha = 0.6;
    self.m_stepNextBtn.hidden = YES;
    self.m_sureMenuBtn.hidden = NO;
    self.m_emptyLabel.hidden = YES;
    self.m_emptylabel1.hidden = YES;
    // 设置背景的透明度
    self.m_backImagV.backgroundColor = [UIColor blackColor];
    self.m_backImagV.alpha = 0.6f;
    // 默认隐藏掉下一步所在的view
    self.m_downView.hidden = YES;
    // 设置下面的footerView用于显示downview的时候不至于覆盖掉
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(self.BCMLeftTableview.frame.origin.x, 0, self.BCMLeftTableview.frame.size.width, 50)];
    view.backgroundColor = [UIColor clearColor];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.BCMRightTableview.frame.size.width, 50)];
    view1.backgroundColor = [UIColor clearColor];
    self.BCMLeftTableview.tableFooterView = view;
    self.BCMRightTableview.tableFooterView = view1;
    // 设置按钮圆角
    self.m_homeBtn.layer.cornerRadius = 40.0f;
    self.m_homeBtn.layer.masksToBounds = YES;
    self.m_shopBtn.layer.cornerRadius = 40.0f;
    self.m_shopBtn.layer.masksToBounds = YES;
    // 默认为默认的状态
    [self setDefault:YES withSale:NO withPrice:NO];
    // 设置满立减的参数
    self.m_yhDescription.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:YHDESCRIPTION]];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)getFlagDic:(NSMutableDictionary *)falgDic withCoutDic:(NSMutableDictionary *)countDic{
    self.m_flagDic = falgDic;
    self.m_countDic = countDic;
    // 刷新列表
    [self.BCMLeftTableview reloadData];
    [self.BCMRightTableview reloadData];
    // 计算总价钱的显示
    self.m_totalPrice = 0.0;
    for (int ii = 0; ii < self.m_flagDic.count; ii++) {
        NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:ii]];
        for (int i = 0; i < dic.count; i++) {
            NSMutableDictionary *l_dic = [dic objectForKey:[NSString stringWithFormat:@"%d",i]];
            NSString *Istring = [l_dic objectForKey:@"amount"];
            NSString *price = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"price"]];
            self.m_totalPrice = self.m_totalPrice + [price floatValue] * [Istring intValue];
        }
    }
    self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",self.m_totalPrice];
    if ( self.m_totalPrice == 0.0000 || self.m_totalPrice <= 0.0000 ) {
        self.m_downView.hidden = YES;
    }else{
        self.m_downView.hidden = NO;
    }
}
   
- (void)leftClicked{
    // 如果大小>0的话则将view隐藏掉
    if ( self.m_menuTimeController.view.frame.size.height > 0.000000 ) {
        [self.m_menuTimeController.view setFrame:CGRectMake(0, self.view.frame.size.height - 50, WindowSizeWidth, 0)];
        [self.m_stepNextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        selectedStepNext = NO;
        self.m_stepNextBtn.hidden = YES;
        self.m_sureMenuBtn.hidden = NO;
    }else{
        [self goBack];
    }
}

- (void)orderListClicked{
    // 如果是选择了下一步的按钮则将它隐藏起来
    if ( selectedStepNext ) {
        [self nextClicked:nil];
    }
    // 进入订单列表的页面
    HH_MenuOrderListViewController *VC = [[HH_MenuOrderListViewController alloc]initWithNibName:@"HH_MenuOrderListViewController" bundle:nil];
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        // 外卖模式
        VC.m_shopId = @"";
        VC.m_isWaiMai = @"1";
    }else{
        VC.m_shopId = [NSString stringWithFormat:@"%@",self.m_shopId];
        VC.m_isWaiMai = @"0";
    }
    VC.m_merchantId = self.m_merchantId;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)initwithScroller{
    self.m_scrollerView.backgroundColor = [UIColor clearColor];
    self.m_scrollerView.pagingEnabled = YES;
    self.m_scrollerView.showsHorizontalScrollIndicator = NO;
    self.m_scrollerView.showsVerticalScrollIndicator = NO;
    // 添加按钮
    for (int i = 0; i < self.m_shopList.count; i ++) {
        NSDictionary *dic = [self.m_shopList objectAtIndex:i];
        // 添加按钮触发点击事件
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, i * 50, self.m_scrollerView.frame.size.width, 40);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        btn.tag = i;
        [btn addTarget:self action:@selector(shopClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopName"]] forState:UIControlStateNormal];
        [self.m_scrollerView addSubview:btn];
    }
    CGRect frame = self.m_scrollerView.frame;
    int fr = (int)self.m_shopList.count * 50;
    if (fr > 300) {
        frame.size.height = 300;
        [self.m_scrollerView setContentSize:CGSizeMake(self.m_scrollerView.frame.size.width,600/*self.m_shopList.count*/)];
    }else {
        frame.size.height = fr;
    }
    [self.m_scrollerView setFrame:frame];
}

- (void)shopClicked:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSDictionary *dic = [self.m_shopList objectAtIndex:btn.tag];
    // 将店铺的名称保存起来用于后面支付的页面显示
    [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopName"]] andKey:@"MctShopNameKey"];
    self.m_shopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopID"]];
    self.m_tempView.hidden = YES;
    // 设置导航栏右按钮的触发事件
    [self setRightButtonWithTitle:@"订单列表" action:@selector(orderListClicked)];
    // 请求类别的数据-根据选择的店铺去请求数据
    [self categoryRequest];
}

#pragma mark - UINetworking
- (void)categoryRequest{
//    self.m_morenBtn.hidden = NO;
//    self.m_saleBtn.hidden = NO;
//    self.m_priceBtn.hidden = NO;
//    self.m_saleImgV.hidden = NO;
//    self.m_priceImgV.hidden = NO;
    
    // 外卖模式的时候 merchantShopId为空
//    if ( [self.m_typeString isEqualToString:@"1"] ) {
    
//        self.m_shopId = @"";
        
//    }
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    // 根据是送货上门还是预约的模式来判断进行不同的数据请求
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        AppHttpClient* httpClient = [AppHttpClient sharedClient];
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               memberId,@"MemberID",
                               key,@"Key",
                               self.m_shopId,@"MerchantShopID",nil];
        
        NSLog(@"param111111 = %@",param);
        [httpClient request:@"GetCloudMenuClassList_2.ashx" parameters:param success:^(NSJSONSerialization* json) {
            BOOL success = [[json valueForKey:@"status"] boolValue];
            NSString *msg = [json valueForKey:@"msg"];
            NSLog(@"json = %@",json);
            if (success) {
                self.BCMLeftArray = (NSMutableArray *)[json valueForKey:@"MenuClassList"];
                // 标记值的字典-每个类别里面有不同的选择的一个set
                for (int i = 0; i < self.BCMLeftArray.count; i++) {
                    [self.m_flagDic setObject:[NSMutableDictionary dictionary] forKey:[NSNumber numberWithInt:i]];
                    // 记录左边tableView的数字的显示的值
                    [self.m_countDic setObject:@"0" forKey:[NSString stringWithFormat:@"%i",i]];
                }
                
                [BCMLeftTableview reloadData];
                if ( self.BCMLeftArray.count != 0 ) {
                    if ( SelectLeft >= self.BCMLeftArray.count ) {
                        SelectLeft = self.BCMLeftArray.count - 1;
                    }
                    NSDictionary *dic = [self.BCMLeftArray objectAtIndex:SelectLeft];
                    NSString *cloudMenuClassId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuClassID"]];
                    //                self.m_menuClassId = [NSString stringWithFormat:@"%@",cloudMenuClassId];
                    self.m_emptylabel1.hidden = YES;
                    [self CloudMenuList:cloudMenuClassId];
                }else{
                    self.m_emptylabel1.hidden = NO;
                    self.m_emptyLabel.hidden = NO;
                }
            } else {
                [SVProgressHUD showErrorWithStatus:msg];
            }
            [BCMLeftTableview reloadData];
            
            
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            [BCMLeftTableview reloadData];
        }];
    }else {
        AppHttpClient* httpClient = [AppHttpClient sharedClient];
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               memberId,@"MemberID",
                               key,@"Key",
                               self.m_shopId,@"MerchantShopID",nil];
        NSLog(@"param111111 = %@",param);
        
        [httpClient request:@"GetCloudMenuClassList_2.ashx" parameters:param success:^(NSJSONSerialization* json) {
            BOOL success = [[json valueForKey:@"status"] boolValue];
            NSString *msg = [json valueForKey:@"msg"];
            
            NSLog(@"json = %@",json);
            
            if (success) {
                
                self.BCMLeftArray = (NSMutableArray *)[json valueForKey:@"MenuClassList"];
                
                // 标记值的字典-每个类别里面有不同的选择的一个set
                for (int i = 0; i < self.BCMLeftArray.count; i++) {
                    
                    [self.m_flagDic setObject:[NSMutableDictionary dictionary] forKey:[NSNumber numberWithInt:i]];
                    
                    // 记录左边tableView的数字的显示的值
                    [self.m_countDic setObject:@"0" forKey:[NSString stringWithFormat:@"%i",i]];
                    
                }
                
                [BCMLeftTableview reloadData];
                
                if ( self.BCMLeftArray.count != 0 ) {
                    
                    if ( SelectLeft >= self.BCMLeftArray.count ) {
                        
                        SelectLeft = self.BCMLeftArray.count - 1;
                        
                    }
                    
                    NSDictionary *dic = [self.BCMLeftArray objectAtIndex:SelectLeft];
                    
                    NSString *cloudMenuClassId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuClassID"]];
                    
                    //                self.m_menuClassId = [NSString stringWithFormat:@"%@",cloudMenuClassId];
                    
                    self.m_emptylabel1.hidden = YES;
                    
                    [self CloudMenuList:cloudMenuClassId];
                    
                }else{
                    
                    self.m_emptylabel1.hidden = NO;
                    self.m_emptyLabel.hidden = NO;
                    
                }
                
            } else {
                [SVProgressHUD showErrorWithStatus:msg];
            }
            [BCMLeftTableview reloadData];
            
            
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            [BCMLeftTableview reloadData];
            
        }];
        
    }
    
}

//云菜单子类别列表
-(void)CloudMenuList:(NSString *)cloudMenuClassId{
    
    NSLog(@"self.m_typeString = %@",self.m_typeString);
    
    // 外卖模式的时候 merchantShopId为空
    //从此不存在
//    if ( [self.m_typeString isEqualToString:@"1"] ) {
//        self.m_shopId = @"";
//    }
    
    
    if ( ![self isConnectionAvailable] ) {
      
        return;
    
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"MemberID",
                           key,@"Key",
                           cloudMenuClassId,@"CloudMenuClassID",
                           [NSString stringWithFormat:@"%@",self.m_shopId],@"MerchantShopID",
                           [NSString stringWithFormat:@"%@",self.m_typeString],@"Type",nil];
    
    NSLog(@"parms = %@",param);
    
    [httpClient request:@"GetCloudMenuList_4.ashx" parameters:param success:^(NSJSONSerialization* json) {
       
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        
        NSLog(@"json111111111111 = %@",json);
        
        if (success) {
            
            self.BCMRightArray = (NSMutableArray *)[json valueForKey:@"MenuList"];
            
            
            if ( self.BCMRightArray.count != 0 ) {
                
                self.m_emptyLabel.hidden = YES;
                
            }else{
                
                self.m_emptyLabel.hidden = NO;
                
            }
            
            [BCMRightTableview reloadData];
            
        } else {
            [SVProgressHUD showErrorWithStatus:msg];
        }
        [BCMLeftTableview reloadData];
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        [BCMLeftTableview reloadData];
        
    }];

    
    
    
    //=================原来接口=======================
    // 判断网络是否存在
//    if ( ![self isConnectionAvailable] ) {
//        return;
//    }
//    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
//    NSString *key = [CommonUtil getServerKey];
//
//    AppHttpClient* httpClient = [AppHttpClient sharedClient];
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
//                           memberId,@"memberId",
//                           key,@"key",
//                           cloudMenuClassId,@"cloudMenuClassId",
//                           [NSString stringWithFormat:@"%@",self.m_shopId],@"merchantShopId",nil];
//    
//    [httpClient request:@"GetCloudMenuList.ashx" parameters:param success:^(NSJSONSerialization* json) {
//        BOOL success = [[json valueForKey:@"status"] boolValue];
//        NSString *msg = [json valueForKey:@"msg"];
//        
//        if (success) {
//            
//            self.BCMRightArray = (NSMutableArray *)[json valueForKey:@"MenuList"];
//            
//            if ( self.BCMRightArray.count != 0 ) {
//                
//                self.m_emptyLabel.hidden = YES;
//
//            }else{
//                
//                self.m_emptyLabel.hidden = NO;
//
//            }
//            
//            [BCMRightTableview reloadData];
//
//        } else {
//            [SVProgressHUD showErrorWithStatus:msg];
//        }
//        [BCMLeftTableview reloadData];
//        
//        
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
//        [BCMLeftTableview reloadData];
//        
//    }];
    
    //====================原来接口==========================

}

- (void)orderMenuRequest{
    
    // 设置按钮不能点击
    self.m_stepNextBtn.userInteractionEnabled = NO;
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
//                           memberId,@"memberId",
//                           key,@"key",
//                           [NSString stringWithFormat:@"%@ %@",self.m_menuTimeController.m_dateTime.text,self.m_menuTimeController.m_timeString],@"bookDateTime",
//                           [NSString stringWithFormat:@"%@",self.m_menuTimeController.m_peopleCOunt.text],@"cloudMenuPerson",
//                           [NSString stringWithFormat:@"%@",self.m_menuId],@"goods",
//                           [NSString stringWithFormat:@"%@",self.m_shopId],@"merchantShopId",
//                           @"",@"seatId",nil];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           @"",@"address",
                           [NSString stringWithFormat:@"%@ %@",self.m_menuTimeController.m_dateTime.text,self.m_menuTimeController.m_timeString],@"bookDateTime",
                           [NSString stringWithFormat:@"%@",self.m_menuTimeController.m_peopleCOunt.text],@"cloudMenuPerson",
                           [NSString stringWithFormat:@"%@",self.m_menuId],@"goods",
                           @"0",@"isWaiMai",
                           @"",@"linkName",
                           @"",@"linkPhone",
                           [NSString stringWithFormat:@"%@",self.m_shopId],@"merchantShopId",
//                           self.m_merchantId,@"merchantId",
                           @"",@"peiSongTime",
                           @"",@"remark",
                           @"",@"seatId",
                           
                           nil];

    NSLog(@"params = %@",param);
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"AddCloudMenuOrder_3.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        
        // 恢复按钮可点击
        self.m_stepNextBtn.userInteractionEnabled = YES;

        if (success) {
            
            [SVProgressHUD dismiss];
            
            
//            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 赋值
            self.m_orderId = [json valueForKey:@"CloudMenuOrderId"];
            
            // 点单模式下的情况
            if ( [self.m_seat isEqualToString:@"1"] ) {

                // 下单成功后再显示页面
                [UIView animateWithDuration:0.3 animations:^{
                    
                    CGRect frame = self.view.frame;
                    frame.size.height = 0;
                    
                    [self.m_menuTimeController.view setFrame:CGRectMake(0, self.view.frame.size.height - 50, WindowSizeWidth, 0)];
                    
                    //            [self.m_menuTimeController.view removeFromSuperview];
                    
                    [self.m_stepNextBtn setTitle:@"下一步" forState:UIControlStateNormal];
                    
                } completion:^(BOOL finished){
                    
                    selectedStepNext = NO;
                    
                    self.m_stepNextBtn.hidden = YES;
                    self.m_sureMenuBtn.hidden = NO;
                    
                }];
                
                
                // 清空数组里面的数据
                if ( self.m_menuList.count != 0 ) {
                    
                    [self.m_menuList removeAllObjects];
                    
                }
                
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                                   message:@"您已下单成功"
                                                                  delegate:self
                                                         cancelButtonTitle:@"现场支付"
                                                         otherButtonTitles:@"立即支付", nil];
                
                alertView.tag = 10920;
                [alertView show];

                
                
            }else{
                
                // 美容模式下的情况-下单成功后进入到支付的页面
                HH_CardPayViewController *VC = [[HH_CardPayViewController alloc]initWithNibName:@"HH_CardPayViewController" bundle:nil];
                VC.m_orderId = [NSString stringWithFormat:@"%@",self.m_orderId];
                VC.m_shopId = [NSString stringWithFormat:@"%@",self.m_shopId];
                VC.m_typeString = @"1";
                [self.navigationController pushViewController:VC animated:YES];
                
            }
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:msg];
            
            if ( [self.m_seat isEqualToString:@"1"] ) {
            
                // 下单成功后再显示页面
                [UIView animateWithDuration:0.3 animations:^{
                    
                    CGRect frame = self.view.frame;
                    frame.size.height = 0;
                    
                    [self.m_menuTimeController.view setFrame:CGRectMake(0, self.view.frame.size.height - 50, WindowSizeWidth, 0)];
                    
                    //            [self.m_menuTimeController.view removeFromSuperview];
                    
                    [self.m_stepNextBtn setTitle:@"下一步" forState:UIControlStateNormal];
                    
                } completion:^(BOOL finished){
                    
                    selectedStepNext = NO;
                    
                    self.m_stepNextBtn.hidden = YES;
                    self.m_sureMenuBtn.hidden = NO;
                    
                }];
   
            }
        }
        
        [BCMLeftTableview reloadData];
        
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        [BCMLeftTableview reloadData];
        
        
        if ( [self.m_seat isEqualToString:@"1"] ) {

            // 下单成功后再显示页面
            [UIView animateWithDuration:0.3 animations:^{
                
                CGRect frame = self.view.frame;
                frame.size.height = 0;
                
                [self.m_menuTimeController.view setFrame:CGRectMake(0, self.view.frame.size.height - 50, WindowSizeWidth, 0)];
                
                //            [self.m_menuTimeController.view removeFromSuperview];
                
                [self.m_stepNextBtn setTitle:@"下一步" forState:UIControlStateNormal];
                
            } completion:^(BOOL finished){
                
                selectedStepNext = NO;
                
                self.m_stepNextBtn.hidden = YES;
                self.m_sureMenuBtn.hidden = NO;
                
            }];
            
        }
        
    }];
 
}

#pragma mark - UIalertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 10920 ) {
        
        if ( buttonIndex == 1 ) {
           // 下单成功后进入到支付的页面
            HH_CardPayViewController *VC = [[HH_CardPayViewController alloc]initWithNibName:@"HH_CardPayViewController" bundle:nil];
            VC.m_orderId = [NSString stringWithFormat:@"%@",self.m_orderId];
            VC.m_shopId = [NSString stringWithFormat:@"%@",self.m_shopId];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else{
            
            // 返回上一级
//            [self goBack];
            
            // 点击现场支付进入到订单详情显示的页面进行分享
            HH_ShareMenuViewController *VC = [[HH_ShareMenuViewController alloc]initWithNibName:@"HH_ShareMenuViewController" bundle:nil];
            VC.m_orderId = [NSString stringWithFormat:@"%@",self.m_orderId];
            VC.m_titleString = @"恭喜您下单成功";
            VC.m_typeString = @"1";
            [self.navigationController pushViewController:VC animated:YES];
        }
        
        
    }else if (alertView.tag == 18924){
        if ([alertView cancelButtonIndex] != buttonIndex) {
            UITextField *messageTextField = [alertView textFieldAtIndex:0];
            // 计算价格
            if ([messageTextField.text isEqualToString:@"0"]) {
                [self showHint:@"数量不能为0"];
            }else{
                [self setPriceWithAccount:messageTextField.text];
            }
        }
    }
    
}

#pragma mark 云菜单
- (void)AllocLeftTB{
    
    [BCMLeftTableview initTableViewDataSourceAndDelegate:^NSInteger(UITableView *tableView,NSInteger section)
     
     {
         return self.BCMLeftArray.count+1;
         
     } setCellForIndexPathBlock:^UITableViewCell *(UITableView *tableView,NSIndexPath *indexPath)
     
     {
         
         BCloundMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BCloundMenuCellIdentifier"];
         
         if (!cell)
             
         {
             
             cell = [[[NSBundle mainBundle]loadNibNamed:@"BCloundMenuCell" owner:self options:nil]objectAtIndex:0];
             
             [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
             
             
             cell.m_amoutLabel.layer.masksToBounds = YES;
             cell.m_amoutLabel.layer.cornerRadius = 10.0f;
             
         }


         if ( self.BCMLeftArray.count != 0 ) {
             
             if (indexPath.row==self.BCMLeftArray.count) {
                 
                 cell.m_labeltext.text =@"团购商品";
                 
             }else
             {
             
             NSDictionary *dic = [self.BCMLeftArray objectAtIndex:indexPath.row];
             
             cell.m_labeltext.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuClassName"]];
             
             if (SelectLeft == indexPath.row) {
                 
                 cell.m_labeltext.textColor = RGBA(239, 154, 85, 1);
                 
             }else{
                 
                 cell.m_labeltext.textColor = [UIColor blackColor];
                 
             }
                 
             }
             
         }else{

             cell.m_labeltext.text =@"团购商品";

         }
         
         
         // 根据值来判断红点数字的显示
         NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:indexPath.row]];
         
         NSString *count = [NSString stringWithFormat:@"%@",[self.m_countDic objectForKey:[NSString stringWithFormat:@"%li",(long)indexPath.row]]];
         
         if ( dic.count != 0 ) {
             
             if ( ![count isEqualToString:@"0"] ) {
                 
                 cell.m_amoutLabel.hidden = NO;
                 
                 cell.m_amoutLabel.text = [NSString stringWithFormat:@"%@",count];
                 
             }else{
                 
                 cell.m_amoutLabel.hidden = YES;
                 
             }
             
         }else{
             
             cell.m_amoutLabel.hidden = YES;
         }
         
       
         
         return cell;
         
         
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     
     {
         
         if (indexPath.row != self.BCMLeftArray.count) {
             
             SelectLeft = indexPath.row;
             
             NSDictionary *dic = [self.BCMLeftArray objectAtIndex:indexPath.row];
             
             NSString *cloudMenuClassId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuClassID"]];
             
             [self.BCMLeftTableview reloadData];
             [self CloudMenuList:cloudMenuClassId];
         }else
         {
             ProductListViewController *VC = [[ProductListViewController alloc]initWithNibName:@"ProductListViewController" bundle:nil];
             VC.m_merchantId = [NSString stringWithFormat:@"%@",self.m_merchantId];
             VC.m_merchantShopId = @"";
             [self.navigationController pushViewController:VC animated:YES];
         }
         
     }];
    
    [self.BCMLeftTableview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    
    [self.BCMLeftTableview.layer setBorderWidth:0];
     
}

- (void)AllocRithTB{
 
    [self.BCMRightTableview initTableViewDataSourceAndDelegate:^NSInteger(UITableView *tableView,NSInteger section)
     
     {
         
         return self.BCMRightArray.count;
         
         
     } setCellForIndexPathBlock:^UITableViewCell *(UITableView *tableView,NSIndexPath *indexPath)
     
     {
         
         BCloundMenuCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"BCloundMenuCell1Identifier"];
         
         if (!cell)
             
         {
             cell = [[[NSBundle mainBundle]loadNibNamed:@"BCloundMenuCell" owner:self options:nil]objectAtIndex:1];
             
             [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
             
         }
         
         if ( self.BCMRightArray.count != 0 ) {
             
             NSDictionary *dic = [self.BCMRightArray objectAtIndex:indexPath.row];
             
             cell.m_labelname.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuName"]];
             
             cell.m_labelpice.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"MenuPrice"]];
             
             cell.m_orignPrice.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"MenuPrices"]];
             
             [cell setImagePath:[dic objectForKey:@"MenuImageM"]];
             
             // 计算画线的坐标大小
             CGSize size = [cell.m_orignPrice.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];

            cell.m_line.frame = CGRectMake(cell.m_line.frame.origin.x, cell.m_line.frame.origin.y, size.width + 3, cell.m_line.frame.size.height);
             
             
         }
         
         NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:SelectLeft]];
         
         NSMutableDictionary *l_dic = [dic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
         
         NSString *Istring = [l_dic objectForKey:@"amount"];
         
         if ((!Istring) ||([Istring isEqualToString:@"0"])) {
             
             // 设置加号的颜色
//             [cell.m_Btnjia.titleLabel setTextColor:[UIColor darkGrayColor]];
//             
//             [cell.m_Btnjia.layer setBorderColor:[UIColor darkGrayColor].CGColor];//边框颜色
             
         }else
             
         {
             cell.m_Btnjian.hidden = cell.m_Btnnum.hidden = NO;
             
             [cell.m_Btnnum setTitle:[NSString stringWithFormat:@"%@",Istring] forState:UIControlStateNormal];
             
             // 设置加号的颜色
//             [cell.m_Btnjia.titleLabel setTextColor:[UIColor darkGrayColor]];
//             
//             [cell.m_Btnjia.layer setBorderColor:[UIColor darkGrayColor].CGColor];//边框颜色
             
         }
         
         cell.m_Btnjia.tag = indexPath.row;
         
         cell.m_Btnjian.tag = indexPath.row;

         cell.m_Btnnum.tag = indexPath.row;

         [cell.m_Btnnum addTarget:self action:@selector(changeNumber:) forControlEvents:UIControlEventTouchUpInside];
         
         [cell.m_Btnjia addTarget:self action:@selector(Addnum:) forControlEvents:UIControlEventTouchUpInside];
         
         [cell.m_Btnjian addTarget:self action:@selector(Jiannum:) forControlEvents:UIControlEventTouchUpInside];
       
         
         return cell;
         
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     
     {
         SelectRight = indexPath.row;
         
         // 初始化显示的view
         self.m_menuDetailView = [[HH_MenuDetailViewController alloc]initWithNibName:@"HH_MenuDetailViewController" bundle:nil];

         
         NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:SelectLeft]];
         
         self.m_menuDetailView.m_dic = dic;
         self.m_menuDetailView.m_type = self.m_typeString;
         self.m_menuDetailView.delegate = self;
         self.m_menuDetailView.m_menuList = self.BCMRightArray;
         self.m_menuDetailView.m_index = SelectRight;
         self.m_menuDetailView.view.backgroundColor = [UIColor clearColor];
         
         // 点击查看详情
         [self.navigationController.view.window addSubview:self.m_menuDetailView.view];
         
         
     }];
    
    
    [self.BCMRightTableview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [self.BCMRightTableview.layer setBorderWidth:0];
    
}

- (void)Addnum:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:SelectLeft]];
    
    // 存放数组的总个数
    [dic setObject:[NSString stringWithFormat:@"%i",self.BCMRightArray.count] forKey:@"TotalCount"];
    
    NSMutableDictionary *l_dic = [dic objectForKey:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
    
    NSString *Istring = [l_dic objectForKey:@"amount"];
    
    
    
    // ======判断如果自定义的数组值为空的话则不进行跳转，直接对菜单进行加减======
    NSDictionary *dic123 = [self.BCMRightArray objectAtIndex:btn.tag];
    
    if ( [[dic123 objectForKey:@"AttributeList"]count] != 0 ) {
        
        // 点击加号的时候进入自定义规则选择的页面
        HH_customRuleViewController *VC = [[HH_customRuleViewController alloc]initWithNibName:@"HH_customRuleViewController" bundle:nil];
        VC.m_customList = [dic123 objectForKey:@"AttributeList"];
        VC.m_menuString = [NSString stringWithFormat:@"%@",[dic123 objectForKey:@"MenuName"]];
        VC.delegate = self;
//        NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:SelectLeft]];
//        VC.m_dic = dic;
        VC.delegate = self;
//        VC.m_menuList = self.BCMRightArray;
        VC.m_index = btn.tag;
        VC.m_countDic = self.m_countDic;
        VC.m_sectionIndex = SelectLeft;
        VC.m_amount = [Istring intValue];
        
        [self.navigationController pushViewController:VC animated:YES];
        
        
    }else{
                
        
        int nownum ;
        
        if ((!Istring) ||([Istring isEqualToString:@"0"])) {
            
            nownum = 1;
            
            // 存放字典中的值
            NSString *count = [self.m_countDic objectForKey:[NSString stringWithFormat:@"%i",SelectLeft]];
            
            int countValue = [count intValue];
            
            countValue = countValue + 1;
            
            [self.m_countDic setObject:[NSString stringWithFormat:@"%i",countValue] forKey:[NSString stringWithFormat:@"%i",SelectLeft]];
            
        }else{
            
            NSString *num = [NSString stringWithFormat:@"%@",Istring];
            
            nownum = [num intValue]+1;
            
        }
        
        // ========计算总价钱的算法===========
        NSString *price = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"price"]];
        
        // 当数据没值的时候先从数组里进行赋值
        if ( [price isEqualToString:@"(null)"] ) {
            
            NSDictionary *dic = [self.BCMRightArray objectAtIndex:btn.tag];
            
            price = [dic objectForKey:@"MenuPrice"];
            
        }
        
        self.m_totalPrice = self.m_totalPrice + [price floatValue];
        
        self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",self.m_totalPrice];
        
        
        if ( self.m_totalPrice == 0.0000 || self.m_totalPrice <= 0.0000 ) {
            
            self.m_downView.hidden = YES;
            
        }else{
            
            self.m_downView.hidden = NO;
            
        }
        
        // =======总价钱的计算========
        
        
        
        // 将选择的菜单的值记录到字典里面
        NSMutableDictionary *l_dic22 = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        NSMutableDictionary *dic1 = [self.BCMRightArray objectAtIndex:btn.tag];
        
        [l_dic22 setObject:[dic1 objectForKey:@"CloudMenuID"] forKey:@"menuId"];
        [l_dic22 setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"amount"];
        
        [l_dic22 setObject:[dic1 objectForKey:@"MenuPrice"] forKey:@"price"];
        [l_dic22 setObject:[dic1 objectForKey:@"MenuName"] forKey:@"menuName"];
        [l_dic22 setObject:[dic1 objectForKey:@"MenuImageM"] forKey:@"MenuImage"];
        
        [l_dic22 setObject:[NSString stringWithFormat:@"%i",SelectLeft] forKey:@"sectionKey"];
        
        [dic setObject:l_dic22 forKey:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
        
        [self.BCMRightTableview reloadData];
        
        // 刷新左边的tableView
        NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:SelectLeft inSection:0], nil];
        
        [self.BCMLeftTableview reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
        
        // 添加到数组里面===============================
        NSMutableDictionary *dic_2 = [[NSMutableDictionary alloc]initWithCapacity:0];
        [dic_2 setObject:[dic1 objectForKey:@"CloudMenuID"] forKey:@"menuId"];
        [dic_2 setObject:[dic1 objectForKey:@"MenuPrice"] forKey:@"price"];
        [dic_2 setObject:[dic1 objectForKey:@"MenuName"] forKey:@"menuName"];
        [dic_2 setObject:[dic1 objectForKey:@"MenuImageM"] forKey:@"MenuImage"];
        
        [dic_2 setObject:[NSString stringWithFormat:@"%i",SelectLeft] forKey:@"sectionKey"];
        
        if ( self.m_menuList.count != 0 ) {
            
            // 首先判断数组里有没有这个数据，如果有则直接替换该数据，如果没有，则直接加入这个数据到数组里
            NSMutableArray *l_array = [[NSMutableArray alloc]initWithCapacity:0];

            NSMutableArray *menuIdArr = [[NSMutableArray alloc]initWithCapacity:0];

            
            [l_array addObjectsFromArray:self.m_menuList];
            
            for (int i = 0; i < l_array.count; i++) {
                
                NSDictionary *dic = [l_array objectAtIndex:i];
                
                NSString *menuId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"menuId"]];
                
                [menuIdArr addObject:menuId];
                
            }
        
            NSString *menuId_1 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"CloudMenuID"]];
     
            
            if ( [menuIdArr containsObject:menuId_1] ) {
                
                NSInteger index_1 = [menuIdArr indexOfObject:menuId_1];
                
                NSDictionary *dic_1 = [l_array objectAtIndex:index_1];
                
                NSString *amountString = [NSString stringWithFormat:@"%@",[dic_1 objectForKey:@"amount"]];
                
                int amountValue_1 = [amountString intValue];
                
                [dic_2 setObject:[NSString stringWithFormat:@"%d",amountValue_1 + 1] forKey:@"amount"];
                
                [self.m_menuList replaceObjectAtIndex:index_1 withObject:dic_2];
                
            }else{
                
                [dic_2 setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"amount"];

                [self.m_menuList addObject:dic_2];
               
            }
            
        }else{
            
//            [self.m_menuList addObject:l_dic22];
            
            [dic_2 setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"amount"];
            
            [self.m_menuList addObject:dic_2];
            
        }
        
    }

    
    // =====================
 
    
}

- (void)Jiannum:(id)sender
{
    
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:SelectLeft]];
    
    // 存放数组的总个数
    [dic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)self.BCMRightArray.count] forKey:@"TotalCount"];
    
    
    NSMutableDictionary *l_dic = [dic objectForKey:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
    
    NSString *Istring = [l_dic objectForKey:@"amount"];
    
    int nownum;
    
    // ======判断如果自定义的数组值为空的话则不进行跳转，直接对菜单进行加减======
    NSDictionary *dic123 = [self.BCMRightArray objectAtIndex:btn.tag];
    
    if ( [[dic123 objectForKey:@"AttributeList"]count] != 0 ) {
        
        [self.m_tableView reloadData];
        
        // 设置view的坐标大小
        CGRect frame = self.view.frame;
        frame.size.height = self.view.frame.size.height - 50;
        
        [self.m_control setFrame:CGRectMake(0, 0, WindowSizeWidth, frame.size.height)];
        
        self.m_stepNextBtn.hidden = NO;
        self.m_sureMenuBtn.hidden = YES;
        
    }else{
        
        // 没有自定义参数的情况下的操作
        if ([Istring isEqualToString:@"1"]) {
            
            nownum = 0;
            
            // 存放字典中的值
            NSString *count = [self.m_countDic objectForKey:[NSString stringWithFormat:@"%i",SelectLeft]];
            
            int countValue = [count intValue];
            
            countValue = countValue - 1;
            
            [self.m_countDic setObject:[NSString stringWithFormat:@"%i",countValue] forKey:[NSString stringWithFormat:@"%i",SelectLeft]];
            
        }else{
            
            NSString *num = [NSString stringWithFormat:@"%@",Istring];
            
            nownum = [num intValue] - 1;
            
        }
        
        // ========计算总价钱的算法===========
        NSString *price = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"price"]];
        
        // 当数据没值的时候先从数组里进行赋值
        if ( [price isEqualToString:@"(null)"] ) {
            
            NSDictionary *dic = [self.BCMRightArray objectAtIndex:btn.tag];
            
            price = [dic objectForKey:@"MenuPrice"];
            
        }
        
        self.m_totalPrice = self.m_totalPrice - [price floatValue];
        
        self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",self.m_totalPrice];
        
        if ( self.m_totalPrice == 0.0000 || self.m_totalPrice <= 0.0000 ) {
            
            self.m_downView.hidden = YES;
            
        }else{
            
            self.m_downView.hidden = NO;
            
        }
        
        // =======总价钱的计算========
        
        
        // 将选择的菜单的值记录到字典里面
        NSMutableDictionary *l_dic11 = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        NSMutableDictionary *dic1 = [self.BCMRightArray objectAtIndex:btn.tag];
        
        [l_dic11 setObject:[dic1 objectForKey:@"CloudMenuID"] forKey:@"menuId"];
        [l_dic11 setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"amount"];
        [l_dic11 setObject:[dic1 objectForKey:@"MenuName"] forKey:@"menuName"];
        
        [l_dic11 setObject:[dic1 objectForKey:@"MenuPrice"] forKey:@"price"];
        [l_dic11 setObject:[dic1 objectForKey:@"MenuImageM"] forKey:@"MenuImage"];
        
        [l_dic11 setObject:[NSString stringWithFormat:@"%i",SelectLeft] forKey:@"sectionKey"];
        
        [dic setObject:l_dic11 forKey:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
        
        [self.BCMRightTableview reloadData];
        
        // 刷新左边的tableView
        NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:SelectLeft inSection:0], nil];
        
        [self.BCMLeftTableview reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
        
        
        //========================================
        NSMutableDictionary *dic_2 = [[NSMutableDictionary alloc]initWithCapacity:0];
        [dic_2 setObject:[dic1 objectForKey:@"CloudMenuID"] forKey:@"menuId"];
        [dic_2 setObject:[dic1 objectForKey:@"MenuPrice"] forKey:@"price"];
        [dic_2 setObject:[dic1 objectForKey:@"MenuName"] forKey:@"menuName"];
        [dic_2 setObject:[dic1 objectForKey:@"MenuImageM"] forKey:@"MenuImage"];
        
        [dic_2 setObject:[NSString stringWithFormat:@"%i",SelectLeft] forKey:@"sectionKey"];

        
        
        // 添加到数组里面===============================
        if ( self.m_menuList.count != 0 ) {
            
            // 首先判断数组里有没有这个数据，如果有则直接替换该数据，如果没有，则直接加入这个数据到数组里
            NSMutableArray *l_array = [[NSMutableArray alloc]initWithCapacity:0];
            
            NSMutableArray *menuIdArr = [[NSMutableArray alloc]initWithCapacity:0];
            
           
            
            [l_array addObjectsFromArray:self.m_menuList];
            
            for (int i = 0; i < l_array.count; i++) {
                
                NSDictionary *dic = [l_array objectAtIndex:i];
                
                NSString *menuId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"menuId"]];
                
                [menuIdArr addObject:menuId];
                
            }
            
            NSString *menuId_1 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"CloudMenuID"]];
            
            if ( [menuIdArr containsObject:menuId_1] ) {
                
                NSInteger index_1 = [menuIdArr indexOfObject:menuId_1];
                
                NSDictionary *dic_1 = [l_array objectAtIndex:index_1];
                
                NSString *amountString = [NSString stringWithFormat:@"%@",[dic_1 objectForKey:@"amount"]];
                
                int amountValue_1 = [amountString intValue];
                
                [dic_2 setObject:[NSString stringWithFormat:@"%d",amountValue_1 - 1] forKey:@"amount"];
                
                // 如果值为0的话则删除这个数据
                if ( amountValue_1 - 1 == 0 ) {
                    
                    [self.m_menuList removeObjectAtIndex:index_1];

                }else{
                    
                    [self.m_menuList replaceObjectAtIndex:index_1 withObject:dic_2];

                }
                
                
            }else{
                
//                [self.m_menuList addObject:l_dic11];
                [dic_2 setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"amount"];

                [self.m_menuList addObject:dic_2];
                
            }
            
        }else{
            
//            [self.m_menuList addObject:l_dic11];
            
            [dic_2 setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"amount"];
            
            [self.m_menuList addObject:dic_2];
            
        }
        
        
        
        //========================================
        
    
    }
  
}

// 把选择的菜单拼接成json字符传递给服务器
- (void)jsonWithDic{
    
    NSString *l_string = @"";
    NSString *string = @"";
    
    for (int i = 0; i < self.m_menuList.count; i++) {
        
        NSDictionary *dic = [self.m_menuList objectAtIndex:i];
        
        NSString *amount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"amount"]];
        
        NSString *menuId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"menuId"]];

        
        l_string = [NSString stringWithFormat:@"{\"amount\":\"%@\",\"menuId\":\"%@\"},",amount,menuId];

        string = [string stringByAppendingString:l_string];
        
    }
    
    if ( string.length != 0 ) {
        
        // 设置拼接的字符串
        string = [string substringWithRange:NSMakeRange(0, string.length - 1)];
        
    }

    
    self.m_menuId = [NSString stringWithFormat:@"\{\"goodList\":[%@]}",string];
    
}

- (IBAction)nextClicked:(id)sender {
    
    int sum = 0;
    
    for (int i = 0; i < self.m_countDic.count; i++) {
        
        NSString *string = [NSString stringWithFormat:@"%@",[self.m_countDic objectForKey:[NSString stringWithFormat:@"%i",i]]];
        
        int num = [string intValue];
        
        sum = sum + num;
        
    }
    
    if ( sum == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"您还没有选择任何商品,请先选择"];
        
        return;
        
    }
    if ([self.m_ModelType isEqualToString:@"2"]) {
        
        // C物流模式
        HH_menuToHomeViewController *VC = [[HH_menuToHomeViewController alloc]initWithNibName:@"HH_menuToHomeViewController" bundle:nil];
        VC.m_ModelType = self.m_ModelType;
        VC.m_menuList = self.m_menuList;
        VC.m_dic = self.m_flagDic;
        VC.m_countDic = self.m_countDic;
        VC.delegate = self;
        VC.m_merchantId = [NSString stringWithFormat:@"%@",self.m_merchantId];
        VC.m_shopId = self.m_shopId;
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
    if ( [self.m_seat isEqualToString:@"1"] ) {
        
        // 点单模式下判断是送货上门还是预约的类型
        if ( [self.m_typeString isEqualToString:@"1"] ) {
            
            // 成功后再显示页面-----------------------------------------------------------------
//            [UIView animateWithDuration:0.3 animations:^{
            
                [self.m_control setFrame:CGRectMake(0, self.view.frame.size.height - 50, WindowSizeWidth, 0)];
                
//            } completion:^(BOOL finished){
            
                self.m_stepNextBtn.hidden = YES;
                self.m_sureMenuBtn.hidden = NO;
                
//            }];
            
            // ----------------------------------------------------------------------------------
            
            
            // 1.送货上门
            // 进入到地址选择的页面
            HH_menuToHomeViewController *VC = [[HH_menuToHomeViewController alloc]initWithNibName:@"HH_menuToHomeViewController" bundle:nil];
            VC.m_menuList = self.m_menuList;
            VC.m_dic = self.m_flagDic;
            VC.m_countDic = self.m_countDic;
            VC.delegate = self;
            VC.m_merchantId = [NSString stringWithFormat:@"%@",self.m_merchantId];
            VC.m_shopId = self.m_shopId;

            [self.navigationController pushViewController:VC animated:YES];
            
            
            
        }else{
            // 2.预约的类型
            // 动画效果
            if ( selectedStepNext ) {
                
                // 选择成功后进行数据判断
                if ( self.m_menuTimeController.m_dateTime.text.length == 0 ) {
                    
                    [SVProgressHUD showErrorWithStatus:@"请选择预定日期"];
                    
                    return;
                    
                }
                
                if ( self.m_menuTimeController.m_orderTime.text.length == 0 ) {
                    
                    [SVProgressHUD showErrorWithStatus:@"请选择预定时间"];
                    
                    return;
                }
                
                if ( self.m_menuTimeController.m_peopleCOunt.text.length == 0 ) {
                    
                    [SVProgressHUD showErrorWithStatus:@"请选择消费人数"];
                    
                    return;
                }
                
                // 成功后进行请求数据
                [self orderMenuRequest];
                
            }else{
                
                // 拼接json字符
                [self jsonWithDic];
                
                [self.m_control setFrame:CGRectMake(0, self.view.frame.size.height - 50, WindowSizeWidth, 0)];
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    CGRect frame = self.view.frame;
                    frame.size.height = self.view.frame.size.height - 50;
                    
                    [self.m_menuTimeController.view setFrame:CGRectMake(0, 0, WindowSizeWidth, frame.size.height)];
                    
                    [self.m_stepNextBtn setTitle:@"确定" forState:UIControlStateNormal];
                    
                    
                } completion:^(BOOL finished){
                    
                    selectedStepNext = YES;
                    
                    self.m_stepNextBtn.hidden = NO;
                    self.m_sureMenuBtn.hidden = YES;
                    
                    
                }];
                
            }
            
        }
        
    }else{
        
        // 拼接json字符
        [self jsonWithDic];
        
        // 美容模式的操作
        [self.m_control setFrame:CGRectMake(0, self.view.frame.size.height - 50, WindowSizeWidth, 0)];
        
        self.m_stepNextBtn.hidden = YES;
        self.m_sureMenuBtn.hidden = NO;

        
        self.m_menuTimeController.m_dateTime.text = @"";
        self.m_menuTimeController.m_orderTime.text = @"";
        self.m_menuTimeController.m_peopleCOunt.text = @"";
      
        // 成功后进行请求数据
        [self orderMenuRequest];
        
        
    }
    }

}

// 点击下一步按钮触发的事件
- (IBAction)backTap:(id)sender {
    // 清空数组里面的数据
//    if ( self.m_menuList.count != 0 ) {
//        
//        [self.m_menuList removeAllObjects];
//   
//    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.m_control setFrame:CGRectMake(0, self.view.frame.size.height - 50, WindowSizeWidth, 0)];
        
    } completion:^(BOOL finished){
        
        self.m_stepNextBtn.hidden = YES;
        self.m_sureMenuBtn.hidden = NO;
        
    }];
    
}

- (IBAction)sureMenuOrder:(id)sender {
    
//    if ( self.m_menuList.count != 0 ) {
//        
//        [self.m_menuList removeAllObjects];
//    }
    
    
    // 判断选择的菜单的价钱，如果为0则表示没有选择过菜单提示选择菜单，否则表示选择了菜单
    if ( self.m_totalPrice == 0.00 ) {
        
        [SVProgressHUD showErrorWithStatus:@"您还没有选择任何商品,请先选择"];
        
        return;
    }

    
    [self.m_tableView reloadData];
    
    // 设置view的坐标大小
    CGRect frame = self.view.frame;
    frame.size.height = self.view.frame.size.height - 50;
    
    [self.m_control setFrame:CGRectMake(0, 0, WindowSizeWidth, frame.size.height)];
    
    self.m_stepNextBtn.hidden = NO;
    self.m_sureMenuBtn.hidden = YES;
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_menuList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"BCloundMenuOrderCellIdentifier";
    
    BCloundMenuOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"BCloundMenuCell" owner:self options:nil];
        
        cell = (BCloundMenuOrderCell *)[nib objectAtIndex:3];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    // 赋值 =====
    
    if ( self.m_menuList.count != 0 ) {
        
        NSDictionary *dic = [self.m_menuList objectAtIndex:indexPath.row];
        
        cell.m_menuName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"menuName"]];

        cell.m_menuPrice.text = [NSString stringWithFormat:@"%@元",[dic objectForKey:@"price"]];
        
        // 赋值自定义参数的名称的值
        NSString *customName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CustomNameKey"]];
        
        if ( customName.length != 0 && ![customName isEqualToString:@"(null)"] ) {
            
            cell.m_customName.text = customName;
            
            
        }else{
            
            cell.m_customName.text = @"";
        }
    
        
        NSString *Istring = [dic objectForKey:@"amount"];
        
        if ((!Istring) ||([Istring isEqualToString:@"0"])) {
            
            cell.m_Btnjian1.hidden = cell.m_Btnnum.hidden = YES;
            
            // 设置加号的颜色
//            [cell.m_Btnjia1.titleLabel setTextColor:[UIColor darkGrayColor]];
//            
//            [cell.m_Btnjia1.layer setBorderColor:[UIColor darkGrayColor].CGColor];//边框颜色
            
        }else
            
        {
            cell.m_Btnjian1.hidden = cell.m_Btnnum.hidden = NO;
            
            [cell.m_Btnnum setTitle:[NSString stringWithFormat:@"%@",Istring] forState:UIControlStateNormal];
//            // 设置加号的颜色
//            [cell.m_Btnjia1.titleLabel setTextColor:[UIColor darkGrayColor]];
//            
//            [cell.m_Btnjia1.layer setBorderColor:[UIColor redColor].CGColor];//边框颜色
            
        }
        
    }
  
 
    
    cell.m_Btnjia1.tag = indexPath.row;
    
    cell.m_Btnjian1.tag = indexPath.row;
    
    [cell.m_Btnjia1 addTarget:self action:@selector(AddMenuNum:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.m_Btnjian1 addTarget:self action:@selector(JianMenuNum:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70.0f;
}


- (void)AddMenuNum:(id)sender
{

    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *l_dic = [self.m_menuList objectAtIndex:btn.tag];
    
    NSString *Istring = [l_dic objectForKey:@"amount"];
  
    int nownum;
    
    if ((!Istring) ||([Istring isEqualToString:@"0"])) {
        
        nownum = 1;

    }else{
        
        NSString *num = [NSString stringWithFormat:@"%@",Istring];
        
        nownum = [num intValue]+1;
        
    }
    
    [l_dic setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"amount"];
  
    // ====设置数组的显示=========
    
    NSMutableDictionary *dic_1 = [self.m_flagDic objectForKey:[NSNumber numberWithInt:SelectLeft]];
    
    NSString *totalCount = [dic_1 objectForKey:@"TotalCount"];
    
    NSString *menuId_1 = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"menuId"]];

    int index_menuId = 0;
    
    for (int ii = 0; ii < [totalCount intValue]; ii++) {
        
        NSMutableDictionary *l_dic = [dic_1 objectForKey:[NSString stringWithFormat:@"%d",ii]];
        
        if ( l_dic.count != 0 ) {
            
            NSString *menuId = [l_dic objectForKey:@"menuId"];
            
            if ( [menuId isEqualToString:menuId_1] ) {
                
                index_menuId = ii;
                
            }
            
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
    
    self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",self.m_totalPrice];
    
    // =======总价钱的计算========
    
    // 刷新ableView
    NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:btn.tag inSection:0], nil];
    
    [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
    
    [self.BCMRightTableview reloadData];
    
    [self.BCMLeftTableview reloadData];
    
    [self.m_tableView reloadData];
    
    // 当总价等于0的时候将view隐藏
    if ( self.m_totalPrice == 0.0000 || self.m_totalPrice <= 0.0000 ) {
        
        [self backTap:nil];

        self.m_downView.hidden = YES;
        
    }else{
        
        self.m_downView.hidden = NO;
        
    }
    
    
    
}

- (void)JianMenuNum:(id)sender
{
    
    UIButton *btn = (UIButton *)sender;
    
    
    NSMutableDictionary *l_dic = [self.m_menuList objectAtIndex:btn.tag];
    
    NSString *Istring = [l_dic objectForKey:@"amount"];
    
    // 所在的区
    NSString *sectionKey = [l_dic objectForKey:@"sectionKey"];

    int section = [sectionKey intValue];
    
    int nownum;
    
    if ([Istring isEqualToString:@"1"]) {
        
        nownum = 0;
        
        [l_dic setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"amount"];

        // 删除该数据
        [self.m_menuList removeObjectAtIndex:btn.tag];

    }else{
        
        NSString *num = [NSString stringWithFormat:@"%@",Istring];
        
        nownum = [num intValue] - 1;
        
        [l_dic setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"amount"];
        
    }
    
    
    // ====设置数组的显示=========
    
    NSMutableDictionary *dic_1 = [self.m_flagDic objectForKey:[NSNumber numberWithInt:SelectLeft]];
    
    NSString *totalCount = [dic_1 objectForKey:@"TotalCount"];
    
    NSMutableArray *l_arr = [[NSMutableArray alloc]initWithCapacity:0];
    
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
    
    // ====================
    
    
    
    
    // ========计算总价钱的算法===========
    NSString *price = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"price"]];
    
    self.m_totalPrice = self.m_totalPrice - [price floatValue];
    
    self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",self.m_totalPrice];
    
     // =======总价钱的计算========
    [self.BCMRightTableview reloadData];
    
    [self.BCMLeftTableview reloadData];
    
    [self.m_tableView reloadData];
    
    // 当总价等于0的时候将view隐藏
    if ( self.m_menuList.count == 0 ) {
        
        [self backTap:nil];
        
        self.m_downView.hidden = YES;
    
        
    }else{
        
        self.m_downView.hidden = NO;
        
    }
    
}


- (void)copyToData:(int)index withCount:(NSString *)amount{
    
    NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:SelectLeft]];
    //
    //    // 存放数组的总个数
    [dic setObject:[NSString stringWithFormat:@"%i",self.BCMRightArray.count] forKey:@"TotalCount"];
    //
    NSMutableDictionary *l_dic = [dic objectForKey:[NSString stringWithFormat:@"%d",index]];
    
    //    NSString *Istring = [l_dic objectForKey:@"amount"];
    
    NSString *Istring = [NSString stringWithFormat:@"%@",amount];
    
    int nownum ;
    
    if ([Istring isEqualToString:@"0"]) {
        
        nownum = 1;
        
        // 存放字典中的值
        NSString *count = [self.m_countDic objectForKey:[NSString stringWithFormat:@"%i",SelectLeft]];
        
        int countValue = [count intValue];
        
        countValue = countValue + 1;
        
        [self.m_countDic setObject:[NSString stringWithFormat:@"%i",countValue] forKey:[NSString stringWithFormat:@"%i",SelectLeft]];
        
    }else{
        
        NSString *num = [NSString stringWithFormat:@"%@",Istring];
        
        nownum = [num intValue]+1;
        
    }
    
    // ========计算总价钱的算法===========
    NSString *price = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"price"]];
    
    // 当数据没值的时候先从数组里进行赋值
    if ( [price isEqualToString:@"(null)"] ) {
        
        NSDictionary *dic = [self.BCMRightArray objectAtIndex:index];
        
        price = [dic objectForKey:@"MenuPrice"];
        
    }
    
    self.m_totalPrice = self.m_totalPrice + [price floatValue];
    
    self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",self.m_totalPrice];
    
    
    if ( self.m_totalPrice == 0.0000 || self.m_totalPrice <= 0.0000 ) {
        
        self.m_downView.hidden = YES;
        
    }else{
        
        self.m_downView.hidden = NO;
        
    }
    
    // =======总价钱的计算========
    
    
    
    // 将选择的菜单的值记录到字典里面
    NSMutableDictionary *l_dic22 = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    NSMutableDictionary *dic1 = [self.BCMRightArray objectAtIndex:index];
    
    [l_dic22 setObject:[dic1 objectForKey:@"CloudMenuID"] forKey:@"menuId"];
    [l_dic22 setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"amount"];
    
    [l_dic22 setObject:[dic1 objectForKey:@"MenuPrice"] forKey:@"price"];
    [l_dic22 setObject:[dic1 objectForKey:@"MenuName"] forKey:@"menuName"];
    [l_dic22 setObject:[dic1 objectForKey:@"MenuImageM"] forKey:@"MenuImage"];

    [l_dic22 setObject:[NSString stringWithFormat:@"%i",SelectLeft] forKey:@"sectionKey"];
    
    [dic setObject:l_dic22 forKey:[NSString stringWithFormat:@"%d",index]];
    
    
    [self.BCMRightTableview reloadData];
    
    // 刷新左边的tableView
    NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:SelectLeft inSection:0], nil];
    
    [self.BCMLeftTableview reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];

    
}

#pragma mark - MenuDetailDelegate
//- (void)menuDetailgetIndex:(NSDictionary *)aDic{

- (void)menuDetailgetIndex:(UIButton *)button{

//    NSString *indexString = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"index"]];
//
//    NSString *amount = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"amount"]];
//
//    int index = [indexString intValue];
//    
//    // 进行加的操作
//    [self copyToData:index withCount:amount];
    
    
    [self Addnum:button];
    
   
    
}

//- (void)minuMenuClicked:(NSDictionary *)aDic{

- (void)minuMenuClicked:(UIButton *)button{
    
    
    [self Jiannum:button];
    
    
/*
    NSString *indexString = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"index"]];
    
    NSString *Istring = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"amount"]];
    
    int index = [indexString intValue];
    
    // 进行减的操作
    NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:SelectLeft]];
    
    // 存放数组的总个数
    [dic setObject:[NSString stringWithFormat:@"%i",self.BCMRightArray.count] forKey:@"TotalCount"];
    
    
    NSMutableDictionary *l_dic = [dic objectForKey:[NSString stringWithFormat:@"%d",index]];
    
//    NSString *Istring = [l_dic objectForKey:@"amount"];
    
    int nownum;
    
    if ([Istring isEqualToString:@"1"]) {
        
        nownum = 0;
        
        // 存放字典中的值
        NSString *count = [self.m_countDic objectForKey:[NSString stringWithFormat:@"%i",SelectLeft]];
        
        int countValue = [count intValue];
        
        countValue = countValue - 1;
        
        [self.m_countDic setObject:[NSString stringWithFormat:@"%i",countValue] forKey:[NSString stringWithFormat:@"%i",SelectLeft]];
        
    }else{
        
        NSString *num = [NSString stringWithFormat:@"%@",Istring];
        
        nownum = [num intValue] - 1;
        
    }
    
    // ========计算总价钱的算法===========
    NSString *price = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"price"]];
    
    // 当数据没值的时候先从数组里进行赋值
    if ( [price isEqualToString:@"(null)"] ) {
        
        NSDictionary *dic = [self.BCMRightArray objectAtIndex:index];
        
        price = [dic objectForKey:@"MenuPrice"];
        
    }
    
    self.m_totalPrice = self.m_totalPrice - [price floatValue];
    
    self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",self.m_totalPrice];
    
    if ( self.m_totalPrice == 0.0000 || self.m_totalPrice <= 0.0000 ) {
        
        self.m_downView.hidden = YES;
        
    }else{
        
        self.m_downView.hidden = NO;
        
    }
    
    // =======总价钱的计算========
    
    
    // 将选择的菜单的值记录到字典里面
    NSMutableDictionary *l_dic11 = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    NSMutableDictionary *dic1 = [self.BCMRightArray objectAtIndex:index];
    
    [l_dic11 setObject:[dic1 objectForKey:@"CloudMenuID"] forKey:@"menuId"];
    [l_dic11 setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"amount"];
    [l_dic11 setObject:[dic1 objectForKey:@"MenuName"] forKey:@"menuName"];
    
    [l_dic11 setObject:[dic1 objectForKey:@"MenuPrice"] forKey:@"price"];
    [l_dic11 setObject:[dic1 objectForKey:@"MenuImage"] forKey:@"MenuImage"];
    [l_dic11 setObject:[NSString stringWithFormat:@"%i",SelectLeft] forKey:@"sectionKey"];
    
    [dic setObject:l_dic11 forKey:[NSString stringWithFormat:@"%d",index]];
    
    [self.BCMRightTableview reloadData];
    
    // 刷新左边的tableView
    NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:SelectLeft inSection:0], nil];
    
    [self.BCMLeftTableview reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
    
    
    */
   
    
}

- (IBAction)toHomeBtnClicked:(id)sender {
    
    // 表示送货上门
    self.m_typeString = @"1";
    
    // 送货上门操作
    
//    if ( self.m_shopList.count == 1 ) {
    
        // 设置导航栏右按钮的触发事件
        [self setRightButtonWithTitle:@"订单列表" action:@selector(orderListClicked)];
        
        self.m_tempView.hidden = YES;
        
        // 请求类别的数据-根据选择的店铺去请求数据
        [self categoryRequest];
//        
//    }else{
//        
//        // 如果有多个店铺的话则现实店铺选择的页面
//        self.m_typeView.hidden = YES;
//        
//        self.m_scrollerView.hidden = NO;
//        
//    }

    
}

- (IBAction)toShopBtnClicked:(id)sender {
    
    // 表示预约
    self.m_typeString = @"2";
    
    // 预约
    if ( self.m_shopList.count == 1 ) {
        
        // 设置导航栏右按钮的触发事件
        [self setRightButtonWithTitle:@"订单列表" action:@selector(orderListClicked)];

        self.m_tempView.hidden = YES;
        
        // 请求类别的数据-根据选择的店铺去请求数据
        [self categoryRequest];
        
    }else{
        
        // 如果有多个店铺的话则现实店铺选择的页面
        self.m_typeView.hidden = YES;
        
        self.m_scrollerView.hidden = NO;
        
    }
    
    
}

- (IBAction)cancelBtnClicked:(id)sender {
    
    [self goBack];
    
}

- (IBAction)btnClicked:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 111 ) {
        
        [self setDefault:YES withSale:NO withPrice:NO];
        
        isChangeSacle = YES;
        isChangePrice = YES;
        
    }else if ( btn.tag == 222 ){
        
        [self setDefault:NO withSale:YES withPrice:NO];
       
        isChangePrice = YES;

        isChangeSacle = NO;

        
    }else{
        
        [self setDefault:NO withSale:NO withPrice:YES];
  
        isChangeSacle = YES;

        isChangePrice = NO;

    }

}

- (void)setDefault:(BOOL)aDefault withSale:(BOOL)aSale withPrice:(BOOL)aPrice{
    
    self.m_morenBtn.selected = aDefault;
    self.m_saleBtn.selected = aSale;
    self.m_priceBtn.selected = aPrice;
    
    if ( aDefault ) {
        
        self.m_morenBtn.userInteractionEnabled = NO;
        self.m_saleBtn.userInteractionEnabled = YES;
        self.m_priceBtn.userInteractionEnabled = YES;
        
    }
    
    if ( aSale ) {
        
       
        self.m_morenBtn.userInteractionEnabled = YES;
        self.m_saleBtn.userInteractionEnabled = YES;
        self.m_priceBtn.userInteractionEnabled = YES;
        
        if ( isChangeSacle == NO ) {
            
            isSale = !isSale;

            if ( isSale ) {
                
                self.m_saleImgV.image = [UIImage imageNamed:@"arrow_up.png"];
                
            }else{
                
                self.m_saleImgV.image = [UIImage imageNamed:@"arrow_down.png"];
                
            }

        }

    }
    
    if ( aPrice ) {
        
        self.m_morenBtn.userInteractionEnabled = YES;
        self.m_saleBtn.userInteractionEnabled = YES;
        self.m_priceBtn.userInteractionEnabled = YES;
        
        if ( isChangePrice == NO ) {
            
            isPrice = !isPrice;
            
            if ( isPrice ) {
                
                self.m_priceImgV.image = [UIImage imageNamed:@"arrow_up.png"];
                
            }else{
                
                self.m_priceImgV.image = [UIImage imageNamed:@"arrow_down.png"];
                
                
            }
        }
        
    }
   
    
}

#pragma mark - CustomDelegate
- (void)addMenugetIndex:(NSDictionary *)aDic withCountDic:(NSMutableDictionary *)countDic{
 
    NSString *indexString = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"index"]];
    
    NSString *amount = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"amount"]];
    
    int index = [indexString intValue];
    
    self.m_countDic = countDic;
    
    [self customRulsData:index withCount:amount];
    
   
}

- (void)minuMenugetIndex:(NSDictionary *)aDic{
    
    
    
}

- (void)customRulsData:(int)index withCount:(NSString *)amount{
    
    NSString *customName = @"";

    NSString *customKey = @"";
    
    NSDictionary *dic123 = [self.BCMRightArray objectAtIndex:index];
    NSMutableArray *attributeList = [dic123 objectForKey:@"AttributeList"];
    
    for (int i = 0; i < attributeList.count; i++) {
        
        NSMutableDictionary *attributeDic = [attributeList objectAtIndex:i];
        
        NSString *attributeName = [NSString stringWithFormat:@"%@",[attributeDic objectForKey:@"AttributeName"]];
        
        NSString *string = [NSString stringWithFormat:@"%@",[Appdelegate.m_customNameDic objectForKey:[NSString stringWithFormat:@"%@",attributeName]]];
        
        if ( i == attributeList.count - 1 ) {
            
            if ( string.length != 0 ) {
                
                customName = [customName stringByAppendingString:[NSString stringWithFormat:@"%@",string]];
                
                customKey = [customKey stringByAppendingString:[NSString stringWithFormat:@"%@,%@",attributeName,string]];
            }
            
        }else{
            
            if ( string.length != 0 ) {
                
                customName = [customName stringByAppendingString:[NSString stringWithFormat:@"%@,",string]];
                
                customKey = [customKey stringByAppendingString:[NSString stringWithFormat:@"%@,%@|",attributeName,string]];

                
            }
        }
    }
  
    NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:SelectLeft]];
    //
    //    // 存放数组的总个数
    [dic setObject:[NSString stringWithFormat:@"%i",self.BCMRightArray.count] forKey:@"TotalCount"];
    //
    NSMutableDictionary *l_dic = [dic objectForKey:[NSString stringWithFormat:@"%d",index]];
    
    NSString *count11111 = [self.m_countDic objectForKey:[NSString stringWithFormat:@"%i",SelectLeft]];
    
    
    int countValue = [amount intValue];

    // ========计算总价钱的算法===========
    NSString *price = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"price"]];
    
    // 当数据没值的时候先从数组里进行赋值
    if ( [price isEqualToString:@"(null)"] ) {
        
        NSDictionary *dic = [self.BCMRightArray objectAtIndex:index];
        
        price = [dic objectForKey:@"MenuPrice"];
        
    }
    
    // =======总价钱的计算========
    // 将选择的菜单的值记录到字典里面
    NSMutableDictionary *l_dic22 = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    NSMutableDictionary *dic1 = [self.BCMRightArray objectAtIndex:index];
    
    // =====赋值类别的数量=======
    NSString *amountString = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"amount"]];
    
    int amountValue = [amountString intValue];
    
    int totalAmount = 0;
    
    totalAmount = countValue + amountValue;
    
    self.m_totalPrice = self.m_totalPrice + (countValue * [price floatValue]);
    
    self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",self.m_totalPrice];
    
    if ( self.m_totalPrice == 0.0000 || self.m_totalPrice <= 0.0000  ) {
        
        self.m_downView.hidden = YES;
        
    }else{
        
        self.m_downView.hidden = NO;
        
    }
    
    
    // ==========
    
    [l_dic22 setObject:[dic1 objectForKey:@"CloudMenuID"] forKey:@"menuId"];
    [l_dic22 setObject:[NSString stringWithFormat:@"%d",totalAmount] forKey:@"amount"];
    
    [l_dic22 setObject:[dic1 objectForKey:@"MenuPrice"] forKey:@"price"];
    [l_dic22 setObject:[dic1 objectForKey:@"MenuName"] forKey:@"menuName"];
    [l_dic22 setObject:[dic1 objectForKey:@"MenuImageM"] forKey:@"MenuImage"];
    
    [l_dic22 setObject:[NSString stringWithFormat:@"%i",SelectLeft] forKey:@"sectionKey"];
    
    // 赋值自定义参数的值
    [l_dic22 setObject:customName forKey:@"CustomNameKey"];

    [l_dic22 setObject:customKey forKey:@"CustomKey"];

    [dic setObject:l_dic22 forKey:[NSString stringWithFormat:@"%d",index]];
    
    [self.BCMRightTableview reloadData];
    
    // 刷新左边的tableView
    NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:SelectLeft inSection:0], nil];
    
    [self.BCMLeftTableview reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
    
    // ============================
    

    // 根据不同的情况将值添加到数组里
    if ( self.m_menuList.count == 0 ) {
        
        NSMutableDictionary *dic111 = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        [dic111 setObject:[dic1 objectForKey:@"CloudMenuID"] forKey:@"menuId"];
        [dic111 setObject:[NSString stringWithFormat:@"%d",totalAmount] forKey:@"amount"];
        
        [dic111 setObject:[dic1 objectForKey:@"MenuPrice"] forKey:@"price"];
        [dic111 setObject:[dic1 objectForKey:@"MenuName"] forKey:@"menuName"];
        [dic111 setObject:[dic1 objectForKey:@"MenuImageM"] forKey:@"MenuImage"];
        
        [dic111 setObject:[NSString stringWithFormat:@"%i",SelectLeft] forKey:@"sectionKey"];
        
        // 赋值自定义参数的值
        [dic111 setObject:customName forKey:@"CustomNameKey"];
        
        [dic111 setObject:customKey forKey:@"CustomKey"];

        
//        NSString *amount = [l_dic objectForKey:@"amount"];
        
        if ( ![amount isEqualToString:@"0"] ) {
            
            [self.m_menuList addObject:dic111];
            
        }
       

        
    }else{
        
        NSMutableArray *l_array = [[NSMutableArray alloc]initWithCapacity:0];

        NSMutableArray *menuIdArr = [[NSMutableArray alloc]initWithCapacity:0];
        NSMutableArray *customNameArr = [[NSMutableArray alloc]initWithCapacity:0];
        
        [l_array addObjectsFromArray:self.m_menuList];
        
        // 判断是否包含这个数据，如果数据一样，则重叠加起来，否则就直接添加一个数据
        for (int y = 0; y < l_array.count; y ++) {
            
            NSDictionary *dic_1 = [l_array objectAtIndex:y];
            
            NSString *customName1 = [NSString stringWithFormat:@"%@",[dic_1 objectForKey:@"CustomNameKey"]];
      
            NSString *menuId = [NSString stringWithFormat:@"%@",[dic_1 objectForKey:@"menuId"]];
            
            [menuIdArr addObject:menuId];
            [customNameArr addObject:customName1];
            
            
        }
        
        NSString *menuId_1 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"CloudMenuID"]];
        
        // 如果自定义的参数值一样并且menuId的值一样的话，则直接在原来的基础上将值加1，否则将重复的数据叠加到一起
        NSMutableDictionary *dic_2 = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        [dic_2 setObject:[dic1 objectForKey:@"CloudMenuID"] forKey:@"menuId"];
        [dic_2 setObject:[dic1 objectForKey:@"MenuPrice"] forKey:@"price"];
        [dic_2 setObject:[dic1 objectForKey:@"MenuName"] forKey:@"menuName"];
        [dic_2 setObject:[dic1 objectForKey:@"MenuImageM"] forKey:@"MenuImage"];
        
        [dic_2 setObject:[NSString stringWithFormat:@"%li",(long)SelectLeft] forKey:@"sectionKey"];
        // 赋值自定义参数的值
        [dic_2 setObject:customName forKey:@"CustomNameKey"];
        
        [dic_2 setObject:customKey forKey:@"CustomKey"];

        
        if ( [menuIdArr containsObject:menuId_1] ) {
            
            if ( [customNameArr containsObject:customName] ) {
                
                NSInteger index_1 = [customNameArr indexOfObject:customName];
                
                NSDictionary *dic_1 = [l_array objectAtIndex:index_1];
                
                NSString *amountString = [NSString stringWithFormat:@"%@",[dic_1 objectForKey:@"amount"]];
                
                int amountValue_1 = [amountString intValue];
                
                [dic_2 setObject:[NSString stringWithFormat:@"%d",amountValue_1 + countValue] forKey:@"amount"];
                
                [self.m_menuList replaceObjectAtIndex:index_1 withObject:dic_2];
                
            }else{
                
                [dic_2 setObject:[NSString stringWithFormat:@"%d",countValue] forKey:@"amount"];
                
                [self.m_menuList addObject:dic_2];
                
            }
            
        }else{
            
            [dic_2 setObject:[NSString stringWithFormat:@"%d",countValue] forKey:@"amount"];
            
            [self.m_menuList addObject:dic_2];
            
        }
        
    }

    
}

- (void)changeNumber:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    m_index = btn.tag;
    
    NSDictionary *dic = [self.BCMRightArray objectAtIndex:btn.tag];
    
    NSString *title = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuName"]];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:nil
                          message:title
                          delegate:self
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    self.m_textField = [alert textFieldAtIndex:0];
    self.m_textField.text = [NSString stringWithFormat:@"%@",btn.titleLabel.text];
    
    self.m_textField = [alert textFieldAtIndex:0];
    self.m_textField.delegate = self;
    self.m_textField.keyboardType = UIKeyboardTypeNumberPad;
    self.m_textField.placeholder = @"请输入数量";
    alert.tag = 18924;
    [alert show];
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ( textField == self.m_textField ) {
        
        [self hiddenNumPadDone:nil];
        
    }
    
}

- (void)setPriceWithAccount:(NSString *)number{
    
//    NSMutableDictionary *l_dic = [self.m_menuList objectAtIndex:m_index];
    
    NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:SelectLeft]];
    
    // 存放数组的总个数
    [dic setObject:[NSString stringWithFormat:@"%i",self.BCMRightArray.count] forKey:@"TotalCount"];
    
    NSMutableDictionary *l_dic = [dic objectForKey:[NSString stringWithFormat:@"%ld",(long)m_index]];
    
    NSString *Istring = [l_dic objectForKey:@"amount"];
    
    
    
    // ======判断如果自定义的数组值为空的话则不进行跳转，直接对菜单进行加减======
    NSDictionary *dic123 = [self.BCMRightArray objectAtIndex:m_index];
    
    if ( [[dic123 objectForKey:@"AttributeList"]count] != 0 ) {
        
        // 点击加号的时候进入自定义规则选择的页面
        HH_customRuleViewController *VC = [[HH_customRuleViewController alloc]initWithNibName:@"HH_customRuleViewController" bundle:nil];
        VC.m_customList = [dic123 objectForKey:@"AttributeList"];
        VC.m_menuString = [NSString stringWithFormat:@"%@",[dic123 objectForKey:@"MenuName"]];
        VC.delegate = self;
        //        NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:SelectLeft]];
        //        VC.m_dic = dic;
        VC.delegate = self;
        //        VC.m_menuList = self.BCMRightArray;
        VC.m_index = m_index;
        VC.m_countDic = self.m_countDic;
        VC.m_sectionIndex = SelectLeft;
        VC.m_amount = [Istring intValue];
        
        [self.navigationController pushViewController:VC animated:YES];
        
        
    }else{
        
        
        int nownum = [number intValue];
        
//        if ((!Istring) ||([Istring isEqualToString:@"0"])) {
//            
//            nownum = 1;
//            
//            // 存放字典中的值
//            NSString *count = [self.m_countDic objectForKey:[NSString stringWithFormat:@"%i",SelectLeft]];
//            
//            int countValue = [count intValue];
//            
//            countValue = countValue + 1;
//            
//            [self.m_countDic setObject:[NSString stringWithFormat:@"%i",countValue] forKey:[NSString stringWithFormat:@"%i",SelectLeft]];
//            
//        }
        
        // ========计算总价钱的算法===========
        NSString *price = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"price"]];
        
        // 当数据没值的时候先从数组里进行赋值
        if ( [price isEqualToString:@"(null)"] ) {
            
            NSDictionary *dic = [self.BCMRightArray objectAtIndex:m_index];
            
            price = [dic objectForKey:@"MenuPrice"];
            
        }
        
        self.m_totalPrice = self.m_totalPrice + [price floatValue];
        
        self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",self.m_totalPrice];
        
        
        if ( self.m_totalPrice == 0.0000 || self.m_totalPrice <= 0.0000 ) {
            
            self.m_downView.hidden = YES;
            
        }else{
            
            self.m_downView.hidden = NO;
            
        }
        
        // =======总价钱的计算========
        
        
        
        // 将选择的菜单的值记录到字典里面
        NSMutableDictionary *l_dic22 = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        NSMutableDictionary *dic1 = [self.BCMRightArray objectAtIndex:m_index];
        
        [l_dic22 setObject:[dic1 objectForKey:@"CloudMenuID"] forKey:@"menuId"];
        [l_dic22 setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"amount"];
        
        [l_dic22 setObject:[dic1 objectForKey:@"MenuPrice"] forKey:@"price"];
        [l_dic22 setObject:[dic1 objectForKey:@"MenuName"] forKey:@"menuName"];
        [l_dic22 setObject:[dic1 objectForKey:@"MenuImageM"] forKey:@"MenuImage"];
        
        [l_dic22 setObject:[NSString stringWithFormat:@"%i",SelectLeft] forKey:@"sectionKey"];
        
        [dic setObject:l_dic22 forKey:[NSString stringWithFormat:@"%ld",(long)m_index]];
        
        [self.BCMRightTableview reloadData];
        
        // 刷新左边的tableView
        NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:SelectLeft inSection:0], nil];
        
        [self.BCMLeftTableview reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
        
        // 添加到数组里面===============================
        NSMutableDictionary *dic_2 = [[NSMutableDictionary alloc]initWithCapacity:0];
        [dic_2 setObject:[dic1 objectForKey:@"CloudMenuID"] forKey:@"menuId"];
        [dic_2 setObject:[dic1 objectForKey:@"MenuPrice"] forKey:@"price"];
        [dic_2 setObject:[dic1 objectForKey:@"MenuName"] forKey:@"menuName"];
        [dic_2 setObject:[dic1 objectForKey:@"MenuImageM"] forKey:@"MenuImage"];
        
        [dic_2 setObject:[NSString stringWithFormat:@"%i",SelectLeft] forKey:@"sectionKey"];
        
        if ( self.m_menuList.count != 0 ) {
            
            // 首先判断数组里有没有这个数据，如果有则直接替换该数据，如果没有，则直接加入这个数据到数组里
            NSMutableArray *l_array = [[NSMutableArray alloc]initWithCapacity:0];
            
            NSMutableArray *menuIdArr = [[NSMutableArray alloc]initWithCapacity:0];
            
            
            [l_array addObjectsFromArray:self.m_menuList];
            
            for (int i = 0; i < l_array.count; i++) {
                
                NSDictionary *dic = [l_array objectAtIndex:i];
                
                NSString *menuId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"menuId"]];
                
                [menuIdArr addObject:menuId];
                
            }
            
            NSString *menuId_1 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"CloudMenuID"]];
            
            
            if ( [menuIdArr containsObject:menuId_1] ) {
                
                NSInteger index_1 = [menuIdArr indexOfObject:menuId_1];
                
                NSDictionary *dic_1 = [l_array objectAtIndex:index_1];
                
                NSString *amountString = [NSString stringWithFormat:@"%@",[dic_1 objectForKey:@"amount"]];
                
                int amountValue_1 = [amountString intValue];
                
                [dic_2 setObject:[NSString stringWithFormat:@"%d",amountValue_1 + 1] forKey:@"amount"];
                
                [self.m_menuList replaceObjectAtIndex:index_1 withObject:dic_2];
                
            }else{
                
                [dic_2 setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"amount"];
                
                [self.m_menuList addObject:dic_2];
                
            }
            
        }else{
            
            //            [self.m_menuList addObject:l_dic22];
            
            [dic_2 setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"amount"];
            
            [self.m_menuList addObject:dic_2];
            
        }
        
    }
    
    
    // =====================
}


@end
