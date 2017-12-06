//
//  Quan_detailViewController.h
//  HuiHui
//
//  Created by mac on 15-5-28.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  商户的券券详情-查看信息和领取的成员列表

#import "BaseViewController.h"

@interface Quan_detailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

// 存放券券数据的字典
@property (nonatomic, strong) NSMutableDictionary  *m_quanquanDic;

// 判断是否是展开还是闭合的集合
@property (nonatomic, strong) NSMutableSet          *m_SectionsSet;

// 存放选择筛选条件的内容
@property (nonatomic, strong) NSMutableDictionary   *m_dic;

// 存放店铺信息的数组
@property (nonatomic, strong) NSMutableArray        *m_shopList;


@end
