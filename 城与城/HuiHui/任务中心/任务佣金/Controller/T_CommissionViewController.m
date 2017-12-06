//
//  T_CommissionViewController.m
//  HuiHui
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_CommissionViewController.h"
#import "T_NewTask.h"
#import "T_CommissionFrame.h"
#import "T_CommissionCell.h"
#import "T_InvitationViewController.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define TabBGCOLOR [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.]
#define SureCOLOR [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0]

@interface T_CommissionViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation T_CommissionViewController

-(NSArray *)dataArray {
    
    if (_dataArray == nil) {
        
        NSMutableArray *mut = [NSMutableArray array];
            
        T_CommissionFrame *frame = [[T_CommissionFrame alloc] init];
        
        frame.taskModel = self.taskModel;
        
        [mut addObject:frame];
        
        _dataArray = mut;
        
    }
    
    return _dataArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"设置佣金";
    
    [self initWithTableview];

}

- (void)initWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 124)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = TabBGCOLOR;
    
    [self.view addSubview:tableview];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tableview.frame), SCREEN_WIDTH, 60)];
    
    [btn setTitle:@"邀请好友" forState:0];
    
    [btn setTitleColor:SureCOLOR forState:0];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:19];
    
    [btn addTarget:self action:@selector(AddFriends) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
}

- (void)AddFriends {

    T_InvitationViewController *vc = [[T_InvitationViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return self.dataArray.count;
        
    }else {
    
        return 0;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        T_CommissionFrame *frame = self.dataArray[indexPath.row];
        
        T_CommissionCell *cell = [[T_CommissionCell alloc] init];
        
        cell.frameModel = frame;
        
        return cell;
        
    }else {
    
        return nil;
        
    }
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        T_CommissionFrame *frame = self.dataArray[indexPath.row];
        
        return frame.height;
        
    }else {
    
        return 0;
        
    }
    
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
