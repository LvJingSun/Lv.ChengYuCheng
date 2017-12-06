//
//  ApplyInsuranceViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/9.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "ApplyInsuranceViewController.h"
#import "OilHeadView.h"
#import "RedHorseHeader.h"

#import "RH_InsuranceModel.h"
#import "RH_InsuranceInPutFrame.h"
#import "RH_InsuranceInPutCell.h"

#import "RH_CarModel.h"
#import "RH_SwitchCarViewController.h"

#import "InsuranceTypeModel.h"
#import "InsuranceTypeFrame.h"
#import "InsuranceTypeAlertView.h"

@interface ApplyInsuranceViewController () <UITableViewDelegate,UITableViewDataSource,Insurance_FieldDelegate>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) NSArray *typeArr;

@end

@implementation ApplyInsuranceViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"申请保险";
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"RH_HomeBack.png" andaction:@selector(popApplyInsuranceVC)];
    
    [self allocWithTableview];
    
    self.array = [NSMutableArray array];
    
    NSMutableArray *mut = [NSMutableArray array];
    
    RH_InsuranceInPutFrame *frame = [[RH_InsuranceInPutFrame alloc] init];
    
    RH_InsuranceModel *model = [[RH_InsuranceModel alloc] init];
    
    frame.insuranceModel = model;
    
    model.drivingYears = @"1";
    
    model.carYears = @"1";
    
    [mut addObject:frame];
    
    self.array = mut;
    
    [self requestForType];
    
}

- (void)PriceFieldChange:(UITextField *)field {

    for (RH_InsuranceInPutFrame *frame in self.array) {
        
        frame.insuranceModel.carPrice = [NSString stringWithFormat:@"%@",field.text];
        
    }
    
}

- (void)InsurancePersonFieldChange:(UITextField *)field {

    for (RH_InsuranceInPutFrame *frame in self.array) {
        
        frame.insuranceModel.insurancePerson = [NSString stringWithFormat:@"%@",field.text];
        
    }
    
}

- (void)DrivingAreaFieldChange:(UITextField *)field {

    for (RH_InsuranceInPutFrame *frame in self.array) {
        
        frame.insuranceModel.drivingArea = [NSString stringWithFormat:@"%@",field.text];
        
    }
    
}

//初始化tableview
- (void)allocWithTableview {
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    DefaultCarID = [defaults objectForKey:@"RH_DefaultCheID"];
//    
//    CarImg = [defaults objectForKey:@"RH_DefaultCheImg"];
//    
//    DefaultCarModel = [defaults objectForKey:@"RH_DefaultCheModel"];
    
    OilHeadView *headview = [[OilHeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, ScreenWidth, headview.height);
    
    headview.switchBlock = ^{
        
        RH_SwitchCarViewController *vc = [[RH_SwitchCarViewController alloc] init];
        
        vc.popCar = ^(RH_CarModel *carModel) {
            
            self.DefaultCarID = carModel.CheID;
            
            self.DefaultCarModel = carModel.carModel;
            
            self.CarImg = carModel.carImg;
            
            [self.tableview reloadData];
            
        };
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    [headview.iconImg setImageWithURL:[NSURL URLWithString:self.CarImg] placeholderImage:[UIImage imageNamed:@"RH_CarPL.png"]];
    
    headview.carModel.text = self.DefaultCarModel;
    
    [self.view addSubview:headview];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headview.frame), ScreenWidth, ScreenHeight - 64 - CGRectGetMaxY(headview.frame))];
    
    self.tableview = tableview;
    
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    
    vv.backgroundColor = RH_ViewBGColor;
    
    tableview.tableFooterView = vv;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.array.count;
    
}

- (BOOL)isNULLString:(NSString *)string {
    
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


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RH_InsuranceInPutFrame *frame = self.array[indexPath.row];
    
    RH_InsuranceInPutCell *cell = [[RH_InsuranceInPutCell alloc] init];
    
    cell.frameModel = frame;
    
    cell.delegate = self;
    
    cell.typeBlock = ^{
        
        for (RH_InsuranceInPutFrame *frame in self.array) {
            
            if (![self isNULLString:frame.insuranceModel.insuranceTypeID]) {
                
                for (InsuranceTypeFrame *ff in self.typeArr) {
                    
                    if ([ff.typemodel.ID isEqualToString:frame.insuranceModel.insuranceTypeID]) {
                        
                        ff.typemodel.isChoose = @"1";
                        
                    }else {
                        
                        ff.typemodel.isChoose = @"0";
                        
                    }
                    
                }
                
            }
            
        }
        
        InsuranceTypeAlertView *alert = [[InsuranceTypeAlertView alloc] init];
        
        alert.array = self.typeArr;
        
        alert.choosetype = ^(InsuranceTypeModel *typemodel) {
            
            frame.insuranceModel.insuranceTypeID = typemodel.ID;
            
            frame.insuranceModel.insuranceType = typemodel.TypeName;
            
            [tableView reloadData];
            
        };
        
        [alert showInView:self.view];
        
    };
    
    cell.Driving_OneBlock = ^{
        
        frame.insuranceModel.drivingYears = @"1";
        
        [tableView reloadData];
        
    };
    
    cell.Driving_OneToThreeBlock = ^{
        
        frame.insuranceModel.drivingYears = @"2";
        
        [tableView reloadData];
        
    };
    
    cell.Driving_MoreThreeBlock = ^{
        
        frame.insuranceModel.drivingYears = @"3";
        
        [tableView reloadData];
        
    };
    
    cell.Car_OneBlock = ^{
        
        frame.insuranceModel.carYears = @"1";
        
        [tableView reloadData];
        
    };
    
    cell.Car_OneToTwoBlock = ^{
        
        frame.insuranceModel.carYears = @"2";
        
        [tableView reloadData];
        
    };
    
    cell.Car_TwoToSixBlock = ^{
        
        frame.insuranceModel.carYears = @"3";
        
        [tableView reloadData];
        
    };
    
    cell.Car_MoreSixBlock = ^{
        
        frame.insuranceModel.carYears = @"4";
        
        [tableView reloadData];
        
    };
    
    cell.sureBlock = ^{
        
        //点击提交，检测数据
        [self checkData];
        
    };
    
    return cell;
    
}

- (void)checkData {

    RH_InsuranceInPutFrame *frame = self.array[0];
    
    if ([self isNULLString:self.DefaultCarID]) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择车辆信息"];
        
    }else if ([self isNULLString:frame.insuranceModel.carPrice]) {
    
        [SVProgressHUD showErrorWithStatus:@"请完善车辆价格"];
        
    }else if ([self isNULLString:frame.insuranceModel.insurancePerson]) {
        
        [SVProgressHUD showErrorWithStatus:@"请完善被保险人信息"];
        
    }else if ([self isNULLString:frame.insuranceModel.insuranceTypeID]) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择保险种类"];
        
    }else if ([self isNULLString:frame.insuranceModel.drivingArea]) {
        
        [SVProgressHUD showErrorWithStatus:@"请填写行驶里程"];
        
    }else if ([self isNULLString:frame.insuranceModel.drivingYears]) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择驾龄信息"];
        
    }else if ([self isNULLString:frame.insuranceModel.carYears]) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择车龄信息"];
        
    }else {
    
        [self requestForPushData];
        
    }
    
}

//提交数据
- (void)requestForPushData {

    RH_InsuranceInPutFrame *frame = self.array[0];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         self.DefaultCarID,@"CarID",
                         frame.insuranceModel.carPrice,@"CarPrices",
                         frame.insuranceModel.insurancePerson,@"InsuredName",
                         frame.insuranceModel.insuranceTypeID,@"InsuranceType",
                         frame.insuranceModel.drivingArea,@"DrivingArea",
                         frame.insuranceModel.drivingYears,@"DrivingAge",
                         frame.insuranceModel.carYears,@"CarAge",
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberId",
                         nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horserequest:@"ApplyInsurance.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
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

//请求保险种类
- (void)requestForType {
    
    NSDictionary *dic = [NSDictionary dictionary];
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horserequest:@"InsureanceTypeList.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *tempArr = [json valueForKey:@"ListReInsure"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in tempArr) {
                
                InsuranceTypeModel *model = [[InsuranceTypeModel alloc] init];
                
                model.ID = [NSString stringWithFormat:@"%@",dd[@"ID"]];
                
                model.TypeName = [NSString stringWithFormat:@"%@",dd[@"TypeName"]];
                
                model.isChoose = @"0";
                
                InsuranceTypeFrame *frame = [[InsuranceTypeFrame alloc] init];
                
                frame.typemodel = model;
                
                [mut addObject:frame];
                
            }
            
            self.typeArr = mut;
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RH_InsuranceInPutFrame *frame = self.array[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)popApplyInsuranceVC {

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
