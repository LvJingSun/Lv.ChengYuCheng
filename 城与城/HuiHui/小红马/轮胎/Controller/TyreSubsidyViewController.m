//
//  TyreSubsidyViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "TyreSubsidyViewController.h"
#import "OilHeadView.h"
#import "RedHorseHeader.h"
#import "NearBySectionView.h"

#import "TyreView.h"
#import "TyreHeadView.h"
#import "RH_CarModel.h"
#import "ApplySubsidyViewController.h"
#import "RH_SwitchCarViewController.h"
#import "TyreGetDescViewController.h"
#import "RH_NearByViewController.h"

@interface TyreSubsidyViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSString *DefaultCarID;
    
    NSString *CarImg;
    
    NSString *DefaultCarModel;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) TyreHeadView *tyreheadview;

@end

@implementation TyreSubsidyViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"轮胎";
    
    [self allocWithWenHaoBtn];
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"RH_HomeBack.png" andaction:@selector(popTyreVC)];
    
    [self allocWithTableview];
    
}

-(void)viewWillAppear:(BOOL)animated {

    [self requestForList];
    
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
    
    vc.DescType = @"1";
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//初始化轮胎列表
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
    
    TyreHeadView *tyreHead = [[TyreHeadView alloc] init];
    
    tyreHead.frame = CGRectMake(0, 0, ScreenWidth, tyreHead.height);
    
    self.tyreheadview = tyreHead;
    
    tableview.tableHeaderView = tyreHead;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    [self.view addSubview:tableview];
    
    NearBySectionView *view = [[NearBySectionView alloc] init];
    
    view.frame = CGRectMake(0, CGRectGetMaxY(tableview.frame), ScreenWidth, view.height);
    
    view.titleLab.text = @"附近的轮胎店";
    
    view.nearByBlock = ^{
        
        RH_NearByViewController *vc = [[RH_NearByViewController alloc] init];
        
        vc.nearByType = @"汽车4S店";
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    [self.view addSubview:view];
    
}

//设置已发放view
- (void)setTrueBtn:(UIButton *)sender {

    [sender setTitle:@"已发放" forState:0];
    
    [sender setTitleColor:RH_NAVTextColor forState:0];
    
    sender.layer.masksToBounds = YES;
    
    sender.layer.cornerRadius = 3;
    
    sender.layer.borderColor = RH_NAVTextColor.CGColor;
    
    sender.layer.borderWidth = 1;
    
}

//设置未发放view
- (void)setFlaseBtn:(UIButton *)sender {
    
    [sender setTitle:@"未发放" forState:0];
    
    [sender setTitleColor:[UIColor whiteColor] forState:0];
    
    sender.layer.masksToBounds = YES;
    
    sender.layer.cornerRadius = 3;
    
    [sender setBackgroundColor:RH_NAVTextColor];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    return nil;
    
}

//请求轮胎补助列表
- (void)requestForList {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         memberId,@"MemberId",
                         DefaultCarID,@"ID",
                         nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horserequest:@"MyTireList.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = [json valueForKey:@"listModel"];
            
            for (int i = 0; i < arr.count; i ++) {
                
                NSDictionary *dic = arr[i];
                
                if (i == 0) {
                    
                    self.tyreheadview.luntai1view.titleLab.text = dic[@"TireType"];
                    
                    [self.tyreheadview.luntai1view.tyreImg setImageWithURL:[NSURL URLWithString:dic[@"TireImg"]] placeholderImage:[UIImage imageNamed:@""]];
                    
                    if ([dic[@"State"] isEqualToString:@"未发放"]) {
                        
                        [self setFlaseBtn:self.tyreheadview.luntai1view.sendBtn];
                        
                    }else {
                    
                        [self setTrueBtn:self.tyreheadview.luntai1view.sendBtn];
                        
                    }
                    
                }else if (i == 1) {
                    
                    self.tyreheadview.luntai2view.titleLab.text = dic[@"TireType"];
                    
                    [self.tyreheadview.luntai2view.tyreImg setImageWithURL:[NSURL URLWithString:dic[@"TireImg"]] placeholderImage:[UIImage imageNamed:@""]];
                    
                    if ([dic[@"State"] isEqualToString:@"未发放"]) {
                        
                        [self setFlaseBtn:self.tyreheadview.luntai2view.sendBtn];
                        
                    }else {
                        
                        [self setTrueBtn:self.tyreheadview.luntai2view.sendBtn];
                        
                    }

                }else if (i == 2) {
                
                    self.tyreheadview.luntai3view.titleLab.text = dic[@"TireType"];
                    
                    [self.tyreheadview.luntai3view.tyreImg setImageWithURL:[NSURL URLWithString:dic[@"TireImg"]] placeholderImage:[UIImage imageNamed:@""]];
                    
                    if ([dic[@"State"] isEqualToString:@"未发放"]) {
                        
                        [self setFlaseBtn:self.tyreheadview.luntai3view.sendBtn];
                        
                    }else {
                        
                        [self setTrueBtn:self.tyreheadview.luntai3view.sendBtn];
                        
                    }
                    
                }else {
                
                    self.tyreheadview.luntai4view.titleLab.text = dic[@"TireType"];
                    
                    [self.tyreheadview.luntai4view.tyreImg setImageWithURL:[NSURL URLWithString:dic[@"TireImg"]] placeholderImage:[UIImage imageNamed:@""]];
                    
                    if ([dic[@"State"] isEqualToString:@"未发放"]) {
                        
                        [self setFlaseBtn:self.tyreheadview.luntai4view.sendBtn];
                        
                    }else {
                        
                        [self setTrueBtn:self.tyreheadview.luntai4view.sendBtn];
                        
                    }
                    
                }
                
            }
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}


//返回上级页面
- (void)popTyreVC {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


//补助点击
- (void)AddSubsidyClick {
    
    ApplySubsidyViewController *vc = [[ApplySubsidyViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
