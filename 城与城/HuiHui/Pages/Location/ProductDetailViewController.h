//
//  ProductDetailViewController.h
//  HuiHui
//
//  Created by mac on 13-11-22.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  商品详情

#import "BaseViewController.h"
#import "YKCommonBanner.h"


@interface ProductDetailViewController : BaseViewController<YKCommonBannerDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,QQApiInterfaceDelegate,TencentSessionDelegate,DPRequestDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,QQApiInterfaceDelegate,UIWebViewDelegate>{
    
    TencentOAuth                *tencentOAuth;
    
    
    int dpapinum;
    
    int FrommeNearly;//离我最近；
    
    
    int current;
}


// 滚动的scrollerView所在的view
@property (nonatomic, strong) YKCommonBanner	*m_CommonBanner;
// 存放商品数据的数组
@property (nonatomic, strong) NSMutableArray    *m_productList;

// 用于假数据判断
@property (nonatomic, strong) NSString         *m_productIntro;

@property (nonatomic, strong) NSString         *m_PromptmString;

@property (nonatomic, strong) NSString         *m_countString;
// 拨打电话使用的webView
@property (nonatomic, strong) UIWebView        *m_webView;

// 请求数据用的商品id
@property (nonatomic, strong) NSString         *m_productId;
// 请求数据时得商户id
@property (nonatomic, strong) NSString         *m_merchantShopId;
// 用于存放请求网络返回的数据
@property (nonatomic, strong) NSMutableDictionary  *m_itemsDic;

// 动画的三个数组
@property (nonatomic, strong) NSArray           *m_values;

@property (nonatomic, strong) NSArray           *m_keyTimes;

@property (nonatomic, strong) NSArray           *m_Funtions;


//@property (weak, nonatomic) IBOutlet UIButton   *InsureWorkBtn;//保险试算按钮

// 记录右上角的按钮触发的事件
@property (nonatomic, strong) UIButton          *m_titleBtn;

// 记录是取消收藏还是收藏的字段
@property (nonatomic, strong) NSString          *m_typeString;


//@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
//@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

// 存放商品介绍和特别提示的webView-大众点评的情况下
@property (nonatomic, strong) UIWebView   *m_detailsWebView;
@property (nonatomic, strong) UIWebView   *m_specialWebView;

@property (nonatomic, copy) NSString *ruKou;

//@property (nonatomic, strong) NSMutableDictionary   *m_webDic;


// 拨打电话
- (void)callPhone;

// 地图点击事件
- (void)mapClicked;
// 更多商家
- (void)moreShop;

// 请求网络
- (void)requestProductDetail;

// 加入购物车请求数据
- (void)addShopCartSubmit;

// 验证用户是否填写了支付问题的网络请求
- (void)paymentSafeRequest;



@property (weak, nonatomic) IBOutlet UIImageView *merchantimage;

@property (weak, nonatomic) IBOutlet UIButton *merchantBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_addcarBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_buyBtn;


@property (nonatomic, strong) NSString         *m_FromDPId;//是否来自点评的信息（0表示城与城数据，1表示大众点评数据）

@property (nonatomic, strong) NSMutableArray    *dp_merchantList;
//存放多个商户的信息


@end
