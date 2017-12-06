//
//  MemberShipTiXianViewController.m
//  HuiHui
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "MemberShipTiXianViewController.h"
#import "M_TiXianModel.h"
#import "M_TiXianFrame.h"
#import "M_TiXianCell.h"
#import "LJConst.h"

@interface MemberShipTiXianViewController () <UITableViewDelegate,UITableViewDataSource,CountFieldDelegate>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UILabel *needLab;

@end

@implementation MemberShipTiXianViewController

//-(NSArray *)dataArray {
//
//    if (_dataArray == nil) {
//
//        M_TiXianModel *model = [[M_TiXianModel alloc] init];
//
//        model.balance = @"300";
//
//        model.jifen = @"15000";
//
//        model.needJiFen = @"300";
//
//        M_TiXianFrame *frame = [[M_TiXianFrame alloc] init];
//
//        frame.tixianModel = model;
//
//        NSMutableArray *mut = [NSMutableArray array];
//
//        [mut addObject:frame];
//
//        _dataArray = mut;
//
//    }
//
//    return _dataArray;
//
//}

- (void)requestForData {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberId",
                         self.vipCardRecordId,@"vipCardRecordId",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [SVProgressHUD show];
    
    [http request:@"VIPRPToMemInfo.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            M_TiXianModel *model = [[M_TiXianModel alloc] init];
    
            model.balance = [NSString stringWithFormat:@"%@",[json valueForKey:@"HongBaoBalance"]];
    
            model.jifen = [NSString stringWithFormat:@"%@",[json valueForKey:@"jiFen"]];
    
            model.notice = [NSString stringWithFormat:@"%@",[json valueForKey:@"Desc"]];
    
            M_TiXianFrame *frame = [[M_TiXianFrame alloc] init];
    
            frame.tixianModel = model;
    
            NSMutableArray *mut = [NSMutableArray array];
    
            [mut addObject:frame];
            
            self.dataArray = mut;
            
            [self.tableview reloadData];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setTitle:@"转出到账户余额"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self allocWithTableview];
    
    [self requestForData];
    
}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:245/255. alpha:1.];
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    M_TiXianCell *cell = [[M_TiXianCell alloc] init];
    
    M_TiXianFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    cell.delegate = self;
    
    self.needLab = cell.needLab;
    
    cell.sureBlock = ^{
        
        [self checkData];
        
    };
    
    return cell;
    
}

- (void)checkData {
    
    M_TiXianFrame *frame = self.dataArray[0];
    
    if ([frame.tixianModel.count floatValue] > [frame.tixianModel.balance floatValue]) {
        
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"你最多可转出%@元",frame.tixianModel.balance]];
        
    }else if ([frame.tixianModel.needJiFen floatValue] > [frame.tixianModel.jifen floatValue]) {
        
        [SVProgressHUD showErrorWithStatus:@"你的积分不足"];
        
    }else {
        
        [self tixianRequest];
        
    }
    
}

- (void)tixianRequest {
    
    M_TiXianFrame *frame = self.dataArray[0];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         self.vipCardRecordId,@"vipCardRecordId",
                         frame.tixianModel.count,@"Amount",
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberId",
                         frame.tixianModel.needJiFen,@"Jifen",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [SVProgressHUD show];
    
    [http request:@"VIPRPToMemAccount.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

-(void)CountFieldChange:(UITextField *)field {
    
    for (M_TiXianFrame *frame in self.dataArray) {
        
        frame.tixianModel.count = [NSString stringWithFormat:@"%@",field.text];
        
    }
    
    [self jisuanJiFenWithCount:[NSString stringWithFormat:@"%@",field.text]];
    
}

- (void)jisuanJiFenWithCount:(NSString *)count {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         count,@"amount",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [http request:@"CalculateJifen.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            for (M_TiXianFrame *frame in self.dataArray) {
                
                frame.tixianModel.needJiFen = [NSString stringWithFormat:@"%@",[json valueForKey:@"jiFen"]];
                
            }
            
            self.needLab.text = [NSString stringWithFormat:@"扣除%@积分",[json valueForKey:@"jiFen"]];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    M_TiXianFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)leftClicked{
    
    [self goBack];
    
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
