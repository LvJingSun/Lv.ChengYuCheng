//
//  OilSubsidyViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "OilSubsidyViewController.h"
#import "RedHorseHeader.h"
#import "OilHeadView.h"

#import "OilSubsidyModel.h"
#import "OilSubsidyFrame.h"
#import "OilSubsidyCell.h"

#import "NearBySectionView.h"
#import "ApplySubsidyViewController.h"
#import "RH_SwitchCarViewController.h"
#import "RH_CarModel.h"
#import "RH_NearByViewController.h"

@interface OilSubsidyViewController () <UITableViewDelegate,UITableViewDataSource> {

    NSString *DefaultCarID;
    
    NSString *CarImg;
    
    NSString *DefaultCarModel;
    
}

@property (nonatomic, weak) UITableView *OilJournalTableview;

@property (nonatomic, strong) NSArray *OilJournalArray;

//@property (nonatomic, weak) UITableView *NearByTableview;
//
//@property (nonatomic, strong) NSArray *NearByArray;

@end

@implementation OilSubsidyViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"油费补助";
    
    self.navigationItem.rightBarButtonItem = [self SetNavigationBarRightTitle:@"补助" andaction:@selector(AddSubsidyClick)];
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"RH_HomeBack.png" andaction:@selector(popOilVC)];
    
    [self allocWithOilJournalTableview];
    
    [self allocWithNearByView];
    
}

-(void)viewWillAppear:(BOOL)animated {

    [self requestForList];
    
}

//初始化油费日志列表
- (void)allocWithOilJournalTableview {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    DefaultCarID = [defaults objectForKey:@"RH_DefaultCheID"];
    
    CarImg = [defaults objectForKey:@"RH_DefaultCheImg"];
    
    DefaultCarModel = [defaults objectForKey:@"RH_DefaultCheModel"];
    
    OilHeadView *headview = [[OilHeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, ScreenWidth, headview.height);
    
    __weak typeof(OilHeadView) *weakHeadview = headview;
    
    headview.switchBlock = ^{
        
        RH_SwitchCarViewController *vc = [[RH_SwitchCarViewController alloc] init];
        
        vc.popCar = ^(RH_CarModel *carModel) {
            
            DefaultCarID = carModel.CheID;
            
            DefaultCarModel = carModel.carModel;
            
            CarImg = carModel.carImg;
            
            [weakHeadview.iconImg setImageWithURL:[NSURL URLWithString:CarImg] placeholderImage:[UIImage imageNamed:@"RH_CarPL.png"]];
            
            weakHeadview.carModel.text = DefaultCarModel;
            
        };
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    [headview.iconImg setImageWithURL:[NSURL URLWithString:CarImg] placeholderImage:[UIImage imageNamed:@"RH_CarPL.png"]];
    
    headview.carModel.text = DefaultCarModel;
    
    [self.view addSubview:headview];

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headview.frame), ScreenWidth, ScreenHeight - 64 - 50 - CGRectGetMaxY(headview.frame))];
    
    self.OilJournalTableview = tableview;
    
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    
    vv.backgroundColor = RH_ViewBGColor;
    
    tableview.tableFooterView = vv;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    [self.view addSubview:tableview];
    
}

//初始化附近view
- (void)allocWithNearByView {

    NearBySectionView *view = [[NearBySectionView alloc] init];
    
    view.frame = CGRectMake(0, CGRectGetMaxY(self.OilJournalTableview.frame), ScreenWidth, view.height);
    
    view.titleLab.text = @"附近的加油站";
    
    view.nearByBlock = ^{
        
        RH_NearByViewController *vc = [[RH_NearByViewController alloc] init];
        
        vc.nearByType = @"加油站";
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    [self.view addSubview:view];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        
    return self.OilJournalArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    OilSubsidyCell *cell = [[OilSubsidyCell alloc] init];
    
    OilSubsidyFrame *frame = self.OilJournalArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OilSubsidyFrame *frame = self.OilJournalArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//补助点击
- (void)AddSubsidyClick {

    ApplySubsidyViewController *vc = [[ApplySubsidyViewController alloc] init];
    
    vc.applyType = @"4";
    
    vc.DefaultCarID = DefaultCarID;
    
    vc.DefaultCarModel = DefaultCarModel;
    
    vc.CarImg = CarImg;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//请求邮费补助列表
- (void)requestForList {

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         memberId,@"MemberId",
                         DefaultCarID,@"ID",
                         nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horserequest:@"FuelList.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = [json valueForKey:@"listFule"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in arr) {
                
                OilSubsidyModel *model = [[OilSubsidyModel alloc] init];
                
                model.ID = [NSString stringWithFormat:@"%@",dd[@"ID"]];
                
                model.count = [NSString stringWithFormat:@"%@",dd[@"Amount"]];
                
                model.status = [NSString stringWithFormat:@"%@",dd[@"State"]];
                
                model.time = [NSString stringWithFormat:@"%@",dd[@"ApplyTime"]];
                
                OilSubsidyFrame *frame = [[OilSubsidyFrame alloc] init];
                
                frame.subsidyModel = model;
                
                [mut addObject:frame];
                
            }
            
            self.OilJournalArray = mut;
            
            [self.OilJournalTableview reloadData];
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//返回上级页面
- (void)popOilVC {

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
