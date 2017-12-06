//
//  PaymentQueViewController.h
//  baozhifu
//
//  Created by mac on 13-11-13.
//  Copyright (c) 2013年 mac. All rights reserved.
//  填写支付安全问题页面

#import "BaseViewController.h"

#import "QuestionViewController.h"


@interface PaymentQueViewController : BaseViewController<UITextFieldDelegate,UIScrollViewDelegate,QuestionDelegate>


// 用于接收返回选择问题的记录
@property (nonatomic, assign) NSInteger      m_index;

@property (nonatomic, strong) NSArray        *m_array;

@property (strong, nonatomic) NSDate         *clickDateTime;


// 请求数据
- (void)questionSubmit;


@end
