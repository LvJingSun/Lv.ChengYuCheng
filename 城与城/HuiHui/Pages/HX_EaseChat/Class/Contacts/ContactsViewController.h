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
#import "FriendHelper.h"
#import "TableViewWithBlock.h"

#import "PhoneContactsViewController.h"
#import "SearchNumberViewController.h"
#import "JSONKit.h"
#import "SBJson.h"
@interface ContactsViewController : BaseViewController
{
    FriendHelper  *friendHelp;
    
    // tableView是否展开
    BOOL            tableViewOpened;
    
    
    PhoneContactsViewController *PhoneContactsVC;
//    SearchNumberViewController *SearchNumberVC;
}

//好友请求变化时，更新好友请求未处理的个数
- (void)reloadApplyView;

//群组变化时，更新群组页面
- (void)reloadGroupView;

//好友个数变化时，重新获取数据
//- (void)reloadDataSource;
- (void)reloadDataSource:(NSString *)DB;

//添加好友的操作被触发
- (void)addFriendAction;

// 用于解决页面tableView大小的问题
@property (nonatomic, assign) BOOL                      isEnterSecondPage;




@end
