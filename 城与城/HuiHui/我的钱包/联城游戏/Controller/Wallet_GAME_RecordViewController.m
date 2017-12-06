//
//  Wallet_GAME_RecordViewController.m
//  HuiHui
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Wallet_GAME_RecordViewController.h"
#import "RedHorseHeader.h"
#import "LJConst.h"
#import "GAME_TranModel.h"
#import "GAME_TranFrame.h"
#import "GAME_TranCell.h"
#import "GAME_RecordHeadView.h"
#import "Wallet_GAMEDetailViewController.h"

@interface Wallet_GAME_RecordViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSString *segmType; // 1-全部 2-收入 3-支出
    
    NSInteger pageindex;
    
}

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UITableView *tableview;

@end

@implementation Wallet_GAME_RecordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = FSB_StyleCOLOR;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:FSB_NAVFont,NSForegroundColorAttributeName:FSB_NAVTextColor}];
    
    self.title = @"明细";
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.view.backgroundColor = RH_ViewBGColor;
    
    [self allocWithTableview];
    
    segmType = @"1";
    
    pageindex = 1;
    
    [self requestForData];
    
}

- (void)setLeftButtonWithNormalImage:(NSString *)aImageName action:(SEL)action{
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [backButton setImage:[UIImage imageNamed:aImageName] forState:UIControlStateNormal];
    [backButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
}

- (void)requestForData {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                         segmType,@"Type",
                         [NSString stringWithFormat:@"%ld",(long)pageindex],@"pageIndex",
                         nil];
    
    AppHttpClient *httpclient = [AppHttpClient sharedClient];
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    [httpclient request:@"MyGameTranList.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *array = [json valueForKey:@"transactionRecords"];
            
            if (pageindex == 1) {
                
                if (array.count != 0) {
                    
                    NSMutableArray *mut = [NSMutableArray array];
                    
                    for (NSDictionary *dic in array) {
                        
                        GAME_TranModel *model = [[GAME_TranModel alloc] init];
                        
                        model.OrderNo = [NSString stringWithFormat:@"%@",dic[@"OrderNo"]];
                        
                        model.TradingOperations = [NSString stringWithFormat:@"%@",dic[@"TradingOperations"]];
                        
                        model.icon = [NSString stringWithFormat:@"%@",dic[@"icon"]];
                        
                        model.name = [NSString stringWithFormat:@"%@",dic[@"name"]];
                        
                        model.count = [NSString stringWithFormat:@"%@",dic[@"count"]];
                        
                        model.status = [NSString stringWithFormat:@"%@",dic[@"status"]];
                        
                        model.CostDesc = [NSString stringWithFormat:@"%@",dic[@"CostDesc"]];
                        
                        model.TranType = [NSString stringWithFormat:@"%@",dic[@"TranType"]];
                        
                        model.GoodsDesc = [NSString stringWithFormat:@"%@",dic[@"GoodsDesc"]];
                        
                        model.CreateTime = [NSString stringWithFormat:@"%@",dic[@"CreateTime"]];
                        
                        GAME_TranFrame *frame = [[GAME_TranFrame alloc] init];
                        
                        frame.tranmodel = model;
                        
                        [mut addObject:frame];
                        
                    }
                    
                    self.dataArray = mut;
                    
                }else {
                    
                    self.dataArray = array;
                    
                }
                
            }else {
                
                if (array.count != 0) {
                    
                    NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArray];
                    
                    for (NSDictionary *dic in array) {
                        
                        GAME_TranModel *model = [[GAME_TranModel alloc] init];
                        
                        model.OrderNo = [NSString stringWithFormat:@"%@",dic[@"OrderNo"]];
                        
                        model.TradingOperations = [NSString stringWithFormat:@"%@",dic[@"TradingOperations"]];
                        
                        model.icon = [NSString stringWithFormat:@"%@",dic[@"icon"]];
                        
                        model.name = [NSString stringWithFormat:@"%@",dic[@"name"]];
                        
                        model.count = [NSString stringWithFormat:@"%@",dic[@"count"]];
                        
                        model.status = [NSString stringWithFormat:@"%@",dic[@"status"]];
                        
                        model.CostDesc = [NSString stringWithFormat:@"%@",dic[@"CostDesc"]];
                        
                        model.TranType = [NSString stringWithFormat:@"%@",dic[@"TranType"]];
                        
                        model.GoodsDesc = [NSString stringWithFormat:@"%@",dic[@"GoodsDesc"]];
                        
                        model.CreateTime = [NSString stringWithFormat:@"%@",dic[@"CreateTime"]];
                        
                        GAME_TranFrame *frame = [[GAME_TranFrame alloc] init];
                        
                        frame.tranmodel = model;
                        
                        [temp addObject:frame];
                        
                    }
                    
                    self.dataArray = temp;
                    
                }
                
            }
            
            [SVProgressHUD dismiss];
            
            [self headAndFootEndRefreshing];
            
            [self.tableview reloadData];
            
        }else {
            
            if (pageindex > 1) {
                
                pageindex --;
                
            }
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
            [self headAndFootEndRefreshing];
            
        }
        
    } failure:^(NSError *error) {
        
        if (pageindex > 1) {
            
            pageindex --;
            
        }
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        [self headAndFootEndRefreshing];
        
    }];
    
}

- (void)allocWithTableview {
    
    GAME_RecordHeadView *headview = [[GAME_RecordHeadView alloc] init];
    
    headview.changeblock = ^(NSInteger i) {
        
        switch (i) {
            case 0:
            {
                
                segmType = @"1";
                
                pageindex = 1;
                
                [self requestForData];
                
            }
                break;
                
            case 1:
            {
                
                segmType = @"2";
                
                pageindex = 1;
                
                [self requestForData];
                
            }
                break;
                
            case 2:
            {
                
                segmType = @"3";
                
                pageindex = 1;
                
                [self requestForData];
                
            }
                break;
                
            default:
                break;
        }
        
    };
    
    headview.frame = CGRectMake(0, 0, _WindowViewWidth, headview.height);
    
    [self.view addSubview:headview];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headview.frame), _WindowViewWidth, _WindowViewHeight - 64 - headview.height)];
    
    self.tableview = tableview;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        pageindex = 1;
        
        [self requestForData];
        
    }];
    
    tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        pageindex ++;
        
        [self requestForData];
        
    }];
    
    [self.view addSubview:tableview];
    
}

- (void)headAndFootEndRefreshing {
    
    [self.tableview.mj_header endRefreshing];
    
    [self.tableview.mj_footer endRefreshing];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GAME_TranCell *cell = [[GAME_TranCell alloc] init];
    
    GAME_TranFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GAME_TranFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GAME_TranFrame *frame = self.dataArray[indexPath.row];
    
    Wallet_GAMEDetailViewController *vc = [[Wallet_GAMEDetailViewController alloc] init];
    
    vc.tranModel = frame.tranmodel;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)leftClicked {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
