//
//  GG_PriceRecordViewController.m
//  HuiHui
//
//  Created by mac on 2017/9/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GG_PriceRecordViewController.h"
#import "GoldPriceModel.h"
#import "GoldPriceRecordFrame.h"
#import "GoldPriceRecordCell.h"
#import "GameGoldHeader.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"

@interface GG_PriceRecordViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *goldPriceArray;

@end

@implementation GG_PriceRecordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"最近金价";
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"IMG_4582.PNG" andaction:@selector(viewDismiss)];
    
    [self allocWithTableview];
    
    [self requestForData];
    
}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        
    return self.goldPriceArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    GoldPriceRecordCell *cell = [[GoldPriceRecordCell alloc] init];
    
    GoldPriceRecordFrame *frame = self.goldPriceArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    GoldPriceRecordFrame *frame = self.goldPriceArray[indexPath.row];
    
    return frame.height;
    
}

- (void)viewDismiss {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)requestForData {
    
    NSDictionary *dic = [NSDictionary dictionary];
    
    AppHttpClient *client = [AppHttpClient sharedBonus];
    
    [client Bonusrequest:@"GoldHistory.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = [json valueForKey:@"gdList"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in arr) {
                
                GoldPriceModel *model = [[GoldPriceModel alloc] init];
                
                model.price = [NSString stringWithFormat:@"%@",dd[@"GoldPrice"]];
                
                model.date = [NSString stringWithFormat:@"%@",dd[@"time"]];
                
                GoldPriceRecordFrame *frame = [[GoldPriceRecordFrame alloc] init];
                
                frame.priceModel = model;
                
                [mut addObject:frame];
                
            }
            
            self.goldPriceArray = mut;
            
            [self.tableview reloadData];
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
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
