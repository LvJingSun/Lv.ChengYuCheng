//
//  HH_PhoneViewController.h
//  HuiHui
//
//  Created by mac on 14-11-5.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  注册时 绑定手机号的页面

#import "BaseViewController.h"

#import "FriendHelper.h"

#import "ImageCache.h"

@interface HH_PhoneViewController : BaseViewController{
    
    FriendHelper  *friendHelp;

}

@property (weak, nonatomic) ImageCache *imageCache;

// 判断发送验证码的时间
@property (strong, nonatomic) NSDate            *clickDateTime;
// 是否同意注册协议
@property (assign, nonatomic) BOOL              isChecked;

// 存放登录成功后的信息
@property (nonatomic, strong) NSMutableDictionary   *m_dic;

// 请求数据
- (void)requestSubmit;

@end
