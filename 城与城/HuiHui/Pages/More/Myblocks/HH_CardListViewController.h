//
//  HH_CardListViewController.h
//  HuiHui
//
//  Created by mac on 15-6-4.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  会员卡商品

#import "BaseViewController.h"

@interface HH_CardListViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>


// 商品的类别
@property (nonatomic, strong) NSMutableArray  *m_array;

// 判断是否是展开还是闭合的集合
@property (nonatomic, strong) NSMutableSet          *m_SectionsSet;

// 请求数据的merchantId
@property (nonatomic, strong) NSString              *m_merchantId;

// 存放店铺数据的数组
@property (nonatomic, strong) NSMutableArray        *m_shopList;
// 记录是否是选择座位的
@property (nonatomic, strong) NSString              *m_selectSeat;
//m_ModelType为2是物流模式
@property (nonatomic, strong) NSString              *m_ModelType;


@property (nonatomic, strong) NSString *isWaimai;


// 请求数据
- (void)menuRequest;

@end
