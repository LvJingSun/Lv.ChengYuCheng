//
//  SecuritySettingViewController.h
//  baozhifu
//
//  Created by mac on 13-9-8.
//  Copyright (c) 2013年 mac. All rights reserved.
//  安全设置的页面

#import "BaseViewController.h"

#import "QuestionViewController.h"

@interface SecuritySettingViewController : BaseViewController<QuestionDelegate>

@property (strong, nonatomic) NSMutableDictionary       *registInfo;
// 用于接收返回选择问题的记录
@property (nonatomic, assign) NSInteger                 m_index;

@property (strong, nonatomic) NSDate                    *clickDateTime;

@property (strong, nonatomic) NSMutableDictionary       *m_imgVDic;
// 是否同意注册协议
@property (assign, nonatomic) BOOL                      isChecked;

// 判断来自于哪个页面  1表示普通的注册 2表示扫描公众邀请码的注册
@property (nonatomic, strong) NSString                  *m_typeString;
// 存放问题的数组
@property (nonatomic, strong) NSMutableArray            *m_array;


// 来自于扫描邀请码注册的话请求问题的接口
- (void)questionSubmit;

@end
