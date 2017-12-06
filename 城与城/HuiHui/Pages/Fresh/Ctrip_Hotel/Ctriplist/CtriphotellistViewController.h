//
//  CtriphotellistViewController.h
//  HuiHui
//
//  Created by 冯海强 on 14-9-16.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
#import "PullTableView.h"

@interface CtriphotellistViewController : BaseViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,PullTableViewDelegate>
{
    int indexpage;
    
    BMKMapView             *CH_mapView;
    BMKLocationService* CH_locService;
    BMKGeoCodeSearch          *m_search;
}

@property(nonatomic,weak) IBOutlet PullTableView * Ctrip_hoteltableview;

@property(nonatomic,weak) IBOutlet UILabel * Ctrip_hotelmyaddress;//我的当前地址；


//@property (nonatomic, strong) NSString *StartTimeANDendTime;//例：今天入住1晚；
@property (strong, nonatomic)  NSMutableDictionary *Ctrip_hotelInfomation;////入住信息的存储；

@end
