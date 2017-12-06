//
//  Wallet_GAMEViewController.m
//  HuiHui
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Wallet_GAMEViewController.h"
#import "RedHorseHeader.h"
#import "Wallet_FSB_HeadView.h"
#import "LJConst.h"
#import "New_WalletModel.h"
#import "New_WalletFrame.h"
#import "MyWallet_Cell.h"
#import "FSB_CumulativeProfitViewController.h"
#import "Wallet_GetOutViewController.h"
#import "Wallet_GAME_RecordViewController.h"
#import "Wallet_GAMERechargeViewController.h"

#import "GameBtnCellModel.h"
#import "GameBtnCellFrame.h"
#import "Wallet_Game_GetInCell.h"
#import "GameWebViewController.h"
#import "ToMeViewController.h"

@interface Wallet_GAMEViewController ()<UITableViewDelegate,UITableViewDataSource,GameBtnCellDelegate> {

    //限制转出金额
    NSString *getoutCount;
    
    //限制转出说明
    NSString *getoutDesc;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) Wallet_FSB_HeadView *headview;

@property (nonatomic, strong) NSArray *Menus;

@property (nonatomic, strong) NSArray *gameArray;

@end

@implementation Wallet_GAMEViewController

-(NSArray *)Menus {
    
    if (_Menus == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Wallet_GAME_Menu.plist" ofType:nil];
        
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *mut = [NSMutableArray array];
        
        for (NSDictionary *dic in array) {
            
            New_WalletModel *model = [[New_WalletModel alloc] initWithDict:dic];
            
            New_WalletFrame *frame = [[New_WalletFrame alloc] init];
            
            frame.walletmodel = model;
            
            [mut addObject:frame];
            
        }
        
        _Menus = mut;
        
    }
    
    return _Menus;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = FSB_StyleCOLOR;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:FSB_NAVFont,NSForegroundColorAttributeName:FSB_NAVTextColor}];

    self.title = @"联城游戏";
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.navigationItem.rightBarButtonItem = [self SetNavigationBarRightImage:@"fsb_mingxi.png" andaction:@selector(MingXiClicked)];
    
    self.view.backgroundColor = RH_ViewBGColor;
    
    [self allocWithTableview];
    
}

- (UIBarButtonItem *)SetNavigationBarRightImage:(NSString *)aImageName andaction:(SEL)Saction{
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [addButton setFrame:CGRectMake(0, 0, 18, 20)];
    
    addButton.backgroundColor = [UIColor clearColor];
    
    [addButton setImage:[UIImage imageNamed:aImageName] forState:UIControlStateNormal];
    
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    return _addFriendItem;
    
}

- (void)setLeftButtonWithNormalImage:(NSString *)aImageName action:(SEL)action{

    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [backButton setImage:[UIImage imageNamed:aImageName] forState:UIControlStateNormal];
    [backButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
}

-(void)viewWillAppear:(BOOL)animated {

    [self requestForGAMEbalance];
    
    [self requestForYCBgetout];
    
}

//请求游戏转出限额
- (void)requestForYCBgetout {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                         @"3",@"Type",
                         nil];
    
    AppHttpClient *httpclient = [AppHttpClient sharedClient];
    
    [httpclient request:@"CashWithdrawalState_New.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            getoutCount = [NSString stringWithFormat:@"%@",[json valueForKey:@"LimitAmount"]];
            
            getoutDesc = [NSString stringWithFormat:@"%@",[json valueForKey:@"Descs"]];
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)requestForGAMEbalance {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                         @"3",@"Type",
                         nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horserequest:@"MyBalance.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            self.headview.balanceLab.text = [NSString stringWithFormat:@"%.2f",[[json valueForKey:@"Balance"] floatValue]];
            
            NSDictionary *dd1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSString stringWithFormat:@"%@",[json valueForKey:@"DZPIconImg"]],@"img",
                                 [NSString stringWithFormat:@"%@",[json valueForKey:@"DZPLinkUrl"]],@"url",
                                 nil];
            
            NSDictionary *dd2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSString stringWithFormat:@"%@",[json valueForKey:@"DQEIconImg"]],@"img",
                                 [NSString stringWithFormat:@"%@",[json valueForKey:@"DQELinkUrl"]],@"url",
                                 nil];
            
            NSDictionary *dd3 = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSString stringWithFormat:@"%@",[json valueForKey:@"CHJIconImg"]],@"img",
                                 [NSString stringWithFormat:@"%@",[json valueForKey:@"CHJLinkUrl"]],@"url",
                                 nil];
            
            NSArray *arr = [NSArray arrayWithObjects:dd1,dd2,dd3, nil];
            
            NSMutableArray *tempGames = [NSMutableArray array];
            
            GameBtnCellModel *gamesModel = [[GameBtnCellModel alloc] init];
            
            gamesModel.games = arr;
            
            GameBtnCellFrame *gamesFrame = [[GameBtnCellFrame alloc] init];
            
            gamesFrame.gameBtnCellModel = gamesModel;
            
            [tempGames addObject:gamesFrame];
            
            self.gameArray = tempGames;
            
            [self.tableview reloadData];
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)MingXiClicked {
    
    Wallet_GAME_RecordViewController *vc = [[Wallet_GAME_RecordViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)allocWithTableview {
    
    Wallet_FSB_HeadView *headview = [[Wallet_FSB_HeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, ScreenWidth, headview.height);
    
    self.headview = headview;
    
    headview.titleLab.text = @"我的游戏余额（元）";
    
    headview.countBlock = ^{
        
        Wallet_GAME_RecordViewController *vc = [[Wallet_GAME_RecordViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    
    self.tableview = tableview;
    
    UIView *header = [[UIView alloc] init];
    
    header.backgroundColor = [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0];
    
    header.frame = CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight);
    
    [tableview addSubview:header];
    
    tableview.tableHeaderView = headview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        
    return self.Menus.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    
    view.backgroundColor = RH_ViewBGColor;
    
    return view;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    MyWallet_Cell *cell = [[MyWallet_Cell alloc] init];
    
    New_WalletFrame *frame = self.Menus[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    New_WalletFrame *frame = self.Menus[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {

        //充值
        Wallet_GAMERechargeViewController *vc = [[Wallet_GAMERechargeViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 1) {
        
        //转出
        Wallet_GetOutViewController *vc = [[Wallet_GetOutViewController alloc] init];
        
        vc.viewType = @"Game";
        
        vc.getoutCount = getoutCount;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

- (void)leftClicked {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
