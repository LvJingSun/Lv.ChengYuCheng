//
//  CouponWebViewController.h
//  HuiHui
//
//  Created by mac on 15-4-30.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@interface CouponWebViewController : BaseViewController<UIWebViewDelegate>

// 存放数据的字典
@property (nonatomic, strong) NSMutableDictionary   *m_dic;

@end
