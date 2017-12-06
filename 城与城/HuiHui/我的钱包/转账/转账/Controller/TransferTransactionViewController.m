//
//  TransferTransactionViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "TransferTransactionViewController.h"
#import "TransferTransactionModel.h"
#import "TransferTransactionFrame.h"
#import "TransferTranctionCell.h"
#import "RedHorseHeader.h"

@interface TransferTransactionViewController () <UITableViewDelegate,UITableViewDataSource,TransferTransaction_FieldDelegate>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *inPutArray;

@end

@implementation TransferTransactionViewController

-(NSArray *)inPutArray {

    if (_inPutArray == nil) {
        
        NSMutableArray *mut = [NSMutableArray array];
        
        TransferTransactionFrame *frame = [[TransferTransactionFrame alloc] init];
        
        frame.tranModel = self.tranModel;
        
        [mut addObject:frame];
        
        _inPutArray = mut;
        
    }
    
    return _inPutArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:@"转账"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.view.backgroundColor = RH_ViewBGColor;
    
    [self allocWithTableview];
    
}

- (void)leftClicked{
    
    [self goBack];
    
}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.inPutArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TransferTranctionCell *cell = [[TransferTranctionCell alloc] init];
    
    TransferTransactionFrame *frame = self.inPutArray[indexPath.row];
    
    cell.frameModel = frame;
    
    cell.delegate = self;
    
    cell.sureBlock = ^{
        
        NSLog(@"sure");
        
    };
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    TransferTransactionFrame *frame = self.inPutArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)CountFieldChange:(UITextField *)field {

    for (TransferTransactionFrame *frame in self.inPutArray) {
        
        frame.tranModel.count = field.text;
        
    }
    
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
