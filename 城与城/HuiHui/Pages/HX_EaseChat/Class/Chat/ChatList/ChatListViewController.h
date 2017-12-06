/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "IDInfoCache.h"

@interface ChatListViewController : UIViewController

- (void)refreshDataSource;

- (void)networkChanged:(EMConnectionState)connectionState;

@property (strong, nonatomic) IDInfoCache *InfoCache;

@property (strong, nonatomic) UIImageView *M_ImageV;

@property (nonatomic, assign) BOOL                      isEnterSecondPage;

// 记录红点的字典
@property (nonatomic, strong) NSMutableDictionary   *RedTipCnt;

// 存储朋友圈红点的动态的记录
@property (nonatomic, strong) NSString              *m_dynamicString;

@property (nonatomic, strong) NSString              *m_DynamicCommentsString;


@end
