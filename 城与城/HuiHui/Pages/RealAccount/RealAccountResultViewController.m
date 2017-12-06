//
//  RealAccountResultViewController.m
//  baozhifu
//
//  Created by mac on 13-7-26.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "RealAccountResultViewController.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "RealAccountViewController.h"

@interface RealAccountResultViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *vldStatusImage;

@property (weak, nonatomic) IBOutlet UILabel *labMessage;

@property (weak, nonatomic) IBOutlet UILabel *labRealName;

@property (weak, nonatomic) IBOutlet UILabel *labIdcard;

@property (weak, nonatomic) IBOutlet UIButton *redoButton;

@property (weak, nonatomic) IBOutlet UIView *rootView;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

-(IBAction)account:(id)sender;

@end

@implementation RealAccountResultViewController

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
    
    self.rootView.hidden = YES;
    
    [self setTitle:@"实名认证"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
}

- (void)viewDidAppear:(BOOL)animated {
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
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"RealAttestation.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            NSLog(@"json = %@",json);
            
            NSMutableDictionary *realAccountData = [json valueForKey:@"realAttestation"];
            if (realAccountData != nil) {
                
                [realAccountData setObject:[json valueForKey:@"msg"] forKey:@"msg"];
                
            }
            [self setDataView:realAccountData];
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (void)setDataView:(NSMutableDictionary *)realAccountData {
    self.rootView.hidden = NO;
    NSString *vldStatus = [realAccountData objectForKey:@"VldStatus"];
    
    if ([VLD_STATUS_NOT_CERTIFIED isEqualToString:vldStatus]) {
        self.labRealName.hidden = YES;
        self.labIdcard.hidden = YES;
        return;
    }
    
    NSString *realName = [realAccountData objectForKey:@"RealName"];
    self.labRealName.text = [NSString stringWithFormat:@"姓　名：%@", realName];
    NSString *idcard = [realAccountData objectForKey:@"IDNumber"];
    self.labIdcard.text = [NSString stringWithFormat:@"证件号：%@", idcard];
    
    // 保存身份证证件号码
    //    [CommonUtil addValue:idcard andKey:REAL_ACCOUNT_IDCARD];
    
    NSString *message = [realAccountData objectForKey:@"msg"];
    self.labMessage.text = [NSString stringWithFormat:@"友情提示：\n%@", message];
    
    self.redoButton.hidden = YES;
    if ([VLD_STATUS_AUDIT isEqualToString:vldStatus]) {
        self.vldStatusImage.image = [UIImage imageNamed:@"icon_warning.png"];
    } else if ([VLD_STATUS_VALID isEqualToString:vldStatus]) {
        self.vldStatusImage.image = [UIImage imageNamed:@"icon_success.png"];
    } else if ([VLD_STATUS_INVALID isEqualToString:vldStatus]) {
        self.vldStatusImage.image = [UIImage imageNamed:@"icon_error.png"];
        self.redoButton.hidden = NO;
    }
}

-(IBAction)account:(id)sender {
    RealAccountViewController *viewController = [[RealAccountViewController alloc] initWithNibName:@"RealAccountViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
};

@end
