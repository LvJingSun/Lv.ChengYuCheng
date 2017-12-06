//
//  SceneryDetailViewController.h
//  HuiHui
//
//  Created by mac on 15-1-13.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  景点详情页面

#import "BaseViewController.h"

#import "SceneryStarView.h"

@interface SceneryDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>{
    
    NSInteger  m_index;
    
    BOOL   m_firstIn;
    
}

// 传递过来的字典
@property (nonatomic, strong) NSMutableDictionary   *m_dic;

// 存放图片尺寸的字典
@property (nonatomic, strong) NSMutableDictionary   *m_sizeDic;

// 存放图片路径的字典
@property (nonatomic, strong) NSMutableDictionary   *m_PathDic;
// 存储值用于在图片列表进行显示，即当前页面请求了图片列表的第一个数据，进入图片列表后就不用去请求请求第一页的数据
@property (nonatomic, strong) NSString              *m_imagePath;


// 记录价钱搜索接口的数据
@property (nonatomic, strong) NSMutableArray        *m_priceList;
@property (nonatomic, strong) NSMutableArray        *m_noticeList;
@property (nonatomic, strong) NSMutableDictionary   *m_aheadDic;

// 存放拼接购买须知的字符串
@property (nonatomic, strong) NSString              *m_noticeString;

@property (nonatomic, strong) UIWebView             *m_noticeWebView;


// 请求价格的接口
- (void)sceneryPriceRequest;

// 景区图片列表请求数据
- (void)sceneryPictureListRequest;

@end
