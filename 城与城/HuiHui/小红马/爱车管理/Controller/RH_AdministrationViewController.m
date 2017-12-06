//
//  RH_AdministrationViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_AdministrationViewController.h"
#import "Car_ListFrame.h"
#import "Car_ListCell.h"
#import "RH_CarModel.h"
#import "RedHorseHeader.h"

#import "RH_AddBtnView.h"
#import "RH_CarInfoViewController.h"
#import "RH_CarDetailViewController.h"

#import "RH_ListNoDataCell.h"

@interface RH_AdministrationViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@end

@implementation RH_AdministrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"爱车管理";
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"RH_HomeBack.png" andaction:@selector(dismissRH_Administration)];
    
    [self allocWithTableview];
    
}

-(void)viewWillAppear:(BOOL)animated {

    [self requestForCarList];
    
}

- (void)allocWithTableview {

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 65)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    [self.view addSubview:tableview];
    
    RH_AddBtnView *btn = [[RH_AddBtnView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tableview.frame), ScreenWidth, 65)];
    
    btn.AddBlock = ^{
        
        RH_CarInfoViewController *vc = [[RH_CarInfoViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    [self.view addSubview:btn];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    if (self.array.count == 0) {
//        
//        return 1;
//        
//    }else {
    
        return self.array.count;
        
//    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (self.array.count == 0) {
//        
//        RH_ListNoDataCell *cell = [[RH_ListNoDataCell alloc] init];
//        
//        cell.titleText = @"暂无车辆";
//        
//        return cell;
//        
//    }else {
    
        Car_ListCell *cell = [[Car_ListCell alloc] init];
        
        Car_ListFrame *frame = self.array[indexPath.row];
        
        cell.frameModel = frame;
        
        cell.DefaultBlock = ^{
            
            [self setDefaultCarRequestWithID:frame.carmodel.CheID];
            
        };
        
        return cell;
        
//    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (self.array.count == 0) {
//        
//        RH_ListNoDataCell *cell = [[RH_ListNoDataCell alloc] init];
//        
//        return cell.height;
//        
//    }else {
    
        Car_ListFrame *frame = self.array[indexPath.row];
        
        return frame.height;
        
//    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    Car_ListFrame *frame = self.array[indexPath.row];
    
    RH_CarDetailViewController *vc = [[RH_CarDetailViewController alloc] init];
    
    vc.cheID = frame.carmodel.CheID;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//设置车辆默认
- (void)setDefaultCarRequestWithID:(NSString *)cheID {

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         memberId,@"Memberid",
                         cheID,@"ID",
                         nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horserequest:@"SetDefaultCar.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [self requestForCarList];
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//请求汽车列表数据
- (void)requestForCarList {

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         memberId,@"MemberId",
                         nil];

    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horserequest:@"MyCarInfoList.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = [json valueForKey:@"listCar"];
            
            NSMutableArray *mut = [NSMutableArray array];
    
            for (NSDictionary *dd in arr) {
    
                RH_CarModel *car = [[RH_CarModel alloc] init];
                
                car.CheID = dd[@"ID"];
                
                car.carPlate = dd[@"carNo"];
                
                car.carModel = dd[@"BrandName"];
                
                car.carImg = dd[@"CarImg"];
                
                car.isDefault = dd[@"DefaultCar"];
                
                car.CarStatus = dd[@"CarStatus"];
    
                Car_ListFrame *frame = [[Car_ListFrame alloc] init];
    
                frame.carmodel = car;
                
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

- (void)dismissRH_Administration {

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
