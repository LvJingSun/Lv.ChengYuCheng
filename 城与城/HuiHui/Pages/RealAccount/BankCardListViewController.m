//
//  BankCardListViewController.m
//  baozhifu
//
//  Created by mac on 13-7-23.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "BankCardListViewController.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "CardInfoListView.h"
#import "AddBankCardViewController.h"
#import "CardVerifyViewController.h"
#import "CardInfoController.h"

@interface BankCardListViewController () <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *bankListView;

@property (weak, nonatomic) IBOutlet UILabel *labelBanks;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

- (void)addBankCard:(id)sender;

@end

@implementation BankCardListViewController

@synthesize m_defaultCardId;
 
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backItem;
    
    [self setTitle:@"我的银行卡"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    [self setRightButtonWithNormalImage:@"add.png" action:@selector(addBankCard:)];

    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self loadData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
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

- (void)leftClicked{
    
    [self goBack];
}

- (void)loadData {
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberid",
                           key,   @"key",
                           @"ALL",   @"bnkListType",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"BankCarList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            self.bankItems = [json valueForKey:@"memberBankCard"];
            
            [self setDataView];
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (void)setDataView {
    NSArray *bankCarList = self.bankItems;
    CGFloat width = 294.0;
    CGFloat padding = (WindowSizeWidth - width) / 2.0;
    CGFloat height = 96.0;
    if (bankCarList == nil || [bankCarList count] == 0) {
        return;
    }
    for (UIView *view in [self.bankListView subviews]) {
        [view removeFromSuperview];
    }
    int count = [bankCarList count];
    self.labelBanks.text = [NSString stringWithFormat:@"已验证的银行卡（%d）", count];
    CardInfoListView *preView;
    CardInfoListView *currentView;
    for (NSInteger index = 0; index < count; index++) {
        preView = currentView;
        NSDictionary *bankInfo = [bankCarList objectAtIndex:index];
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CardInfoListView" owner:self options:nil];
        currentView = [array objectAtIndex:0];
        currentView.rootViewController = self;
        currentView.index = index;
        [currentView setData:bankInfo];
        currentView.frame = CGRectMake(padding, (padding+height)*index + padding, width, height);
        [self.bankListView addSubview:currentView];
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
        {
            [currentView setTranslatesAutoresizingMaskIntoConstraints:NO];

        }
    }
    
    // 设置scrollerView的滚动范围
    if ( isIOS7 ) {
        
         self.bankListView.contentSize = CGSizeMake(WindowSizeWidth, (height+padding)*count+padding + 20);
        
    }else{
        
         self.bankListView.contentSize = CGSizeMake(WindowSizeWidth, (height+padding)*count+padding);
    }
   
}

- (void)addBankCard:(id)sender {
    AddBankCardViewController *viewController = [[AddBankCardViewController alloc] initWithNibName:@"AddBankCardViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)selectCard:(NSString *)memberBankCardId index:(NSInteger)index status:(NSString *)status{
        
    self.m_defaultCardId = [NSString stringWithFormat:@"%@",memberBankCardId];
    
    self.m_index = index;
    
    // 判断是什么状态，如果是验证中的则不能进行删除银行卡的操作,否则则可以;失败的仅仅可以删除
    if ( [status isEqualToString:@"VerificationSucc"] ) {
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"设为默认" otherButtonTitles:@"删除", nil];
        
        sheet.tag = 10902;
        
        [sheet showInView:self.view];
        
    }else {
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil, nil];
        
        sheet.tag = 10903;
        
        [sheet showInView:self.view];
      
    }
    
}

// 设置为默认的请求数据
- (void)defaultSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedCityPay];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberid",
                           key,   @"key",
                           self.m_defaultCardId,   @"MemberBankCardId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient requestCityPay:@"DefaultBank.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            self.bankItems = [json valueForKey:@"memberBankCard"];
            
            [self loadData];
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}

// 删除银行卡
- (void)DeleteBankCard{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberid",
                           self.m_defaultCardId,@"MemberBankCardId",
                           nil];
    [SVProgressHUD showWithStatus:@"删除中"];
    [httpClient request:@"BankCardDelete.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[json valueForKey:@"msg"]];

            [self loadData];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {

        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (actionSheet.tag == 10902) {
        
        if (buttonIndex == 0) {
            
            // 设置为默认请求数据
            [self defaultSubmit];
            
        }else if (buttonIndex == 1) {
        
            [self DeleteBankCard];
            
        }
        
    }else if (actionSheet.tag == 10903) {
        
        if (buttonIndex == 0) {
            
            [self DeleteBankCard];
            
        }
        
    }
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 10902 ) {
        
        if ( buttonIndex == 1 ) {
                    
            // 设置为默认请求数据
            [self defaultSubmit];
        
        }else{
            
        }
            
    }else if ( alertView.tag == 10903 ){
            
            if ( buttonIndex == 1 ) {
                
                // 删除银行卡
                [self deleteCard:self.m_defaultCardId index:self.m_index];
            
            }else{
                
                
            }
        }
}

- (void)deleteCard:(NSString *)memberBankCardId index:(NSInteger)index {
   
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberid",
                           key,   @"key",
                           memberBankCardId,   @"MemberBankCardId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"DeleteBank.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            [self.bankItems removeObjectAtIndex:index];
            [self setDataView];
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (void)verifyCard:(NSDictionary *)bankInfo {
//    CardVerifyViewController *viewController = [[CardVerifyViewController alloc] initWithNibName:@"CardVerifyViewController" bundle:nil];
    
    CardInfoController *viewController = [[CardInfoController alloc] init];
    viewController.bankInfo = bankInfo;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
