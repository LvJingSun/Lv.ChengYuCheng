//
//  GoldGetOutViewController.m
//  HuiHui
//
//  Created by mac on 2017/9/19.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GoldGetOutViewController.h"
#import "Gold_OutModel.h"
#import "Gold_OutFrame.h"
#import "Gold_OutCell.h"
#import "GameGoldHeader.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "GetOutSuccessViewController.h"

@interface GoldGetOutViewController () <UITableViewDelegate,UITableViewDataSource,GetOutFieldDelegate>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, weak) UILabel *moneyLab;

@end

@implementation GoldGetOutViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"奖励金卖出";
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"IMG_4582.PNG" andaction:@selector(viewDismiss)];
    
    [self allocWithTableview];
    
    [self requestForGold];
    
}

- (void)viewDismiss {

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)requestForGold {

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberid", nil];
    
    AppHttpClient *http = [AppHttpClient sharedBonus];
    
    [http Bonusrequest:@"SellLoad.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            Gold_OutModel *model = [[Gold_OutModel alloc] init];
            
            model.allQuality = [NSString stringWithFormat:@"%@",[json valueForKey:@"goldsum"]];
            
            model.goldPrice = [NSString stringWithFormat:@"%@",[json valueForKey:@"goldprice"]];
            
            Gold_OutFrame *frame = [[Gold_OutFrame alloc] init];
            
            frame.outModel = model;
            
            NSMutableArray *mut = [NSMutableArray array];
            
            [mut addObject:frame];
            
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

    return self.array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    Gold_OutCell *cell = [[Gold_OutCell alloc] init];
    
    Gold_OutFrame *frame = self.array[indexPath.row];
    
    cell.frameModel = frame;
    
    cell.delegate = self;
    
    self.moneyLab = cell.moneyLab;
    
    cell.lookBlock = ^{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"当前金价" message:[NSString stringWithFormat:@"%@元/克",frame.outModel.goldPrice] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    };
    
    cell.sureBlock = ^{
        
        if (![frame.outModel.outQuality isEqualToString:@""] && [frame.outModel.outQuality floatValue] != 0) {
            
            if ([frame.outModel.outQuality floatValue] > [frame.outModel.allQuality floatValue]) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"你本次最多可卖出%@毫克!",frame.outModel.allQuality] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }else {
            
                [self requestForGetOut];
                
            }

        }
        
    };
    
    return cell;
    
}

- (void)requestForGetOut {
    
    Gold_OutFrame *frame = self.array[0];

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberid",
                         frame.outModel.goldPrice,@"GoldPrice",
                         frame.outModel.outQuality,@"GoldNums",
                         nil];
    
    [SVProgressHUD show];
    
    AppHttpClient *http = [AppHttpClient sharedBonus];
    
    [http Bonusrequest:@"SubmitSell.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
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

- (void)CountFieldChange:(UITextField *)field {
    
    for (Gold_OutFrame *frame in self.array) {
        
        frame.outModel.outQuality = [NSString stringWithFormat:@"%@",field.text];
        
        self.moneyLab.text = [NSString stringWithFormat:@"折合共%.2f元",[frame.outModel.outQuality floatValue] * 0.001 * [frame.outModel.goldPrice floatValue]];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    Gold_OutFrame *frame = self.array[indexPath.row];
    
    return frame.height;
    
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
