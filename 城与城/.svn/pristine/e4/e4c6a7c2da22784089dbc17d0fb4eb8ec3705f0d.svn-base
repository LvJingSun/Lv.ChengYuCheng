//
//  CodeViewController.h
//  HuiHui
//
//  Created by mac on 13-11-20.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@interface CodeViewController : BaseViewController<UIAlertViewDelegate,QQApiInterfaceDelegate,TencentSessionDelegate>{
    
    TencentOAuth                *tencentOAuth;

}

// 生成二维码的账号
@property (nonatomic, strong) NSString *m_accountString;

// 记录公众邀请码的状态
@property (nonatomic, strong) NSString     *m_codeStatus;

// 请求网络返回的数据
@property (nonatomic, strong) NSMutableDictionary *m_CodeDic;

// 动画的三个数组
@property (nonatomic, strong) NSArray           *m_values;

@property (nonatomic, strong) NSArray           *m_keyTimes;

@property (nonatomic, strong) NSArray           *m_Funtions;


@end
