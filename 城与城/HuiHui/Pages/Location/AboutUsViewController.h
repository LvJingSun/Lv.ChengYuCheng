//
//  AboutUsViewController.h
//  HuiHui
//
//  Created by mac on 14-8-5.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@interface AboutUsViewController : BaseViewController

@property (nonatomic, strong) NSMutableDictionary       *m_dic;

// 记录来自于哪个页面  1表示来自于商户列表显示右上角的关注按钮  2表示其他的地方
@property (nonatomic, strong) NSString                  *m_typeString;

// 记录右上角的按钮触发的事件
@property (nonatomic, strong) UIButton                  *m_titleBtn;


@end
