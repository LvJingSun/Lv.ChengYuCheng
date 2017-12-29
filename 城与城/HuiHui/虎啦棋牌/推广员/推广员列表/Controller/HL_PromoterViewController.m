//
//  HL_PromoterViewController.m
//  HuiHui
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_PromoterViewController.h"
#import "HL_PromoterModel.h"
#import "HL_PromoterFrame.h"
#import "HL_PromoterCell.h"
#import "LJConst.h"
#import "HL_PromoterDetailViewController.h"
#import "HL_CommitPromoterViewController.h"

@interface HL_PromoterViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation HL_PromoterViewController

-(NSArray *)dataArray {
    
    if (_dataArray == nil) {
        
        HL_PromoterModel *model = [[HL_PromoterModel alloc] init];
        
        model.name = @"红烧吕小布";
        
        model.delegate = @"粉丝代理(99/年)";
        
        model.count = @"1年";
        
        HL_PromoterFrame *frame = [[HL_PromoterFrame alloc] init];
        
        frame.promoterModel = model;
        
        HL_PromoterModel *model2 = [[HL_PromoterModel alloc] init];
        
        model2.name = @"红烧吕小布";
        
        model2.delegate = @"粉丝代理(99/年)";
        
        model2.count = @"1年";
        
        HL_PromoterFrame *frame2 = [[HL_PromoterFrame alloc] init];
        
        frame2.promoterModel = model2;
        
        NSMutableArray *mut = [NSMutableArray array];
        
        [mut addObject:frame];
        
        [mut addObject:frame2];
        
        _dataArray = mut;
        
    }
    
    return _dataArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:@"推广代理"];
    
    self.view.backgroundColor = FSB_ViewBGCOLOR;
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"添加" action:@selector(rightClicked)];

    [self allocWithTableview];
    
}

- (void)rightClicked {
    
    HL_CommitPromoterViewController *vc = [[HL_CommitPromoterViewController alloc] init];
    
    vc.type = @"0";
    
    [self.navigationController pushViewController:vc animated:YES];
    
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
    
    HL_PromoterFrame *frame = self.dataArray[indexPath.row];
    
    HL_PromoterCell *cell = [[HL_PromoterCell alloc] init];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HL_PromoterFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HL_PromoterDetailViewController *vc = [[HL_PromoterDetailViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
//        FSB_ListFrame *frame = self.array[indexPath.row];
//
//        cancleModel = frame.listModel;
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否要撤销该笔交易？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//
//        [alert show];
        
        NSLog(@"删除");
        
    }];
    
    deleteAction.backgroundColor = [UIColor redColor];
    
    UITableViewRowAction *changeAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"修改" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        HL_CommitPromoterViewController *vc = [[HL_CommitPromoterViewController alloc] init];
        
        vc.type = @"1";
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    changeAction.backgroundColor = [UIColor purpleColor];
    
    return @[deleteAction,changeAction];
    
}

- (void)leftClicked {
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
