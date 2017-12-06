//
//  SettingViewController.m
//  HuiHui
//
//  Created by mac on 13-11-20.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "SettingViewController.h"

#import "AboutViewController.h"

#import "CommonUtil.h"
#import "ApplyViewController.h"

#import "DynamicViewController.h"

#import "PushNotificationViewController.h"

@interface SettingViewController ()


@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        friendHelp = [[FriendHelper alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self setTitle:@"设置"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    if ( isIOS7 ) {
        // tableView的线往右移了，添加这代码可以填充
        if ([self.m_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.m_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
    }
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    if ( section == 0 ) {
        
        return 1;
        
    }
    else if ( section == 1) {
        
        return 2;
        
    }
    else{
        
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        cell = [(UITableViewCell *)[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        // 添加分割线
//        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43, 320, 1)];
//        imgV.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
//        
//        [cell addSubview:imgV];

    }
     if ( indexPath.section == 0 )
     {
         cell.textLabel.text = @"消息设置";
         
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         
         cell.selectionStyle = UITableViewCellSelectionStyleGray;
         
     }
    else if ( indexPath.section == 1 ) {
        
        if ( indexPath.row == 0 ) {
            
            cell.textLabel.text = @"关于";
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
        }else if ( indexPath.row == 1 ) {
            
            cell.textLabel.text = @"帮助";
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
        }else{
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            // 将本身的版本与服务器端请求的数据进行比较，若相同则不升级；反之升级
            NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
            
            
            cell.textLabel.text = [NSString stringWithFormat:@"当前版本：%@",version];
                        
            cell.detailTextLabel.textColor = [UIColor redColor];
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 130, 40)];
            
            view.backgroundColor = [UIColor clearColor];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:@"button_m.png"] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
            button.backgroundColor = [UIColor clearColor];
            [button addTarget:self action:@selector(upDateVersion) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(60, 5, 60, 30);
            [button setTitle:@"升级" forState:UIControlStateNormal];
            
            
            if ( [version isEqualToString:[CommonUtil getValueByKey:VERSION_NUM]] ) {
                
                cell.detailTextLabel.text = @"此版本为最新版本";
                
                button.enabled = NO;
                
            }else{
                
                cell.detailTextLabel.text = @"已有新版本，可立即升级";
                
                button.enabled = YES;
            }
            
            
            [view addSubview:button];
            
            cell.accessoryView = view;
            
        }
        
        
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];

    }else{
        
        cell = [(UITableViewCell *)[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

        cell.textLabel.text = @"退出登录";
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        
        cell.textLabel.textColor = [UIColor redColor];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];

    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ( indexPath.section == 0 )
    {
        PushNotificationViewController *pushController = [[PushNotificationViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:pushController animated:YES];
        
    }
    else if ( indexPath.section == 1 ) {
        
        if ( indexPath.row == 0 ) {
            
            AboutViewController *VC = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
            VC.m_typeString = @"63";
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ( indexPath.row == 1 ) {
            
            AboutViewController *VC = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
            VC.m_typeString = @"64";
            [self.navigationController pushViewController:VC animated:YES];
            
            
        }else{
            
            
        }

    }else{
        
        
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"确定退出系统"
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:@"确定", nil];
        alertView.tag = 1989;
        [alertView show];

        
    }
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 1989 ) {
        
        if ( buttonIndex == 1 ) {
            
            [self logoutAction];
            
        }else{
            
            
        }
    }
    
}

// 版本更新
- (void)upDateVersion{
    // 点击进入版本升级的url-appStore下载的地址
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[CommonUtil getValueByKey:VERSION_APPURL]]];
}

- (void)logoutAction
{
    __weak SettingViewController *weakSelf = self;
    [self showHudInView:self.view hint:@"正在退出..."];
    [[EaseMob sharedInstance].chatManager asyncLogoffWithCompletion:^(NSDictionary *info, EMError *error) {
        [weakSelf hideHud];
        if (error) {
            [weakSelf showHint:error.description];
        }
        else{
            [[ApplyViewController shareController] clear];
            [DynamicViewController attemptDealloc];
            //清除密码
            [CommonUtil addValue:@"0" andKey:LOGINSELF];
            [CommonUtil addValue:@"(null)" andKey:MEMBER_ID];
            // 清空qq的token及openId的值
            [CommonUtil addValue:@"" andKey:QQAccessTokenKey];
            [CommonUtil addValue:@"" andKey:QQCurrentUserIdKey];
            [CommonUtil addValue:@"" andKey:QQExpirationDateKey];
            [CommonUtil addValue:@"" andKey:weixinOrQqOrAccount];

            
            
            // 退出账号时清空我的里面红点的数据 ====
            // 默认第一次赋值都为0
            NSDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"0",@"IntegralRecordList",@"0",@"KeyList",@"0",@"MemberOrder",@"0",@"MemberPublicInviteList",@"0",@"MemberToken",@"0",@"TransactionRecords", nil];
            
            NSArray *arr = [NSArray arrayWithObject:dic];
            
            [friendHelp updateRedDot:arr];
            
            // 退出的时候删除加在状态栏位置的label
            if ( isIOS7 ) {
                
                // 移除导航栏上面的view
                for (UILabel *label in self.tabBarController.navigationController.view.subviews) {
                    
                    if ( label.tag == 10392 ) {
                    
                        [label removeFromSuperview];
                        
                    }
                }
                
            }
            
            [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
            
//            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
        }
    } onQueue:nil];
}

-(void)NotifiExit
{
    
    
}

@end
