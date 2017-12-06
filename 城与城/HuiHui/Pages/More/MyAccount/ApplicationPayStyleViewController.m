//
//  ApplicationPayStyleViewController.m
//  HuiHui
//
//  Created by mac on 15-5-27.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "ApplicationPayStyleViewController.h"

#import "RightCell.h"

@interface ApplicationPayStyleViewController ()

@property (weak, nonatomic) IBOutlet UIControl *m_alphaView;

@property (weak, nonatomic) IBOutlet UIView *m_backView;

@property (weak, nonatomic) IBOutlet UITextField *m_textField;

- (IBAction)payClicked:(id)sender;

- (IBAction)alphaviewTap:(id)sender;

- (IBAction)choosePayClicked:(id)sender;

@end

@implementation ApplicationPayStyleViewController

@synthesize m_array;

@synthesize m_type;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_array = [[NSMutableArray alloc]initWithCapacity:0];

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"选择支付方式"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    rightOpened = NO;
    
    self.m_type = @"";

//    self.m_array = [NSMutableArray arrayWithObjects:@"银联支付",@"微信支付", nil];
  
    self.m_array = [NSMutableArray arrayWithObjects:@"微信支付", nil];

    // 刷新tableView
    [self reloadTableData];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    rightOpened = NO;
    
    
    CGRect frame4 = self.m_tableView.frame;
    //    frame4.size.height = 0.0f;
    frame4 = CGRectMake(0, 40,  WindowSizeWidth, 0);
    
    [self.m_tableView setFrame:frame4];
    
    self.m_alphaView.alpha = 0;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.m_tableView.hidden = YES;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

- (void) reloadTableData
{
    [self.m_tableView initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count = self.m_array.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightCell"];
         
         if (!cell)
         {
             cell = [[[NSBundle mainBundle]loadNibNamed:@"RightCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         if ( self.m_array.count != 0 ) {
             
             [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.m_array objectAtIndex:indexPath.row]]];
             
         }
         
         return cell;
         
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell = (RightCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         self.m_textField.text = [NSString stringWithFormat:@"%@",cell.MctName.text];
         
         self.m_type = [NSString stringWithFormat:@"%i",indexPath.row];
         
         [self alphaviewTap:nil];
         
     }];
    
    [self.m_tableView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.m_tableView.layer setBorderWidth:0];
}

- (IBAction)choosePayClicked:(id)sender {
    
    if (rightOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_tableView.frame;
            
            frame.size.height = 0;
            [self.m_tableView setFrame:frame];
            self.m_alphaView.alpha = 0;
            
        } completion:^(BOOL finished){
            
            rightOpened = NO;
        }];
    }else{
        
        self.m_tableView.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_tableView.frame;
            
            frame.origin.y = self.m_backView.frame.origin.y + self.m_backView.frame.size.height;
            
            int fr = self.m_array.count * 44;
            if (fr>300) {
                frame.size.height = 300;
            }else
            {
                frame.size.height = fr;
            }
            [self.m_tableView setFrame:frame];
            
            self.m_alphaView.alpha = 0.3;
            
        } completion:^(BOOL finished){
            
            rightOpened = YES;
            
        }];
        
    }
    
}

- (IBAction)payClicked:(id)sender {
    
    NSLog(@"type = %@",self.m_type);
    
    if ( self.m_type.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择一种支付方式"];
        
        return;
        
    }
   
    // 支付
//    if ( [self.m_type isEqualToString:@"0"] ) {
//        
//        // 银联支付
//        
//        
//        
//    }else
    
        if ( [self.m_type isEqualToString:@"0"] ) {
            
            // 表示是代理商申请
            [CommonUtil addValue:@"2" andKey:WEIXIN_PAYTYPE];

            
            // 判断是否安装了微信
            if ( [WXApi isWXAppInstalled] ) {
                
                // 微信支付
                // 微信支付 =======
                //创建支付签名对象
                payRequsestHandler *req = [payRequsestHandler alloc];
                //初始化支付签名对象
                [req init:APP_ID mch_id:MCH_ID];
                //设置密钥
                [req setKey:PARTNER_ID];
                
                //}}}
                
                //获取到实际调起微信支付的参数后，在app端调起支付
                NSMutableDictionary *dict = [req sendPay_demo];
                
                if(dict == nil){
                    //错误提示
                    NSString *debug = [req getDebugifo];
                    
                    [SVProgressHUD showErrorWithStatus:debug];
                    
                    //            [self alert:@"提示信息" msg:debug];
                    
                    NSLog(@"%@\n\n",debug);
                    
                }else{
                    
                    //            NSLog(@"%@\n\n",[req getDebugifo]);
                    //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
                    
                    NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                    
                    //调起微信支付
                    PayReq* req             = [[PayReq alloc] init];
                    req.openID              = [dict objectForKey:@"appid"];
                    req.partnerId           = [dict objectForKey:@"partnerid"];
                    req.prepayId            = [dict objectForKey:@"prepayid"];
                    req.nonceStr            = [dict objectForKey:@"noncestr"];
                    req.timeStamp           = stamp.intValue;
                    req.package             = [dict objectForKey:@"package"];
                    req.sign                = [dict objectForKey:@"sign"];
                    
                    NSLog(@"dict = %@",dict);
                    
                    [WXApi sendReq:req];
                }
                
                
                // ==========
 
                
                
            }else{
                
                // 微信没有安装
                [SVProgressHUD showErrorWithStatus:@"您没有安装微信"];
                
            }
        
       
    }
    
    
}

- (IBAction)alphaviewTap:(id)sender{
    
    rightOpened = YES;
    
    [self choosePayClicked:nil];
}


@end
