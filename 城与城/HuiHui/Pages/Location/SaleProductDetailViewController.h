//
//  SaleProductDetailViewController.h
//  HuiHui
//
//  Created by mac on 14-2-12.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  抢购的商品详情

#import "BaseViewController.h"

#import "GrayPageControl.h"

@interface SaleProductDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,UIAlertViewDelegate,QQApiInterfaceDelegate,TencentSessionDelegate>{
    
    NSInteger m_current;
    
     TencentOAuth                *tencentOAuth;
}


// 用于显示当前页的pageControl
@property (nonatomic, strong) GrayPageControl   *m_pageControl;

@property (nonatomic, strong) NSMutableArray    *m_array;

// 用于拨打电话的webView
@property (nonatomic, strong) UIWebView        *m_webView;

// 记录商品详情的字符
@property (nonatomic, strong) NSString         *m_productIntro;

@property (nonatomic, strong) NSString         *m_ruleString;

@property (nonatomic, strong) NSString         *m_userString;

@property (nonatomic, strong) NSString         *m_merchantInfo;
// 和该商户相关的商品
@property (nonatomic, strong) NSMutableArray   *m_productList;

@property (nonatomic, strong) NSMutableDictionary *m_dic;

@property (nonatomic, strong) NSMutableArray   *m_shopList;

@property (nonatomic, strong) NSMutableArray   *m_webViewArray;

// 结束时间
@property (nonatomic, strong) NSDate            *m_EndLimitTime;
// 开始时间
@property (nonatomic, strong) NSDate            *m_startTime;
// 结束时间倒计时
@property (nonatomic, strong) NSTimer           *mEndTimer;
// 系统时间
@property (nonatomic, strong) NSDate            *m_systemTime;

@property (nonatomic, assign) NSTimeInterval    m_timeSecond;

@property (nonatomic, assign) NSTimeInterval    m_Second;

// 用于请求数据的panicBuyGoodID
@property (nonatomic, strong) NSString          *m_panicBuyGoodID;

// 动画的三个数组
@property (nonatomic, strong) NSArray           *m_values;

@property (nonatomic, strong) NSArray           *m_keyTimes;

@property (nonatomic, strong) NSArray           *m_Funtions;

// 获取店铺信息
- (void)requestShopList;

// 验证用户是否填写了支付问题的网络请求
- (void)paymentSafeRequest;

// 请求数据
- (void)productDetailSubmit;

@end
