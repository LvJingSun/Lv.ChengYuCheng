//
//  FanliDetailViewController.m
//  HuiHui
//
//  Created by mac on 15-3-31.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "FanliDetailViewController.h"

@interface FanliDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *m_recordId;

@property (weak, nonatomic) IBOutlet UILabel *m_time;

@property (weak, nonatomic) IBOutlet UILabel *m_price;

@property (weak, nonatomic) IBOutlet UILabel *m_description;

@property (weak, nonatomic) IBOutlet UILabel *m_priceKey;

@property (weak, nonatomic) IBOutlet UILabel *m_key;

@property (weak, nonatomic) IBOutlet UILabel *m_status;

@end

@implementation FanliDetailViewController

@synthesize m_orderId;

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
    [self setTitle:@"返利详情"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    // 请求数据
    [self fanliDetailRequestSubmit];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)fanliDetailRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           [NSString stringWithFormat:@"%@",self.m_orderId],@"recordId",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestScenery:@"Flight/FlightRebateDetail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSLog(@"json = %@",json);
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            // 赋值
            self.m_dic = [json valueForKey:@"flightRebate"];
            
            self.m_recordId.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"OrderId"]];

            self.m_time.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"CreateDate"]];
            
            NSString *status = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Status"]];
            
            // Status：状态（1：处理中2：已退回3：成功）
            if ( [status isEqualToString:@"1"] ) {
                
                self.m_status.text = @"处理中";
                
                self.m_status.textColor = [UIColor redColor];//[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
                
                self.m_priceKey.hidden = YES;
                self.m_price.hidden = YES;
                self.m_key.hidden = YES;
                self.m_description.hidden = YES;
                
            }else if ( [status isEqualToString:@"2"] ){
                
                self.m_status.text = @"已退回";
                
                self.m_status.textColor = [UIColor redColor];//[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
                
                self.m_priceKey.hidden = YES;
                self.m_price.hidden = YES;
                self.m_key.hidden = NO;
                self.m_description.hidden = NO;

                self.m_description.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Description"]];
                
                
                if ( self.m_description.text.length == 0 ) {
                    
                    self.m_description.text = @"暂无说明";
                    
                }
                
                
                CGSize size = [self.m_description.text sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(210, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                self.m_description.frame = CGRectMake(self.m_description.frame.origin.x, self.m_description.frame.origin.y, 210, size.height);
                
                
            }else if ( [status isEqualToString:@"3"] ){
                
                self.m_status.text = @"申请成功";
                
                self.m_status.textColor = RGBACKTAB;
                
                self.m_priceKey.hidden = NO;
                self.m_price.hidden = NO;
                self.m_key.hidden = YES;
                self.m_description.hidden = YES;
                
                self.m_price.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Rebate"]];
                
                
            }else{
                
                self.m_status.text = @"";
                
            }
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}


@end
