//
//  BusinesserlistViewController.m
//  Receive
//
//  Created by 冯海强 on 13-12-26.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BusinesserlistViewController.h"
#import "BusinesserlistCell.h"
#import "DetailViewController.h"
#import "IncomeoneViewController.h"
#import "PBaseViewController.h"
#import "BprodetailViewController.h"

#import "CommonUtil.h"
#import "SVProgressHUD.h"
#import "AppHttpClient.h"

@interface BusinesserlistViewController ()

@property (weak, nonatomic) IBOutlet UIButton *RemindProBtn;
@property (weak, nonatomic) IBOutlet UILabel *RemindProLab;

@property (weak, nonatomic) IBOutlet UIButton *RemindBusBtn;
@property (weak, nonatomic) IBOutlet UILabel *RemindBusLab;
@property (weak, nonatomic) IBOutlet UILabel *RemindBusLab2;


@property (weak, nonatomic) IBOutlet UIButton *RemindShopBtn;
@property (weak, nonatomic) IBOutlet UILabel *RemindShopLab;
@property (weak, nonatomic) IBOutlet UILabel *RemindShopLab2;

@property (weak, nonatomic) IBOutlet UIButton *PBtnSVCProjecting;
@property (weak, nonatomic) IBOutlet UIButton *PBtnSVCAuditing;
@property (weak, nonatomic) IBOutlet UIButton *PBtnSVCSelling;
@property (weak, nonatomic) IBOutlet UIButton *PBtnSVCUnder;
@property (weak, nonatomic) IBOutlet UIButton *PBtnSVCViolation;

@property (weak, nonatomic) IBOutlet UIButton *BBtnSVCProjecting;
@property (weak, nonatomic) IBOutlet UIButton *BBtnSVCAuditing;
@property (weak, nonatomic) IBOutlet UIButton *BBtnSVCSelling;
@property (weak, nonatomic) IBOutlet UIButton *BBtnSVCUnder;
@property (weak, nonatomic) IBOutlet UIButton *BBtnSVCViolation;


@end

@implementation BusinesserlistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.Businesserarray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];

    self.RemindProBtn.hidden=YES;
    self.RemindBusBtn.hidden=YES;
    self.RemindProLab.hidden=YES;
    self.RemindBusLab.hidden=YES;
    self.RemindBusLab2.hidden=YES;
    self.RemindShopBtn.hidden=YES;
    self.RemindShopLab.hidden=YES;
    self.RemindShopLab2.hidden=YES;
    
    if ([copy isEqualToString:@"copy"]) {
        
        copy = nil;
        
        self.PBtnSVCProjecting.userInteractionEnabled = NO;
        self.PBtnSVCAuditing.userInteractionEnabled = YES;
        self.PBtnSVCSelling.userInteractionEnabled = YES;
        self.PBtnSVCUnder.userInteractionEnabled = YES;
        self.PBtnSVCViolation.userInteractionEnabled = YES;
        [self.PBtnSVCProjecting setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        [self.PBtnSVCAuditing setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
        [self.PBtnSVCSelling setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
        [self.PBtnSVCUnder setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
        [self.PBtnSVCViolation setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
        
        self.itemType = @"SVCProjecting";
        
    }
    
    if ([self.PorB isEqualToString:@"1"])
    {
        self.m_BtopView.hidden=YES;
        self.m_PtopView.hidden=NO;
        
        //请求产品需要页数；
        page=1;
        
        //是否是商户
        [self Ismerchant];
        
        
    }else if ([self.PorB isEqualToString:@"2"])
    {
        self.m_BtopView.hidden=NO;
        self.m_PtopView.hidden=YES;
        
        [self requestMerchantList:self.itemType];
        
    }

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ( isIOS7 ) {
        
        // tableView的线往右移了，添加这代码可以填充
        if ([self.B_ListTable respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.B_ListTable setSeparatorInset:UIEdgeInsetsZero];
        }
    }
    
    [self.RemindProBtn addTarget:self action:@selector(addProductInCome) forControlEvents:UIControlEventTouchUpInside];
    [self.RemindBusBtn addTarget:self action:@selector(addBusinesserInCome) forControlEvents:UIControlEventTouchUpInside];
    [self.RemindShopBtn addTarget:self action:@selector(PerfectMerchant) forControlEvents:UIControlEventTouchUpInside];

    
    [self.B_ListTable setDelegate:self];
    [self.B_ListTable setDataSource:self];
    [self.B_ListTable setPullDelegate:self];
    self.B_ListTable.pullBackgroundColor = [UIColor whiteColor];
    self.B_ListTable.useRefreshView = YES;
    self.B_ListTable.useLoadingMoreView= YES;
    
    // 隐藏多余的分割线
    [self setExtraCellLineHidden:self.B_ListTable];
    
    self.B_ListTable.hidden=YES;

    if ([self.PorB isEqualToString:@"1"])
    {
        self.PBtnSVCProjecting.userInteractionEnabled = NO;
        self.PBtnSVCAuditing.userInteractionEnabled = YES;
        self.PBtnSVCSelling.userInteractionEnabled = YES;
        self.PBtnSVCUnder.userInteractionEnabled = YES;
        self.PBtnSVCViolation.userInteractionEnabled = YES;
        
        [self.PBtnSVCProjecting setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        
        self.itemType = @"SVCProjecting";
        
        
    }else if ([self.PorB isEqualToString:@"2"])
    {
        
        self.itemType = @"Projecting";
        
        self.BBtnSVCProjecting.userInteractionEnabled = NO;
        self.BBtnSVCAuditing.userInteractionEnabled = YES;
        self.BBtnSVCSelling.userInteractionEnabled = YES;
        self.BBtnSVCUnder.userInteractionEnabled = YES;
        self.BBtnSVCViolation.userInteractionEnabled = YES;
        
        [self.BBtnSVCProjecting setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
    }
    
    if ([self.PorB isEqualToString:@"1"])
    {
        [self setTitle:@"我的产品"];
        
        [self setRightButtonWithTitle:@"发布" action:@selector(addInCome)];
        
        
    }else if ([self.PorB isEqualToString:@"2"])
    {
        [self setTitle:@"我的商户"];

        [self setRightButtonWithTitle:@"入驻" action:@selector(addInCome)];

    }
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

}

- (void)leftClicked{
    
    [self goBack];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//产品类型分类
-(IBAction)changeTypeP:(UIButton*)sender {
    self.RemindProBtn.hidden=YES;
    self.RemindProLab.hidden=YES;
    
    page=1;
    
    [self.PBtnSVCProjecting setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.PBtnSVCProjecting setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.PBtnSVCAuditing setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.PBtnSVCAuditing setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.PBtnSVCSelling setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.PBtnSVCSelling setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.PBtnSVCUnder setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.PBtnSVCUnder setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.PBtnSVCViolation setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.PBtnSVCViolation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if (sender == self.PBtnSVCProjecting) {
        
        self.B_ListTable.hidden = YES;
        self.PBtnSVCProjecting.userInteractionEnabled = NO;
        self.PBtnSVCAuditing.userInteractionEnabled = YES;
        self.PBtnSVCSelling.userInteractionEnabled = YES;
        self.PBtnSVCUnder.userInteractionEnabled = YES;
        self.PBtnSVCViolation.userInteractionEnabled = YES;
        
        [self.PBtnSVCProjecting setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        self.itemType = @"SVCProjecting";
        [self requestservicelist:self.itemType];//开发中
        
    }
    if (sender == self.PBtnSVCAuditing) {
        
        self.B_ListTable.hidden = YES;
        self.PBtnSVCProjecting.userInteractionEnabled = YES;
        self.PBtnSVCAuditing.userInteractionEnabled = NO;
        self.PBtnSVCSelling.userInteractionEnabled = YES;
        self.PBtnSVCUnder.userInteractionEnabled = YES;
        self.PBtnSVCViolation.userInteractionEnabled = YES;
        
        [self.PBtnSVCAuditing setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        self.itemType = @"SVCAuditing";
        [self requestservicelist:self.itemType];//审核中
    }
    if (sender == self.PBtnSVCSelling) {
        
        self.B_ListTable.hidden = YES;
        
        self.PBtnSVCProjecting.userInteractionEnabled = YES;
        self.PBtnSVCAuditing.userInteractionEnabled = YES;
        self.PBtnSVCSelling.userInteractionEnabled = NO;
        self.PBtnSVCUnder.userInteractionEnabled = YES;
        self.PBtnSVCViolation.userInteractionEnabled = YES;
        
        [self.PBtnSVCSelling setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        self.itemType = @"SVCSelling";
        [self requestservicelist:self.itemType];//销售中
        
    }
    if (sender == self.PBtnSVCUnder) {
        
        self.B_ListTable.hidden = YES;
        
        self.PBtnSVCProjecting.userInteractionEnabled = YES;
        self.PBtnSVCAuditing.userInteractionEnabled = YES;
        self.PBtnSVCSelling.userInteractionEnabled = YES;
        self.PBtnSVCUnder.userInteractionEnabled = NO;
        self.PBtnSVCViolation.userInteractionEnabled = YES;
        
        [self.PBtnSVCUnder setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        self.itemType = @"SVCUnder";
        [self requestservicelist:self.itemType];//已下架
        
    }
    if (sender == self.PBtnSVCViolation) {
        
        self.B_ListTable.hidden = YES;
        
        self.PBtnSVCProjecting.userInteractionEnabled = YES;
        self.PBtnSVCAuditing.userInteractionEnabled = YES;
        self.PBtnSVCSelling.userInteractionEnabled = YES;
        self.PBtnSVCUnder.userInteractionEnabled = YES;
        self.PBtnSVCViolation.userInteractionEnabled = NO;
        
        [self.PBtnSVCViolation setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        self.itemType = @"SVCViolation";
        [self requestservicelist:self.itemType];//违规
        
    }
    
    
    
}

//商户类型分类
-(IBAction)changeTypeB:(UIButton*)sender {
    
    [self.BBtnSVCProjecting setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.BBtnSVCProjecting setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.BBtnSVCAuditing setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.BBtnSVCAuditing setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.BBtnSVCSelling setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.BBtnSVCSelling setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.BBtnSVCUnder setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.BBtnSVCUnder setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.BBtnSVCViolation setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.BBtnSVCViolation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (sender == self.BBtnSVCProjecting) {
        self.itemType = @"Projecting";
        
        self.B_ListTable.hidden = YES;
        self.BBtnSVCProjecting.userInteractionEnabled = NO;
        self.BBtnSVCAuditing.userInteractionEnabled = YES;
        self.BBtnSVCSelling.userInteractionEnabled = YES;
        self.BBtnSVCUnder.userInteractionEnabled = YES;
        self.BBtnSVCViolation.userInteractionEnabled = YES;
        
        [self.BBtnSVCProjecting setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        [self requestMerchantList:self.itemType];//开发中
        
    }
    if (sender == self.BBtnSVCAuditing) {
        self.itemType = @"Processing";
        
        self.B_ListTable.hidden = YES;
        
        self.BBtnSVCProjecting.userInteractionEnabled = YES;
        self.BBtnSVCAuditing.userInteractionEnabled = NO;
        self.BBtnSVCSelling.userInteractionEnabled = YES;
        self.BBtnSVCUnder.userInteractionEnabled = YES;
        self.BBtnSVCViolation.userInteractionEnabled = YES;
        
        [self.BBtnSVCAuditing setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        [self requestMerchantList:self.itemType];//审核中
    }
    if (sender == self.BBtnSVCSelling) {
        self.itemType = @"Contracted";
        
        self.B_ListTable.hidden = YES;
        
        self.BBtnSVCProjecting.userInteractionEnabled = YES;
        self.BBtnSVCAuditing.userInteractionEnabled = YES;
        self.BBtnSVCSelling.userInteractionEnabled = NO;
        self.BBtnSVCUnder.userInteractionEnabled = YES;
        self.BBtnSVCViolation.userInteractionEnabled = YES;
        
        [self.BBtnSVCSelling setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        [self requestMerchantList:self.itemType];//已签约
        
    }
    
    if (sender == self.BBtnSVCUnder) {
        self.itemType = @"Returned";
        
        self.B_ListTable.hidden = YES;
        
        self.BBtnSVCProjecting.userInteractionEnabled = YES;
        self.BBtnSVCAuditing.userInteractionEnabled = YES;
        self.BBtnSVCSelling.userInteractionEnabled = YES;
        self.BBtnSVCUnder.userInteractionEnabled = NO;
        self.BBtnSVCViolation.userInteractionEnabled = YES;
        
        [self.BBtnSVCUnder setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        [self requestMerchantList:self.itemType];//已退回
        
    }
    
    if (sender == self.BBtnSVCViolation) {
        self.itemType = @"Stop";
        
        self.B_ListTable.hidden = YES;
        
        self.BBtnSVCProjecting.userInteractionEnabled = YES;
        self.BBtnSVCAuditing.userInteractionEnabled = YES;
        self.BBtnSVCSelling.userInteractionEnabled = YES;
        self.BBtnSVCUnder.userInteractionEnabled = YES;
        self.BBtnSVCViolation.userInteractionEnabled = NO;
        
        [self.BBtnSVCViolation setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        [self requestMerchantList:self.itemType];//冻结
        
    }
}




//会员状态
-(void)Ismerchant
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MemberMerchantList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSLog(@"json = %@",json);
            
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"merchantInfo"];
            if (metchantShop == nil || metchantShop.count == 0) {
                self.B_ListTable.hidden = YES;
                
                self.RemindBusBtn.hidden=NO;
                self.RemindBusLab.hidden=NO;
                self.RemindBusLab2.hidden=NO;
                self.RemindBusLab.text = @"您还没有入驻的商户，即刻入驻，免费将您的生意传播到本地品质人脉社交圈！";
                status =@"Noenter";//没入驻
                [self setRightButtonWithTitle:@"入驻" action:@selector(addInCome)];
                
                self.PBtnSVCProjecting.userInteractionEnabled = NO;
                self.PBtnSVCAuditing.userInteractionEnabled = NO;
                self.PBtnSVCSelling.userInteractionEnabled = NO;
                self.PBtnSVCUnder.userInteractionEnabled = NO;
                self.PBtnSVCViolation.userInteractionEnabled = NO;
                
                
                [self.PBtnSVCProjecting setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
                [self.PBtnSVCAuditing setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
                [self.PBtnSVCSelling setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
                [self.PBtnSVCUnder setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
                [self.PBtnSVCViolation setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
                
                
                return;
            } else {
                
                
                for (int i=0; i<metchantShop.count; i++)
                {
                    NSMutableDictionary *dic = [metchantShop objectAtIndex:i];
                    if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"Status"]]isEqualToString:@"Contracted"]) {
                        status =@"sign";//已签约
                        
                        [self requestservicelist:self.itemType];//默认开发中
                        
                        return;
                    }
                }
                
                self.RemindShopBtn.hidden=NO;
                self.RemindShopLab.hidden=NO;
                self.RemindShopLab2.hidden=NO;
                
                [self setRightButtonWithTitle:@"完善" action:@selector(addInCome)];
                
                status =@"Nosign";//没签约
                
                self.PBtnSVCProjecting.userInteractionEnabled = NO;
                self.PBtnSVCAuditing.userInteractionEnabled = NO;
                self.PBtnSVCSelling.userInteractionEnabled = NO;
                self.PBtnSVCUnder.userInteractionEnabled = NO;
                self.PBtnSVCViolation.userInteractionEnabled = NO;
                
                
                [self.PBtnSVCProjecting setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
                [self.PBtnSVCAuditing setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
                [self.PBtnSVCSelling setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
                [self.PBtnSVCUnder setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
                [self.PBtnSVCViolation setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
                
            }
            
        }
        else
        {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

//产品列表
-(void)requestservicelist:(NSString *)statuss
{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%d",page],@"pageIndex",
                           statuss,@"status",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MemberServiceList_1_0.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"memberSerivceInfo"];
            
            
            if (page == 1) {
                if (metchantShop == nil || metchantShop.count == 0) {
                    [self.Businesserarray removeAllObjects];
                    self.B_ListTable.hidden = YES;
                    
                    self.RemindProBtn.hidden=NO;
                    self.RemindProLab.hidden=NO;
                    return;
                } else {
                    
                    self.Businesserarray = metchantShop;
                    self.RemindProBtn.hidden=YES;
                    self.RemindProLab.hidden=YES;
                    self.RemindProBtn.hidden=YES;
                    self.RemindProLab.hidden=YES;
                    self.RemindShopBtn.hidden = YES;
                    self.RemindShopLab.hidden =YES;
                    self.RemindShopLab2.hidden =YES;
                    
                    
                }
            } else {
                if (metchantShop == nil || metchantShop.count == 0) {
                    self.RemindProBtn.hidden=YES;
                    self.RemindProLab.hidden=YES;
                    page--;
                } else {
                    self.RemindProBtn.hidden=YES;
                    self.RemindProLab.hidden=YES;
                    [self.Businesserarray addObjectsFromArray:metchantShop];
                    
                }
            }
            [self.B_ListTable reloadData];
            self.B_ListTable.hidden = NO;
        } else {
            if (page > 1) {
                page--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.B_ListTable.pullLastRefreshDate = [NSDate date];
        self.B_ListTable.pullTableIsRefreshing = NO;
        self.B_ListTable.pullTableIsLoadingMore = NO;
    } failure:^(NSError *error) {
        if (page > 1) {
            page--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        self.B_ListTable.pullTableIsRefreshing = NO;
        self.B_ListTable.pullTableIsLoadingMore = NO;
    }];
    
}

// 请求数据(商户)
- (void)requestMerchantList:(NSString *)statuss{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           statuss,@"status",
                           nil];
    
    NSLog(@"params = %@",param);
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MemberMerchantList_1_0.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"merchantInfo"];
            if (metchantShop == nil || metchantShop.count == 0) {
                [self.Businesserarray removeAllObjects];
                self.B_ListTable.hidden = YES;
                
                self.RemindBusBtn.hidden=NO;
                self.RemindBusLab2.hidden=NO;
                self.RemindBusLab.hidden=NO;
                
                return;
            } else {
                
                self.B_ListTable.hidden = NO;
                self.RemindBusBtn.hidden=YES;
                self.RemindBusLab2.hidden=YES;
                self.RemindBusLab.hidden=YES;
                
                self.Businesserarray = metchantShop;
                
                [self.B_ListTable reloadData];
                
            }
            self.B_ListTable.pullLastRefreshDate = [NSDate date];
            self.B_ListTable.pullTableIsRefreshing = NO;
            self.B_ListTable.pullTableIsLoadingMore = NO;
            
        }
        else
        {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.Businesserarray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"BusinesserlistCellIdentifier";
    
    BusinesserlistCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"BusinesserlistCell" owner:self options:nil];
        
        cell = (BusinesserlistCell *)[nib objectAtIndex:0];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    if ( self.Businesserarray.count != 0 ) {
        
        NSMutableDictionary *dic = [self.Businesserarray objectAtIndex:indexPath.row];
        
        if ([self.PorB isEqualToString:@"1"])
        {
            cell.BL_Data.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"ShelfTime"]];
            
            if ([self.itemType isEqualToString:@"SVCProjecting"])
            {
                cell.BL_states.text=@"开发中";
            }else if ([self.itemType isEqualToString:@"SVCSelling"])
            {
                cell.BL_states.text=@"销售中";
                cell.BL_states.textColor=[UIColor colorWithRed:0.6 green:0.9  blue:0.35 alpha:1.0f];
            }else if ([self.itemType isEqualToString:@"SVCAuditing"])
            {
                cell.BL_states.text=@"审核中";
                cell.BL_states.textColor=[UIColor colorWithRed:0.8 green:0.85  blue:0.25 alpha:1.0f];
            }
            else if ([self.itemType isEqualToString:@"SVCUnder"])
            {
                cell.BL_states.text=@"已下架";
                cell.BL_states.textColor=[UIColor colorWithRed:1 green:0  blue:0 alpha:1.0f];
            }

            else if ([self.itemType isEqualToString:@"SVCViolation"])
            {
                cell.BL_states.text=@"违规";
                cell.BL_states.textColor=[UIColor colorWithRed:1 green:0  blue:0 alpha:1.0f];
            }
            cell.BL_Name.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"SvcName"]];
            
            float aaa= [[NSString stringWithFormat:@"%@",[dic objectForKey:@"CommissionRate"]] floatValue];
            float bbb=(aaa/100)*[[NSString stringWithFormat:@"%@",[dic objectForKey:@"Price"]] floatValue];
            cell.BL_faren.text =[NSString stringWithFormat:@"%@(返利:%0.2f)",[NSString stringWithFormat:@"%@",[dic objectForKey:@"Price"]],bbb];
            
            
        }else if ([self.PorB isEqualToString:@"2"])
        {
            // 赋值
            cell.BL_Data.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ModifyDate"]];
            cell.BL_faren.text = [NSString stringWithFormat:@"%@(%@)",[dic objectForKey:@"OfficialContactsPhone"],[dic objectForKey:@"OfficialContacts"]];
            cell.BL_Name.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AllName"]];
            if ([self.itemType isEqualToString:@"Projecting"])
            {
                cell.BL_states.text = [NSString stringWithFormat:@"完善中"];
            }else if ([self.itemType isEqualToString:@"Processing"])
            {   cell.BL_states.text = [NSString stringWithFormat:@"审核中"];
                cell.BL_states.textColor=[UIColor colorWithRed:0.85 green:0.85  blue:0.25 alpha:1.0f];
                
            }else if ([self.itemType isEqualToString:@"Contracted"])
            {
                cell.BL_states.text = [NSString stringWithFormat:@"已签约"];
                cell.BL_states.textColor=[UIColor colorWithRed:0.5 green:0.9  blue:0.35 alpha:1.0f];
                
            }else if ([self.itemType isEqualToString:@"Returned"])
            {
                cell.BL_states.text = [NSString stringWithFormat:@"已退回"];
                cell.BL_states.textColor=[UIColor colorWithRed:1 green:0.3  blue:0.2 alpha:1.0f];
                
            }else if ([self.itemType isEqualToString:@"Stop"])
            {
                cell.BL_states.text = [NSString stringWithFormat:@"冻结"];
                cell.BL_states.textColor=[UIColor colorWithRed:1 green:0.3  blue:0.2 alpha:1.0f];
            }
            
        }
        
    }
    return cell;
}

//选中CELL
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.PorB isEqualToString:@"1"])
    {
        BprodetailViewController*BproDetailVC=[[BprodetailViewController alloc]initWithNibName:@"BprodetailViewController" bundle:nil];
        
        BproDetailVC.Copydelegate = self;
                
        BproDetailVC.ProDic=[self.Businesserarray objectAtIndex:indexPath.row];
        
        if ([self.itemType isEqualToString:@"SVCProjecting"]) {
            BproDetailVC.ProductStatus=@"1";//开发中
        }
        else if ([self.itemType isEqualToString:@"SVCAuditing"])
        {
            BproDetailVC.ProductStatus=@"2";//审核中
        }
        else if ([self.itemType isEqualToString:@"SVCSelling"])
        {
            BproDetailVC.ProductStatus=@"3";//销售中
            
//            index = indexPath.row;
//            [self CheckOREditing];
//            return;
        }

        else if ([self.itemType isEqualToString:@"SVCUnder"])
        {
            BproDetailVC.ProductStatus=@"6";//已下架
        }

        else if ([self.itemType isEqualToString:@"SVCViolation"])
        {
            BproDetailVC.ProductStatus=@"8";//违规
        }
        [self .navigationController pushViewController:BproDetailVC animated:YES];
        
    }
    else if ([self.PorB isEqualToString:@"2"])
    {
        
        DetailViewController*DetailVC=[[DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:nil];
        
        DetailVC.faxDic=[self.Businesserarray objectAtIndex:indexPath.row];
        
        if ([self.itemType isEqualToString:@"Projecting"]) {
            DetailVC.Iscanchange=@"1";
        }else  if ([self.itemType isEqualToString:@"Processing"]) {
            DetailVC.Iscanchange=@"2";
        }
        else if ([self.itemType isEqualToString:@"Contracted"]) {
            DetailVC.Iscanchange=@"3";
        }
        else  if ([self.itemType isEqualToString:@"Stop"]) {
            DetailVC.Iscanchange=@"4";
        }
        else if ([self.itemType isEqualToString:@"Returned"]) {
            DetailVC.Iscanchange=@"5";
        }
        
        [self.navigationController pushViewController:DetailVC animated:YES];
        
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中状态。。

    
}

//查看成员或是编辑
-(void)CheckOREditing;
{
    UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"产品编辑",@"查看订单", nil];
    sheet.tag = 10001;
    [sheet showInView:self.view];
    
}


-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 10001)
    {
        if (buttonIndex==0)
        {
            BprodetailViewController*BproDetailVC=[[BprodetailViewController alloc]initWithNibName:@"BprodetailViewController" bundle:nil];
            BproDetailVC.Copydelegate = self;
            BproDetailVC.ProDic=[self.Businesserarray objectAtIndex:index];
            BproDetailVC.ProductStatus=@"3";//销售中
            [self .navigationController pushViewController:BproDetailVC animated:YES];
            
        }
        if (buttonIndex==1)
        {
            [SVProgressHUD showSuccessWithStatus:@"订单查看"];
        }
    }
}


-(void)CopyValue:(NSString *)value{

    copy =value;
}



-(void)addInCome
{
    
    IncomeoneViewController*incomeVC=[[IncomeoneViewController alloc]initWithNibName:@"IncomeoneViewController" bundle:nil];
    
    PBaseViewController*PBaseVC=[[PBaseViewController alloc]initWithNibName:@"PBaseViewController" bundle:nil];
    
    if ([self.PorB isEqualToString:@"1"]){//是分享产品
        
        if ([status isEqualToString:@"Noenter"]) {//没入驻
            
            [self .navigationController pushViewController:incomeVC animated:YES];
        }
        else if ([status isEqualToString:@"sign"]){//已签约
            
            [self .navigationController pushViewController:PBaseVC animated:YES];
        }
        else if ([status isEqualToString:@"Nosign"]){//未签约
            
            [self PerfectMerchant];
            
        }
    }else if ([self.PorB isEqualToString:@"2"]){//是商户入驻
        
        [self .navigationController pushViewController:incomeVC animated:YES];
    }
}



-(void)addProductInCome
{
    
    PBaseViewController*PBaseVC=[[PBaseViewController alloc]initWithNibName:@"PBaseViewController" bundle:nil];
    
    [self .navigationController pushViewController:PBaseVC animated:YES];
    
}


-(void)addBusinesserInCome
{
    
    IncomeoneViewController*incomeVC=[[IncomeoneViewController alloc]initWithNibName:@"IncomeoneViewController" bundle:nil];
    
    [self .navigationController pushViewController:incomeVC animated:YES];
    
}


-(void)PerfectMerchant
{
    self.PorB=@"2";
    
    self.m_BtopView.hidden=NO;
    self.m_PtopView.hidden=YES;
    
    self.RemindShopBtn.hidden=YES;
    self.RemindShopLab.hidden=YES;
    self.RemindShopLab2.hidden=YES;
    
    [self setTitle:@"我的商户"];
    
    [self setRightButtonWithTitle:@"入驻" action:@selector(addInCome)];
    
    self.itemType = @"Projecting";
    
    self.BBtnSVCProjecting.userInteractionEnabled = NO;
    self.BBtnSVCAuditing.userInteractionEnabled = YES;
    self.BBtnSVCSelling.userInteractionEnabled = YES;
    self.BBtnSVCUnder.userInteractionEnabled = YES;
    self.BBtnSVCViolation.userInteractionEnabled = YES;
    
    [self.BBtnSVCProjecting setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
    
    [self requestMerchantList:self.itemType];
    
    
    
}



#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    if ([self.PorB isEqualToString:@"1"])
    {
        page=1;
        
        [self requestservicelist:self.itemType];
        
    }else if ([self.PorB isEqualToString:@"2"])
    {
        [self requestMerchantList:self.itemType];
    }
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    if ([self.PorB isEqualToString:@"1"])
    {
        page++;
        
        [self requestservicelist:self.itemType];
        
        
    }else if ([self.PorB isEqualToString:@"2"])
    {
        [self requestMerchantList:self.itemType];
        
    }
}




@end
