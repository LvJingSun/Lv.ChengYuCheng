//
//  XiangQingViewController.m
//  HuiHui
//
//  Created by mac on 2016/12/2.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "XiangQingViewController.h"
#import "MoneyXQCell.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface XiangQingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@end

@implementation XiangQingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"详情";
    
    [self initWithTableview];
    
}

- (void)initWithTableview {

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MoneyXQCell *cell = [[MoneyXQCell alloc] init];
    
    cell.NOLab.text = [NSString stringWithFormat:@"编号:%@",self.no];
//
    cell.timeLab.text = [NSString stringWithFormat:@"时间:%@",self.time];

    if ([self.money isEqualToString:@"Income"]) {
    
        cell.moneyLab.text = @"操作:收入";
        
    }else {
    
        cell.moneyLab.text = @"操作:支出";
        
    }

    cell.typeLab.text = [NSString stringWithFormat:@"类型:%@",self.type];
    
    if ([self.status isEqualToString:@"HasCompleted"]) {
        
        cell.statusLab.text = @"状态:已完成";
        
    }else {
    
        cell.statusLab.text = @"状态:未完成";
        
    }
//
    cell.countLab.text = self.count;
    
    cell.descLab.text = self.desc;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    MoneyXQCell *cell = [[MoneyXQCell alloc] init];
    
    return cell.height;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
