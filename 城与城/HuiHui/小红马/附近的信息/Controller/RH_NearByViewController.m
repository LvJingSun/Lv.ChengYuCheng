//
//  RH_NearByViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/29.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_NearByViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "CommonUtil.h"
#import "Configuration.h"
#import "NearByInfoModel.h"
#import "NearByInfoFrame.h"
#import "NearByInfoCell.h"
#import "RedHorseHeader.h"
#import <MJRefresh.h>

@interface RH_NearByViewController ()<BMKPoiSearchDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate> {

    BMKPoiSearch *_searcher;
    
    int pageIndex;
    
    NSString *endAddress;
    
    CGFloat endLatitude;
    
    CGFloat endLontidute;
    
}

@property (nonatomic, strong) NSMutableArray *infoArr;

@property (nonatomic, weak) UITableView *tableview;

@end

@implementation RH_NearByViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"RH_HomeBack.png" andaction:@selector(popOilVC)];
    
    self.title = self.nearByType;
    
    //初始化检索对象
    _searcher =[[BMKPoiSearch alloc]init];
    
    _searcher.delegate = self;
    
    pageIndex = 0;
    
    [self allocWithTableview];
    
}

-(void)viewWillAppear:(BOOL)animated {

    [self infoForNearBy];
    
}

- (void)allocWithTableview {

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        pageIndex = 0;
        
        [self infoForNearBy];
        
    }];
    
    tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        pageIndex ++;
        
        [self infoForNearBy];
        
    }];
    
    [self.view addSubview:tableview];
    
}

- (void)headAndFootEndRefreshing {
    
    [self.tableview.mj_header endRefreshing];
    
    [self.tableview.mj_footer endRefreshing];
    
}

- (void)infoForNearBy {

    //发起检索
    CGFloat latitudeString = [[CommonUtil getValueByKey:kLatitudeKey] floatValue];
    
    CGFloat lontiduteString = [[CommonUtil getValueByKey:kLongitudeKey] floatValue];
    
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    
    option.pageIndex = pageIndex;
    
    option.pageCapacity = 20;
    
    option.location = CLLocationCoordinate2DMake(latitudeString, lontiduteString);
    
    option.keyword = self.nearByType;
    
    option.radius = 5000;
    
    BOOL flag = [_searcher poiSearchNearBy:option];
    
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
    
}

//实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        
        NSArray *arr = poiResultList.poiInfoList;
        
        if (pageIndex == 0) {
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (BMKPoiInfo *info in arr) {
                
                NearByInfoModel *model = [[NearByInfoModel alloc] init];
                
                model.name = info.name;
                
                model.uid = info.uid;
                
                model.address = info.address;
                
                model.city = info.city;
                
                model.phone = info.phone;
                
                model.postcode = info.postcode;
                
                model.epoitype = info.epoitype;
                
                model.pt = info.pt;
                
                model.panoFlag = info.panoFlag;
                
                if ([self.nearByType isEqualToString:@"加油站"]) {
                    
                    model.picUrl = @"NearBy_加油站.png";
                    
                }else if ([self.nearByType isEqualToString:@"汽车4S店"]) {
                
                    model.picUrl = @"NearBy_4s.png";
                    
                }
                
                NearByInfoFrame *frame = [[NearByInfoFrame alloc] init];
                
                frame.infoModel = model;
                
                [mut addObject:frame];
                
            }
            
            self.infoArr = mut;
            
        }else {
        
            NSMutableArray *mut = [NSMutableArray arrayWithArray:self.infoArr];
            
            for (BMKPoiInfo *info in arr) {
                
                NearByInfoModel *model = [[NearByInfoModel alloc] init];
                
                model.name = info.name;
                
                model.uid = info.uid;
                
                model.address = info.address;
                
                model.city = info.city;
                
                model.phone = info.phone;
                
                model.postcode = info.postcode;
                
                model.epoitype = info.epoitype;
                
                model.pt = info.pt;
                
                model.panoFlag = info.panoFlag;
                
                if ([self.nearByType isEqualToString:@"加油站"]) {
                    
                    model.picUrl = @"NearBy_加油站.png";
                    
                }else if ([self.nearByType isEqualToString:@"汽车4S店"]) {
                    
                    model.picUrl = @"NearBy_4s.png";
                    
                }
                
                NearByInfoFrame *frame = [[NearByInfoFrame alloc] init];
                
                frame.infoModel = model;
                
                [mut addObject:frame];
                
            }
            
            self.infoArr = mut;
            
        }
        
        [self headAndFootEndRefreshing];
        
        [self.tableview reloadData];
        
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
        [self headAndFootEndRefreshing];
    } else {
        NSLog(@"抱歉，未找到结果");
        [self headAndFootEndRefreshing];
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.infoArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NearByInfoCell *cell = [[NearByInfoCell alloc] init];
    
    NearByInfoFrame *frame = self.infoArr[indexPath.row];
    
    cell.frameModel = frame;
    
    cell.daoHaoBlock = ^{
        
        endAddress = frame.infoModel.name;
        
        endLatitude = frame.infoModel.pt.latitude;
        
        endLontidute = frame.infoModel.pt.longitude;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否要前往店铺？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往", nil];
        
        [alert show];
        
    };
    
    return cell;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    switch (buttonIndex) {
        case 1:
        {
        
            [self GoToBaiDuMap];
            
        }
            break;
            
        default:
            break;
    }
    
}

//调用百度地图查询路线
- (void)GoToBaiDuMap {

    NSString *startAddress = [CommonUtil getValueByKey:kHomeCityAddress];
    
    CGFloat startLatitude = [[CommonUtil getValueByKey:kLatitudeKey] floatValue];
    
    CGFloat startLontidute = [[CommonUtil getValueByKey:kLongitudeKey] floatValue];
    
    BMKOpenDrivingRouteOption *opt = [[BMKOpenDrivingRouteOption alloc] init];
    opt.appScheme = @"baidumapsdk://mapsdk.baidu.com";//用于调起成功后，返回原应用
    //初始化起点节点
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    //指定起点经纬度
    CLLocationCoordinate2D coor1;
    coor1.latitude = startLatitude;
    coor1.longitude = startLontidute;
    //指定起点名称
    start.name = startAddress;
    start.pt = coor1;
    //指定起点
    opt.startPoint = start;
    
    //初始化终点节点
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    CLLocationCoordinate2D coor2;
    coor2.latitude = endLatitude;
    coor2.longitude = endLontidute;
    end.pt = coor2;
    //指定终点名称
    end.name = endAddress;
    opt.endPoint = end;
    
    //打开地图公交路线检索
    BMKOpenErrorCode code = [BMKOpenRoute openBaiduMapDrivingRoute:opt];
    
//    if (code) {
//        
//        NSLog(<#NSString * _Nonnull format, ...#>)
//        
//    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    NearByInfoFrame *frame = self.infoArr[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


//不使用时将delegate设置为 nil
-(void)viewWillDisappear:(BOOL)animated
{
    _searcher.delegate = nil;
}

- (void)popOilVC {

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
