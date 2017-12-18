//
//  HL_PromoterDetailViewController.m
//  HuiHui
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_PromoterDetailViewController.h"
#import "LJConst.h"
#import "HL_PromoterDetailHeadView.h"
#import "HL_Promoter_DetailModel.h"
#import "HL_Promoter_DetailFrame.h"
#import "HL_Promoter_DetailCell.h"

@interface HL_PromoterDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation HL_PromoterDetailViewController

-(NSArray *)dataArray {
    
    if (_dataArray == nil) {
        
        HL_Promoter_DetailModel *model1 = [[HL_Promoter_DetailModel alloc] init];
        
        model1.title = @"总收益";
        
        model1.content1 = @"¥200";
        
        model1.type = @"1";
        
        HL_Promoter_DetailFrame *frame1 = [[HL_Promoter_DetailFrame alloc] init];
        
        frame1.model = model1;
        
        HL_Promoter_DetailModel *model2 = [[HL_Promoter_DetailModel alloc] init];
        
        model2.title = @"推广分成";
        
        model2.content1 = @"30%";
        
        model2.content2 = @"修改";
        
        model2.type = @"2";
        
        HL_Promoter_DetailFrame *frame2 = [[HL_Promoter_DetailFrame alloc] init];
        
        frame2.model = model2;
        
        HL_Promoter_DetailModel *model3 = [[HL_Promoter_DetailModel alloc] init];
        
        model3.title = @"加入时间";
        
        model3.content1 = @"2017-12-14";
        
        model3.type = @"3";
        
        HL_Promoter_DetailFrame *frame3 = [[HL_Promoter_DetailFrame alloc] init];
        
        frame3.model = model3;
        
        HL_Promoter_DetailModel *model4 = [[HL_Promoter_DetailModel alloc] init];
        
        model4.title = @"联系方式";
        
        model4.content1 = @"13806131616";
        
        model4.type = @"3";
        
        HL_Promoter_DetailFrame *frame4 = [[HL_Promoter_DetailFrame alloc] init];
        
        frame4.model = model4;
        
        HL_Promoter_DetailModel *model5 = [[HL_Promoter_DetailModel alloc] init];
        
        model5.title = @"推广代理";
        
        model5.type = @"4";
        
        HL_Promoter_DetailFrame *frame5 = [[HL_Promoter_DetailFrame alloc] init];
        
        frame5.model = model5;
        
        HL_Promoter_DetailModel *model6 = [[HL_Promoter_DetailModel alloc] init];
        
        model6.type = @"5";
        
        HL_Promoter_DetailFrame *frame6 = [[HL_Promoter_DetailFrame alloc] init];
        
        frame6.model = model6;
        
        NSMutableArray *mut = [NSMutableArray array];
        
        [mut addObject:frame1];
        
        [mut addObject:frame2];
        
        [mut addObject:frame3];
        
        [mut addObject:frame4];
        
        [mut addObject:frame5];
        
        [mut addObject:frame6];
        
        _dataArray = mut;
        
    }
    
    return _dataArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:@"推广员信息"];
    
    self.view.backgroundColor = FSB_ViewBGCOLOR;
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self allocWithTableview];
    
}

- (void)allocWithTableview {
    
    HL_PromoterDetailHeadView *headview = [[HL_PromoterDetailHeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, _WindowViewWidth, headview.height);
    
    headview.nickLab.text = @"红烧吕小布";
    
    headview.nameLab.text = @"真实姓名:XXX";
    
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
    
    HL_Promoter_DetailCell *cell = [[HL_Promoter_DetailCell alloc] init];
    
    HL_Promoter_DetailFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    if ([frame.model.type isEqualToString:@"4"]) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HL_Promoter_DetailFrame *frame = self.dataArray[indexPath.row];
    
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
