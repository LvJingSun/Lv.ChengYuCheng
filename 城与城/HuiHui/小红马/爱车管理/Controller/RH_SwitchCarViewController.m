//
//  RH_SwitchCarViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_SwitchCarViewController.h"
#import "SwitchCarFrame.h"
#import "SwitchCarCell.h"
#import "RH_CarModel.h"
#import "RedHorseHeader.h"

@interface RH_SwitchCarViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@end

@implementation RH_SwitchCarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"切换车辆";
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"RH_HomeBack.png" andaction:@selector(dismissRH_Administration)];
    
    [self allocWithTableview];
    
    [self requestForCarList];

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
    
    SwitchCarCell *cell = [[SwitchCarCell alloc] init];
    
    SwitchCarFrame *frame = self.array[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SwitchCarFrame *frame = self.array[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SwitchCarFrame *frame = self.array[indexPath.row];
    
    if ([frame.carmodel.CarStatus isEqualToString:@"审核通过"]) {
        
        self.popCar(frame.carmodel);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

- (void)popCarClick:(popSwitchCarBlock)block {

    self.popCar = block;
    
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
                
                SwitchCarFrame *frame = [[SwitchCarFrame alloc] init];
                
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
