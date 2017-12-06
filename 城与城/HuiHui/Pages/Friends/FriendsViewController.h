//
//  FriendsViewController.h
//  HuiHui
//
//  Created by mac on 13-11-20.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  朋友圈

#import "BaseViewController.h"


@interface FriendsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UISearchBarDelegate>

// 主表
@property (weak, nonatomic) IBOutlet UITableView        *m_tableView;
// 存放好友的数组
@property (strong, nonatomic) NSMutableArray            *m_friendsArray;
// 存放商户的数组
@property (strong, nonatomic) NSMutableArray            *m_MerchantArray;
// 存放邀请中的数据的数组
@property (strong, nonatomic) NSMutableArray            *m_InviteArray;
// 判断是否是搜索状态
@property (nonatomic, assign) BOOL                      m_isSearching;
// 搜索中我的朋友的数组
@property (nonatomic, strong) NSMutableArray            *m_searchArray;

// 搜索框
@property (weak, nonatomic) IBOutlet UISearchBar        *m_searchBar;
// =====test 用于记录邀请中好友是已过期的还是未过期的
@property (nonatomic, strong) NSMutableArray            *m_typeArray;

// section上面的箭头图片，用于执行动画
@property (nonatomic, strong) UIImageView             *m_imageView1;
@property (nonatomic, strong) UIImageView             *m_imageView2;
@property (nonatomic, strong) UIImageView             *m_imageView3;

// 存放tableView的数组
@property (nonatomic, strong) NSMutableDictionary     *flagDictinary;

// 用于解决页面tableView大小的问题
@property (nonatomic, assign) BOOL                    isEnterSecondPage;

// 根据数组的多少来计算行数
- (NSInteger)rowCell;

// 请求网络
- (void)friendsRequest;




@end
