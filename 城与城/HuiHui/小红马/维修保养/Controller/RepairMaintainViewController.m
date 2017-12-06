//
//  RepairMaintainViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RepairMaintainViewController.h"
#import "OilHeadView.h"
#import "RedHorseHeader.h"
#import "NearBySectionView.h"

#import "RepairMaintainModel.h"
#import "RepairMaintainFrame.h"
#import "RepairMaintainCell.h"

#import "ApplySubsidyViewController.h"

#import "ApplySubsidyViewController.h"
#import "RH_SwitchCarViewController.h"
#import "RH_CarModel.h"
#import "RH_NearByViewController.h"

@interface RepairMaintainViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSString *DefaultCarID;
    
    NSString *CarImg;
    
    NSString *DefaultCarModel;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@end

@implementation RepairMaintainViewController

//-(NSArray *)array {
//
//    if (_array == nil) {
//        
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"RepairMaintain.plist" ofType:nil];
//        
//        NSArray *array = [NSArray arrayWithContentsOfFile:path];
//        
//        NSMutableArray *tempArray = [NSMutableArray array];
//        
//        for (NSDictionary *dd in array) {
//            
//            RepairMaintainModel *model = [[RepairMaintainModel alloc] initWithDict:dd];
//            
//            RepairMaintainFrame *frame = [[RepairMaintainFrame alloc] init];
//            
//            frame.repairModel = model;
//            
//            [tempArray addObject:frame];
//            
//        }
//        
//        _array = tempArray;
//        
//    }
//    
//    return _array;
//    
//}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"维修保养";
    
    self.navigationItem.rightBarButtonItem = [self SetNavigationBarRightTitle:@"补助" andaction:@selector(AddSubsidyClick)];
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"RH_HomeBack.png" andaction:@selector(popRepairVC)];
    
    [self allocWithTableview];
    
}

-(void)viewWillAppear:(BOOL)animated {

    [self requestForList];
    
}

//初始化tableview
- (void)allocWithTableview {
    
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
    
    self.tableview = tableview;
    
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    
    vv.backgroundColor = RH_ViewBGColor;
    
    tableview.tableFooterView = vv;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    [self.view addSubview:tableview];
    
    NearBySectionView *view = [[NearBySectionView alloc] init];
    
    view.frame = CGRectMake(0, CGRectGetMaxY(tableview.frame), ScreenWidth, view.height);
    
    view.titleLab.text = @"附近的汽修店";
    
    view.nearByBlock = ^{
        
        RH_NearByViewController *vc = [[RH_NearByViewController alloc] init];
        
        vc.nearByType = @"汽车4S店";
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    [self.view addSubview:view];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    RepairMaintainCell *cell = [[RepairMaintainCell alloc] init];
    
    RepairMaintainFrame *frame = self.array[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    RepairMaintainFrame *frame = self.array[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//请求维修保养补助列表
- (void)requestForList {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         memberId,@"MemberId",
                         DefaultCarID,@"ID",
                         nil];
    
    NSLog(@"%@",dic);
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horserequest:@"MaintainList.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = [json valueForKey:@"listFule"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in arr) {
                
                RepairMaintainModel *model = [[RepairMaintainModel alloc] init];
                
                model.ID = [NSString stringWithFormat:@"%@",dd[@"ID"]];
                
                model.type = [NSString stringWithFormat:@"%@",dd[@"Type"]];
                
                model.count = [NSString stringWithFormat:@"%@",dd[@"Amount"]];
                
                model.status = [NSString stringWithFormat:@"%@",dd[@"State"]];
                
                model.time = [NSString stringWithFormat:@"%@",dd[@"ApplyTime"]];
                
                model.content = [NSString stringWithFormat:@"%@",dd[@"TypeName"]];
                
                RepairMaintainFrame *frame = [[RepairMaintainFrame alloc] init];
                
                frame.repairModel = model;
                
                [mut addObject:frame];
                
            }
            
            self.array = mut;
            
            [self.tableview reloadData];
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//返回上级页面
- (void)popRepairVC {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


//补助点击
- (void)AddSubsidyClick {
    
    ApplySubsidyViewController *vc = [[ApplySubsidyViewController alloc] init];
    
    vc.applyType = self.type;
    
    vc.DefaultCarID = DefaultCarID;
    
    vc.DefaultCarModel = DefaultCarModel;
    
    vc.CarImg = CarImg;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
