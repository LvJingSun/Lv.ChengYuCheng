//
//  MemberListViewController.m
//  baozhifu
//
//  Created by mac on 14-3-13.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MemberListViewController.h"

#import "MemberListCell.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"


@interface MemberListViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@end

@implementation MemberListViewController

@synthesize m_friendsArray;

@synthesize m_index;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_friendsArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_index = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"成员列表"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
   
    
    self.m_tableView.hidden = YES;
    self.m_emptyLabel.hidden = YES;
    
    
    // 请求数据
    [self memberRequestSubmit];
    

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
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

- (void)memberRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  self.m_activiceId,@"actId",
                                  self.m_typeString,@"actType",
                                  nil];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ActivityMemberList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
           
            self.m_friendsArray = [json valueForKey:@"ActMemberList"];
            
            if ( self.m_friendsArray.count != 0 ) {
                
                self.m_tableView.hidden = NO;
                
                [self.m_tableView reloadData];
                
                self.m_emptyLabel.hidden = YES;
                
            }else{
                
                self.m_tableView.hidden = YES;
                self.m_emptyLabel.hidden = NO;
 
            }
                        
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        
    }];

}

#pragma mark - UITabelViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.m_friendsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"MemberListCellIdentifier";
    
    MemberListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MemberListCell" owner:self options:nil];
        
        cell = (MemberListCell *)[nib objectAtIndex:0];
        
    }
    
    if ( self.m_friendsArray.count != 0 ) {
        
        NSDictionary *dic = [self.m_friendsArray objectAtIndex:indexPath.row];
        
        // 赋值
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"NickName"]];
        
        [cell setImageView:[NSString stringWithFormat:@"%@",[dic objectForKey:@"PhotoSmlUrl"]]];
        
        cell.m_phoneLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Account"]];
       
        cell.m_emailLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Email"]];

        NSString *sexString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Sex"]];
        
        if ( [sexString isEqualToString:@"Female"] ) {
            // 女
            cell.m_sexImgV.image = [UIImage imageNamed:@"gr_xingbie.png"];
            
        }else if ( [sexString isEqualToString:@"Male"] ){
            
            // 男
            cell.m_sexImgV.image = [UIImage imageNamed:@"gr_xingbie2.png"];
            
        }else{
            
            cell.m_sexImgV.image = [UIImage imageNamed:@""];

        }
        
        CGSize size = [cell.m_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 25) lineBreakMode:NSLineBreakByWordWrapping];
        
        cell.m_nameLabel.frame = CGRectMake(cell.m_nameLabel.frame.origin.x, cell.m_nameLabel.frame.origin.y, size.width, 25);
        
        cell.m_sexImgV.frame = CGRectMake(cell.m_nameLabel.frame.origin.x + size.width + 2, cell.m_sexImgV.frame.origin.y, cell.m_sexImgV.frame.size.width, cell.m_sexImgV.frame.size.height);
                             
    }
   
    
    return cell;
}

#pragma makr - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 77.0f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.m_index = indexPath.row;
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                       message:nil
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"打电话",@"发短信", nil];
    alertView.tag = 10132;
    [alertView show];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 10132 ) {
        
        NSDictionary *dic = [self.m_friendsArray objectAtIndex:self.m_index];
        
        NSString *phone = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Account"]];
        
        if ( buttonIndex == 1 ) {
            
            // 调用此方法，进入通讯录后不返回程序  下面的方法将会返回程序当中
            //    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone]];//telprompt
            //    [[UIApplication sharedApplication] openURL:phoneNumberURL];
            
            // 判断设备是否支持
            if([[[UIDevice currentDevice] model] rangeOfString:@"iPhone Simulator"].location != NSNotFound) {
                
                [SVProgressHUD showErrorWithStatus:@"该设备暂不支持电话功能"];
                
            }else{
                
                self.m_webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
                [self.m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone]]]];
                
            }
            
        }else if ( buttonIndex == 2 ){
            
            if ([MFMessageComposeViewController canSendText]) {
                MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
                picker.messageComposeDelegate = self;
                picker.body = @"";
                picker.recipients = [NSArray arrayWithObject:[NSString stringWithFormat:@"%@",phone]];
                [self presentViewController:picker animated:YES completion:nil];
                
            } else {
                
                [SVProgressHUD showErrorWithStatus:@"该设备不支持短信功能"];
            }

        }else{
            
            
        }
    }
    
    
}

#pragma mark - MFMessageComposeViewControllerDelegate
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    switch (result) {
        case MessageComposeResultCancelled:
            break;
        case MessageComposeResultFailed:
            [SVProgressHUD showErrorWithStatus:@"发送失败"];
            break;
        case MessageComposeResultSent:
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
            break;
        default:
            break;
    }
}
@end
