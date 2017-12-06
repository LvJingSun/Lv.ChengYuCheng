//
//  SceneryOrderformViewController.h
//  HuiHui
//
//  Created by mac on 15-1-28.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  景区填写预订订单的页面

#import "BaseViewController.h"

#import "SceneryOutListViewController.h"

@interface SceneryOrderformViewController : BaseViewController<UIAlertViewDelegate,SceneryTravellerDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    int  m_sceneryIndex;
        
}


// 存储从上个页面传递过来的字典
@property (nonatomic, strong) NSMutableDictionary   *m_dic;

@property (nonatomic, assign) int                   realNameOrUseCard;
// 用于请求数据的参数sceneryId
@property (nonatomic, strong) NSString              *m_sceneryId;

@property (nonatomic, strong) NSMutableArray        *m_travellerList;



// 实名制和身份证两个的综合类型
- (int)RealNameOrUseCard;

// 请求立即预订的接口
- (void)submitOrderRequest;


@end
