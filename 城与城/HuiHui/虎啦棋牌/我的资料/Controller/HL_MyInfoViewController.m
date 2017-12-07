//
//  HL_MyInfoViewController.m
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_MyInfoViewController.h"
#import "LJConst.h"
#import "HL_MyInfoHeadView.h"
#import "HL_MyInfoModel.h"
#import "HL_MyInfoFrame.h"
#import "HL_MyInfoCell.h"
#import "GameTranViewController.h"

@interface HL_MyInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) HL_MyInfoHeadView *headview;

@end

@implementation HL_MyInfoViewController

-(NSArray *)dataArray {
    
    if (_dataArray == nil) {
        
        NSMutableArray *mut = [NSMutableArray array];
        
        HL_MyInfoModel *model1 = [[HL_MyInfoModel alloc] init];
        
        model1.title = @"会员等级";
        
        model1.content = @"粉丝代理";
        
        model1.type = @"0";
        
        HL_MyInfoFrame *frame1 = [[HL_MyInfoFrame alloc] init];
        
        frame1.infoModel = model1;
        
        [mut addObject:frame1];
        
        HL_MyInfoModel *model2 = [[HL_MyInfoModel alloc] init];
        
        model2.title = @"总收入";
        
        model2.content = @"¥1200";
        
        model2.type = @"0";
        
        HL_MyInfoFrame *frame2 = [[HL_MyInfoFrame alloc] init];
        
        frame2.infoModel = model2;
        
        [mut addObject:frame2];
        
        HL_MyInfoModel *model3 = [[HL_MyInfoModel alloc] init];
        
        model3.title = @"开通时间";
        
        model3.content = @"2017-11-12";
        
        model3.type = @"1";
        
        HL_MyInfoFrame *frame3 = [[HL_MyInfoFrame alloc] init];
        
        frame3.infoModel = model3;
        
        [mut addObject:frame3];
        
        HL_MyInfoModel *model4 = [[HL_MyInfoModel alloc] init];
        
        model4.title = @"结束时间";
        
        model4.content = @"2018-11-12";
        
        model4.type = @"1";
        
        HL_MyInfoFrame *frame4 = [[HL_MyInfoFrame alloc] init];
        
        frame4.infoModel = model4;
        
        [mut addObject:frame4];
        
        HL_MyInfoModel *model5 = [[HL_MyInfoModel alloc] init];
        
        model5.title = @"账户流水";
        
        HL_MyInfoFrame *frame5 = [[HL_MyInfoFrame alloc] init];
        
        frame5.infoModel = model5;
        
        [mut addObject:frame5];
        
        HL_MyInfoModel *model6 = [[HL_MyInfoModel alloc] init];
        
        model6.title = @"APP下载";
        
        HL_MyInfoFrame *frame6 = [[HL_MyInfoFrame alloc] init];
        
        frame6.infoModel = model6;
        
        [mut addObject:frame6];
        
        HL_MyInfoModel *model7 = [[HL_MyInfoModel alloc] init];
        
        model7.title = @"查看授权证书";
        
        HL_MyInfoFrame *frame7 = [[HL_MyInfoFrame alloc] init];
        
        frame7.infoModel = model7;
        
        [mut addObject:frame7];
        
        _dataArray = mut;
        
    }
    
    return _dataArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:@"我的资料"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.view.backgroundColor = FSB_ViewBGCOLOR;
    
    [self allocWithTableview];

}

- (void)allocWithTableview {
    
    HL_MyInfoHeadView *headview = [[HL_MyInfoHeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, _WindowViewWidth, headview.height);
    
    headview.type = @"0";
    
    headview.nameLab.text = @"红烧吕小布";
    
    headview.roomcard.text = @"200";
    
    headview.yuanbao.text = @"300";
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.tableHeaderView = headview;
    
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
    
    HL_MyInfoFrame *frame = self.dataArray[indexPath.row];
    
    HL_MyInfoCell *cell = [[HL_MyInfoCell alloc] init];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HL_MyInfoFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 4) {
        
        //账户流水
        GameTranViewController *vc = [[GameTranViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
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
