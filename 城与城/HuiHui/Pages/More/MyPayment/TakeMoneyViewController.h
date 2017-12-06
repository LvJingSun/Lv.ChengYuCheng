//
//  TakeMoneyViewController.h
//  baozhifu
//
//  Created by mac on 13-11-5.
//  Copyright (c) 2013年 mac. All rights reserved.
//  提现的页面

#import "BaseViewController.h"

@interface TakeMoneyViewController : BaseViewController<UITextFieldDelegate,UIScrollViewDelegate,UIAlertViewDelegate>


@property (nonatomic, strong) UIButton *doneButton;

@property (nonatomic, assign) BOOL needDone;

@property (nonatomic,assign) BOOL keyShow;
// 存放银行数据的数组
@property (nonatomic, strong) NSMutableArray  *m_array;

@property (assign, nonatomic) NSInteger currentPage;
// 接收可提现金额的字段
@property (nonatomic, strong) NSString  *m_inString;

//限额状态
@property (nonatomic, copy) NSString *xianeStatus;

//限额金额
@property (nonatomic, copy) NSString *xianeCount;

// 请求数据
- (void)requestSubmit;



@end
