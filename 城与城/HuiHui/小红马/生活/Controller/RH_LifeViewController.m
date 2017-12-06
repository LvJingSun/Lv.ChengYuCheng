//
//  RH_LifeViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/10.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_LifeViewController.h"
#import "RedHorseHeader.h"
#import "Life_CellModel.h"
#import "Life_CellFrame.h"
#import "Life_Cell.h"

@interface RH_LifeViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@end

@implementation RH_LifeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"生活";
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"RH_HomeBack.png" andaction:@selector(popInsuranceVC)];
    
    [self allocWithTableview];
    
    [self requestForLife];
    
}

//初始化tableview
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
    
    Life_Cell *cell = [[Life_Cell alloc] init];
    
    Life_CellFrame *frame = self.array[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Life_CellFrame *frame = self.array[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)requestForLife {

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    NSString *cityId = [CommonUtil getValueByKey:CITYID];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         memberId,@"MemberId",
                         cityId,@"CityId",
                         nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horserequest:@"LifeList.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = [json valueForKey:@"listLife"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in arr) {
                
                Life_CellModel *model = [[Life_CellModel alloc] init];
                
                model.titleName = [NSString stringWithFormat:@"%@",dd[@"Title"]];
                
                model.imageName = [NSString stringWithFormat:@"%@",dd[@"PhotoImg"]];
                
                model.LinkUrl = [NSString stringWithFormat:@"%@",dd[@"LinkUrl"]];
                
                model.RemainingDay = [NSString stringWithFormat:@"%@",dd[@"RemainingDay"]];
                
                Life_CellFrame *frame = [[Life_CellFrame alloc] init];
                
                frame.cellModel = model;
                
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

- (void)popInsuranceVC {
    
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
