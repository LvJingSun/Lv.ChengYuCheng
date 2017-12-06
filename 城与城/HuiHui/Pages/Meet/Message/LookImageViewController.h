//
//  LookImageViewController.h
//  HuiHui
//
//  Created by mac on 14-5-23.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  查看聊天的图片的页面

#import "BaseViewController.h"

@interface LookImageViewController : BaseViewController<UIGestureRecognizerDelegate,UIScrollViewDelegate,UIActionSheetDelegate>

// 图片的字符
@property (nonatomic, strong) NSString *m_imageString;

@end
