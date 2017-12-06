//
//  ZanListViewController.m
//  HuiHui
//
//  Created by mac on 14-6-12.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "ZanListViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "FriDynamicViewController.h"


@interface ZanListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@end

@implementation ZanListViewController

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
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"赞"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    if ( isIOS7 ) {
        
        // tableView的线往右移了，添加这代码可以填充
        if ([self.m_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.m_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
    }
    
    self.m_tableView.hidden = YES;
    
    // 请求数据
    [self zanRequestSubmit];
    
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

#pragma mark - Network
- (void)zanRequestSubmit{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedSpace];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           self.m_dynimacId,@"dynamicID",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestSpace:@"PraiseMembers.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            self.m_zanList = [json valueForKey:@"DynPraiseList"];
            
            NSLog(@"%i",self.m_zanList.count);
            
            self.m_tableView.hidden = NO;
            
            [self.m_tableView reloadData];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_zanList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        cell = [(UITableViewCell *)[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        // 设置分割线
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43, WindowSizeWidth, 1)];
        imageView.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0];
        
        [cell.contentView addSubview:imageView];
        
    }
    
    if ( self.m_zanList.count != 0 ) {
        
        NSDictionary *dic = [self.m_zanList objectAtIndex:indexPath.row];
        // 赋值
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"NickName"]];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        
    }
    
    
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // 进入某个人的空间动态列表
    NSDictionary *dic = [self.m_zanList objectAtIndex:indexPath.row];
    
    FriDynamicViewController * VC = [[FriDynamicViewController alloc]initWithNibName:@"FriDynamicViewController" bundle:nil];
    [VC setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"NickName"]]];
    VC.m_memberId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]];
    [self.navigationController pushViewController:VC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

@end
