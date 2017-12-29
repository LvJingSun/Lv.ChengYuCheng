//
//  GameCenterHomeNewViewController.m
//  HuiHui
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameCenterHomeNewViewController.h"
#import "LJConst.h"
#import "GameCenterHomeNewHeadView.h"
#import "HL_NoticeModel.h"
#import "HL_NoticeFrame.h"
#import "HL_NoticeCell.h"
#import "HL_ScrollHornModel.h"
#import "HL_ScrollHornFrame.h"
#import "HL_ScrollHornCell.h"
#import "HL_HornTextModel.h"
#import "GameCenterGameModel.h"
#import "GameCenterGameArrayModel.h"
#import "GameCenterGameArrayFrame.h"
#import "GameCenterGameArrayCell.h"
#import "H_BecomeDelegateCell.h"
#import "H_BecomeDelegateModel.h"
#import "H_BecomeDelegateFrame.h"
#import "HL_NoDataCell.h"
#import "H_BecomeDelegateAlert.h"
#import "Buy_DelegateViewController.h"
#import "HL_RecommendViewController.h"
#import "GameCenterDelegateSectionHeadView.h"
#import "Game_MyTeamViewController.h"
#import "HL_MyInfoViewController.h"
#import "Game_MyCommisionViewController.h"
#import "GameTranViewController.h"
#import "New_GameDetailViewController.h"
#import "New_HLRechargeViewController.h"
#import "GameWebViewController.h"
#import "Wallet_GAMERechargeViewController.h"
#import "Wallet_GAME_RecordViewController.h"
#import "GameNoticeWebViewController.h"

@interface GameCenterHomeNewViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSString *balance;//账户余额
    
    NSString *noticeListLink;//通知h5链接
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *noticeArray;

@property (nonatomic, strong) NSArray *hornArray;

@property (nonatomic, strong) NSArray *gameArray;

@property (nonatomic, strong) NSArray *becomeArray;

@property (nonatomic, weak) GameCenterHomeNewHeadView *headview;

@end

@implementation GameCenterHomeNewViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setTitle:@"游戏大厅"];
    
    self.view.backgroundColor = FSB_ViewBGCOLOR;
    
    [self allocWithTableview];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self requestForHomeData];
    
}

- (void)requestForHomeData {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberId",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedHuLa];
    
    [SVProgressHUD show];
    
    [http HuLarequest:@"Home/Index.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        if ([[NSString stringWithFormat:@"%@",[json valueForKey:@"status"]] boolValue]) {
            
            self.headview.count = [NSString stringWithFormat:@"%@",[json valueForKey:@"balance"]];
            
            balance = [NSString stringWithFormat:@"%@",[json valueForKey:@"balance"]];
            
            noticeListLink = [NSString stringWithFormat:@"%@",[json valueForKey:@"noticeListLink"]];
            
            NSArray *gameArr = [json valueForKey:@"gameList"];

            NSMutableArray *gameMut = [NSMutableArray array];

            for (NSDictionary *gameDic in gameArr) {

                GameCenterGameModel *gameModel = [[GameCenterGameModel alloc] init];

                gameModel.gameName = [NSString stringWithFormat:@"%@",gameDic[@"gameName"]];

                gameModel.gameType = [NSString stringWithFormat:@"%@",gameDic[@"gameType"]];
                
                gameModel.gameTypeName = [NSString stringWithFormat:@"%@",gameDic[@"gameTypeName"]];

                gameModel.iconUrl = [NSString stringWithFormat:@"%@",gameDic[@"gameIcon"]];

                gameModel.ID = [NSString stringWithFormat:@"%@",gameDic[@"id"]];

                gameModel.gameLink = [NSString stringWithFormat:@"%@",gameDic[@"gameLink"]];

                [gameMut addObject:gameModel];

            }
            
            GameCenterGameArrayModel *model = [[GameCenterGameArrayModel alloc] init];
            
            model.gameArray = gameMut;
            
            GameCenterGameArrayFrame *frame = [[GameCenterGameArrayFrame alloc] init];
            
            frame.arrayModel = model;
            
            NSMutableArray *gamemut = [NSMutableArray array];
            
            [gamemut addObject:frame];
            
            self.gameArray = gamemut;
            
            
            NSArray *noticeArray = [json valueForKey:@"noticeList"];
            
            HL_NoticeModel *noticemodel = [[HL_NoticeModel alloc] init];
            
            noticemodel.title = @"今日通知";
            
            noticemodel.notice1 = [NSString stringWithFormat:@"%@",((NSDictionary *)noticeArray[0])[@"noticeTitle"]];
            
            noticemodel.notice1ID = [NSString stringWithFormat:@"%@",((NSDictionary *)noticeArray[0])[@"noticeId"]];
            
            noticemodel.notice2 = [NSString stringWithFormat:@"%@",((NSDictionary *)noticeArray[1])[@"noticeTitle"]];
            
            noticemodel.notice2ID = [NSString stringWithFormat:@"%@",((NSDictionary *)noticeArray[1])[@"noticeId"]];
            
            noticemodel.imgUrl = @"HL_公告.png";
            
            HL_NoticeFrame *noticeframe = [[HL_NoticeFrame alloc] init];
            
            noticeframe.noticeModel = noticemodel;
            
            NSMutableArray *noticemut = [NSMutableArray array];
            
            [noticemut addObject:noticeframe];
            
            self.noticeArray = noticemut;
            
            
            NSArray *hornArray = [json valueForKey:@"messageList"];
            
            NSMutableArray *horntemp = [NSMutableArray array];
            
            for (NSDictionary *hornDic in hornArray) {
                
                HL_HornTextModel *hornmodel = [[HL_HornTextModel alloc] init];
                
                hornmodel.textStr = [NSString stringWithFormat:@"%@",hornDic[@"message"]];
                
                [horntemp addObject:hornmodel];
                
            }
            
            HL_ScrollHornModel *scrModel = [[HL_ScrollHornModel alloc] init];
            
            scrModel.hornTextArray = horntemp;
            
            scrModel.hornImgUrl = @"HL_喇叭.png";
            
            HL_ScrollHornFrame *scrframe = [[HL_ScrollHornFrame alloc] init];
            
            scrframe.scrollHornModel = scrModel;
            
            NSMutableArray *scrmut = [NSMutableArray array];
            
            [scrmut addObject:scrframe];
            
            self.hornArray = scrmut;
            
            
            NSMutableArray *mut = [NSMutableArray array];
            
            NSArray *arr = [json valueForKey:@"agentCategoryList"];
            
            for (NSDictionary *dd in arr) {
                
                H_BecomeDelegateModel *model = [[H_BecomeDelegateModel alloc] init];
                
                model.CategoryId = [NSString stringWithFormat:@"%@",dd[@"CategoryId"]];
                
                model.title = [NSString stringWithFormat:@"%@",dd[@"CateGoryName"]];
                
                model.price = [NSString stringWithFormat:@"%@",dd[@"Price"]];
                
                model.btnStatus = [NSString stringWithFormat:@"%@",dd[@"btnStatus"]];
                
                model.Remark = [NSString stringWithFormat:@"%@",dd[@"Remark"]];
                
                model.OriginalPrice = [NSString stringWithFormat:@"%@",dd[@"OriginalPrice"]];
                
                model.CanMatching = [NSString stringWithFormat:@"%@",dd[@"CanMatching"]];
                
                model.MatchingPrice = [NSString stringWithFormat:@"%@",dd[@"MatchingPrice"]];
                
                H_BecomeDelegateFrame *frame = [[H_BecomeDelegateFrame alloc] init];
                
                frame.model = model;
                
                [mut addObject:frame];
                
            }
            
            self.becomeArray = mut;
            
            
            [self.tableview reloadData];
            
            [SVProgressHUD dismiss];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)allocWithTableview {
    
    GameCenterHomeNewHeadView *headview = [[GameCenterHomeNewHeadView alloc] init];
    
    self.headview = headview;
    
    headview.count = @"0";
    
    headview.frame = CGRectMake(0, 0, _WindowViewWidth, headview.height);
    
    headview.RecordBlock = ^{
        
        //记录点击
//        GameTranViewController *vc = [[GameTranViewController alloc] init];
//
//        [self.navigationController pushViewController:vc animated:YES];
        Wallet_GAME_RecordViewController *vc = [[Wallet_GAME_RecordViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    headview.RechargeBlock = ^{
      
        //充值点击
//        New_HLRechargeViewController *vc = [[New_HLRechargeViewController alloc] init];
//
//        [self.navigationController pushViewController:vc animated:YES];

        Wallet_GAMERechargeViewController *vc = [[Wallet_GAMERechargeViewController alloc] init];
        
        vc.balance = balance;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    headview.MyInfoBlock = ^{
        
        //我的信息点击
        HL_MyInfoViewController *vc = [[HL_MyInfoViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    headview.MyTeamBlock = ^{
        
        //我的团队点击
        Game_MyTeamViewController *vc = [[Game_MyTeamViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    headview.MyInvitationBlock = ^{
        
        //我的邀请点击
        HL_RecommendViewController *vc = [[HL_RecommendViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    headview.MyCommissionBlock = ^{
        
        //我的佣金点击
        Game_MyCommisionViewController *vc = [[Game_MyCommisionViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.tableHeaderView = headview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = FSB_ViewBGCOLOR;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 3) {
        
        GameCenterDelegateSectionHeadView *view = [[GameCenterDelegateSectionHeadView alloc] init];
        
        view.frame = CGRectMake(0, 0, _WindowViewWidth, view.height);
        
        view.titleLab.text = @"代理购买";
        
        return view;
        
    }else {
        
        return nil;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 3) {
        
        GameCenterDelegateSectionHeadView *view = [[GameCenterDelegateSectionHeadView alloc] init];
        
        return view.height;
        
    }else {
        
        return 0;
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return self.noticeArray.count;
        
    }else if (section == 1) {
        
        return self.hornArray.count;
        
    }else if (section == 2) {
        
        return self.gameArray.count;
        
    }else if (section == 3) {
        
        //成为代理
        if (self.becomeArray.count == 0) {
            
            return 1;
            
        }else {
            
            return self.becomeArray.count;
            
        }
        
    }
    
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        //今日通知
        HL_NoticeCell *cell = [[HL_NoticeCell alloc] init];
        
        HL_NoticeFrame *frame = self.noticeArray[indexPath.row];
        
        cell.frameModel = frame;
        
        cell.clickBlock = ^{
            
            //通知点击
            GameNoticeWebViewController *vc = [[GameNoticeWebViewController alloc] init];
            
            vc.loadStr = noticeListLink;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        };
        
        return cell;
        
    }else if (indexPath.section == 1) {
        
        //小喇叭
        HL_ScrollHornCell *cell = [[HL_ScrollHornCell alloc] init];
        
        HL_ScrollHornFrame *frame = self.hornArray[indexPath.row];
        
        cell.frameModel = frame;
        
        return cell;
        
    }else if (indexPath.section == 2) {
        
        //热门游戏
        GameCenterGameArrayFrame *frame = self.gameArray[indexPath.row];
        
        GameCenterGameArrayCell *cell = [[GameCenterGameArrayCell alloc] init];
        
        cell.frameModel = frame;
        
        cell.game1Block = ^{
            
            GameCenterGameModel *gameModel = frame.arrayModel.gameArray[0];
            
            if ([gameModel.gameType isEqualToString:@"1"]) {
                
                //h5
                NSString *str = [NSString stringWithFormat:@"%@?memberId=%@&app=ios",gameModel.gameLink,[CommonUtil getValueByKey:MEMBER_ID]];
                
                GameWebViewController *vc = [[GameWebViewController alloc] init];
                
                vc.loadStr = str;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if ([gameModel.gameType isEqualToString:@"2"]) {
                
                New_GameDetailViewController *vc = [[New_GameDetailViewController alloc] init];
                
                vc.gameID = gameModel.ID;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
        };
        
        cell.game2Block = ^{
            
            GameCenterGameModel *gameModel = frame.arrayModel.gameArray[1];
            
            if ([gameModel.gameType isEqualToString:@"1"]) {
                
                //h5
                NSString *str = [NSString stringWithFormat:@"%@?memberId=%@&app=ios",gameModel.gameLink,[CommonUtil getValueByKey:MEMBER_ID]];
                
                GameWebViewController *vc = [[GameWebViewController alloc] init];
                
                vc.loadStr = str;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if ([gameModel.gameType isEqualToString:@"2"]) {
                
                New_GameDetailViewController *vc = [[New_GameDetailViewController alloc] init];
                
                vc.gameID = gameModel.ID;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
        };
        
        cell.game3Block = ^{
            
            GameCenterGameModel *gameModel = frame.arrayModel.gameArray[2];
            
            if ([gameModel.gameType isEqualToString:@"1"]) {
                
                //h5
                NSString *str = [NSString stringWithFormat:@"%@?memberId=%@&app=ios",gameModel.gameLink,[CommonUtil getValueByKey:MEMBER_ID]];
                
                GameWebViewController *vc = [[GameWebViewController alloc] init];
                
                vc.loadStr = str;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if ([gameModel.gameType isEqualToString:@"2"]) {
                
                New_GameDetailViewController *vc = [[New_GameDetailViewController alloc] init];
                
                vc.gameID = gameModel.ID;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
        };
        
        cell.game4Block = ^{
            
            GameCenterGameModel *gameModel = frame.arrayModel.gameArray[3];
            
            if ([gameModel.gameType isEqualToString:@"1"]) {
                
                //h5
                NSString *str = [NSString stringWithFormat:@"%@?memberId=%@&app=ios",gameModel.gameLink,[CommonUtil getValueByKey:MEMBER_ID]];
                
                GameWebViewController *vc = [[GameWebViewController alloc] init];
                
                vc.loadStr = str;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if ([gameModel.gameType isEqualToString:@"2"]) {
                
                New_GameDetailViewController *vc = [[New_GameDetailViewController alloc] init];
                
                vc.gameID = gameModel.ID;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
        };
        
        cell.game5Block = ^{
            
            GameCenterGameModel *gameModel = frame.arrayModel.gameArray[4];
            
            if ([gameModel.gameType isEqualToString:@"1"]) {
                
                //h5
                NSString *str = [NSString stringWithFormat:@"%@?memberId=%@&app=ios",gameModel.gameLink,[CommonUtil getValueByKey:MEMBER_ID]];
                
                GameWebViewController *vc = [[GameWebViewController alloc] init];
                
                vc.loadStr = str;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if ([gameModel.gameType isEqualToString:@"2"]) {
                
                New_GameDetailViewController *vc = [[New_GameDetailViewController alloc] init];
                
                vc.gameID = gameModel.ID;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
        };
        
        cell.game6Block = ^{
            
            GameCenterGameModel *gameModel = frame.arrayModel.gameArray[5];
            
            if ([gameModel.gameType isEqualToString:@"1"]) {
                
                //h5
                NSString *str = [NSString stringWithFormat:@"%@?memberId=%@&app=ios",gameModel.gameLink,[CommonUtil getValueByKey:MEMBER_ID]];
                
                GameWebViewController *vc = [[GameWebViewController alloc] init];
                
                vc.loadStr = str;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if ([gameModel.gameType isEqualToString:@"2"]) {
                
                New_GameDetailViewController *vc = [[New_GameDetailViewController alloc] init];
                
                vc.gameID = gameModel.ID;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
        };
        
        return cell;
        
    }else if (indexPath.section == 3) {
        
        if (self.becomeArray.count == 0) {
            
            HL_NoDataCell *cell = [[HL_NoDataCell alloc] init];
            
            return cell;
            
        }else {
            
            H_BecomeDelegateCell *cell = [[H_BecomeDelegateCell alloc] init];
            
            H_BecomeDelegateFrame *frame = self.becomeArray[indexPath.row];
            
            cell.frameModel = frame;
            
            cell.lookBlock = ^{
                
                H_BecomeDelegateAlert *alert = [[H_BecomeDelegateAlert alloc] initWithContent:frame.model.Remark];
                
                [alert showInView:[UIApplication sharedApplication].keyWindow];
                
            };
            
            cell.buyBlock = ^{
                
                Buy_DelegateViewController *vc = [[Buy_DelegateViewController alloc] init];
                
                if ([frame.model.btnStatus isEqualToString:@"2"]) {
                    
                    vc.price = frame.model.price;
                    
                    vc.categoryId = frame.model.CategoryId;
                    
                    vc.type = @"2";
                    
                }else if ([frame.model.btnStatus isEqualToString:@"3"]) {
                    
                    vc.price = frame.model.price;
                    
                    vc.categoryId = frame.model.CategoryId;
                    
                    vc.type = @"3";
                    
                    vc.difference = frame.model.MatchingPrice;
                    
                }else {
                    
                    vc.price = frame.model.price;
                    
                    vc.categoryId = frame.model.CategoryId;
                    
                    vc.type = @"1";
                    
                }
                
                [self.navigationController pushViewController:vc animated:YES];
                
            };
            
            return cell;
            
        }
        
    }
    
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        //今日通知
        HL_NoticeFrame *frame = self.noticeArray[indexPath.row];
        
        return frame.height;
        
    }else if (indexPath.section == 1) {
        
        //小喇叭
        HL_ScrollHornFrame *frame = self.hornArray[indexPath.row];
        
        return frame.height;
        
    }else if (indexPath.section == 2) {
        
        //热门游戏
        GameCenterGameArrayFrame *frame = self.gameArray[indexPath.row];
        
        return frame.height;
        
    }else if (indexPath.section == 3) {
        
        if (self.becomeArray.count == 0) {
            
            HL_NoDataCell *cell = [[HL_NoDataCell alloc] init];
            
            return cell.height;
            
        }else {
            
            H_BecomeDelegateFrame *frame = self.becomeArray[indexPath.row];
            
            return frame.height;
            
        }
        
    }
    
    return 0;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
