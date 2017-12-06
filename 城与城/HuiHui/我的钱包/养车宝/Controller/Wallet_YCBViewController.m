//
//  Wallet_YCBViewController.m
//  HuiHui
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Wallet_YCBViewController.h"
#import "RedHorseHeader.h"
#import "Wallet_FSB_HeadView.h"

#import "New_WalletModel.h"
#import "New_WalletFrame.h"
#import "MyWallet_Cell.h"
#import "Wallet_GetOutViewController.h"
#import "Wallet_YCB_RedBageViewController.h"
#import "Wallet_YCB_RecordViewController.h"

#import "GameBtnCellModel.h"
#import "GameBtnCellFrame.h"
#import "Wallet_Game_GetInCell.h"
#import "GameWebViewController.h"

#import "GameCenterModel.h"
#import "GameBtnCell.h"
#import "GameImageModel.h"

@interface Wallet_YCBViewController ()<UITableViewDelegate,UITableViewDataSource,GameBtnCellDelegate> {

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

@implementation Wallet_YCBViewController

-(NSArray *)Menus {
    
    if (_Menus == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Wallet_YCB_Menu.plist" ofType:nil];
        
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

    [self setTitle:@"养车宝"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.navigationItem.rightBarButtonItem = [self SetNavigationBarRightImage:@"fsb_mingxi.png" andaction:@selector(MingXiClicked)];
    
    self.view.backgroundColor = RH_ViewBGColor;
    
    [self allocWithTableview];
    
}

-(void)viewWillAppear:(BOOL)animated {

    [self requestForYCBbalance];
    
    [self requestForYCBgetout];
    
    [self requestForGameCenterData];
    
}

//请求养车宝转出限额
- (void)requestForYCBgetout {

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                         @"1",@"Type",
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

//请求养车宝余额
- (void)requestForYCBbalance {

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                         @"1",@"Type",
                         nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horserequest:@"MyBalance.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            self.headview.balanceLab.text = [NSString stringWithFormat:@"%.2f",[[json valueForKey:@"Balance"] floatValue]];
            
//            NSDictionary *dd1 = [NSDictionary dictionaryWithObjectsAndKeys:
//                                 [NSString stringWithFormat:@"%@",[json valueForKey:@"DZPIconImg"]],@"img",
//                                 [NSString stringWithFormat:@"%@",[json valueForKey:@"DZPLinkUrl"]],@"url",
//                                 nil];
//
//            NSDictionary *dd2 = [NSDictionary dictionaryWithObjectsAndKeys:
//                                 [NSString stringWithFormat:@"%@",[json valueForKey:@"DQEIconImg"]],@"img",
//                                 [NSString stringWithFormat:@"%@",[json valueForKey:@"DQELinkUrl"]],@"url",
//                                 nil];
//
//            NSDictionary *dd3 = [NSDictionary dictionaryWithObjectsAndKeys:
//                                 [NSString stringWithFormat:@"%@",[json valueForKey:@"CHJIconImg"]],@"img",
//                                 [NSString stringWithFormat:@"%@",[json valueForKey:@"CHJLinkUrl"]],@"url",
//                                 nil];
//
//            NSArray *arr = [NSArray arrayWithObjects:dd1,dd2,dd3, nil];
//
//            NSMutableArray *tempGames = [NSMutableArray array];
//
//            GameBtnCellModel *gamesModel = [[GameBtnCellModel alloc] init];
//
//            gamesModel.games = arr;
//
//            GameBtnCellFrame *gamesFrame = [[GameBtnCellFrame alloc] init];
//
//            gamesFrame.gameBtnCellModel = gamesModel;
//
//            [tempGames addObject:gamesFrame];
//
//            self.gameArray = tempGames;
//
//            [self.tableview reloadData];
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
                
            [SVProgressHUD showErrorWithStatus:msg];

        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//请求游戏大厅数据
- (void)requestForGameCenterData {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient *httpClient = [AppHttpClient sharedGame];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           nil];
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    [httpClient gamerequest:@"GameHomeInfo_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            GameCenterModel *center = [[GameCenterModel alloc] initWithDict:(NSDictionary *)json];
            //
            //            gameCenterModel = center;
            //
            //            [self.iconImageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[json valueForKey:@"MemPhoto"]]] placeholderImage:[UIImage imageNamed:@""]];
            //
            //            self.nameLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"NickName"]];
            //
            //            self.countLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"AccountBalance"]];
            //
            //            //轮播数据
            NSArray *gamesArr = center.listCategory;
            //
            //            NSMutableArray *temp = [NSMutableArray array];
            //
            //            for (GameImageModel *model in gamesArr) {
            //
            //                [temp addObject:model.GameLinkPhtoto];
            //
            //            }
            //
            //            NSMutableArray *sourceTemp = [NSMutableArray array];
            //
            //            GameScrollModel *scc = [[GameScrollModel alloc] init];
            //
            //            scc.source = temp;
            //
            //            GameScrollFrame *frame = [[GameScrollFrame alloc] init];
            //
            //            frame.scrollmodel = scc;
            //
            //            [sourceTemp addObject:frame];
            //
            //            self.sourceArray = sourceTemp;
            
            //入口按钮
            
            NSMutableArray *tempGames = [NSMutableArray array];
            
            GameBtnCellModel *gamesModel = [[GameBtnCellModel alloc] init];
            
            gamesModel.games = gamesArr;
            
            GameBtnCellFrame *gamesFrame = [[GameBtnCellFrame alloc] init];
            
            gamesFrame.gameBtnCellModel = gamesModel;
            
            [tempGames addObject:gamesFrame];
            
            self.gameArray = tempGames;
            
            [self.tableview reloadData];
            
            [SVProgressHUD showSuccessWithStatus:[json valueForKey:@"msg"]];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}


- (void)MingXiClicked {
    
    Wallet_YCB_RecordViewController *vc = [[Wallet_YCB_RecordViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)allocWithTableview {
    
    Wallet_FSB_HeadView *headview = [[Wallet_FSB_HeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, ScreenWidth, headview.height);
    
    self.headview = headview;
    
    headview.titleLab.text = @"我的红包余额（元）";
    
    headview.countBlock = ^{
        
        Wallet_YCB_RecordViewController *vc = [[Wallet_YCB_RecordViewController alloc] init];
        
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
    
    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return self.Menus.count;
        
    }else if (section == 1) {
        
        return self.gameArray.count;
        
    }else {
        
        return 0;
        
    }
    
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
    
    if (indexPath.section == 0) {
        
        MyWallet_Cell *cell = [[MyWallet_Cell alloc] init];
        
        New_WalletFrame *frame = self.Menus[indexPath.row];
        
        cell.frameModel = frame;
        
        return cell;
        
    }else if (indexPath.section == 1) {
        
        GameBtnCellFrame *frame = self.gameArray[indexPath.row];
        
        GameBtnCell *cell = [[GameBtnCell alloc] init];
        
        cell.delegate = self;
        
        cell.frameModel = frame;
        
        return cell;
        
    }else {
        
        return nil;
        
    }
    
}

//点击进入游戏
- (void)GameBtnClick:(UIButton *)sender {
    
    GameBtnCellFrame *frame = self.gameArray[0];
    
    GameBtnCellModel *gamemodel = frame.gameBtnCellModel;
    
    GameImageModel *model = gamemodel.games[sender.tag];
    
    NSString *str = [NSString stringWithFormat:@"%@?memberId=%@&app=ios",model.Link,[CommonUtil getValueByKey:MEMBER_ID]];
    
    GameWebViewController *vc = [[GameWebViewController alloc] init];
    
    vc.loadStr = str;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        New_WalletFrame *frame = self.Menus[indexPath.row];
        
        return frame.height;
        
    }else if (indexPath.section == 1) {
        
        GameBtnCellFrame *frame = self.gameArray[indexPath.row];
        
        return frame.height;
        
    }else {
        
        return 0;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 1) {
            //领取记录
            Wallet_YCB_RedBageViewController *vc = [[Wallet_YCB_RedBageViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 0) {
            
            //转出
            Wallet_GetOutViewController *vc = [[Wallet_GetOutViewController alloc] init];
            
            vc.viewType = @"YCB";
            
            vc.getoutCount = getoutCount;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
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
