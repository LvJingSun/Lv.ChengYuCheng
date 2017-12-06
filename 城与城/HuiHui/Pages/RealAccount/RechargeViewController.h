//
//  RechargeViewController.h
//  baozhifu
//
//  Created by mac on 13-7-23.
//  Copyright (c) 2013年 mac. All rights reserved.
//  充值页面

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface RechargeViewController : BaseViewController<UIScrollViewDelegate,UIAlertViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) NSArray *bankItems;

@property (assign, nonatomic) NSInteger currentPage;

@property (strong, nonatomic) NSDate *clickDateTime;

@end
