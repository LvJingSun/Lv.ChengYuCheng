//
//  MoreViewController.h
//  HuiHui
//
//  Created by mac on 13-11-19.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  更多

#import "BaseViewController.h"

#import "RootViewController.h"

#import "FriendHelper.h"

@interface MoreViewController : BaseViewController{
    
    FriendHelper  *friendHelp;
}

@property (nonatomic, strong) NSMutableDictionary   *appMore;

// 存放红点数据的字典
@property (nonatomic, strong) NSMutableDictionary   *RedTipCnt;

// 存放数组的数据
@property (nonatomic, strong) NSMutableArray        *m_redDotArray;
// 存放数据
@property (nonatomic, strong) NSMutableDictionary   *m_dic;

// 存放红点值的参数
@property (nonatomic, strong) NSString              *m_keyString;
@property (nonatomic, strong) NSString              *m_orderString;
@property (nonatomic, strong) NSString              *m_recordsString;
@property (nonatomic, strong) NSString              *m_integralString;
@property (nonatomic, strong) NSString              *m_tokenString;
@property (nonatomic, strong) NSString              *m_userString;

// 修改了个人信息后进行刷新页面重新赋值
@property (nonatomic, assign) BOOL                  m_modify;

// 验证用户是否填写了支付问题的网络请求
- (void)paymentSafeRequest;

// 请求数据
- (void)loadData;

// 请求数据判断设置红点
- (void)requestSubmitRedDian;

@end
