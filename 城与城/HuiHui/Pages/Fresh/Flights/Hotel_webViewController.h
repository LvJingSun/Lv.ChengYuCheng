//
//  Hotel_webViewController.h
//  HuiHui
//
//  Created by mac on 15-3-12.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "CommonShareView.h"


@interface Hotel_webViewController : BaseViewController<UIWebViewDelegate,UIActionSheetDelegate,CommonShareDelegate>


@property (strong, nonatomic) NSString *m_hotelString;

@property (strong, nonatomic) CommonShareView   *m_sharingView;
// 存放分享的地址链接
@property (strong, nonatomic) NSString          *m_urlString;

@property (nonatomic, strong) NSString          *m_titleString;

// 动画的三个数组
@property (nonatomic, strong) NSArray           *m_values;

@property (nonatomic, strong) NSArray           *m_keyTimes;

@property (nonatomic, strong) NSArray           *m_Funtions;

@end
