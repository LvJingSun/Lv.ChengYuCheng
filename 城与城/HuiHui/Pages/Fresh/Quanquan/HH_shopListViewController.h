//
//  HH_shopListViewController.h
//  HuiHui
//
//  Created by mac on 15-3-20.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  商户店铺列表页面

#import "BaseViewController.h"

@protocol HHShopListListDelegate <NSObject>

- (void)getShopList:(NSMutableArray *)aShopArray;

@end


@interface HH_shopListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

// 存放店铺数据的数组
@property (nonatomic, strong) NSMutableArray                *m_shopList;

@property (nonatomic, assign) id<HHShopListListDelegate>    delegate;

// 存放选择的店铺的数组
@property (nonatomic, strong) NSMutableArray                *m_chooseShopList;

// 存放是否选择的值
@property (nonatomic, strong) NSMutableDictionary           *m_selectedDic;

// 记录是否全选的值
@property (nonatomic, assign) BOOL                          isSelected;

// 记录传值过来的店铺数组
@property (nonatomic, strong) NSMutableArray                *m_shopArray;


//保证分类只有一个
+ (HH_shopListViewController *)shareobject;

// 店铺数据请求数据
- (void)shopListRequest;

@end
