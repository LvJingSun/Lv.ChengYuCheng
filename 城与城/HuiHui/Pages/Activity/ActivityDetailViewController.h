//
//  ActivityDetailViewController.h
//  baozhifu
//
//  Created by mac on 14-2-27.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BaseViewController.h"

#import "GrayPageControl.h"

@interface ActivityDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,QQApiInterfaceDelegate,TencentSessionDelegate,UIAlertViewDelegate>{
    
    TencentOAuth                *tencentOAuth;
    
}


// 存放其他商品的数据
@property (nonatomic, strong) NSMutableArray *m_productList;
// 存放图片的数组
@property (nonatomic, strong) NSMutableArray *m_imagArray;

@property (nonatomic, strong) GrayPageControl *m_pageControl;

// 活动简介
@property (nonatomic, strong) NSString *m_infoString;
// 活动内容
@property (nonatomic, strong) NSString *m_contentString;
// 特别提示
@property (nonatomic, strong) NSString *m_PromptString;

// 判断类型 是活动还是个人聚会
@property (nonatomic, strong) NSString *m_typeString;

// 用于请求网络的参数
@property (nonatomic, strong) NSString *m_serviceId;

// 存放请求下来的数据
@property (nonatomic, strong) NSMutableDictionary *m_items;

// 我要参加的按钮
@property (weak, nonatomic) IBOutlet UIButton *m_joinedBtn;
// 定时器
@property (nonatomic,strong)  NSTimer       *m_timer;

// 记录是否从我的聚会或我的活动页面过来 1表示是
@property (nonatomic, strong) NSString      *m_partyString;

@property (nonatomic, strong) NSArray           *m_values;

@property (nonatomic, strong) NSArray           *m_keyTimes;

@property (nonatomic, strong) NSArray           *m_Funtions;


// 请求数据
- (void)detailRequestSubmit;

// 参加聚会请求数据
- (void)joinedPartyRequest;

// 参加活动请求数据
- (void)joinedActivityRequest;


@end
