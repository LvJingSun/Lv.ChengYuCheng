//
//  TrainwebViewController.h
//  HuiHui
//
//  Created by 冯海强 on 15-1-22.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
#import "CommonShareView.h"


@interface TrainwebViewController : BaseViewController<UIWebViewDelegate,UIActionSheetDelegate,CommonShareDelegate>


@property (strong, nonatomic) NSString *Trainstring;

@property (strong, nonatomic) CommonShareView   *m_sharingView;
// 存放分享的地址链接
@property (strong, nonatomic) NSString          *m_urlString;

@property (nonatomic, strong) NSString          *m_titleString;

// 动画的三个数组
@property (nonatomic, strong) NSArray           *m_values;

@property (nonatomic, strong) NSArray           *m_keyTimes;

@property (nonatomic, strong) NSArray           *m_Funtions;

@end
