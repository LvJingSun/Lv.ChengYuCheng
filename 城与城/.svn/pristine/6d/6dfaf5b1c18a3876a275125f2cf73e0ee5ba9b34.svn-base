//
//  CardLevelViewController.m
//  HuiHui
//
//  Created by mac on 15-7-28.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "CardLevelViewController.h"

#import "AddCardLevelViewController.h"

#import "HH_MemberDetailCell.h"

@interface CardLevelViewController ()

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@end

@implementation CardLevelViewController

@synthesize m_levelList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_levelList = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"会员卡等级列表";
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"新增等级" action:@selector(addLevel)];
    
    // 隐藏控件
    self.m_emptyLabel.hidden = YES;
    self.m_tableView.hidden = YES;
    
    
    [self setExtraCellLineHidden:self.m_tableView];
    
    // 请求会员卡等级的数据
    [self levelRequest];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 如果此值为1的话则重新请求数据刷新页面，否则的话不请求数据
    NSString *levelKey = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"levelGradeKey"]];
    
    if ( [levelKey isEqualToString:@"1"] ) {
        
        [CommonUtil addValue:@"0" andKey:@"levelGradeKey"];
        
        // 请求数据
        [self levelRequest];
        
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
    
}

- (void)addLevel{
    
    // 进入到新增等级的页面
    AddCardLevelViewController *VC = [[AddCardLevelViewController alloc]initWithNibName:@"AddCardLevelViewController" bundle:nil];
    VC.m_levelId = @"";
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - NetWorking
- (void)levelRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    //    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"MemberID",
                           key,@"Key",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"VIPCardGradeList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSLog(@"json = %@",json);
            
            // 赋值
            self.m_levelList = [json valueForKey:@"GradeList"];
            
            if ( self.m_levelList.count != 0 ) {
                
                self.m_emptyLabel.hidden = YES;
                
                self.m_tableView.hidden = NO;
                
                [self.m_tableView reloadData];
                
            }else{
                
                self.m_emptyLabel.hidden = NO;
                
                self.m_tableView.hidden = YES;
                
            }
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.m_levelList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"HH_cardLevelCellIdentifier";
    
    HH_cardLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_MemberDetailCell" owner:self options:nil];
        
        cell = (HH_cardLevelCell *)[nib objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        
        // 设置坐标
        cell.m_levelGrade.frame = CGRectMake(WindowSizeWidth - 20 - cell.m_levelGrade.frame.size.width, cell.m_levelGrade.frame.origin.y, cell.m_levelGrade.frame.size.width, cell.m_levelGrade.frame.size.height);
        
        
    }
    
    // 赋值
    if ( self.m_levelList.count != 0 ) {
        
        // 赋值
        NSMutableDictionary *dic = [self.m_levelList objectAtIndex:indexPath.row];
        
        cell.m_levelName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"GradeName"]];

        cell.m_description.text = [NSString stringWithFormat:@"描述:%@",[dic objectForKey:@"Description"]];

        cell.m_levelGrade.text = [NSString stringWithFormat:@"等级:%@",[dic objectForKey:@"GradeLevel"]];
        
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 进入编辑会员卡等级的页面
    NSMutableDictionary *dic = [self.m_levelList objectAtIndex:indexPath.row];
    
    AddCardLevelViewController *VC = [[AddCardLevelViewController alloc]initWithNibName:@"AddCardLevelViewController" bundle:nil];
    VC.m_levelId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"VIPCardGradeID"]];
    VC.m_dic = dic;
    [self.navigationController pushViewController:VC animated:YES];
    
}

@end
