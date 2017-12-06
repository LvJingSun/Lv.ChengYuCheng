//
//  RH_NoMemberShipViewController.m
//  HuiHui
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_NoMemberShipViewController.h"
#import "RedHorseHeader.h"
#import "RH_HomeHeadView.h"
#import "RH_HomeBtnView.h"
#import "RH_BottomShopCell.h"
#import "RH_DescWebViewController.h"
#import "RH_BoModel.h"
#import "RH_BoFrame.h"

@interface RH_NoMemberShipViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    UIImage *dropImg;
    
    NSString *bottomString;
    
    NSString *phone;
    
    NSString *h5Url;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) RH_HomeHeadView *noMemberHeadView;

@property (nonatomic, strong) NSArray *bottomArr;

@end

@implementation RH_NoMemberShipViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"养车宝";
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"RH_HomeBack.png" andaction:@selector(dismissRH_Homeview)];
    
    [self initWithTableview];
    
    [self requestForNoData];
    
    [self requestForZuiJinClick];
    
}

- (void)requestForZuiJinClick {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                         @"4",@"Type",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [http request:@"ClickIconRecord.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)requestForNoData {

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberId", nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [http request:@"NotCarMemberData.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
          
            h5Url = [NSString stringWithFormat:@"%@",[json valueForKey:@"IsIOSRedHorseImg"]];
            
            phone = [NSString stringWithFormat:@"%@",[json valueForKey:@"tel"]];
            
            self.noMemberHeadView.phoneLab.text = [NSString stringWithFormat:@"服务热线：%@",[NSString stringWithFormat:@"%@",[json valueForKey:@"tel"]]];
            
            [self.noMemberHeadView.redHorseImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[json valueForKey:@"icon"]]] placeholderImage:[UIImage imageNamed:@"RH_马.png"]];
            
            self.noMemberHeadView.redHorseTitleLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"brand"]];
            
            self.noMemberHeadView.descTitleLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"introduce"]];
            
            self.noMemberHeadView.descContentLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"Title"]];
            
            self.noMemberHeadView.detailBlock = ^{
                
                [self pushToWebView];
                
            };
            
            self.navigationItem.rightBarButtonItem = [self SetNavigationBarRightTitle:@"加入" andaction:@selector(CityDingWei)];
            
        }else {
        
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)CityDingWei {

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]]];
    
}

- (void)pushToWebView {

    RH_DescWebViewController *vc = [[RH_DescWebViewController alloc] init];
    
    vc.urlString = h5Url;
    
    vc.photoNum = phone;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)initWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    
    self.tableview = tableview;
        
    RH_HomeHeadView *headview = [[RH_HomeHeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, ScreenWidth, headview.height);
    
    self.noMemberHeadView = headview;
    
    tableview.tableHeaderView = headview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableview];
    
}

//油费点击
- (void)youfeiClick {
    
    [self pushToWebView];
    
}

//轮胎点击
- (void)luntaiClick {
    
    [self pushToWebView];
    
}

//保养点击
- (void)BaoyangClick {
    
    [self pushToWebView];
    
}

//维修点击
- (void)XiuLiClick {
    
    [self pushToWebView];
    
}

//保险点击
- (void)BaoXianClick {
    
    [self pushToWebView];
    
}

//生活点击
- (void)ShengHuoClick {
    
    [self pushToWebView];
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    [self requestForHomeData];
    
}

-(UIImage *)getImageFromURL:(NSString *)fileURL
{
    
    UIImage * result;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:fileURL]] returningResponse:NULL error:NULL];
    //    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}

//请求首页数据
- (void)requestForHomeData {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberId",
                         [CommonUtil getValueByKey:CITYID],@"cityid",
                         nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horserequest:@"Index.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight)];
            
            imageView.image = [self getImageFromURL:[NSString stringWithFormat:@"%@",[json valueForKey:@"DropDownImg"]]];
            
            NSMutableArray *pp = [NSMutableArray array];
            
            RH_BoModel *model = [[RH_BoModel alloc] init];
            
            model.title = [NSString stringWithFormat:@"%@",[json valueForKey:@"ExtField"]];
            
            RH_BoFrame *frame = [[RH_BoFrame alloc] init];
            
            frame.bomodel = model;
            
            [pp addObject:frame];
            
            self.bottomArr = pp;
            
            [self.tableview addSubview:imageView];
            
            bottomString = [NSString stringWithFormat:@"%@",[json valueForKey:@"ExtField"]];
            
            NSArray *array = [json valueForKey:@"Icons"];
            
            NSDictionary *youfeiDic = array[0];
            
            [self.noMemberHeadView.youfeiView.button setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",youfeiDic[@"Photo"]]] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
            
            self.noMemberHeadView.youfeiView.label.text = [NSString stringWithFormat:@"%@",youfeiDic[@"Title"]];
            
            [self.noMemberHeadView.youfeiView.button addTarget:self action:@selector(youfeiClick) forControlEvents:UIControlEventTouchUpInside];
            
            NSDictionary *luntaiDic = array[1];
            
            [self.noMemberHeadView.luntaiView.button setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",luntaiDic[@"Photo"]]] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
            
            self.noMemberHeadView.luntaiView.label.text = [NSString stringWithFormat:@"%@",luntaiDic[@"Title"]];
            
            [self.noMemberHeadView.luntaiView.button addTarget:self action:@selector(luntaiClick) forControlEvents:UIControlEventTouchUpInside];
            
            NSDictionary *baoyangDic = array[2];
            
            [self.noMemberHeadView.baoyangView.button setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baoyangDic[@"Photo"]]] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
            
            self.noMemberHeadView.baoyangView.label.text = [NSString stringWithFormat:@"%@",baoyangDic[@"Title"]];
            
            [self.noMemberHeadView.baoyangView.button addTarget:self action:@selector(BaoyangClick) forControlEvents:UIControlEventTouchUpInside];
            
            NSDictionary *weixiuDic = array[3];
            
            [self.noMemberHeadView.xiuliView.button setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",weixiuDic[@"Photo"]]] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
            
            self.noMemberHeadView.xiuliView.label.text = [NSString stringWithFormat:@"%@",weixiuDic[@"Title"]];
            
            [self.noMemberHeadView.xiuliView.button addTarget:self action:@selector(XiuLiClick) forControlEvents:UIControlEventTouchUpInside];
            
            NSDictionary *baoxianDic = array[4];
            
            [self.noMemberHeadView.baoxianView.button setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baoxianDic[@"Photo"]]] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
            
            [self.noMemberHeadView.baoxianView.button addTarget:self action:@selector(BaoXianClick) forControlEvents:UIControlEventTouchUpInside];
            
            self.noMemberHeadView.baoxianView.label.text = [NSString stringWithFormat:@"%@",baoxianDic[@"Title"]];
            
            NSDictionary *shenghuoDic = array[5];
            
            [self.noMemberHeadView.shenghuoView.button setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",shenghuoDic[@"Photo"]]] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
            
            [self.noMemberHeadView.shenghuoView.button addTarget:self action:@selector(ShengHuoClick) forControlEvents:UIControlEventTouchUpInside];
            
            self.noMemberHeadView.shenghuoView.label.text = [NSString stringWithFormat:@"%@",shenghuoDic[@"Title"]];
            
            [self.tableview reloadData];
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    RH_BoFrame *frame = self.bottomArr[indexPath.row];
    
    RH_BottomShopCell *cell = [[RH_BottomShopCell alloc] init];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    RH_BoFrame *cell = self.bottomArr[indexPath.row];
    
    return cell.height;
    
}

- (void)dismissRH_Homeview {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
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
