//
//  ShopCartViewController.h
//  HuiHui
//
//  Created by mac on 13-11-20.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@interface ShopCartViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>

// BOOL值来记录是否全选商品
@property (nonatomic, assign) BOOL isCheckedAll;

// 用于存放点击的是哪个btn
@property (strong, nonatomic) NSMutableDictionary       *m_SelectedDic;
// 商品信息的数组
@property (strong, nonatomic) NSMutableArray            *m_ProductList;
// 存放选中后的数据
@property (strong, nonatomic) NSMutableArray            *m_selectedArray;

@property (nonatomic, assign) NSInteger                 m_selectedIndex;

// 存放数量的数组
@property (strong, nonatomic) NSMutableDictionary       *m_countDic;


// 请求数据
- (void)requestSubmit;
// 删除某个商品请求数据
- (void)deleteProductRequest;
// 请求数据生成订单的数据请求
- (void)requestOrderSubmit;
// 加入购物车请求数据
- (void)addShopCartSubmit:(NSString *)aCount withServiceId:(NSString *)aServiceId;

@end
