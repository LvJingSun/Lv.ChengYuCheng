//
//  LJHuahuaViewController.m
//  HuiHui
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "LJHuahuaViewController.h"
#import "HuaHuaViewCell.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"

@interface LJHuahuaViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, weak) UILabel *noLab;

@end

@implementation LJHuahuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setViewStyle];

    [self setTableview];
    
    [self loadData];

}

- (void)setTableview {
    
    UILabel *noLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 200) * 0.5, (self.view.bounds.size.height - 40) * 0.5, 200, 40)];
    
    self.noLab = noLabel;
    
    noLabel.hidden = NO;
    
    noLabel.text = @"暂无收支记录";
    
    noLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:noLabel];

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.hidden = YES;
    
    [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.array[indexPath.row];

    HuaHuaViewCell *cell = [[HuaHuaViewCell alloc] init];
    
    NSString *type = [NSString stringWithFormat:@"%@",dic[@"TransactionType"]];
    
    if ([type isEqualToString:@"1"]) {
        
        cell.countLab.text = [NSString stringWithFormat:@"+%@",dic[@"YongBei"]];
        
        cell.countLab.textColor = [UIColor greenColor];
        
    }else {
    
        cell.countLab.text = [NSString stringWithFormat:@"-%@",dic[@"YongBei"]];
        
        cell.countLab.textColor = [UIColor redColor];
        
    }

    cell.nameLab.text = [NSString stringWithFormat:@"%@",dic[@"MerchantID"]];
    
    cell.timeLab.text = [NSString stringWithFormat:@"%@",dic[@"CreateDate"]];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    HuaHuaViewCell *cell = [[HuaHuaViewCell alloc] init];
    
    return cell.height;
    
}

- (void)loadData {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberid",
                           key,   @"key",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"GetHuaHuaTranList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSArray *tempArr = [json valueForKey:@"ybtrList"];

            if (tempArr.count == 0) {
                
                self.noLab.hidden = NO;
                
                self.tableview.hidden = YES;
                
            }else {
                
                self.noLab.hidden = YES;
                
                self.tableview.hidden = NO;
            
                self.array = tempArr;

            }
            
            [self.tableview reloadData];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)setViewStyle {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    UIColor *color = [UIColor whiteColor];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    self.title = @"花花";
    
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
