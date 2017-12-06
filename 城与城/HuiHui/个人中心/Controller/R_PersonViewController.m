//
//  R_PersonViewController.m
//  HuiHui
//
//  Created by mac on 2017/11/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "R_PersonViewController.h"
#import "Configuration.h"
#import "LJConst.h"
#import "R_PersonHeadView.h"
#import "R_PersonModel.h"
#import "R_PersonFrame.h"
#import "R_PersonCell.h"

#import "Wallet_FSBViewController.h"
#import "GG_HomeViewController.h"
#import "GameGoldNavViewController.h"
#import "LJHuahuaViewController.h"
#import "IntegrationViewController.h"
#import "HuLa_HomeViewController.h"
#import "ShopCartViewController.h"
#import "MyFavoriteViewController.h"
#import "ShareViewController.h"
#import "MyCardViewController.h"
#import "InviteViewController.h"
#import "FSB_GameViewController.h"
#import "FSB_GameNAVController.h"
#import "orderChooseViewController.h"
#import "SettingViewController.h"
#import "New_MyWalletViewController.h"
#import "PersonalViewController.h"

@interface R_PersonViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *oneArr;

@property (nonatomic, strong) NSArray *twoArr;

@property (nonatomic, strong) NSArray *threeArr;

@property (nonatomic, weak) R_PersonHeadView *headview;

@end

@implementation R_PersonViewController

-(NSArray *)oneArr {
    
    if (_oneArr == nil) {
        
        R_PersonModel *model1 = [[R_PersonModel alloc] init];
        
        model1.title = @"我的会员卡";
        
        model1.iconUrl = @"P_我的会员卡.png";
        
        R_PersonFrame *frame1 = [[R_PersonFrame alloc] init];
        
        frame1.personModel = model1;
        
        R_PersonModel *model3 = [[R_PersonModel alloc] init];
        
        model3.title = @"虎啦棋牌";
        
        model3.iconUrl = @"P_虎啦";
        
        R_PersonFrame *frame3 = [[R_PersonFrame alloc] init];
        
        frame3.personModel = model3;
        
        R_PersonModel *model4 = [[R_PersonModel alloc] init];
        
        model4.title = @"联城小游戏";
        
        model4.iconUrl = @"P_联城游戏";
        
        R_PersonFrame *frame4 = [[R_PersonFrame alloc] init];
        
        frame4.personModel = model4;
        
        NSMutableArray *mut = [NSMutableArray array];
        
        [mut addObject:frame1];
        
        [mut addObject:frame3];
        
        [mut addObject:frame4];
        
        self.oneArr = mut;
        
        _oneArr = mut;
        
    }
    
    return _oneArr;
    
}

-(NSArray *)threeArr {
    
    if (_threeArr == nil) {
        
        R_PersonModel *model1 = [[R_PersonModel alloc] init];
        
        model1.title = @"商户中心";
        
        model1.iconUrl = @"P_商户中心.png";
        
        R_PersonFrame *frame1 = [[R_PersonFrame alloc] init];
        
        frame1.personModel = model1;
        
        R_PersonModel *model2 = [[R_PersonModel alloc] init];
        
        model2.title = @"设置";
        
        model2.iconUrl = @"P_设置";
        
        R_PersonFrame *frame2 = [[R_PersonFrame alloc] init];
        
        frame2.personModel = model2;
        
        NSMutableArray *mut = [NSMutableArray array];
        
        if ([[CommonUtil getValueByKey:IsDaiLiAndMct] isEqualToString:@"1"]) {
            
            [mut addObject:frame1];
            
            [mut addObject:frame2];
            
        }else {
            
            [mut addObject:frame2];
            
        }
        
        _threeArr = mut;
        
    }
    
    return _threeArr;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self allocWithTableview];
    
}

- (void)allocWithTableview {
    
    R_PersonHeadView *headview = [[R_PersonHeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, _WindowViewWidth, headview.height);
    
    self.headview = headview;
    
    headview.nameLab.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:NICK]];
    
    headview.phoneLab.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:ACCOUNT]];
    
    [headview.iconImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_PHOTO]]]];
    
    headview.iconBlock = ^{
        
        // 进入个人信息
        PersonalViewController *VC = [[PersonalViewController alloc]initWithNibName:@"PersonalViewController" bundle:nil];
        
        [self.navigationController pushViewController:VC animated:YES];
        
    };
    
    headview.balanceBlock = ^{
        
        New_MyWalletViewController *vc = [[New_MyWalletViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    headview.fsbBlock = ^{
        
        //粉丝宝
        Wallet_FSBViewController *vc = [[Wallet_FSBViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    headview.hhBlock = ^{
        
        //花花
        LJHuahuaViewController *vc = [[LJHuahuaViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    headview.jljBlock = ^{
        
        //奖励金
        GG_HomeViewController *vc = [[GG_HomeViewController alloc] init];
        
        GameGoldNavViewController *gamenav = [[GameGoldNavViewController alloc] initWithRootViewController:vc];
        
        [self presentViewController:gamenav animated:YES completion:nil];
        
    };
    
    headview.jfBlock = ^{
        
        //积分
        IntegrationViewController *VC = [[IntegrationViewController alloc]initWithNibName:@"IntegrationViewController" bundle:nil];
        
        [self.navigationController pushViewController:VC animated:YES];
        
    };
    
    headview.contentImg.image = [UIImage imageNamed:@"Person_BG.png"];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, _WindowViewWidth, _WindowViewHeight - 29)];
    
    self.tableview = tableview;
    
    tableview.tableHeaderView = headview;
    
    UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, 20)];
    
    footview.backgroundColor = FSB_ViewBGCOLOR;
    
    tableview.tableFooterView = footview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = FSB_ViewBGCOLOR;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, 20)];
    
    view.backgroundColor = FSB_ViewBGCOLOR;
    
    return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return self.oneArr.count;
        
    }else if (section == 1) {
        
        return self.twoArr.count;
        
    }else if (section == 2) {
        
        return self.threeArr.count;
        
    }else {
        
        return 0;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    R_PersonCell *cell = [[R_PersonCell alloc] init];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        
        R_PersonFrame *frame = self.oneArr[indexPath.row];
        
        cell.frameModel = frame;
        
    }else if (indexPath.section == 1) {
        
        R_PersonFrame *frame = self.twoArr[indexPath.row];
        
        cell.frameModel = frame;
        
    }else if (indexPath.section == 2) {
        
        R_PersonFrame *frame = self.threeArr[indexPath.row];
        
        cell.frameModel = frame;
        
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        R_PersonFrame *frame = self.oneArr[indexPath.row];
        
        return frame.height;
        
    }else if (indexPath.section == 1) {
        
        R_PersonFrame *frame = self.twoArr[indexPath.row];
        
        return frame.height;
        
    }else if (indexPath.section == 2) {
        
        R_PersonFrame *frame = self.threeArr[indexPath.row];
        
        return frame.height;
        
    }else {
        
        return 0;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            //会员卡
            MyCardViewController * VC = [[MyCardViewController alloc]initWithNibName:@"MyCardViewController" bundle:nil];
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.row == 1) {
            
            //虎啦棋牌
            HuLa_HomeViewController *vc = [[HuLa_HomeViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 2) {
            
            //小游戏
            FSB_GameViewController *vc = [[FSB_GameViewController alloc] init];
            
            FSB_GameNAVController *gameNav = [[FSB_GameNAVController alloc] initWithRootViewController:vc];
            
            [self presentViewController:gameNav animated:YES completion:nil];
            
        }
        
    }else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            //我的订单
            orderChooseViewController *VC = [[orderChooseViewController alloc]initWithNibName:@"orderChooseViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.row == 1) {
            
            //我的收藏
            MyFavoriteViewController *VC = [[MyFavoriteViewController alloc]initWithNibName:@"MyFavoriteViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.row == 2) {
            
            //邀请
            InviteViewController *VC = [[InviteViewController alloc]initWithNibName:@"InviteViewController" bundle:nil];

            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.row == 3) {
            
            //我的购物车
            ShopCartViewController *VC = [[ShopCartViewController alloc]initWithNibName:@"ShopCartViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
        }
        
    }else if (indexPath.section == 2) {
        
        if ([[CommonUtil getValueByKey:IsDaiLiAndMct] isEqualToString:@"1"]) {
            
            if (indexPath.row == 0) {
                
                //商户中心
                ShareViewController *VC = [[ShareViewController alloc]initWithNibName:@"ShareViewController" bundle:nil];
                [self.navigationController pushViewController:VC animated:YES];
                
            }else if (indexPath.row == 1) {
                
                //设置
                SettingViewController *VC = [[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil];
                [self.navigationController pushViewController:VC animated:YES];
                
            }
            
        }else {
            
            if (indexPath.row == 0) {
                
                //设置
                SettingViewController *VC = [[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil];
                [self.navigationController pushViewController:VC animated:YES];
                
            }
            
        }
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    if ( isIOS7 ) {
        
        // 移除导航栏上面的view
        for (UILabel *label in self.tabBarController.navigationController.view.subviews) {
            
            if ( label.tag == 10392 ) {
                
                [label removeFromSuperview];
                
            }
        }
        
    }
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self loadData];
    
}

- (void)loadData {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           nil];
    
    [httpClient request:@"More_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            NSDictionary *dd = [json valueForKey:@"appMore"];
            [CommonUtil addValue:dd[@"realAuName"] andKey:REAL_ACCOUNT_NAME];
            [CommonUtil addValue:dd[@"realAuIdCard"] andKey:REAL_ACCOUNT_IDCARD];
            [CommonUtil addValue:dd[@"realAuStatus"] andKey:USER_REALAUSTATUS];
            
            //充值
            NSString *vldStatus = dd[@"realAuStatus"];
            
            // 保存用户的状态
            [CommonUtil addValue:vldStatus andKey:REALAUSTATUS];
            
            self.headview.fsbCount.text = [NSString stringWithFormat:@"%@",dd[@"Fensibao"]];
            
            self.headview.hhCount.text = [NSString stringWithFormat:@"%@",dd[@"MeBalance"]];
            
            self.headview.jljCount.text = [NSString stringWithFormat:@"%@",dd[@"Jianglijin"]];
            
            self.headview.jfCount.text = [NSString stringWithFormat:@"%@",dd[@"Jifen"]];
            
            self.headview.balanceLab.text = [NSString stringWithFormat:@"余额:%@",dd[@"myBalance"]];
            
            R_PersonModel *model1 = [[R_PersonModel alloc] init];
    
            model1.title = @"我的订单";
    
            model1.iconUrl = @"P_我的订单.png";
    
            R_PersonFrame *frame1 = [[R_PersonFrame alloc] init];
    
            frame1.personModel = model1;
    
            R_PersonModel *model2 = [[R_PersonModel alloc] init];
    
            model2.title = @"我的收藏";
    
            model2.iconUrl = @"P_我的收藏.png";
    
            R_PersonFrame *frame2 = [[R_PersonFrame alloc] init];
    
            frame2.personModel = model2;
    
            R_PersonModel *model3 = [[R_PersonModel alloc] init];
    
            model3.title = @"我的购物车";
    
            model3.iconUrl = @"P_购物车.png";
    
            R_PersonFrame *frame3 = [[R_PersonFrame alloc] init];
    
            frame3.personModel = model3;
            
            R_PersonModel *model4 = [[R_PersonModel alloc] init];

            model4.title = @"我的邀请";

            model4.iconUrl = @"P_我的邀请.png";

            model4.content = [NSString stringWithFormat:@"已邀请%@人",dd[@"Yaoqing"]];

            R_PersonFrame *frame4 = [[R_PersonFrame alloc] init];

            frame4.personModel = model4;
    
            NSMutableArray *mut = [NSMutableArray array];
    
            [mut addObject:frame1];
    
            [mut addObject:frame2];
            
            [mut addObject:frame4];
    
            [mut addObject:frame3];
            
            self.twoArr = mut;
            
            [self.tableview reloadData];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    if ( isIOS7 ) {
        
        UILabel *l_label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
        l_label.backgroundColor = RGBACKTAB;
        l_label.tag = 10392;
        [self.tabBarController.navigationController.view addSubview:l_label];
        
    }
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.navigationController.navigationBar.barTintColor = FSB_StyleCOLOR;
    
    self.navigationController.navigationBar.translucent = NO;
    
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
