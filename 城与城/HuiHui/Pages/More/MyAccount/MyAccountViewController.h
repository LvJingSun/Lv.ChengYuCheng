//
//  MyAccountViewController.h
//  baozhifu
//
//  Created by mac on 14-3-28.
//  Copyright (c) 2014年 mac. All rights reserved.
//  我的用户

#import "BaseViewController.h"

#import "PullTableView.h"

@interface MyAccountViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource,PullTableViewDelegate>{
    
    NSInteger pageIndex;
}


@property (weak, nonatomic)  NSString *UserNSString;//默认选择用户

@property (nonatomic, strong) NSMutableArray *m_userArray;

// 全选的BOOL值判断
@property (nonatomic,assign) BOOL  isCheckedAll;

// 存放BOOL的字典
@property (nonatomic, strong) NSMutableDictionary *m_dic;

@property (nonatomic, strong) NSMutableArray      *m_accountArray;

// 判断是否申请过公众邀请码存放的字典
@property (nonatomic, strong) NSMutableDictionary  *m_validateDic;

@property (nonatomic, assign) BOOL    isSearch;

@property (strong, nonatomic) NSMutableArray *m_searchArray;

// 判断登录的用户是否生成过公众邀请码的请求
- (void)requestValidateCode;

// 用户的数据请求网络
- (void)userLoadData;

@end
