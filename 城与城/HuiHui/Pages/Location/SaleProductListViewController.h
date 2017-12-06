//
//  SaleProductListViewController.h
//  HuiHui
//
//  Created by mac on 14-2-11.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  抢购的商品列表

#import "BaseViewController.h"


@interface SaleProductListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    
    // 用于分页请求的参数
    NSInteger pageIndex;
    
    
}


// 存放商品的数组
@property (nonatomic, strong) NSMutableArray   *m_productList;
// 系统日期
@property (nonatomic, strong) NSDate            *m_systemDate;
// 结束时间
@property (nonatomic, strong) NSDate            *m_EndLimitTime;
// 开始时间
@property (nonatomic, strong) NSDate            *m_startTime;
// 结束时间倒计时
@property (nonatomic, strong) NSTimer           *mEndTimer;
// 系统时间
@property (nonatomic, strong) NSString          *m_systemTime;

@property (nonatomic, assign) NSTimeInterval    m_timeSecond;

// 即将开始的秒数计数
@property (nonatomic, assign) NSTimeInterval    m_Second;

// 用于记录点击的是哪个商品
@property (nonatomic, assign) NSInteger  m_index;


// 获取抢购商品
- (void)loadProductList;

// 验证用户是否填写了支付问题的网络请求
- (void)paymentSafeRequest;

@end
