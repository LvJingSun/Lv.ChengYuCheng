//
//  PayMentViewController.h
//  baozhifu
//
//  Created by mac on 13-6-9.
//  Copyright (c) 2013年 mac. All rights reserved.
//  付款

#import <UIKit/UIKit.h>

#import "ZBarSDK.h"

#import "BaseViewController.h"
static SystemSoundID shake_sound_male_id = 0;

@interface PayMentViewController : BaseViewController<UITextFieldDelegate, UIAlertViewDelegate,UIScrollViewDelegate,ZBarReaderDelegate>
{
    UIActivityIndicatorView* activity;
    UILabel     *activityLabel;
    
    BOOL ISscaning;//正在扫；

}


@property (strong, nonatomic) NSArray *paymentRecord;

@property (assign, nonatomic) int index;

// 标记是某种类型
@property (strong, nonatomic) NSString *itemType;

@property (nonatomic, strong) UIButton *doneButton;

@property (nonatomic, assign) BOOL needDone;

@property (nonatomic,assign) BOOL keyShow;
// 当前活动的textField
@property (nonatomic, strong) UITextField *m_activityField;

// 是否显示生成二维码的view
@property (nonatomic, assign) BOOL isShowScan;

@property (nonatomic, strong) ZBarReaderViewController *mWidgetController;

// 请求网络返回的数据
@property (nonatomic, strong) NSMutableDictionary *m_dic;

@property (nonatomic, strong) NSArray  *m_array;

// 判断按钮点击的是进入二维码扫描页面
@property (nonatomic, assign) BOOL     isScan;

- (void)reloadDataView;

// 转账请求数据
- (void)transferRequest;

@property (nonatomic, strong) UIImageView *readline;

@end
