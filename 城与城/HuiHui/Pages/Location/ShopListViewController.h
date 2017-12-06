//
//  ShopListViewController.h
//  HuiHui
//
//  Created by mac on 13-11-25.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "PullTableView.h"

@interface ShopListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>{
    
    // 用于分页请求的参数
    NSInteger pageIndex;
}


// 数组
@property (nonatomic, strong) NSMutableArray *m_shopList;
// 拨打电话的UIWebView
@property (nonatomic, strong) UIWebView      *m_webView;

// 记录来自于商品详情还是商户详情  1表示商品详情  2表示商户详情
@property (nonatomic, strong) NSString    *m_typeString;

// 用于请求网络的参数
@property (nonatomic, strong) NSString       *m_merchantId;


// 请求数据
- (void)requestMerchantShopList;

@property (nonatomic, strong) NSString         *m_FromDPId;//是否来自点评的信息（0表示城与城数据，1表示大众点评数据）


@end
