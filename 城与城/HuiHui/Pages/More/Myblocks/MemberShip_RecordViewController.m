//
//  MemberShip_RecordViewController.m
//  HuiHui
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "MemberShip_RecordViewController.h"
#import "LJConst.h"
#import "M_Record_Model.h"
#import "M_Record_Frame.h"
#import "M_Record_Cell.h"
#import <MJRefresh.h>

@interface MemberShip_RecordViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSString *recordType;
    
    NSInteger pageIndex;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) UISegmentedControl *segmview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation MemberShip_RecordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setTitle:@"交易记录"];
    
    pageIndex = 1;
    
    recordType = @"1";
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self allocWithTableview];
    
    [self requestForData];
    
}

- (void)requestForData {
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [CommonUtil getValueByKey:MEMBER_ID],@"memberId",
                           recordType,@"Types",
                           [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                           self.vipCardRecordId,@"vipCardRecordId",
                           nil];
    
    [httpClient request:@"VIPAccountList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSArray *array = [json valueForKey:@"ListVIPRecord"];
            
            if (pageIndex == 1) {
                
                NSMutableArray *mut = [NSMutableArray array];
                
                for (NSDictionary *dd in array) {
                    
                    M_Record_Model *model = [[M_Record_Model alloc] init];
            
                    model.type = [NSString stringWithFormat:@"%@",dd[@"Title"]];
            
                    model.date = [NSString stringWithFormat:@"%@",dd[@"Date"]];
            
                    model.count = [NSString stringWithFormat:@"%@",dd[@"Amount"]];
                    
                    model.TransactionType = [NSString stringWithFormat:@"%@",dd[@"TransactionType"]];
            
                    M_Record_Frame *frame = [[M_Record_Frame alloc] init];
            
                    frame.recordModel = model;
                    
                    [mut addObject:frame];
                    
                }
                
                self.dataArray = mut;
                
            }else {
                
                NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArray];
                
                for (NSDictionary *dd in array) {
                    
                    M_Record_Model *model = [[M_Record_Model alloc] init];
                    
                    model.type = [NSString stringWithFormat:@"%@",dd[@"Title"]];
                    
                    model.date = [NSString stringWithFormat:@"%@",dd[@"Date"]];
                    
                    model.count = [NSString stringWithFormat:@"%@",dd[@"Amount"]];
                    
                    model.TransactionType = [NSString stringWithFormat:@"%@",dd[@"TransactionType"]];
                    
                    M_Record_Frame *frame = [[M_Record_Frame alloc] init];
                    
                    frame.recordModel = model;
                    
                    [temp addObject:frame];
                    
                }
                
                self.dataArray = temp;
                
            }
            
            [self headAndFootEndRefreshing];
            
            [self.tableview reloadData];
            
        } else {
            
            if (pageIndex > 1) {
                
                pageIndex --;
                
            }
            
            [self headAndFootEndRefreshing];
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        if (pageIndex > 1) {
            
            pageIndex --;
            
        }
        
        [self headAndFootEndRefreshing];
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)allocWithTableview {
    
    UISegmentedControl *segmview = [[UISegmentedControl alloc] initWithItems:@[@"积分使用",@"会员卡红包",@"会员卡余额"]];
    
    segmview.frame = CGRectMake(_WindowViewWidth * 0.15, 10, _WindowViewWidth * 0.7, 35);
    
    self.segmview = segmview;
    
    segmview.selectedSegmentIndex = 0;
    
    segmview.tintColor = FSB_StyleCOLOR;
    
    segmview.layer.masksToBounds = YES;
    
    segmview.layer.borderWidth = 1;
    
    segmview.layer.borderColor = FSB_StyleCOLOR.CGColor;
    
    segmview.layer.cornerRadius = 17.5;
    
    [segmview addTarget:self action:@selector(segmchange:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segmview];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(segmview.frame) + 10, _WindowViewWidth, _WindowViewHeight - 64 - 10 - CGRectGetMaxY(segmview.frame))];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        pageIndex = 1;
        
        [self requestForData];
        
    }];
    
    tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        pageIndex ++;
        
        [self requestForData];
        
    }];
    
    [self.view addSubview:tableview];
    
}

- (void)headAndFootEndRefreshing {
    
    [self.tableview.mj_header endRefreshing];
    
    [self.tableview.mj_footer endRefreshing];
    
}

- (void)segmchange:(UISegmentedControl *)segm {
    
    switch (segm.selectedSegmentIndex) {
        case 0:
        {

            recordType = @"1";
            
            pageIndex = 1;

            [self requestForData];

        }
            break;

        case 1:
        {

            recordType = @"2";
            
            pageIndex = 1;

            [self requestForData];

        }
            break;
            
        case 2:
        {
            
            recordType = @"3";
            
            pageIndex = 1;
            
            [self requestForData];
            
        }
            break;

        default:
            break;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    M_Record_Cell *cell = [[M_Record_Cell alloc] init];
    
    M_Record_Frame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    M_Record_Frame *frame = self.dataArray[indexPath.row];
    
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

}

@end
