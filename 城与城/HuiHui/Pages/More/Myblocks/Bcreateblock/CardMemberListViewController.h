//
//  CardMemberListViewController.h
//  HuiHui
//
//  Created by mac on 15-6-8.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  领取会员卡的会员列表

#import "BaseViewController.h"
#import "EMSearchBar.h"
#import "EMSearchDisplayController.h"

@interface CardMemberListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic, strong) NSString          *m_vipCardId;
// 存放成员的数组
@property (nonatomic, strong) NSMutableArray    *m_memberList;

// 存放会员是什么模式
@property (nonatomic, strong) NSString          *m_IsSelectSeat;


@property (strong, nonatomic) NSMutableArray *contactsSource;//存储每区域

@property (strong, nonatomic) NSMutableArray *dataSource;//存储所有区域

@property (strong, nonatomic) NSMutableArray *sectionTitles;//存储每区域标题

@property (nonatomic, strong) NSMutableArray        *sectionIndex;//用于存储索引栏，对应section下标
@property (nonatomic, assign) BOOL    isSearch;
//@property (strong, nonatomic) EMSearchBar *searchBar;
//@property (strong, nonatomic) EMSearchDisplayController *searchController;

@property (weak, nonatomic) IBOutlet UISearchBar *m_searchBar;

@property (strong, nonatomic) NSMutableArray *m_searchArray;


// 会员列表请求数据
- (void)memberListRequest;

@end
