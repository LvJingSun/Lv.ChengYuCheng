//
//  FlightsFillOrdersViewController.h
//  HuiHui
//
//  Created by mac on 14-12-25.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  机票填写订单的页面

#import "BaseViewController.h"

#import "Fl_ContactViewController.h"

//#import <AddressBook/AddressBook.h>
//#import <AddressBookUI/AddressBookUI.h>
//#import <MessageUI/MessageUI.h>

@interface FlightsFillOrdersViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,FlightsTrideDelegate/*,ABPeoplePickerNavigationControllerDelegate*/>{
    // 记录删除的事哪一行
    NSInteger  m_index;
    // 记录点击编辑了某个乘机人信息
    NSInteger  m_trideIndex;
    
    
}

// 存放数据的字典
@property (nonatomic, strong) NSMutableDictionary *m_dic;
// 临时替代的textField
@property (nonatomic, strong) UITextField *m_phoneField;
@property (nonatomic, strong) UITextField *m_contactField;

// 存放联系人的数组
@property (nonatomic, strong) NSMutableArray *m_contactArray;

// 记录从系统联系人里面获取的联系人和手机号码
@property (nonatomic, strong) NSString *m_contactString;
@property (nonatomic, strong) NSString *m_phoneString;

// 下单成功后存储的字典
@property (nonatomic, strong) NSMutableDictionary *m_orderDic;


@end

