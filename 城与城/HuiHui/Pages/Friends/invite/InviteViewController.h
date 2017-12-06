//
//  InviteViewController.h
//  baozhifu
//
//  Created by mac on 13-7-22.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "BaseViewController.h"
#import <MessageUI/MessageUI.h>

@interface InviteViewController : BaseViewController<UIActionSheetDelegate, ABPeoplePickerNavigationControllerDelegate,QQApiInterfaceDelegate,TencentSessionDelegate,MFMessageComposeViewControllerDelegate>{
    
    TencentOAuth                *tencentOAuth;

}

// 判断是重新邀请还是第一次邀请  1为重新邀请  2为第一次邀请  3从搜索好友的页面过来、包括从消息的页面
@property (nonatomic, strong) NSString          *stringType;

@property (nonatomic, strong) NSDictionary      *m_dic;
// 判断是否选择了通讯录
@property (nonatomic, assign) BOOL              isLeavePage;

// 从搜索好友的页面过来-如果搜索的是手机号则直接赋值
@property (nonatomic, strong) NSString          *m_phoneString;

// 动画的三个数组
@property (nonatomic, strong) NSArray           *m_values;

@property (nonatomic, strong) NSArray           *m_keyTimes;

@property (nonatomic, strong) NSArray           *m_Funtions;

@property (nonatomic, strong) NSMutableDictionary      *m_itemsDic;

// 记录是否生成过公众邀请的值
@property (nonatomic, strong) NSString          *m_stringStatus;

// 判断登录的用户是否生成过公众邀请码的请求
- (void)requestValidateCode;


@end
