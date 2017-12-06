//
//  FSB_GameCenterViewController.m
//  HuiHui
//
//  Created by mac on 2017/5/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_GameCenterViewController.h"
#import "FSB_GameHeadView.h"
#import "LJConst.h"
#import "GameImageModel.h"
#import "FSB_ScrollView.h"
#import "GameScrollCell.h"
#import "GameScrollFrame.h"
#import "GameScrollModel.h"
#import "GameCenterModel.h"


#import "GameBtnCellModel.h"
#import "GameBtnCellFrame.h"
#import "GameBtnCell.h"

#import "GameWebViewController.h"
#import "TiXingView.h"
#import "Wallet_GAMEViewController.h"

@interface FSB_GameCenterViewController () <UITableViewDataSource,UITableViewDelegate,GameScrollDelegate,GameBtnCellDelegate> {

    GameCenterModel *gameCenterModel;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) UIImageView *iconImageview;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) FSB_ScrollView *scroll;

@property (nonatomic, strong) NSArray *gameArray;

@property (nonatomic, strong) NSArray *sourceArray;

@property (nonatomic, strong) NSArray *gameCenterArray;

@end

@implementation FSB_GameCenterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self allocWithTableView];
    
    [self checkGameXieYi];
    
    [self requestForGameCenterData];

}

//验证游戏协议
- (void)checkGameXieYi {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *str = [defaults objectForKey:@"Game_YanZheng"];
    
    NSString *fensibaoExtension = [defaults objectForKey:@"game_extension"];
    
    if ([str isEqualToString:@"0"]) {
        
        TiXingView *tixingview = [[TiXingView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight)];
        
        tixingview.iconImg.image = [UIImage imageNamed:@"yxyuan@2x.png"];
        
        [tixingview.sureBtn addTarget:self action:@selector(tongyiRequest) forControlEvents:UIControlEventTouchUpInside];
        
        [tixingview.backBtn addTarget:self action:@selector(viewDismiss) forControlEvents:UIControlEventTouchUpInside];
        
        fensibaoExtension = [fensibaoExtension stringByReplacingOccurrencesOfString:@"/n" withString:@"\n"];
        
        tixingview.textview.text = [NSString stringWithFormat:@"%@",fensibaoExtension];
        
        [[[UIApplication sharedApplication].windows firstObject] addSubview:tixingview];
        
    }
    
}

//计算滑动位置，block传值 透明度alpha
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat newOffy = scrollView.contentOffset.y;
    
    CGFloat alpha = newOffy/64.0;
    
    self.goodsInfoNavBlock(self,alpha);
    
}

- (void)scrollImageClick:(NSInteger)pageNumber {

    NSLog(@"点击了第%ld张图片",(long)pageNumber);
    
}

//初始化tableview
- (void)allocWithTableView {

    FSB_GameHeadView *headview = [[FSB_GameHeadView alloc] init];

    headview.frame = CGRectMake(0, 0, _WindowViewWidth, headview.height);
    
    headview.rechargeBlock = ^{
        
        //联城游戏
        Wallet_GAMEViewController *vc = [[Wallet_GAMEViewController alloc] init];
        
        [[self getCurrentViewController].navigationController pushViewController:vc animated:YES];
        
    };

    self.iconImageview = headview.iconImageview;
    
    self.nameLab = headview.nameLab;
    
    self.countLab = headview.countLab;

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight)];

    self.tableview = tableview;

    tableview.tableHeaderView = headview;

    tableview.delegate = self;

    tableview.dataSource = self;

    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;

    tableview.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:tableview];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
    
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 1;
        
    }else if (section == 1) {
        
        return 1;
        
    }else {
    
        return 0;
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    
}

- (void)viewDismiss {

    [[self getCurrentViewController] dismissViewControllerAnimated:YES completion:nil];
    
}

//签订游戏协议
- (void)tongyiRequest {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedExtension];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"Memberid",
                           @"4",@"type",
                           @"1",@"IsAgree",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient ExtensionRequest:@"FistAgreement.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:@"欢迎加入游戏"];
            
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
                           @"4",@"type",
                           @"0",@"IsAgree",
                           nil];
    
    [httpClient ExtensionRequest:@"FistAgreement.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:@"1" forKey:@"Game_YanZheng"];
            
        } else {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:@"0" forKey:@"Game_YanZheng"];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        GameScrollFrame *frame = self.sourceArray[indexPath.row];
        
        GameScrollCell *cell = [[GameScrollCell alloc] init];
        
        cell.delegate = self;
        
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

    NSArray *arr = gameCenterModel.listCategory;
    
    GameImageModel *model = arr[sender.tag];
    
    NSString *str = [NSString stringWithFormat:@"%@?memberId=%@&app=ios",model.Link,[CommonUtil getValueByKey:MEMBER_ID]];
    
    if ([model.type isEqualToString:@"0"]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }else {
        
        GameWebViewController *vc = [[GameWebViewController alloc] init];
        
        vc.loadStr = str;
        
        [[self getCurrentViewController].navigationController pushViewController:vc animated:YES];
        
    }

}

/** 获取当前View的控制器对象 */
-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
    
        GameScrollFrame *frame = self.sourceArray[indexPath.row];
        
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
            
            gameCenterModel = center;

            [self.iconImageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[json valueForKey:@"MemPhoto"]]] placeholderImage:[UIImage imageNamed:@""]];
            
            self.nameLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"NickName"]];
            
            self.countLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"AccountBalance"]];
            
            //轮播数据
            NSArray *gamesArr = gameCenterModel.listCategory;
            
            NSMutableArray *temp = [NSMutableArray array];
            
            for (GameImageModel *model in gamesArr) {
                
                [temp addObject:model.GameLinkPhtoto];
                
            }
       
            NSMutableArray *sourceTemp = [NSMutableArray array];
            
            GameScrollModel *scc = [[GameScrollModel alloc] init];
            
            scc.source = temp;
            
            GameScrollFrame *frame = [[GameScrollFrame alloc] init];
            
            frame.scrollmodel = scc;
            
            [sourceTemp addObject:frame];
            
            self.sourceArray = sourceTemp;
            
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

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
