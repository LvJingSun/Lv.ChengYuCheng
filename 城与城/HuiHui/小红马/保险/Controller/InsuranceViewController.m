//
//  InsuranceViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/9.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "InsuranceViewController.h"
#import "OilHeadView.h"
#import "RedHorseHeader.h"

#import "InsuranceNoDataCell.h"
#import "ApplyInsuranceViewController.h"

#import "ApplySubsidyViewController.h"
#import "RH_CarModel.h"
#import "RH_SwitchCarViewController.h"

#import "RH_InsListModel.h"
#import "RH_InsListFrame.h"
#import "RH_InsListCell.h"

#import "TyreGetDescViewController.h"

@interface InsuranceViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSString *DefaultCarID;
    
    NSString *CarImg;
    
    NSString *DefaultCarModel;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@end

@implementation InsuranceViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"保险";
    
    [self allocWithWenHaoBtn];
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"RH_HomeBack.png" andaction:@selector(popInsuranceVC)];
    
    [self allocWithTableview];
    
}

- (void)allocWithWenHaoBtn {
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    
    [btn setTitle:@"?" forState:0];
    
    [btn setTitleColor:RH_NAVTextColor forState:0];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    btn.layer.masksToBounds = YES;
    
    btn.layer.cornerRadius = 9;
    
    btn.layer.borderColor = RH_NAVTextColor.CGColor;
    
    btn.layer.borderWidth = 1;
    
    [btn addTarget:self action:@selector(WenHaoClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *Item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem = Item;
    
}

//问号点击
- (void)WenHaoClick {

    TyreGetDescViewController *vc = [[TyreGetDescViewController alloc] init];
    
    vc.DescType = @"2";
    
    [self.navigationController pushViewController:vc animated:YES];

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
    
    if (self.array.count == 0) {
        
        return 1;
        
    }else {
    
        return self.array.count;
        
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.array.count == 0) {
    
        InsuranceNoDataCell *cell = [[InsuranceNoDataCell alloc] init];
        
        cell.PhoneClickBlock = ^{
            
        };
        
        cell.ApplyClickBlock = ^{
            
            ApplyInsuranceViewController *vc = [[ApplyInsuranceViewController alloc] init];
            
            vc.DefaultCarID = DefaultCarID;
            
            vc.DefaultCarModel = DefaultCarModel;
            
            vc.CarImg = CarImg;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        };
        
        return cell;
        
    }else {
    
        RH_InsListFrame *frame = self.array[indexPath.row];
        
        RH_InsListCell *cell = [[RH_InsListCell alloc] init];
        
        cell.frameModel = frame;
        
        return cell;
        
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.array.count == 0) {
    
        InsuranceNoDataCell *cell = [[InsuranceNoDataCell alloc] init];
        
        return cell.height;
        
    }else {
    
        RH_InsListFrame *frame = self.array[indexPath.row];
        
        return frame.height;
        
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//请求保险列表
- (void)requestForList {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         DefaultCarID,@"CarID",
                         nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horserequest:@"MyCarInsuranceDetail.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
                
                NSMutableArray *mut = [NSMutableArray array];
                
                NSArray *arr = [json valueForKey:@"ListReInsurance"];
                
                for (NSDictionary *dd in arr) {
                    
                    RH_InsListModel *model = [[RH_InsListModel alloc] init];
                    
                    model.InsuranceCompany = dd[@"InsuranceCompany"];
                    
                    model.InsuredTime = dd[@"InsuredTime"];
                    
                    model.InsuredAmount = dd[@"InsuredAmount"];
                    
                    model.CarBrand = dd[@"CarBrand"];
                    
                    model.DrivingAge = dd[@"DrivingAge"];
                    
                    model.CarAge = dd[@"CarAge"];
                    
                    model.IsSubsidies = dd[@"IsSubsidies"];
                    
                    model.HandleState = dd[@"HandleState"];
                    
                    RH_InsListFrame *frame = [[RH_InsListFrame alloc] init];
                    
                    frame.listModel = model;
                    
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

}

@end
