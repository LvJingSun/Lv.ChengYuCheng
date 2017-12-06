//
//  GG_HomeViewController.m
//  HuiHui
//
//  Created by mac on 2017/8/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GG_HomeViewController.h"
#import "GameGoldHeader.h"
#import "GG_HomeHeadView.h"

#import "GoldPriceModel.h"
#import "GoldPriceFrame.h"
#import "GoldPriceCell.h"

#import "GoldBrokenLineModel.h"
#import "GoldBrokenLineFrame.h"
#import "GoldBrokenLineCell.h"
#import "GoldFooterView.h"

#import "GoldRecordViewController.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "GG_PriceRecordViewController.h"

#import "FSB_GameViewController.h"
#import "FSB_GameNAVController.h"
#import "GoldGetOutViewController.h"

@interface GG_HomeViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) GG_HomeHeadView *headview;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *goldPriceArray;

@property (nonatomic, strong) NSArray *brokenArray;

@end

@implementation GG_HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"奖励金";
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"IMG_4582.PNG" andaction:@selector(viewDismiss)];
    
    self.navigationItem.rightBarButtonItem = [self SetNavigationBarRightTitle:@"记录" andaction:@selector(recordsClick)];
    
    [self allocWithTableview];

}

-(void)viewWillAppear:(BOOL)animated {

    [self requestForHomeData];
    
}

- (void)requestForHomeData {

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberid", nil];
    
    AppHttpClient *client = [AppHttpClient sharedBonus];
    
    [client Bonusrequest:@"BonusIndex.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            self.headview.shouyiLab.text = [NSString stringWithFormat:@"%.2f",[[json valueForKey:@"zrProfit"] floatValue]];
            
            self.headview.zhongliangLab.text = [NSString stringWithFormat:@"%@克",[json valueForKey:@"clGold"]];
            
            self.headview.jineLab.text = [NSString stringWithFormat:@"%.2f元",[[json valueForKey:@"sumMoney"] floatValue]];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            GoldPriceModel *model = [[GoldPriceModel alloc] init];
            
            model.price = [NSString stringWithFormat:@"%@",[json valueForKey:@"GPrice"]];
            
            model.date = [NSString stringWithFormat:@"%@",[json valueForKey:@"GTime"]];
            
            GoldPriceFrame *frame = [[GoldPriceFrame alloc] init];
            
            frame.pricemodel = model;
            
            [mut addObject:frame];
            
            self.goldPriceArray = mut;
            
            NSArray *priceArr = [json valueForKey:@"gdList"];
            
            NSMutableArray *keyArray = [NSMutableArray array];
            
            NSMutableArray *valueArray = [NSMutableArray array];
            
            for (NSDictionary *dd in priceArr) {
                
                [keyArray addObject:[NSString stringWithFormat:@"%@",dd[@"time"]]];
                
                [valueArray addObject:[NSString stringWithFormat:@"%@",dd[@"goldprice"]]];
                
            }
            
            GoldBrokenLineModel *lineModel = [[GoldBrokenLineModel alloc] init];
            
            lineModel.keyArr = keyArray;
            
            lineModel.valueArr = valueArray;
            
            GoldBrokenLineFrame *lineframe = [[GoldBrokenLineFrame alloc] init];
            
            lineframe.brokenModel = lineModel;
            
            NSMutableArray *mm = [NSMutableArray array];
            
            [mm addObject:lineframe];

            self.brokenArray = mm;

            [self.tableview reloadData];
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)allocWithTableview {
    
    GG_HomeHeadView *headview = [[GG_HomeHeadView alloc] init];
    
    self.headview = headview;
    
    headview.frame = CGRectMake(0, 0, ScreenWidth, headview.height);
    
    GoldFooterView *footview = [[GoldFooterView alloc] init];
    
    footview.frame = CGRectMake(0, ScreenHeight - 64 - footview.height, ScreenWidth, footview.height);
    
    footview.getInBlock = ^{
        
        FSB_GameViewController *vc = [[FSB_GameViewController alloc] init];
        
        FSB_GameNAVController *gameNav = [[FSB_GameNAVController alloc] initWithRootViewController:vc];
        
        [self presentViewController:gameNav animated:YES completion:nil];
        
    };
    
    footview.getOutBlock = ^{
        
        GoldGetOutViewController *vc = [[GoldGetOutViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    [self.view addSubview:footview];

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - footview.height)];
    
    self.tableview = tableview;
    
    tableview.tableHeaderView = headview;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        
        return self.goldPriceArray.count;
        
    }else if (section == 1) {
        
        return self.brokenArray.count;
        
    }else{
    
        return 0;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        GoldPriceCell *cell = [[GoldPriceCell alloc] init];
        
        GoldPriceFrame *frame = self.goldPriceArray[indexPath.row];
        
        cell.frameModel = frame;
        
        return cell;
        
    }else if (indexPath.section == 1) {
    
        GoldBrokenLineCell *cell = [[GoldBrokenLineCell alloc] init];
        
        GoldBrokenLineFrame *frame = self.brokenArray[indexPath.row];
        
        cell.frameModel = frame;
        
        return cell;
        
    }

    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        GoldPriceFrame *frame = self.goldPriceArray[indexPath.row];
        
        return frame.height;
        
    }else if (indexPath.section == 1) {
    
        GoldBrokenLineFrame *frame = self.brokenArray[indexPath.row];
        
        return frame.height;
        
    }
    
    return 0;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        
        GG_PriceRecordViewController *vc = [[GG_PriceRecordViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    
    view.backgroundColor = RH_ViewBGColor;
    
    return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10;
    
}

- (void)recordsClick {

    GoldRecordViewController *vc = [[GoldRecordViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)viewDismiss {

    [self dismissViewControllerAnimated:YES completion:nil];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
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
