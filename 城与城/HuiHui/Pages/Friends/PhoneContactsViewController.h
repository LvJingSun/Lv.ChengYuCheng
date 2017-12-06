//
//  PhoneContactsViewController.h
//  HuiHui
//
//  Created by mac on 13-12-3.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  手机联系人

#import "BaseViewController.h"

#import "ContactHelper.h"
#import <AddressBookUI/AddressBookUI.h>

@interface PhoneContactsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,ABPersonViewControllerDelegate>{
 
    ContactHelper *m_contactHelp;

}

@property (nonatomic,strong) NSMutableArray *m_friendsList;

// 存放手机号的字符串
//@property (nonatomic, strong) NSString      *m_phoneString;
// 关注某个人的标志
@property (nonatomic, assign)     NSInteger     m_index;



//读取所有联系人
//- (void)ReadAllPeoples;

// 请求数据
- (void)requestPeopleSubmit:(NSString *)aString;

+ (instancetype)shareController;

@property (nonatomic,strong) UINavigationController *PhoneContactsNav;
@property (nonatomic,weak) UIView *PhoneContactsView;


-(NSDictionary *)GetALLpersonsattribute;//获取通讯录全部联系人
- (void)GetABAddressBookRef;//获取通讯录与服务器匹配

@end
