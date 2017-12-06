//
//  JoinedViewController.m
//  baozhifu
//
//  Created by mac on 14-3-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JoinedViewController.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

#import "AppHttpClient.h"

@interface JoinedViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_orignLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_lineLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_tipLabel;

@property (weak, nonatomic) IBOutlet UITextField *m_passTextField;


// 我要参加按钮触发的事件
- (IBAction)joinedClicked:(id)sender;

//// 地址按钮触发的事件
//- (IBAction)addressBtnClicked:(id)sender;



@end

@implementation JoinedViewController

@synthesize m_dic;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"我要参加"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 赋值
    self.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ActivityName"]];
    
    self.m_timeLabel.text = [NSString stringWithFormat:@"%@~%@ %@至%@",[self.m_dic objectForKey:@"ActStartDate"],[self.m_dic objectForKey:@"ActEndDate"],[self.m_dic objectForKey:@"ActStartTime"],[self.m_dic objectForKey:@"ActEndtTime"]];
    
    self.m_addressLabel.text = [NSString stringWithFormat:@"%@\n%@",[self.m_dic objectForKey:@"AddressDetail"],[self.m_dic objectForKey:@"Address"]];
    
    self.m_priceLabel.text = [NSString stringWithFormat:@"￥%@",[self.m_dic objectForKey:@"Price"]];
    self.m_orignLabel.text = [NSString stringWithFormat:@"￥%@",[self.m_dic objectForKey:@"OriginalPrice"]];
    
    // 计算label的大小坐标
    CGSize size = [self.m_priceLabel.text sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize size1 = [self.m_orignLabel.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
    
    self.m_priceLabel.frame = CGRectMake(self.m_priceLabel.frame.origin.x, self.m_priceLabel.frame.origin.y, size.width, 21);
    self.m_orignLabel.frame = CGRectMake(self.m_priceLabel.frame.origin.x + size.width + 5, self.m_orignLabel.frame.origin.y, size1.width + 2, 21);
    
    self.m_lineLabel.frame = CGRectMake(self.m_priceLabel.frame.origin.x + size.width + 5, self.m_lineLabel.frame.origin.y, size1.width + 3, 1);
    
    self.m_tipLabel.text = [NSString stringWithFormat:@"（提示：您将支付%@元参加该活动）",[self.m_dic objectForKey:@"Price"]];
    
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

- (IBAction)joinedClicked:(id)sender {
    
    if ( self.m_passTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入支付密码"];
        
        return;
    }
    // 我要参加按钮触发的事件
    [self joinActivityRequest];
    
}

//- (IBAction)addressBtnClicked:(id)sender {
//    // 进入地图的页面
//    MapViewController *VC = [[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];
//    [self.navigationController pushViewController:VC animated:YES];
//}

// 参加活动请求接口
- (void)joinActivityRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ActivityID"]],   @"actId",
                                  [NSString stringWithFormat:@"%@",self.m_passTextField.text],@"payPassword",
                                  nil];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ActivityJoin.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
           
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 付款成功后跳转
            [NSTimer scheduledTimerWithTimeInterval:1.0
                                               target:self
                                             selector:@selector(goLastView)
                                             userInfo:nil
                                              repeats:NO];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];

        }
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        
    }];
    
    
}

- (void)goLastView{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
   
    [textField resignFirstResponder];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    return YES;
}

@end
