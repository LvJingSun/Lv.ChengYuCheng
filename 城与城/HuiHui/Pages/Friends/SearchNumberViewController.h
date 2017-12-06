//
//  SearchNumberViewController.h
//  HuiHui
//
//  Created by mac on 13-12-3.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  搜号码的页面

#import "BaseViewController.h"

@interface SearchNumberViewController : BaseViewController<UITextFieldDelegate,UIAlertViewDelegate>

// 请服务器返回的数据
@property (nonatomic, strong) NSMutableArray  *m_friendsArray;

@property (nonatomic,strong) UINavigationController *SearchNumberNav;

@end
