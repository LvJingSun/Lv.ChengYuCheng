//
//  HL_CommitPromoterViewController.m
//  HuiHui
//
//  Created by mac on 2017/12/19.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_CommitPromoterViewController.h"
#import "LJConst.h"
#import "HL_CommitPromoterModel.h"
#import "HL_CommitPromoterFrame.h"
#import "HL_CommitPromoterCell.h"

@interface HL_CommitPromoterViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation HL_CommitPromoterViewController

-(NSArray *)dataArray {
    
    if (_dataArray == nil) {
        
        HL_CommitPromoterModel *model = [[HL_CommitPromoterModel alloc] init];
        
        model.phone = @"13906131616";
        
        model.notice = @"该会员不能成为推广员";
        
        model.type = self.type;
        
        HL_CommitPromoterFrame *frame = [[HL_CommitPromoterFrame alloc] init];
        
        frame.model = model;
        
        NSMutableArray *mut = [NSMutableArray array];
        
        [mut addObject:frame];
        
        _dataArray = mut;
        
    }
    
    return _dataArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if ([self.type isEqualToString:@"0"]) {
        
        [self setTitle:@"添加推广员"];
        
    }else if ([self.type isEqualToString:@"1"]) {
        
        [self setTitle:@"修改"];
        
    }
    
    self.view.backgroundColor = FSB_ViewBGCOLOR;
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self allocWithTableview];

}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = FSB_ViewBGCOLOR;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HL_CommitPromoterCell *cell = [[HL_CommitPromoterCell alloc] init];
    
    HL_CommitPromoterFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HL_CommitPromoterFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)leftClicked {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
