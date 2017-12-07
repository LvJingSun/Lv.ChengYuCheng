//
//  HuLa_HomeViewController.m
//  HuiHui
//
//  Created by mac on 2017/11/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HuLa_HomeViewController.h"
#import "LJConst.h"
#import "HuLaHomeModel.h"
#import "HuLaHomeFrame.h"
#import "HuLaHomeCell.h"
#import "HL_HomeSectionView.h"
#import "HL_HomeMoreGameSectionView.h"
#import "HL_GameDownLoadModel.h"
#import "HL_GameDownLoadFrame.h"
#import "HL_GameDownLoadCell.h"
#import "HL_NoticeModel.h"
#import "HL_NoticeFrame.h"
#import "HL_NoticeCell.h"
#import "HL_ScrollHornModel.h"
#import "HL_ScrollHornFrame.h"
#import "HL_ScrollHornCell.h"
#import "HL_HornTextModel.h"
//#import "HL_HornTextView.h"

#import "H_BecomeDelegateCell.h"
#import "H_BecomeDelegateModel.h"
#import "H_BecomeDelegateFrame.h"

#import "H_TuiJianModel.h"
#import "H_TuiJianFrame.h"
#import "H_TuiJianCell.h"

#import "H_MyTeamModel.h"
#import "H_MyTeamFrame.h"
#import "H_MyTeamCell.h"
#import "H_MyTeamHeadCell.h"
#import "H_MyTeamHeadModel.h"
#import "H_MyTeamHeadFrame.h"

#import "H_MyMoneyModel.h"
#import "H_MyMoneyFrame.h"
#import "H_MyMoneyCell.h"
#import "H_MyMoneyHeadCell.h"

#import "HuLaHomeBindAlertView.h"
#import "H_BecomeDelegateAlert.h"
#import "Buy_DelegateViewController.h"

#import "ToMeViewController.h"
#import "TuiJian_ShareView.h"

#import "HL_MyInfoViewController.h"

#import <TencentOpenAPI/TencentOAuth.h>
#import <QuartzCore/QuartzCore.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <MessageUI/MessageUI.h>

@interface HuLa_HomeViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,QQApiInterfaceDelegate,TencentSessionDelegate,MFMessageComposeViewControllerDelegate> {
    
    TencentOAuth *tencentOAuth;
    
    NSInteger selectIndex;
    
    NSString *_gameID; //检测的gameID
    
    NSString *money_type; //1-今日提成 2-近三月提成
    
}

@property (nonatomic, weak) UITableView *tableivew;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSArray *gameArray;

@property (nonatomic, strong) NSArray *noticeArray;

@property (nonatomic, strong) NSArray *hornArray;

@property (nonatomic, strong) NSArray *becomeArray;

@property (nonatomic, strong) NSArray *tuijianArray;

@property (nonatomic, strong) NSArray *myteamHeadArray;

@property (nonatomic, strong) NSArray *myteamArray;

@property (nonatomic, strong) NSArray *mymoneyArray;

@property (nonatomic, weak) HuLaHomeBindAlertView *alertView;

@end

@implementation HuLa_HomeViewController

-(NSArray *)myteamHeadArray {
    
    if (_myteamHeadArray == nil) {
        
        H_MyTeamHeadModel *model = [[H_MyTeamHeadModel alloc] init];
        
        model.title1 = @"全部推荐(人数)";
        
        model.content1 = @"0人";
        
        model.title2 = @"直接推荐(人数)";
        
        model.content2 = @"0人";
        
        model.title3 = @"间接推荐(人数)";
        
        model.content3 = @"0人";
        
        model.title4 = @"三级推荐(人数)";
        
        model.content4 = @"0人";
        
        H_MyTeamHeadFrame *frame = [[H_MyTeamHeadFrame alloc] init];
        
        frame.headModel = model;
        
        NSMutableArray *mut = [NSMutableArray array];
        
        [mut addObject:frame];
        
        _myteamHeadArray = mut;
        
    }
    
    return _myteamHeadArray;
    
}

-(NSArray *)hornArray {
    
    if (_hornArray == nil) {
        
        HL_HornTextModel *model1 = [[HL_HornTextModel alloc] init];
        
        model1.textStr = @"红烧吕小布充值了300游戏币";
        
        HL_HornTextModel *model2 = [[HL_HornTextModel alloc] init];
        
        model2.textStr = @"绝世大魔王充值了50游戏币";
        
        NSMutableArray *temp = [NSMutableArray array];
        
        [temp addObject:model1];
        
        [temp addObject:model2];
        
        HL_ScrollHornModel *scrModel = [[HL_ScrollHornModel alloc] init];
        
        scrModel.hornTextArray = temp;
        
        HL_ScrollHornFrame *frame = [[HL_ScrollHornFrame alloc] init];
        
        frame.scrollHornModel = scrModel;
        
        NSMutableArray *mut = [NSMutableArray array];
        
        [mut addObject:frame];
        
        _hornArray = mut;
        
    }
    
    return _hornArray;
    
}

-(NSArray *)noticeArray {
    
    if (_noticeArray == nil) {
        
        HL_NoticeModel *model = [[HL_NoticeModel alloc] init];
        
        model.title = @"今日通知";
        
        model.notice1 = @"通知通知通知通知";
        
        model.notice2 = @"内容通知内容通知";
        
        HL_NoticeFrame *frame = [[HL_NoticeFrame alloc] init];
        
        frame.noticeModel = model;
        
        NSMutableArray *mut = [NSMutableArray array];
        
        [mut addObject:frame];
        
        _noticeArray = mut;
        
    }
    
    return _noticeArray;
    
}

-(NSArray *)gameArray {
    
    if (_gameArray == nil) {
        
        HL_GameDownLoadModel *model1 = [[HL_GameDownLoadModel alloc] init];
        
        model1.gameName = @"虎啦棋牌";
        
        model1.downloadCount = @"150";
        
        HL_GameDownLoadFrame *frame1 = [[HL_GameDownLoadFrame alloc] init];
        
        frame1.gameModel = model1;
        
        HL_GameDownLoadModel *model2 = [[HL_GameDownLoadModel alloc] init];
        
        model2.gameName = @"虎啦棋牌";
        
        model2.downloadCount = @"150";
        
        HL_GameDownLoadFrame *frame2 = [[HL_GameDownLoadFrame alloc] init];
        
        frame2.gameModel = model2;
        
        HL_GameDownLoadModel *model3 = [[HL_GameDownLoadModel alloc] init];
        
        model3.gameName = @"虎啦棋牌";
        
        model3.downloadCount = @"150";
        
        HL_GameDownLoadFrame *frame3 = [[HL_GameDownLoadFrame alloc] init];
        
        frame3.gameModel = model3;
        
        HL_GameDownLoadModel *model4 = [[HL_GameDownLoadModel alloc] init];
        
        model4.gameName = @"虎啦棋牌";
        
        model4.downloadCount = @"150";
        
        HL_GameDownLoadFrame *frame4 = [[HL_GameDownLoadFrame alloc] init];
        
        frame4.gameModel = model4;
        
        NSMutableArray *mut = [NSMutableArray array];
        
        [mut addObject:frame1];
        
        [mut addObject:frame2];
        
        [mut addObject:frame3];
        
        [mut addObject:frame4];
        
        _gameArray = mut;
        
    }
    
    return _gameArray;
    
}

//获取我的佣金数据
- (void)requestForMoney {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberid",
                         money_type,@"typeid",
                         nil];
    
    AppHttpClient *httpclient = [AppHttpClient sharedHuLa];
    
    [httpclient HuLarequest:@"GetMyCommission.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSMutableArray *mut = [NSMutableArray array];
            
            NSArray *arr = [json valueForKey:@"lm"];
            
            for (NSDictionary *dd in arr) {
                
                H_MyMoneyModel *model = [[H_MyMoneyModel alloc] init];
                
                model.name = [NSString stringWithFormat:@"%@",dd[@"NickName"]];
                
                model.ID = [NSString stringWithFormat:@"%@",dd[@"GameID"]];
                
                model.count = [NSString stringWithFormat:@"%@",dd[@"Price"]];
                
                model.status = [NSString stringWithFormat:@"%@",dd[@"StyleName"]];
                
                model.source = [NSString stringWithFormat:@"%@",dd[@"RechargeType"]];
                
                H_MyMoneyFrame *frame = [[H_MyMoneyFrame alloc] init];
                
                frame.model = model;
                
                [mut addObject:frame];
                
            }
            
            self.mymoneyArray = mut;
            
            [self.tableivew reloadData];
            
        }else {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//请求我的团队
- (void)myTeamRequest {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberid",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedHuLa];
    
    [http HuLarequest:@"GetMyteam.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSMutableArray *mut = [NSMutableArray array];
            
            NSArray *arr = [json valueForKey:@"lm"];
            
            for (NSDictionary *dd in arr) {
                
                H_MyTeamModel *model = [[H_MyTeamModel alloc] init];
                
                model.name = [NSString stringWithFormat:@"%@",dd[@"Name"]];
                
                model.level = [NSString stringWithFormat:@"%@",dd[@"daili"]];
                
                model.delegateCount = [NSString stringWithFormat:@"%@",dd[@"daili_num"]];
                
                model.memberCount = [NSString stringWithFormat:@"%@",dd[@"huiyuan_num"]];
                
                H_MyTeamFrame *frame = [[H_MyTeamFrame alloc] init];
                
                frame.model = model;
                
                [mut addObject:frame];
                
            }
            
            self.myteamArray = mut;
            
            [self.tableivew reloadData];
            
        }else {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//请求推荐代理数据
- (void)requestForTuiJian {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberid",
                         [CommonUtil getServerKey],@"Key",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedHuLa];
    
    [http HuLarequest:@"GetUrlLink.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];

        if (success) {

            NSDictionary *dd = [json valueForKey:@"inviteCode"];
            
            H_TuiJianModel *model = [[H_TuiJianModel alloc] init];
            
            model.urlImg = [NSString stringWithFormat:@"%@",dd[@"QrCodeUrl"]];
            
            model.MemberInviteCode = [NSString stringWithFormat:@"%@",dd[@"MemberInviteCode"]];
            
            model.mail = [NSString stringWithFormat:@"%@",dd[@"DuanXin"]];
    
            H_TuiJianFrame *frame = [[H_TuiJianFrame alloc] init];
    
            frame.model = model;
    
            NSMutableArray *mut = [NSMutableArray array];
    
            [mut addObject:frame];

            self.tuijianArray = mut;

            [self.tableivew reloadData];

        }else {

            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];

        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//获取首页数据
- (void)requestForData {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberid",
                         nil];
    
    AppHttpClient *httpclient = [AppHttpClient sharedHuLa];
    
    [httpclient HuLarequest:@"GetUserInfo.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSMutableArray *mut = [NSMutableArray array];
            
            HuLaHomeModel *model = [[HuLaHomeModel alloc] init];
            
            model.logo = [NSString stringWithFormat:@"%@",[json valueForKey:@"logo"]];
            
            model.title = [NSString stringWithFormat:@"%@",[json valueForKey:@"GameName"]];
            
            model.name = [NSString stringWithFormat:@"%@",[json valueForKey:@"NickName"]];
            
            model.delegate = [NSString stringWithFormat:@"%@",[json valueForKey:@"AgentGrade"]];
            
            model.RoomCard_Balance = [NSString stringWithFormat:@"%@",[json valueForKey:@"RemainingRoomcard"]];
            
            model.Money_Balance = [NSString stringWithFormat:@"%@",[json valueForKey:@"RemainingAcer"]];
            
            model.isBind = [[json valueForKey:@"isBindGame"] boolValue];
            
            model.isAgent = [[json valueForKey:@"IsAgent"] boolValue];
            
            model.gameID = [NSString stringWithFormat:@"%@",[json valueForKey:@"gameID"]];
            
            model.Content_Img = [NSString stringWithFormat:@"%@",[json valueForKey:@"bananer"]];
            
            model.Recharge_Type = @"1";
            
            HuLaHomeFrame *frame = [[HuLaHomeFrame alloc] init];
            
            frame.hulaModel = model;
            
            [mut addObject:frame];
            
            self.dataArray = mut;
            
            [self.tableivew reloadData];
            
        }else {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//请求成为代理数据
- (void)requestForBecomeData {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberId",
                         nil];
    
    AppHttpClient *httpclient = [AppHttpClient sharedHuLa];
    
    [httpclient HuLarequest:@"GetAgentCategoryInfo_1.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSMutableArray *mut = [NSMutableArray array];
            
            NSArray *arr = [json valueForKey:@"CateGoryInfoList"];
            
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
            
            [self.tableivew reloadData];
            
        }else {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    selectIndex = 1;
    
    money_type = @"1";

    self.title = @"虎啦游戏";
    
    [self allocWithTableview];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self requestForData];
    
    [self requestForMoney];
    
    [self requestForBecomeData];
    
    [self myTeamRequest];
    
    [self requestForTuiJian];
    
}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    self.tableivew = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = FSB_ViewBGCOLOR;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return self.dataArray.count;
        
    }else if (section == 1) {
        
        //更多游戏
        return self.gameArray.count;
        
    }else if (section == 2) {
        
        //今日通知
        return self.noticeArray.count;
        
    }else if (section == 3) {
        
        //小喇叭 滚动
        return self.hornArray.count;
        
    }else if (section == 4) {
        
        //四类分组
        
        if (selectIndex == 1) {
            
            //成为代理
            
            return self.becomeArray.count;
            
        }else if (selectIndex == 2) {
            
            //推荐代理
            
            return self.tuijianArray.count;
            
        }else if (selectIndex == 3) {
            
            //我的团队
            
            return self.myteamArray.count + self.myteamHeadArray.count;
            
        }else if (selectIndex == 4) {
            
            //我的佣金
            
            return self.mymoneyArray.count + 1;
            
        }
        
    }
    
    return 0;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    HuLaHomeFrame *frame = self.dataArray[0];
    
    if (section == 1) {
        
        //更多游戏
        HL_HomeMoreGameSectionView *sectionView = [[HL_HomeMoreGameSectionView alloc] init];
        
        sectionView.frame = CGRectMake(0, 0, _WindowViewWidth, sectionView.height);
        
        sectionView.lookBlock = ^{
            
            //更多游戏点击查看
            
        };
        
        return sectionView;
        
    }else if (section == 4) {
        
        if (frame.hulaModel.isAgent) {
            
            HL_HomeSectionView *sectionview = [[HL_HomeSectionView alloc] init];
            
            sectionview.frame = CGRectMake(0, 0, _WindowViewWidth, sectionview.height);
            
            if (selectIndex == 1) {
                
                [sectionview.becomeDelegateBtn setTitleColor:FSB_StyleCOLOR forState:0];
                
                sectionview.becomeDelegateLine.hidden = NO;
                
                [sectionview.tuijianDelegateBtn setTitleColor:[UIColor darkTextColor] forState:0];
                
                sectionview.tuijianDelegateLine.hidden = YES;
                
                [sectionview.myTeamBtn setTitleColor:[UIColor darkTextColor] forState:0];
                
                sectionview.myTeamLine.hidden = YES;
                
                [sectionview.myMoneyBtn setTitleColor:[UIColor darkTextColor] forState:0];
                
                sectionview.myMoneyBLine.hidden = YES;
                
            }else if (selectIndex == 2) {
                
                [sectionview.becomeDelegateBtn setTitleColor:[UIColor darkTextColor] forState:0];
                
                sectionview.becomeDelegateLine.hidden = YES;
                
                [sectionview.tuijianDelegateBtn setTitleColor:FSB_StyleCOLOR forState:0];
                
                sectionview.tuijianDelegateLine.hidden = NO;
                
                [sectionview.myTeamBtn setTitleColor:[UIColor darkTextColor] forState:0];
                
                sectionview.myTeamLine.hidden = YES;
                
                [sectionview.myMoneyBtn setTitleColor:[UIColor darkTextColor] forState:0];
                
                sectionview.myMoneyBLine.hidden = YES;
                
            }else if (selectIndex == 3) {
                
                [sectionview.becomeDelegateBtn setTitleColor:[UIColor darkTextColor] forState:0];
                
                sectionview.becomeDelegateLine.hidden = YES;
                
                [sectionview.tuijianDelegateBtn setTitleColor:[UIColor darkTextColor] forState:0];
                
                sectionview.tuijianDelegateLine.hidden = YES;
                
                [sectionview.myTeamBtn setTitleColor:FSB_StyleCOLOR forState:0];
                
                sectionview.myTeamLine.hidden = NO;
                
                [sectionview.myMoneyBtn setTitleColor:[UIColor darkTextColor] forState:0];
                
                sectionview.myMoneyBLine.hidden = YES;
                
            }else if (selectIndex == 4) {
                
                [sectionview.becomeDelegateBtn setTitleColor:[UIColor darkTextColor] forState:0];
                
                sectionview.becomeDelegateLine.hidden = YES;
                
                [sectionview.tuijianDelegateBtn setTitleColor:[UIColor darkTextColor] forState:0];
                
                sectionview.tuijianDelegateLine.hidden = YES;
                
                [sectionview.myTeamBtn setTitleColor:[UIColor darkTextColor] forState:0];
                
                sectionview.myTeamLine.hidden = YES;
                
                [sectionview.myMoneyBtn setTitleColor:FSB_StyleCOLOR forState:0];
                
                sectionview.myMoneyBLine.hidden = NO;
                
            }

            __weak typeof(HL_HomeSectionView) *weakHeadView = sectionview;
            
            sectionview.becomeDelegateBlock = ^{
                
                if (selectIndex != 1) {
                    
                    [weakHeadView.becomeDelegateBtn setTitleColor:FSB_StyleCOLOR forState:0];
                    
                    weakHeadView.becomeDelegateLine.hidden = NO;
                    
                    [weakHeadView.tuijianDelegateBtn setTitleColor:[UIColor darkTextColor] forState:0];
                    
                    weakHeadView.tuijianDelegateLine.hidden = YES;
                    
                    [weakHeadView.myTeamBtn setTitleColor:[UIColor darkTextColor] forState:0];
                    
                    weakHeadView.myTeamLine.hidden = YES;
                    
                    [weakHeadView.myMoneyBtn setTitleColor:[UIColor darkTextColor] forState:0];
                    
                    weakHeadView.myMoneyBLine.hidden = YES;
                    
                    selectIndex = 1;
                    
                    [self.tableivew reloadData];
                    
                }
                
            };
            
            sectionview.tuijianDelegateBlock = ^{
                
                if (selectIndex != 2) {
                    
                    [weakHeadView.becomeDelegateBtn setTitleColor:[UIColor darkTextColor] forState:0];
                    
                    weakHeadView.becomeDelegateLine.hidden = YES;
                    
                    [weakHeadView.tuijianDelegateBtn setTitleColor:FSB_StyleCOLOR forState:0];
                    
                    weakHeadView.tuijianDelegateLine.hidden = NO;
                    
                    [weakHeadView.myTeamBtn setTitleColor:[UIColor darkTextColor] forState:0];
                    
                    weakHeadView.myTeamLine.hidden = YES;
                    
                    [weakHeadView.myMoneyBtn setTitleColor:[UIColor darkTextColor] forState:0];
                    
                    weakHeadView.myMoneyBLine.hidden = YES;
                    
                    selectIndex = 2;

                    [self.tableivew reloadData];
                    
                }
                
            };
            
            sectionview.myTeamBlock = ^{
                
                if (selectIndex != 3) {
                    
                    [weakHeadView.becomeDelegateBtn setTitleColor:[UIColor darkTextColor] forState:0];
                    
                    weakHeadView.becomeDelegateLine.hidden = YES;
                    
                    [weakHeadView.tuijianDelegateBtn setTitleColor:[UIColor darkTextColor] forState:0];
                    
                    weakHeadView.tuijianDelegateLine.hidden = YES;
                    
                    [weakHeadView.myTeamBtn setTitleColor:FSB_StyleCOLOR forState:0];
                    
                    weakHeadView.myTeamLine.hidden = NO;
                    
                    [weakHeadView.myMoneyBtn setTitleColor:[UIColor darkTextColor] forState:0];
                    
                    weakHeadView.myMoneyBLine.hidden = YES;
                    
                    selectIndex = 3;
 
                    [self.tableivew reloadData];
                    
                }
                
            };
            
            sectionview.myMoneyBlock = ^{
                
                if (selectIndex != 4) {
                    
                    [weakHeadView.becomeDelegateBtn setTitleColor:[UIColor darkTextColor] forState:0];
                    
                    weakHeadView.becomeDelegateLine.hidden = YES;
                    
                    [weakHeadView.tuijianDelegateBtn setTitleColor:[UIColor darkTextColor] forState:0];
                    
                    weakHeadView.tuijianDelegateLine.hidden = YES;
                    
                    [weakHeadView.myTeamBtn setTitleColor:[UIColor darkTextColor] forState:0];
                    
                    weakHeadView.myTeamLine.hidden = YES;
                    
                    [weakHeadView.myMoneyBtn setTitleColor:FSB_StyleCOLOR forState:0];
                    
                    weakHeadView.myMoneyBLine.hidden = NO;
                    
                    selectIndex = 4;
 
                    [self.tableivew reloadData];
                    
                }
                
            };
            
            return sectionview;
            
        }else {
            
            return nil;
            
        }
        
    }
    
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    HuLaHomeFrame *frame = self.dataArray[0];
    
    if (section == 1) {
        
        HL_HomeMoreGameSectionView *sectionview = [[HL_HomeMoreGameSectionView alloc] init];
        
        return sectionview.height;
        
    }else if (section == 4) {
        
        if (frame.hulaModel.isAgent) {
            
            HL_HomeSectionView *sectionview = [[HL_HomeSectionView alloc] init];
            
            return sectionview.height;
            
        }else {
            
            return 0;
            
        }
        
    }
    
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        HuLaHomeCell *cell = [[HuLaHomeCell alloc] init];
        
        HuLaHomeFrame *frame = self.dataArray[indexPath.row];
        
        cell.frameModel = frame;
        
        cell.delegate_Block = ^{
            
            //代理等级点击
            HL_MyInfoViewController *vc = [[HL_MyInfoViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        };
        
        cell.bindBlock = ^{
            
            HuLaHomeBindAlertView *alert = [[HuLaHomeBindAlertView alloc] init];
            
            self.alertView = alert;
            
            alert.IDfield.delegate = self;
            
            alert.bindClickBlock = ^{
                
                [self BindGameID];
                
            };
            
            [alert showInView:[UIApplication sharedApplication].keyWindow];
            
        };
        
        cell.ToOther_Block = ^{
            
            //给他人充值点击
            
            ToMeViewController *vc = [[ToMeViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        };
        
        cell.ToMe_Block = ^{
            
            //充值点击
            
            if (frame.hulaModel.isBind) {
                
                ToMeViewController *vc = [[ToMeViewController alloc] init];
                
                vc.gameID = frame.hulaModel.gameID;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }else {
                
                [SVProgressHUD showErrorWithStatus:@"请先绑定棋牌游戏ID"];
                
            }
            
        };
        
        cell.Send_Block = ^{
            
            //赠送点击
            
        };
        
        return cell;
        
    }else if (indexPath.section == 1) {
        
        //更多游戏
        HL_GameDownLoadCell *cell = [[HL_GameDownLoadCell alloc] init];
        
        HL_GameDownLoadFrame *frame = self.gameArray[indexPath.row];
        
        cell.frameModel = frame;
        
        return cell;
        
    }else if (indexPath.section == 2) {
        
        //今日通知
        HL_NoticeCell *cell = [[HL_NoticeCell alloc] init];
        
        HL_NoticeFrame *frame = self.noticeArray[indexPath.row];
        
        cell.frameModel = frame;
        
        return cell;
        
    }else if (indexPath.section == 3) {
        
        //小喇叭
        HL_ScrollHornCell *cell = [[HL_ScrollHornCell alloc] init];
        
        HL_ScrollHornFrame *frame = self.hornArray[indexPath.row];
        
        cell.frameModel = frame;
        
        return cell;
        
    }else if (indexPath.section == 4) {
        
        if (selectIndex == 1) {
            
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
            
        }else if (selectIndex == 2) {
            
            H_TuiJianCell *cell = [[H_TuiJianCell alloc] init];
            
            H_TuiJianFrame *frame = self.tuijianArray[indexPath.row];
            
            cell.frameModel = frame;
            
            cell.shareBlock = ^{
                
                //分享邀请码
                TuiJian_ShareView *share = [[TuiJian_ShareView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight)];
                
                share.QQ_Block = ^{
                    
                    [self qqShare];
                    
                };
                
                share.QZone_Block = ^{
                    
                    [self qqzoneShare];
                    
                };
                
                share.WX_Block = ^{
                    
                    // 微信分享
                    [self checkIsVaildweixinType:1002];
                    
                };
                
                share.WXFriends_Block = ^{
                    
                    // 朋友圈分享
                    [self checkIsVaildweixinType:1003];
                    
                };
                
                [share showInView:[UIApplication sharedApplication].keyWindow];
                
            };
            
            cell.copyBlock = ^{
                
                //复制二维码
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                
                pasteboard.string = [NSString stringWithFormat:@"%@",frame.model.MemberInviteCode];
                
                [SVProgressHUD showSuccessWithStatus:@"内容已经复制到粘贴板"];
                
            };
            
            cell.mailBlock = ^{
                
                //发短信
                MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
                
                picker.messageComposeDelegate = self;
                
                picker.body = [NSString stringWithFormat:@"%@",frame.model.mail];
                
                picker.recipients = [NSArray arrayWithObject:@" "];
                
                [self presentViewController:picker animated:YES completion:nil];
                
            };
            
            return cell;
            
        }else if (selectIndex == 3) {
            
            if (indexPath.row == 0) {
                
                H_MyTeamHeadCell *cell = [[H_MyTeamHeadCell alloc] init];
                
                H_MyTeamHeadFrame *frame = self.myteamHeadArray[indexPath.row];
                
                cell.frameModel = frame;
                
                return cell;
                
            }else {
                
                H_MyTeamCell *cell = [[H_MyTeamCell alloc] init];
                
                H_MyTeamFrame *frame = self.myteamArray[indexPath.row - 1];
                
                cell.frameModel = frame;
                
                return cell;
                
            }
            
        }else if (selectIndex == 4) {
            
            if (indexPath.row == 0) {
                
                H_MyMoneyHeadCell *cell = [[H_MyMoneyHeadCell alloc] init];
                
                cell.selectIndex = money_type;
                
                cell.changeBlock = ^(NSInteger i) {
                    
                    switch (i) {
                        case 0:
                        {
                            
                            money_type = @"1";
                            
                            [self requestForMoney];
                            
                        }
                            break;
                            
                        case 1:
                        {
                            
                            money_type = @"2";
                            
                            [self requestForMoney];
                            
                        }
                            break;
                            
                        default:
                            break;
                    }
                    
                };
                
                return cell;
                
            }else {
                
                H_MyMoneyCell *cell = [[H_MyMoneyCell alloc] init];
                
                H_MyMoneyFrame *frame = self.mymoneyArray[indexPath.row - 1];
                
                cell.frameModel = frame;
                
                return cell;
                
            }
            
        }
        
    }
    
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        HuLaHomeFrame *frame = self.dataArray[indexPath.row];
        
        return frame.height;
        
    }else if (indexPath.section == 1) {
        
        //更多游戏
        HL_GameDownLoadFrame *frame = self.gameArray[indexPath.row];
        
        return frame.height;
        
    }else if (indexPath.section == 2) {
        
        //今日通知
        HL_NoticeFrame *frame = self.noticeArray[indexPath.row];
        
        return frame.height;
        
    }else if (indexPath.section == 3) {
        
        //小喇叭
        HL_ScrollHornFrame *frame = self.hornArray[indexPath.row];
        
        return frame.height;
        
    }else if (indexPath.section == 4) {
        
        if (selectIndex == 1) {
            
            H_BecomeDelegateFrame *frame = self.becomeArray[indexPath.row];
            
            return frame.height;
            
        }else if (selectIndex == 2) {
            
            H_TuiJianFrame *frame = self.tuijianArray[indexPath.row];
            
            return frame.height;
            
        }else if (selectIndex == 3) {
            
            if (indexPath.row == 0) {
                
                H_MyTeamHeadFrame *frame = self.myteamHeadArray[indexPath.row];
                
                return frame.height;
                
            }else {
                
                H_MyTeamFrame *frame = self.myteamArray[indexPath.row - 1];
                
                return frame.height;
                
            }
            
        }else if (selectIndex == 4) {
            
            if (indexPath.row == 0) {
                
                H_MyMoneyHeadCell *cell = [[H_MyMoneyHeadCell alloc] init];
                
                return cell.height;
                
            }else {
                
                H_MyMoneyFrame *frame = self.mymoneyArray[indexPath.row - 1];
                
                return frame.height;
                
            }
            
        }
        
    }
    
    return 0;
    
}

//短信发送完成代理
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

// 检查是否安装了微信的客户端
-(void)checkIsVaildweixinType:(NSInteger)aType
{
    if( [WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi] ){ //判断是否安装且支持微信
        if ( aType == 1002 ) {
            
            // 好友
            [self shareTogoodFriend];
            
        }else if ( aType == 1003 ) {
            
            // 朋友圈
            [self shareTogoodFriendShipsWithMessage];
            
        }
        
    }else{
        
        //未安装
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"您尚未安装微信,确认进行安装吗？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定",nil];
        alert.tag = 100100;
        [alert show];
        
        
    }
    
}

//发送给好友
-(void)shareTogoodFriend {
    
    WXMediaMessage *message = [WXMediaMessage message];//发送消息的多媒体内容
    
    message.title = @"虎啦棋牌邀请";
    message.description = @"虎啦棋牌代理诚邀您加入他的团队，点击链接即可加入";
    
    H_TuiJianFrame *frame = self.tuijianArray[0];
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",frame.model.urlImg];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             ext.webpageUrl = [NSString stringWithFormat:@"%@",frame.model.MemberInviteCode];
                             message.mediaObject = ext;
                             SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                             req.bText = NO;//发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
                             req.message = message;
                             req.scene = WXSceneSession;//选择发送好友
                             [WXApi sendReq:req];
                             
                         }
                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                             
                         }];
    
}

// 朋友圈
-(void)shareTogoodFriendShipsWithMessage {
    
    WXMediaMessage *message = [WXMediaMessage message];//发送消息的多媒体内容
    message.title = @"虎啦棋牌邀请";
    message.description = @"虎啦棋牌代理诚邀您加入他的团队，点击链接即可加入";
    
    H_TuiJianFrame *frame = self.tuijianArray[0];
    
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",frame.model.urlImg];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             
                             ext.webpageUrl = [NSString stringWithFormat:@"%@",frame.model.MemberInviteCode];
                             message.mediaObject = ext;
                             
                             SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                             req.bText = NO;//发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
                             req.message = message;
                             req.scene = WXSceneTimeline;//发送到朋友圈
                             
                             [WXApi sendReq:req];
                         }
                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                             
                         }];
    
}

// 检查是否安装了QQ的客户端
-(BOOL)checkIsVaildQQType {
    
    if ([QQApi isQQInstalled] &&[QQApi isQQSupportApi]) {
        return YES;
    }else
    {
        //未安装
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"您尚未安装QQ或是当前版本太低"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult {
    
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        default:
        {
            break;
        }
    }
}

//qq分享
- (void)qqShare {
    
    //检测是否安装QQ
    if (![self checkIsVaildQQType]) {
        return;
    }
    
    H_TuiJianFrame *frame = self.tuijianArray[0];
    
    // qq好友
    tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
    NSString *title = @"虎啦棋牌邀请";
    NSString *description = @"虎啦棋牌代理诚邀您加入他的团队，点击链接即可加入";
    
    NSString *utf8String = frame.model.MemberInviteCode;
    
    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:frame.model.urlImg]];
    
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    //将内容分享到qq
    QQApiSendResultCode sent = 0;
    sent = [QQApiInterface sendReq:req];
    // 判断QQ的情况
    [self handleSendResult:sent];
    
}

//qq空间分享
- (void)qqzoneShare {
    
    //检测是否安装QQ
    if (![self checkIsVaildQQType]) {
        return;
    }
    // QQ空间分享
    tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
    
    NSString *title = @"虎啦棋牌邀请";
    NSString *description = @"虎啦棋牌代理诚邀您加入他的团队，点击链接即可加入";
    
    H_TuiJianFrame *frame = self.tuijianArray[0];
    
    NSString *utf8String = frame.model.MemberInviteCode;
    
    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:frame.model.urlImg]];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    //将内容分享到qq
    QQApiSendResultCode sent = 0;
    
    //将内容分享到qzone
    sent = [QQApiInterface SendReqToQZone:req];
    
    // 判断QQ的情况
    [self handleSendResult:sent];
    
}

//游戏ID输入9位自动检测
#define myDotNumbers     @"0123456789"
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //输入字符限制
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers]invertedSet];
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if (filtered.length == 0 ) {
        //支持删除键
        if (textField.text.length ==7) {
            
        }
        
        return [string isEqualToString:@""];
        
    }else if (textField.text.length ==6){
        
        textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
        
        [self checkForGameID:[NSString stringWithFormat:@"%@",textField.text]];
        
    }else if (string.length ==7)
    {
        textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
        
        [self checkForGameID:[NSString stringWithFormat:@"%@",textField.text]];
        
    }
    
    return YES;
    
}

//绑定游戏账号
- (void)BindGameID {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"Memberid",
                         _gameID,@"GameId",
                         nil];
    
    AppHttpClient *httpclient = [AppHttpClient sharedHuLa];
    
    [SVProgressHUD show];
    
    [httpclient HuLarequest:@"Bind_Account.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
            [self.alertView dismiss];
            
            [self requestForData];
            
        }else {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//检测游戏账号
- (void)checkForGameID:(NSString *)gameID {
    
    _gameID = gameID;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         gameID,@"gameid",
                         nil];
    
    AppHttpClient *httpclient = [AppHttpClient sharedHuLa];
    
    [SVProgressHUD show];
    
    if ([self.alertView.IDfield isFirstResponder]) {
        
        [self.alertView.IDfield resignFirstResponder];
        
    }
    
    [httpclient HuLarequest:@"Bind_TestingNickName.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        [SVProgressHUD dismiss];
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
        
            self.alertView.noticeLab.textColor = FSB_StyleCOLOR;
            
            self.alertView.noticeLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"NickName"]];
            
        }else {
            
            self.alertView.noticeLab.textColor = [UIColor redColor];
            
            self.alertView.noticeLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        
        self.alertView.noticeLab.textColor = [UIColor redColor];
        
        self.alertView.noticeLab.text = @"查询失败，请稍后再试！";
        
    }];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
