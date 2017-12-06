//
//  RH_CarDetailViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_CarDetailViewController.h"
#import "RedHorseHeader.h"
#import "RH_CarModel.h"
#import "Car_DetailFrame.h"
#import "Car_DetailCell.h"

@interface RH_CarDetailViewController () <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@end

@implementation RH_CarDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"详情";
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"RH_HomeBack.png" andaction:@selector(dismissRH_Administration)];
    
    [self allocWithTableview];
    
    [self requestForCarDetail];
    
}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    Car_DetailFrame *frame = self.array[indexPath.row];
    
    Car_DetailCell *cell = [[Car_DetailCell alloc] init];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    Car_DetailFrame *frame = self.array[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//删除汽车点击
- (void)DeleteCar {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要删除此车辆信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    switch (buttonIndex) {
        case 1:
        {
        
            [self requestForDeleteCar];
            
        }
            break;
            
        default:
            break;
    }
    
}

//删除汽车请求
- (void)requestForDeleteCar {

    [SVProgressHUD showWithStatus:@"删除中..."];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         self.cheID,@"ID", nil];
    
    AppHttpClient *httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horserequest:@"DelMyCarInfo.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
        
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
        
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)requestForCarDetail {

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         self.cheID,@"ID",
                         nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horserequest:@"MyCarInfoDetail.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSMutableArray *mut = [NSMutableArray array];
            
            RH_CarModel *model = [[RH_CarModel alloc] init];
            
            model.CheID = [json valueForKey:@"ID"];
            
            model.isDefault = [json valueForKey:@"DefaultCar"];
            
            model.carImg = [json valueForKey:@"CarImg"];
            
            model.CarStatus = [json valueForKey:@"CarStatus"];
            
            model.carModel = [json valueForKey:@"BrandName"];
            
            model.carPlate = [json valueForKey:@"CarNo"];
            
            model.buyTime = [json valueForKey:@"BuyCarTime"];
            
            model.Mileage = [json valueForKey:@"Mileage"];
            
            model.EngineNumber = [json valueForKey:@"VIN"];
            
            model.buyMoney = [json valueForKey:@"BuyCarPayment"];
            
            model.InvoiceImgUrl = [json valueForKey:@"CarInvoiceImg"];
            
            Car_DetailFrame *frame = [[Car_DetailFrame alloc] init];
            
            frame.carModel = model;
            
            [mut addObject:frame];
            
            if ([model.CarStatus isEqualToString:@"已拒绝"]) {
                
                self.navigationItem.rightBarButtonItem = [self SetNavigationBarRightTitle:@"删除" andaction:@selector(DeleteCar)];
                
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
