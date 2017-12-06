//
//  ApplicationPayViewController.m
//  HuiHui
//
//  Created by mac on 15-5-25.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "ApplicationPayViewController.h"

#import "RightCell.h"

#import "ApplicationPayStyleViewController.h"

@interface ApplicationPayViewController ()

@property (weak, nonatomic) IBOutlet UIControl *m_alphaView;

@property (weak, nonatomic) IBOutlet UIView *m_backView;

@property (weak, nonatomic) IBOutlet UITextField *m_textField;


- (IBAction)alphaviewTap:(id)sender;

// 选择类别
- (IBAction)chooseCategoryClicked:(id)sender;

// 立即申请按钮触发的事件
- (IBAction)nextStepClicked:(id)sender;

@end

@implementation ApplicationPayViewController

@synthesize m_array;

@synthesize m_type;

@synthesize m_price;

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
    
    [self setTitle:@"立即申请"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    rightOpened = NO;
    
    self.m_type = @"";
    
    // 请求代理商等级数据
    [self requestLevelSubmit];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    rightOpened = NO;

    
    CGRect frame4 = self.m_tableView.frame;
    //    frame4.size.height = 0.0f;
    frame4 = CGRectMake(10, 84,  WindowSizeWidth - 26, 0);
    
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
             
             NSDictionary *dic = [self.m_array objectAtIndex:indexPath.row];
             
             [cell.MctName setText:[NSString stringWithFormat:@"%@ %@ %@",[dic objectForKey:@"LevelPrice"],[dic objectForKey:@"LevelName"],[dic objectForKey:@"LevelDesc"]]];
             
//             [cell.MctName setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"LevelName"]]];

         }
         
         return cell;
         
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell = (RightCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         self.m_textField.text = [NSString stringWithFormat:@"%@",cell.MctName.text];
         
         if ( self.m_array.count != 0 ) {
             
             NSDictionary *dic = [self.m_array objectAtIndex:indexPath.row];
             
             self.m_type = [NSString stringWithFormat:@"%@",[dic objectForKey:@"DaiLiLevelID"]];
             
             self.m_price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"LevelPrice"]];
             
         }
         
         [self alphaviewTap:nil];
         
     }];
    
    [self.m_tableView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.m_tableView.layer setBorderWidth:0];
}

- (IBAction)chooseCategoryClicked:(id)sender {
    
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

- (void)orderNoRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
   
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",self.m_type],@"daiLiLevelID",
                           nil];

    NSLog(@"params = %@",param);
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"CCPDaiLiShenQing.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSLog(@"json = %@",json);
          
            // 获得的订单号作为微信支付的标志
            NSString *msg = [json valueForKey:@"msg"];

            // 点击去支付后将数据保存起来用于微信支付的赋值
            [CommonUtil addValue:@"申请代理商等级" andKey:WEIXIN_NAME];
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",self.m_price] andKey:WEIXIN_PRICE];
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",msg] andKey:WEIXIN_OREDENO];
        
            
            // 提交申请后生成订单 然后 进入选择支付的页面
            ApplicationPayStyleViewController *VC = [[ApplicationPayStyleViewController alloc]initWithNibName:@"ApplicationPayStyleViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

    
}

- (IBAction)nextStepClicked:(id)sender {
    
    NSLog(@"type = %@",self.m_type);
    
    if ( self.m_type.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择一种代理等级"];
        
        return;
    }
    
    // 请求接口获得订单id作为微信的唯一标识
    [self orderNoRequest];
    
}

- (IBAction)alphaviewTap:(id)sender
{
    
    rightOpened = YES;
    
    [self chooseCategoryClicked:nil];
}

- (void)requestLevelSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
//    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
//    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"GetDaiLiLevel.ashx" parameters:nil success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSLog(@"json = %@",json);
            
            // 赋值
            self.m_array = [json valueForKey:@"daiLiLevelList"];
            
            [self reloadTableData];
            
            
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
