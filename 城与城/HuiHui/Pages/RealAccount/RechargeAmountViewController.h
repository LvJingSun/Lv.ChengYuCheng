//
//  RechargeAmountViewController.h
//  baozhifu
//
//  Created by mac on 14-1-15.
//  Copyright (c) 2014年 mac. All rights reserved.
//  输入充值金额页面

#import "BaseViewController.h"

#import "LTInterface.h"

@interface RechargeAmountViewController : BaseViewController<UITextFieldDelegate,UIAlertViewDelegate,LTInterfaceDelegate>

//1-银联充值 2-微信充值 3-支付宝充值
@property (nonatomic, copy) NSString *payType;

@property (nonatomic, strong) UIButton *doneButton;

@property (nonatomic, assign) BOOL needDone;

@property (nonatomic,assign) BOOL keyShow;

@property (nonatomic, assign) BOOL  isCharge;


// 请求充值的接口，请求服务器返回报文提交启动银联支付的插件
- (void)requestRechargeSubmit;


@end
