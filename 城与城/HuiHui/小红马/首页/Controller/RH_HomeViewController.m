//
//  RH_HomeViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_HomeViewController.h"
#import "RedHorseHeader.h"
#import "RH_HomeHeadView.h"
#import "RH_HomeBtnView.h"
#import "RH_HomePersonHeadView.h"

#import "RH_FilpCell.h"
#import "RH_FilpADModel.h"
#import "RH_FilpCellModel.h"
#import "RH_FilpCellFrame.h"

#import "OilSubsidyViewController.h"
#import "TyreSubsidyViewController.h"
#import "RepairMaintainViewController.h"
#import "InsuranceViewController.h"
#import "RH_LifeViewController.h"

#import "RH_AdministrationViewController.h"

#import "FSB_HomeImgScroll.h"
#import "RH_BottomShopCell.h"

#import "RH_RedRecordsViewController.h"

#import "F_H_ScrollImgModel.h"
#import "XieYiViewController.h"
#import "TiXingView.h"
#import "RH_TitleView.h"
#import "GameWebViewController.h"
#import "GameGifAlertView.h"
#import "RH_BoModel.h"
#import "RH_BoFrame.h"

#import "RH_GetMoneyAnimation.h"

@interface RH_HomeViewController () <UITableViewDelegate,UITableViewDataSource,HomeScrollViewDelegate,GifViewDelegate> {

    UIImage *dropImg;
    
    int CountDown;
    
    NSString *gameUrl;
    
}

@property (nonatomic, strong) GameGifAlertView *gameAlertView;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *filpArray;

@property (nonatomic, weak) RH_HomePersonHeadView *yesMemberHeadView;

@property (nonatomic, strong) NSArray *scrollArr;

@property (nonatomic, strong) UIView *gameBGView;

@property (nonatomic, strong) NSArray *bottomArr;

@end

@implementation RH_HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self allocWithFSB_NavTitleView];
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"RH_HomeBack.png" andaction:@selector(dismissRH_Homeview)];
    
    self.navigationItem.rightBarButtonItem = [self SetNavigationBarRightTitle:@"记录" andaction:@selector(CityDingWei)];
    
    [self initWithTableview];
    
    [self checkAccount];
    
    // app从后台进入前台都会调用这个方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [self requestForZuiJinClick];
    
}

- (void)requestForZuiJinClick {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                         @"4",@"Type",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [http request:@"ClickIconRecord.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

//如果游戏悬浮框未消失，执行动画
- (void)applicationBecomeActive {
    
    if (self.gameAlertView) {
        
        [self.gameAlertView startGif];
        
    }
    
}

//初始化titleview
- (void)allocWithFSB_NavTitleView {
    
    RH_TitleView *titleview = [[RH_TitleView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth * 0.6, 30)];
    
    titleview.titleBlock = ^{
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *fensibaoExtension = [defaults objectForKey:@"car_extension"];
        
        fensibaoExtension = [fensibaoExtension stringByReplacingOccurrencesOfString:@"/n" withString:@"\n"];
        
        XieYiViewController *vc = [[XieYiViewController alloc] init];
        
        vc.xieyiString = fensibaoExtension;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    self.navigationItem.titleView = titleview;
    
}

//请求轮播广告图片
- (void)requestForScrollData {
    
    AppHttpClient *httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"2",@"Type",
                           [CommonUtil getValueByKey:CITYID],@"CityID",
                           [CommonUtil getValueByKey:MEMBER_ID],@"Memberid",
                           nil];
    
    [httpClient request:@"ShufflingAdvertiseList.ashx" parameters:param success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = [json valueForKey:@"listShuffAdver"];
            
            CountDown = [[json valueForKey:@"ShuffTime"] intValue];
            
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dd in arr) {
                
                F_H_ScrollImgModel *model = [[F_H_ScrollImgModel alloc] init];
                
                model.ID = [NSString stringWithFormat:@"%@",dd[@"ID"]];
                
                model.Title = [NSString stringWithFormat:@"%@",dd[@"Title"]];
                
                model.PhotoUrl = [NSString stringWithFormat:@"%@",dd[@"PhotoUrl"]];
                
                model.LinkUrl = [NSString stringWithFormat:@"%@",dd[@"LinkUrl"]];
                
                model.ShufflingTime = [NSString stringWithFormat:@"%@",dd[@"ShufflingTime"]];
                
                [tempArray addObject:model];
                
            }
            
            self.scrollArr = tempArray;
            
            if (arr.count != 0) {
                
                [self allocWithImgScroll];
                
            }
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//显示图片轮播广告
- (void)allocWithImgScroll {
    
    FSB_HomeImgScroll *scroll = [[FSB_HomeImgScroll alloc] init];
    
    scroll.delegate = self;
    
    scroll.sourceArray = self.scrollArr;
    
    scroll.countDown = CountDown;
    
    [scroll showInView:[UIApplication sharedApplication].keyWindow];
    
    scroll.dismissBlock = ^{
        
        [self getRedMoney];
        
    };

}

//首页轮播代理
- (void)HomeScrollDidSelected:(NSInteger)index {
    
    NSLog(@"点击了第%ld张图",(long)index);
    
}

//记录点击
- (void)CityDingWei {

    RH_RedRecordsViewController *vc = [[RH_RedRecordsViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated {

    [self requestForHomeData];
    
}

- (void)checkAccount {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *isTongYi = [defaults objectForKey:@"CAR_YanZheng"];
    
    NSString *fensibaoExtension = [defaults objectForKey:@"car_extension"];
    
    if ([isTongYi isEqualToString:@"0"]) {
        
        TiXingView *tixingview = [[TiXingView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        tixingview.iconImg.image = [UIImage imageNamed:@"app图标修改（90）.png"];
        
        [tixingview.sureBtn addTarget:self action:@selector(tongyiRequest) forControlEvents:UIControlEventTouchUpInside];
        
        [tixingview.backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        fensibaoExtension = [fensibaoExtension stringByReplacingOccurrencesOfString:@"/n" withString:@"\n"];
        
        tixingview.textview.text = [NSString stringWithFormat:@"%@",fensibaoExtension];
        
        [[[UIApplication sharedApplication].windows firstObject] addSubview:tixingview];
        
    }else {
        
        [self requestForScrollData];
        
    }
    
}

//签订养车宝协议
- (void)tongyiRequest {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedExtension];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"Memberid",
                           @"5",@"type",
                           @"1",@"IsAgree",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient ExtensionRequest:@"FistAgreement.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:@"欢迎加入养车宝"];
            
            [self requestForScrollData];
            
            [self yyanZheng];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//确认同意后再次验证
- (void)yyanZheng {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedExtension];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"Memberid",
                           @"5",@"type",
                           @"0",@"IsAgree",
                           nil];
    
    [httpClient ExtensionRequest:@"FistAgreement.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:@"1" forKey:@"CAR_YanZheng"];
            
        } else {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:@"0" forKey:@"CAR_YanZheng"];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)backBtnClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//显示游戏悬浮框
- (void)ShowGameIcon {
    
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    self.gameBGView = bgview;
    
    bgview.backgroundColor = [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.6];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:bgview];
    
    NSString *game = [CommonUtil getValueByKey:GameAlert];
    
    NSURL *url;
    
    if ([game isEqualToString:@"拼手气"]) {
        
        url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"regpage(1).gif" ofType:nil]];
        
    }else if ([game isEqualToString:@"打企鹅"]) {
    
        url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"bear.gif" ofType:nil]];
        
    }
    
    self.gameAlertView = [[GameGifAlertView alloc] initWithCenter:CGPointMake(ScreenWidth * 0.5, ScreenHeight * 0.5) fileURL:url];
    
    self.gameAlertView.frame = CGRectMake(ScreenWidth * 0.3, 200, ScreenWidth * 0.4, ScreenWidth * 0.4 * 1.5);
    
    self.gameAlertView.delegate = self;
    
    [self.gameAlertView startGif];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.gameAlertView];
    
}

//游戏悬浮框点击代理
- (void)GifViewClick {
    
    GameWebViewController *vc = [[GameWebViewController alloc] init];
    
    vc.loadStr = [NSString stringWithFormat:@"%@?memberId=%@",[CommonUtil getValueByKey:GameLink],[CommonUtil getValueByKey:MEMBER_ID]];
    
    vc.pushType = @"RH";
    
    [self.navigationController pushViewController:vc animated:YES];
    
    [self.gameAlertView stopGif];
    
    [self.gameAlertView removeFromSuperview];
    
    [self.gameBGView removeFromSuperview];
    
}


//领钱
- (void)getRedMoney {

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberid",
                         nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horserequest:@"RedGetMoney.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            if ([msg isEqualToString:@"领钱成功！"]) {
                
                RH_GetMoneyAnimation *scroll = [[RH_GetMoneyAnimation alloc] init];
                
                [scroll showInView:[UIApplication sharedApplication].keyWindow];
                
                [SVProgressHUD showSuccessWithStatus:msg];
                
                __block RH_HomeViewController/*主控制器*/ *weakSelf = self;
                
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
                
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    
                    [weakSelf ShowGameIcon];
                    
                });
                
            }
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            if (![msg isEqualToString:@"暂无收益！"]) {
                
                [SVProgressHUD showErrorWithStatus:msg];
                
            }

        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)initWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    
    self.tableview = tableview;
    
    RH_HomePersonHeadView *headview = [[RH_HomePersonHeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, ScreenWidth, headview.height);
    
    tableview.tableHeaderView = headview;
    
    self.yesMemberHeadView = headview;
    
    __block RH_HomePersonHeadView *blockself = headview;
    
    headview.EditBlock = ^(){
        
        blockself.userInteractionEnabled = NO;
        
        RH_AdministrationViewController *vc = [[RH_AdministrationViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableview];
    
}

-(void)viewWillDisappear:(BOOL)animated {

    self.yesMemberHeadView.userInteractionEnabled = YES;
    
}

//油费点击
- (void)youfeiClick {
    
    self.yesMemberHeadView.userInteractionEnabled = NO;

    OilSubsidyViewController *vc = [[OilSubsidyViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//轮胎点击
- (void)luntaiClick {
    
    self.yesMemberHeadView.userInteractionEnabled = NO;

    TyreSubsidyViewController *vc = [[TyreSubsidyViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//保养点击
- (void)BaoyangClick {
    
    self.yesMemberHeadView.userInteractionEnabled = NO;

    RepairMaintainViewController *vc = [[RepairMaintainViewController alloc] init];
    
    vc.type = @"2";
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//维修点击
- (void)XiuLiClick {
    
    self.yesMemberHeadView.userInteractionEnabled = NO;
    
    RepairMaintainViewController *vc = [[RepairMaintainViewController alloc] init];
    
    vc.type = @"3";
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//保险点击
- (void)BaoXianClick {
    
    self.yesMemberHeadView.userInteractionEnabled = NO;

    InsuranceViewController *vc = [[InsuranceViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//生活点击
- (void)ShengHuoClick {
    
    self.yesMemberHeadView.userInteractionEnabled = NO;

    RH_LifeViewController *vc = [[RH_LifeViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return self.filpArray.count;
        
    }else if (section == 1) {
    
        return self.bottomArr.count;
        
    }else {
    
        return 0;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            RH_FilpCell *cell = [[RH_FilpCell alloc] init];
            
            RH_FilpCellFrame *frame = self.filpArray[indexPath.row];
            
            cell.frameModel = frame;
            
            cell.flip1Block = ^{
                
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
                
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    
                    RH_FilpADModel *admodel = frame.cellModel.ADs[0];
                    
                    [self QianDaoWithID:admodel.LocationID];
                    
                });
                
            };
            
            cell.click1Block = ^{
                
                NSLog(@"pic1 click");
                
            };
            
            cell.flip2Block = ^{
                
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
                
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    
                    RH_FilpADModel *admodel = frame.cellModel.ADs[1];
                    
                    [self QianDaoWithID:admodel.LocationID];
                    
                });
                
            };
            
            cell.click2Block = ^{
                
                NSLog(@"pic2 click");
                
            };
            
            cell.flip3Block = ^{
                
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
                
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    
                    RH_FilpADModel *admodel = frame.cellModel.ADs[2];
                    
                    [self QianDaoWithID:admodel.LocationID];
                    
                });
                
            };
            
            cell.click3Block = ^{
                
                NSLog(@"pic3 click");
                
            };
            
            cell.flip4Block = ^{
                
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
                
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    
                    RH_FilpADModel *admodel = frame.cellModel.ADs[3];
                    
                    [self QianDaoWithID:admodel.LocationID];
                    
                });
                
            };
            
            cell.click4Block = ^{
                
                NSLog(@"pic4 click");
                
            };
            
            return cell;
            
        }else {
            
            return nil;
            
        }

    }else if (indexPath.section == 1) {
    
        RH_BoFrame *frame = self.bottomArr[indexPath.row];
        
        RH_BottomShopCell *cell = [[RH_BottomShopCell alloc] init];
        
        cell.frameModel = frame;
        
        return cell;
        
    }else {
    
        return nil;
        
    }
    
}

- (void)QianDaoWithID:(NSString *)ID {

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                         ID,@"RHIndexID",
                         nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horserequest:@"RedHorseSignIn.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        RH_FilpCellFrame *frame = self.filpArray[indexPath.row];
        
        return frame.height;
        
    }else if (indexPath.section == 1) {
    
        RH_BoFrame *frame = self.bottomArr[indexPath.row];
        
        return frame.height;
        
    }else {
    
        return 0;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(UIImage *)getImageFromURL:(NSString *)fileURL {
    
    UIImage * result;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:fileURL]] returningResponse:NULL error:NULL];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
}

- (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

//请求首页数据
- (void)requestForHomeData {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberId",
                         [CommonUtil getValueByKey:CITYID],@"cityid",
                         nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horserequest:@"Index.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight)];
            
            imageView.image = [self getImageFromURL:[NSString stringWithFormat:@"%@",[json valueForKey:@"DropDownImg"]]];
            
            
            
            [self.tableview addSubview:imageView];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:[NSString stringWithFormat:@"%@",[json valueForKey:@"DefaultCarID"]] forKey:@"RH_DefaultCheID"];
            
            [defaults setObject:[NSString stringWithFormat:@"%@",[json valueForKey:@"CarImg"]] forKey:@"RH_DefaultCheImg"];
            
            [defaults setObject:[NSString stringWithFormat:@"%@",[json valueForKey:@"brandmodel"]] forKey:@"RH_DefaultCheModel"];
            
            [defaults synchronize];
            
            [self.yesMemberHeadView.editBtn setTitle:[NSString stringWithFormat:@"%@",[json valueForKey:@"CarBrand"]] forState:0];
            
            [self.yesMemberHeadView.iconImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[json valueForKey:@"PhotoBigUrl"]]] placeholderImage:[UIImage imageNamed:@"FSB_头像.png"]];
            
            if ([self isBlankString:[NSString stringWithFormat:@"%@",[json valueForKey:@"brandmodel"]]] || [[NSString stringWithFormat:@"%@",[json valueForKey:@"brandmodel"]] isEqualToString:@"0"]) {
                
                self.yesMemberHeadView.modelTitleLab.hidden = YES;
                
                self.yesMemberHeadView.modelLab.hidden = YES;
                
            }else {
            
                self.yesMemberHeadView.modelLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"brandmodel"]];
                
            }
        
            if ([self isBlankString:[NSString stringWithFormat:@"%@",[json valueForKey:@"Nettime"]]] || [[NSString stringWithFormat:@"%@",[json valueForKey:@"Nettime"]] isEqualToString:@"0"]) {
                
                self.yesMemberHeadView.mileageTitleLab.hidden = YES;
                
                self.yesMemberHeadView.mileageLab.hidden = YES;
                
            }else {
            
                self.yesMemberHeadView.mileageLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"Nettime"]];
                
            }
            
            if ([self isBlankString:[NSString stringWithFormat:@"%@",[json valueForKey:@"SubMoney"]]] || [[NSString stringWithFormat:@"%@",[json valueForKey:@"SubMoney"]] isEqualToString:@"0"]) {
                
                self.yesMemberHeadView.timeTitleLab.hidden = YES;
                
                self.yesMemberHeadView.timeLab.hidden = YES;
                
            }else {
            
                self.yesMemberHeadView.timeLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"SubMoney"]];
                
            }
            
            if ([self isBlankString:[NSString stringWithFormat:@"%@",[json valueForKey:@"GetMoney"]]] || [[NSString stringWithFormat:@"%@",[json valueForKey:@"GetMoney"]] isEqualToString:@"0"]) {
            
                self.yesMemberHeadView.countTitleLab.hidden = YES;
                
                self.yesMemberHeadView.countLab.hidden = YES;
                
            }else {
            
                self.yesMemberHeadView.countLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"GetMoney"]];
                
            }

            NSArray *array = [json valueForKey:@"Icons"];
            
            NSDictionary *youfeiDic = array[0];
            
            [self.yesMemberHeadView.youfeiView.button setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",youfeiDic[@"Photo"]]] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
            
            self.yesMemberHeadView.youfeiView.label.text = [NSString stringWithFormat:@"%@",youfeiDic[@"Title"]];
            
            [self.yesMemberHeadView.youfeiView.button addTarget:self action:@selector(youfeiClick) forControlEvents:UIControlEventTouchUpInside];
            
            NSDictionary *luntaiDic = array[1];
            
            [self.yesMemberHeadView.luntaiView.button setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",luntaiDic[@"Photo"]]] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
            
            self.yesMemberHeadView.luntaiView.label.text = [NSString stringWithFormat:@"%@",luntaiDic[@"Title"]];
            
            [self.yesMemberHeadView.luntaiView.button addTarget:self action:@selector(luntaiClick) forControlEvents:UIControlEventTouchUpInside];
            
            NSDictionary *baoyangDic = array[2];
            
            [self.yesMemberHeadView.baoyangView.button setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baoyangDic[@"Photo"]]] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
            
            self.yesMemberHeadView.baoyangView.label.text = [NSString stringWithFormat:@"%@",baoyangDic[@"Title"]];
            
            [self.yesMemberHeadView.baoyangView.button addTarget:self action:@selector(BaoyangClick) forControlEvents:UIControlEventTouchUpInside];
            
            NSDictionary *weixiuDic = array[3];
            
            [self.yesMemberHeadView.xiuliView.button setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",weixiuDic[@"Photo"]]] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
            
            self.yesMemberHeadView.xiuliView.label.text = [NSString stringWithFormat:@"%@",weixiuDic[@"Title"]];
            
            [self.yesMemberHeadView.xiuliView.button addTarget:self action:@selector(XiuLiClick) forControlEvents:UIControlEventTouchUpInside];
            
            NSDictionary *baoxianDic = array[4];
            
            [self.yesMemberHeadView.baoxianView.button setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baoxianDic[@"Photo"]]] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
            
            [self.yesMemberHeadView.baoxianView.button addTarget:self action:@selector(BaoXianClick) forControlEvents:UIControlEventTouchUpInside];
            
            self.yesMemberHeadView.baoxianView.label.text = [NSString stringWithFormat:@"%@",baoxianDic[@"Title"]];
            
            NSDictionary *shenghuoDic = array[5];
            
            [self.yesMemberHeadView.shenghuoView.button setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",shenghuoDic[@"Photo"]]] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
            
            [self.yesMemberHeadView.shenghuoView.button addTarget:self action:@selector(ShengHuoClick) forControlEvents:UIControlEventTouchUpInside];
            
            self.yesMemberHeadView.shenghuoView.label.text = [NSString stringWithFormat:@"%@",shenghuoDic[@"Title"]];
            
            NSArray *adArr = [json valueForKey:@"Adverds"];
            
            NSMutableArray *adMut = [NSMutableArray array];
            
            for (NSDictionary *adDic in adArr) {
                
                RH_FilpADModel *model = [[RH_FilpADModel alloc] initWithDict:adDic];
                
                [adMut addObject:model];
                
            }
            
            RH_FilpCellModel *adcellModel = [[RH_FilpCellModel alloc] init];
            
            adcellModel.Title = @"有奖签到";
            
            adcellModel.ADs = adMut;
            
            RH_FilpCellFrame *adFrame = [[RH_FilpCellFrame alloc] init];
            
            adFrame.cellModel = adcellModel;
            
            NSMutableArray *adcellArr = [NSMutableArray array];
            
            [adcellArr addObject:adFrame];
            
            self.filpArray = adcellArr;
            
            NSMutableArray *pp = [NSMutableArray array];
            
            RH_BoModel *mm = [[RH_BoModel alloc] init];
            
            mm.title = [NSString stringWithFormat:@"%@",[json valueForKey:@"ExtField"]];
            
            RH_BoFrame *fr = [[RH_BoFrame alloc] init];
            
            fr.bomodel = mm;
            
            [pp addObject:fr];
            
            self.bottomArr = pp;
            
            [self.tableview reloadData];
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)dismissRH_Homeview {

    [self dismissViewControllerAnimated:YES completion:nil];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
